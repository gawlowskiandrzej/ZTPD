import org.apache.lucene.analysis.en.EnglishAnalyzer;
import org.apache.lucene.analysis.pl.PolishAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.ByteBuffersDirectory;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import java.io.IOException;
import java.nio.file.Paths;

public class Search {

    static final String INDEX_DIRECTORY = "index";

    private static Document buildDoc(String title, String isbn) {
        Document doc = new Document();
        doc.add(new TextField("title", title, Field.Store.YES));
        doc.add(new StringField("isbn", isbn, Field.Store.YES));
        return doc;
    }

    public static void main(String[] args) throws Exception{
        PolishAnalyzer analyzer = new PolishAnalyzer();
        Directory directory = FSDirectory.open(Paths.get(INDEX_DIRECTORY));
        IndexWriterConfig config = new IndexWriterConfig(analyzer);

        String querystr = args.length > 0 ? args[0] : "urodzić";
        Query q = new QueryParser("title", analyzer).parse(querystr);

        try(IndexReader reader = DirectoryReader.open(directory)){
            IndexSearcher searcher = new IndexSearcher(reader);
            TopDocs docs = searcher.search(q, 10);
            ScoreDoc[] hits = docs.scoreDocs;

            System.out.println("Found " + hits.length + " matching docs.");
            StoredFields storedFields = searcher.storedFields();
            for(int i=0; i<hits.length; ++i) {
                int docId = hits[i].doc;
                Document d = storedFields.document(docId);
                System.out.println((i + 1) + ". " + d.get("isbn")
                        + "\t" + d.get("title"));
            }
        }

    }
}

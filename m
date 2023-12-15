Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174C6A027;
	Fri, 15 Dec 2023 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uTpIJ5A+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Haux6v60eBd/p5vruOwKLTBeh3vkJK7iQizVm3UqAfQ=; b=uTpIJ5A+lfpANn/PViXJbG6gYu
	59D6LVUz54boCJgmKlKoRi4dsaWXAl35SCUINIgOxcXZhgveFvB4aEGiqzx8rXkMiLk/n3thT50wP
	l+CE/THLkcrTtFBkCo10X5Fndxp2GpjQjrtpss65rU6XxOzmp5ajw6Kq6nCdJkilEDFnRk8mkpsd5
	kXmKe+Q9cG4TFzbGM2SpYatoR3dBEF1kMKvWXbXZNsFOsLBfyxFW2wt6Gr/CQdwlSvfSaJv4Y7aSP
	iGNqt8ee2N20jrSDYLRDqPjK9anjzo5mj0hUnfWVY/gvuXSuo0DTeN0gAqOvItPgdSYSqolTAo22J
	FdtKPxww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038iA-0t; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 02/14] fs: Convert clean_buffers() to take a folio
Date: Fri, 15 Dec 2023 20:02:33 +0000
Message-Id: <20231215200245.748418-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only caller already has a folio, so pass it in and use it throughout.
Saves two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mpage.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 63bf99856024..630f4a7c7d03 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -430,13 +430,13 @@ struct mpage_data {
  * We have our BIO, so we can now mark the buffers clean.  Make
  * sure to only clean buffers which we know we'll be writing.
  */
-static void clean_buffers(struct page *page, unsigned first_unmapped)
+static void clean_buffers(struct folio *folio, unsigned first_unmapped)
 {
 	unsigned buffer_counter = 0;
-	struct buffer_head *bh, *head;
-	if (!page_has_buffers(page))
+	struct buffer_head *bh, *head = folio_buffers(folio);
+
+	if (!head)
 		return;
-	head = page_buffers(page);
 	bh = head;
 
 	do {
@@ -451,8 +451,8 @@ static void clean_buffers(struct page *page, unsigned first_unmapped)
 	 * read_folio would fail to serialize with the bh and it would read from
 	 * disk before we reach the platter.
 	 */
-	if (buffer_heads_over_limit && PageUptodate(page))
-		try_to_free_buffers(page_folio(page));
+	if (buffer_heads_over_limit && folio_test_uptodate(folio))
+		try_to_free_buffers(folio);
 }
 
 static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
@@ -615,7 +615,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		goto alloc_new;
 	}
 
-	clean_buffers(&folio->page, first_unmapped);
+	clean_buffers(folio, first_unmapped);
 
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
-- 
2.42.0


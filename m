Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C5C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD56720878
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfDZAyA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbfDZAyA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A508D307DAAF;
        Fri, 26 Apr 2019 00:53:59 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 892155D9CC;
        Fri, 26 Apr 2019 00:53:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH V3 1/3] lib/sg_pool.c: improve APIs for allocating sg pool
Date:   Fri, 26 Apr 2019 08:53:44 +0800
Message-Id: <20190426005346.27962-2-ming.lei@redhat.com>
In-Reply-To: <20190426005346.27962-1-ming.lei@redhat.com>
References: <20190426005346.27962-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 26 Apr 2019 00:53:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now sg_alloc_table_chained() allows user to provide one preallocated
SGL, and returns simply if the requested number isn't bigger than size of
that SGL. This way is nice for inline small SGL to small IO request.

However, scattergather code only allows that size of the 1st preallocated
SGL is SG_CHUNK_SIZE(128), and this way isn't flexiable and useful, because
it may take too much memory(4KB) to pre-allocat one such size SGL for each
IO request, especially block layer always pre-allocates IO request structure.
Instead it is more friendly to pre-allocate one small size inline SGL just
for small IO.

Introduces __sg_alloc_table_chained() and __sg_free_table_chained() with
one extra parameter to specify size of the pre-allocated SGL, then the
'first_chunk' SGL can include any number of entries.

Both __sg_free_table() and __sg_alloc_table() supposes that each SGL has
same size except for the last one, changes code to allow both to accept
variant size for the 1st preallocated SGL.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/scatterlist.h | 27 ++++++++++++++++++++-----
 lib/scatterlist.c           | 36 +++++++++++++++++++++------------
 lib/sg_pool.c               | 49 ++++++++++++++++++++++++++++++---------------
 3 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b4be960c7e5d..045d7aa81f2c 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -266,10 +266,11 @@ int sg_split(struct scatterlist *in, const int in_mapped_nents,
 typedef struct scatterlist *(sg_alloc_fn)(unsigned int, gfp_t);
 typedef void (sg_free_fn)(struct scatterlist *, unsigned int);
 
-void __sg_free_table(struct sg_table *, unsigned int, bool, sg_free_fn *);
+void __sg_free_table(struct sg_table *, unsigned int, unsigned int,
+		     sg_free_fn *);
 void sg_free_table(struct sg_table *);
 int __sg_alloc_table(struct sg_table *, unsigned int, unsigned int,
-		     struct scatterlist *, gfp_t, sg_alloc_fn *);
+		     struct scatterlist *, unsigned int, gfp_t, sg_alloc_fn *);
 int sg_alloc_table(struct sg_table *, unsigned int, gfp_t);
 int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 				unsigned int n_pages, unsigned int offset,
@@ -331,9 +332,25 @@ size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
 #endif
 
 #ifdef CONFIG_SG_POOL
-void sg_free_table_chained(struct sg_table *table, bool first_chunk);
-int sg_alloc_table_chained(struct sg_table *table, int nents,
-			   struct scatterlist *first_chunk);
+void __sg_free_table_chained(struct sg_table *table,
+			     unsigned nents_first_chunk);
+int __sg_alloc_table_chained(struct sg_table *table, int nents,
+			     struct scatterlist *first_chunk,
+			     unsigned nents_first_chunk);
+
+static inline void sg_free_table_chained(struct sg_table *table,
+					 bool first_chunk)
+{
+	__sg_free_table_chained(table, first_chunk ? SG_CHUNK_SIZE : 0);
+}
+
+static inline int sg_alloc_table_chained(struct sg_table *table,
+					 int nents,
+					 struct scatterlist *first_chunk)
+{
+	return __sg_alloc_table_chained(table, nents, first_chunk,
+					first_chunk ? SG_CHUNK_SIZE : 0);
+}
 #endif
 
 /*
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 739dc9fe2c55..77ec8eec3fd0 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -181,7 +181,8 @@ static void sg_kfree(struct scatterlist *sg, unsigned int nents)
  * __sg_free_table - Free a previously mapped sg table
  * @table:	The sg table header to use
  * @max_ents:	The maximum number of entries per single scatterlist
- * @skip_first_chunk: don't free the (preallocated) first scatterlist chunk
+ * @nents_first_chunk: Number of entries int the (preallocated) first
+ * 	scatterlist chunk, 0 means no such preallocated first chunk
  * @free_fn:	Free function
  *
  *  Description:
@@ -191,9 +192,10 @@ static void sg_kfree(struct scatterlist *sg, unsigned int nents)
  *
  **/
 void __sg_free_table(struct sg_table *table, unsigned int max_ents,
-		     bool skip_first_chunk, sg_free_fn *free_fn)
+		     unsigned int nents_first_chunk, sg_free_fn *free_fn)
 {
 	struct scatterlist *sgl, *next;
+	unsigned curr_max_ents = nents_first_chunk ?: max_ents;
 
 	if (unlikely(!table->sgl))
 		return;
@@ -209,9 +211,9 @@ void __sg_free_table(struct sg_table *table, unsigned int max_ents,
 		 * sg_size is then one less than alloc size, since the last
 		 * element is the chain pointer.
 		 */
-		if (alloc_size > max_ents) {
-			next = sg_chain_ptr(&sgl[max_ents - 1]);
-			alloc_size = max_ents;
+		if (alloc_size > curr_max_ents) {
+			next = sg_chain_ptr(&sgl[curr_max_ents - 1]);
+			alloc_size = curr_max_ents;
 			sg_size = alloc_size - 1;
 		} else {
 			sg_size = alloc_size;
@@ -219,11 +221,12 @@ void __sg_free_table(struct sg_table *table, unsigned int max_ents,
 		}
 
 		table->orig_nents -= sg_size;
-		if (skip_first_chunk)
-			skip_first_chunk = false;
+		if (nents_first_chunk)
+			nents_first_chunk = 0;
 		else
 			free_fn(sgl, alloc_size);
 		sgl = next;
+		curr_max_ents = max_ents;
 	}
 
 	table->sgl = NULL;
@@ -246,6 +249,8 @@ EXPORT_SYMBOL(sg_free_table);
  * @table:	The sg table header to use
  * @nents:	Number of entries in sg list
  * @max_ents:	The maximum number of entries the allocator returns per call
+ * @nents_first_chunk: Number of entries int the (preallocated) first
+ * 	scatterlist chunk, 0 means no such preallocated chunk provided by user
  * @gfp_mask:	GFP allocation mask
  * @alloc_fn:	Allocator to use
  *
@@ -262,10 +267,13 @@ EXPORT_SYMBOL(sg_free_table);
  **/
 int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 		     unsigned int max_ents, struct scatterlist *first_chunk,
-		     gfp_t gfp_mask, sg_alloc_fn *alloc_fn)
+		     unsigned int nents_first_chunk, gfp_t gfp_mask,
+		     sg_alloc_fn *alloc_fn)
 {
 	struct scatterlist *sg, *prv;
 	unsigned int left;
+	unsigned curr_max_ents = nents_first_chunk ?: max_ents;
+	unsigned prv_max_ents;
 
 	memset(table, 0, sizeof(*table));
 
@@ -281,8 +289,8 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 	do {
 		unsigned int sg_size, alloc_size = left;
 
-		if (alloc_size > max_ents) {
-			alloc_size = max_ents;
+		if (alloc_size > curr_max_ents) {
+			alloc_size = curr_max_ents;
 			sg_size = alloc_size - 1;
 		} else
 			sg_size = alloc_size;
@@ -316,7 +324,7 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 		 * If this is not the first mapping, chain previous part.
 		 */
 		if (prv)
-			sg_chain(prv, max_ents, sg);
+			sg_chain(prv, prv_max_ents, sg);
 		else
 			table->sgl = sg;
 
@@ -327,6 +335,8 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 			sg_mark_end(&sg[sg_size - 1]);
 
 		prv = sg;
+		prv_max_ents = curr_max_ents;
+		curr_max_ents = max_ents;
 	} while (left);
 
 	return 0;
@@ -349,9 +359,9 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask)
 	int ret;
 
 	ret = __sg_alloc_table(table, nents, SG_MAX_SINGLE_ALLOC,
-			       NULL, gfp_mask, sg_kmalloc);
+			       NULL, 0, gfp_mask, sg_kmalloc);
 	if (unlikely(ret))
-		__sg_free_table(table, SG_MAX_SINGLE_ALLOC, false, sg_kfree);
+		__sg_free_table(table, SG_MAX_SINGLE_ALLOC, 0, sg_kfree);
 
 	return ret;
 }
diff --git a/lib/sg_pool.c b/lib/sg_pool.c
index d1c1e6388eaa..8026e210a25a 100644
--- a/lib/sg_pool.c
+++ b/lib/sg_pool.c
@@ -67,56 +67,73 @@ static struct scatterlist *sg_pool_alloc(unsigned int nents, gfp_t gfp_mask)
 }
 
 /**
- * sg_free_table_chained - Free a previously mapped sg table
+ * __sg_free_table_chained - Free a previously mapped sg table
  * @table:	The sg table header to use
- * @first_chunk: was first_chunk not NULL in sg_alloc_table_chained?
+ * @nents_first_chunk: size of the first_chunk SGL passed to
+ *		__sg_alloc_table_chained
  *
  *  Description:
  *    Free an sg table previously allocated and setup with
- *    sg_alloc_table_chained().
+ *    __sg_alloc_table_chained().
+ *
+ *    @nents_first_chunk has to be same with that same parameter passed
+ *    to __sg_alloc_table_chained().
  *
  **/
-void sg_free_table_chained(struct sg_table *table, bool first_chunk)
+void __sg_free_table_chained(struct sg_table *table,
+		unsigned nents_first_chunk)
 {
-	if (first_chunk && table->orig_nents <= SG_CHUNK_SIZE)
+	if (table->orig_nents <= nents_first_chunk)
 		return;
-	__sg_free_table(table, SG_CHUNK_SIZE, first_chunk, sg_pool_free);
+
+	if (nents_first_chunk == 1)
+		nents_first_chunk = 0;
+
+	__sg_free_table(table, SG_CHUNK_SIZE, nents_first_chunk, sg_pool_free);
 }
-EXPORT_SYMBOL_GPL(sg_free_table_chained);
+EXPORT_SYMBOL_GPL(__sg_free_table_chained);
 
 /**
- * sg_alloc_table_chained - Allocate and chain SGLs in an sg table
+ * __sg_alloc_table_chained - Allocate and chain SGLs in an sg table
  * @table:	The sg table header to use
  * @nents:	Number of entries in sg list
  * @first_chunk: first SGL
+ * @nents_first_chunk: number of the SGL of @first_chunk
  *
  *  Description:
  *    Allocate and chain SGLs in an sg table. If @nents@ is larger than
- *    SG_CHUNK_SIZE a chained sg table will be setup.
+ *    @nents_first_chunk a chained sg table will be setup.
  *
  **/
-int sg_alloc_table_chained(struct sg_table *table, int nents,
-		struct scatterlist *first_chunk)
+int __sg_alloc_table_chained(struct sg_table *table, int nents,
+		struct scatterlist *first_chunk, unsigned nents_first_chunk)
 {
 	int ret;
 
 	BUG_ON(!nents);
 
-	if (first_chunk) {
-		if (nents <= SG_CHUNK_SIZE) {
+	if (first_chunk && nents_first_chunk) {
+		if (nents <= nents_first_chunk) {
 			table->nents = table->orig_nents = nents;
 			sg_init_table(table->sgl, nents);
 			return 0;
 		}
 	}
 
+	/* User supposes that the 1st SGL includes real entry */
+	if (nents_first_chunk == 1) {
+		first_chunk = NULL;
+		nents_first_chunk = 0;
+	}
+
 	ret = __sg_alloc_table(table, nents, SG_CHUNK_SIZE,
-			       first_chunk, GFP_ATOMIC, sg_pool_alloc);
+			       first_chunk, nents_first_chunk,
+			       GFP_ATOMIC, sg_pool_alloc);
 	if (unlikely(ret))
-		sg_free_table_chained(table, (bool)first_chunk);
+		__sg_free_table_chained(table, nents_first_chunk);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sg_alloc_table_chained);
+EXPORT_SYMBOL_GPL(__sg_alloc_table_chained);
 
 static __init int sg_pool_init(void)
 {
-- 
2.9.5


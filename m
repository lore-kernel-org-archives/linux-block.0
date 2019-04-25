Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF53C282E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 11:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B0D2084B
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 11:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfDYLUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDYLUm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 07:20:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1255AD571A;
        Thu, 25 Apr 2019 11:20:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7A5A1001DC0;
        Thu, 25 Apr 2019 11:20:33 +0000 (UTC)
Date:   Thu, 25 Apr 2019 19:20:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V2 1/2] scsi: core: avoid to pre-allocate big chunk for
 protection meta data
Message-ID: <20190425112027.GC28630@ming.t460p>
References: <20190424093540.15526-1-ming.lei@redhat.com>
 <20190424093540.15526-2-ming.lei@redhat.com>
 <20190424143704.GC21209@lst.de>
 <20190425093729.GB28630@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425093729.GB28630@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 25 Apr 2019 11:20:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 05:37:29PM +0800, Ming Lei wrote:
> On Wed, Apr 24, 2019 at 04:37:04PM +0200, Christoph Hellwig wrote:
> > > -	if (scsi_prot_sg_count(cmd))
> > > -		sg_free_table_chained(&cmd->prot_sdb->table, true);
> > > +	if (scsi_prot_sg_count(cmd) && cmd->prot_sdb->table.sgl !=
> > > +			scsi_prot_inline_sg(cmd))
> > > +		sg_free_table_chained(&cmd->prot_sdb->table, false);
> > 
> > Nipick: I usually find it easier to read if we break around conditions
> > instead of inside them:
> > 
> > 	if (scsi_prot_sg_count(cmd) &&
> > 	    cmd->prot_sdb->table.sgl != scsi_prot_inline_sg(cmd))
> 
> OK.
> 
> > 
> > > +		if (ivecs <= SCSI_INLINE_PROT_SG_CNT) {
> > > +			scsi_init_inline_sg_table(&prot_sdb->table,
> > > +						  scsi_prot_inline_sg(cmd),
> > > +						  SCSI_INLINE_PROT_SG_CNT);
> > > +		} else if (sg_alloc_table_chained(&prot_sdb->table,
> > > +						  ivecs, NULL)) {
> > 
> > Hmm.  Maybe we just need to pass an nr_inline_vecs argument
> > to sg_alloc_table_chained to replace the SG_CHUNK_SIZE argument instead
> > of open coding this logic?
> 
> We can do that, however the current scatterlist code assumes that size
> of each SGL is fixed. We may change the logic to support this feature,
> seems not too difficult to do that.
> 
> Please let us know if you are fine to change the scatterlist code for
> supporting customized size of the 1st SGL.

Especially, something like the following change is needed:

 include/linux/scatterlist.h | 27 ++++++++++++++++++++-----
 lib/scatterlist.c           | 36 ++++++++++++++++++++++------------
 lib/sg_pool.c               | 48 ++++++++++++++++++++++++++++++---------------
 3 files changed, 77 insertions(+), 34 deletions(-)

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
index 739dc9fe2c55..401dd38080bc 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -181,7 +181,8 @@ static void sg_kfree(struct scatterlist *sg, unsigned int nents)
  * __sg_free_table - Free a previously mapped sg table
  * @table:	The sg table header to use
  * @max_ents:	The maximum number of entries per single scatterlist
- * @skip_first_chunk: don't free the (preallocated) first scatterlist chunk
+ * @nrents_first_chunk: Number of entries int the (preallocated) first
+ * 	scatterlist chunk, 0 means skipping to free the first chunk
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
+ * @nrents_first_chunk: Number of entries int the (preallocated) first
+ * 	scatterlist chunk, 0 means no such 1st chunk provided by user
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
index d1c1e6388eaa..e0f4bc0de8bd 100644
--- a/lib/sg_pool.c
+++ b/lib/sg_pool.c
@@ -67,56 +67,72 @@ static struct scatterlist *sg_pool_alloc(unsigned int nents, gfp_t gfp_mask)
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

Thanks,
Ming

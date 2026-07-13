Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B519F121
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946879; cv=none; b=u1otAF2Dl/unlThTRGP/OcaXzCT58QVz7NTD6/sA2Bb1xhwnyKMM629qfkTWyJdJ/JkquPD+mIVHlUoVahVe6B3ShvYKp9ZeD6uIzNo2VNs23KO74dO3xmZ+CM+vLpaLjn06ERHdKMa2nRcrxqlTN4xnvuN0xtUEa6iam8IqHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946879; c=relaxed/simple;
	bh=FYy33pOn0JC2bfSNUAwqxl5o1NmjaMo0ah+ybG4IzBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKFNOP/wGsiwq6lCtm6vGdLo0AjxHIg0KURnqO237zGfMMke2sLtXY21xxKfpHu0pXgLbbCN7tQ8phURVxtxA707VGpXx7XGAp3n/eYQ6o2gyZgMLvtUtYlqa+7qXcxQ0NvRuXrKlR6Opmk6IvQwYjB89vCtTVddzeiwXxk2jeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E07268BFE; Mon, 13 Jul 2026 14:47:51 +0200 (CEST)
Date: Mon, 13 Jul 2026 14:47:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Neptune <z1281552865@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, security@kernel.org
Subject: Re: [RESEND][SECURITY] block: double unpin in bounced direct reads
Message-ID: <20260713124750.GA21676@lst.de>
References: <CAKTh279tH68oS4gTQd9DFqNuegvAhwZ8ck2uViR+cbeJDW9jDA@mail.gmail.com> <20260713092945.GA8612@lst.de> <CAKTh279snB+AfprcUxVazx8v6WBo99AXzEGoeYOYqLfPuhyZhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTh279snB+AfprcUxVazx8v6WBo99AXzEGoeYOYqLfPuhyZhA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 13, 2026 at 06:20:13PM +0800, Neptune wrote:
> Hi Christoph,
> 
> On Mon, Jul 13, 2026 at 11:29 AM Christoph Hellwig <hch@lst.de> wrote:
> > Does fix the issue for you?
> 
> Yes, it fixes the reported double-unpin in my original reproducer. I
> applied the patch to the vulnerable parent, built an x86-64 KASAN
> kernel, and reran the test with the same QEMU NVMe PI namespace and
> XFS setup. The exploit now reports a stale page miss and the process
> remains uid 1000.
> 
> I did find a boundary bug in the rewritten alignment loop. If the bio
> contains a single one-byte bvec and nbytes is also one, the first
> iteration consumes that bvec, decrements bi_vcnt to zero, and moves bv
> before the vector array. The next while condition then dereferences
> the invalid bv before the later bi_vcnt check can run.
> 
> I reproduced this on the patched kernel with a 512-byte O_DIRECT pread
> from a raw virtio block device. The destination starts at the last
> byte of a mapped 4 KiB page and the following page is PROT_NONE,
> leaving one bvec with bv_len=1 and bv_offset=4095. Immediately before
> the loop, GEF showed bi_vcnt=1, nbytes=1, and bv_len=1. After that
> bvec was consumed, GEF caught another call to unpin_user_page() with
> page=0x100020000, bi_vcnt=0, and nbytes=0; KASAN then reported a
> general protection fault from unpin_user_page() through
> bio_iov_iter_get_pages().
> 
> This boundary test requires permission to open the raw block device.
> It is a correctness regression in the proposed loop and is separate
> from the original unprivileged XFS entry point.
> 
> Keeping the loop driven by nbytes, with the old partial-bvec check
> inside it, should avoid evaluating bv after the last vector has been
> consumed. The callers can still pass an explicit starting bvec, but
> the loop needs to stop as soon as nbytes reaches zero.

Yes, updated version below.

> I also noticed two read-bounce cleanup details while reviewing the
> error paths. If alignment removes every user bvec,
> bio_iov_iter_bounce_read() returns the error without dropping the
> allocated bounce folio. If alignment succeeds after trimming bytes,
> bi_io_vec[0].bv_len retains the pre-trim length even though
> bio_iov_iter_unbounce_read() later uses it as the copy length. The
> error path appears to need a folio_put(), and the successful path
> needs to synchronize vector zero's length with bio->bi_iter.bi_size.

I'll look into that next.

---
From 43e1b03b38264d8fb8c647c8a801bd1e81a4638a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 13 Jul 2026 10:42:34 +0200
Subject: block: fix aligning of bounced dio read bios

bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
with this case to avoid a double unpin.

Fixes: e7b8b3c5b2a6 ("block: align down bounces bios")
Reported-by: Neptune <z1281552865@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a967..cc50c603a9f8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1191,7 +1191,7 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
  * for the next iteration.
  */
 static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
-			    unsigned len_align_mask)
+				   struct bio_vec *bv, unsigned len_align_mask)
 {
 	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
 
@@ -1200,9 +1200,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 
 	iov_iter_revert(iter, nbytes);
 	bio->bi_iter.bi_size -= nbytes;
-	do {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
+	for (;;) {
 		if (nbytes < bv->bv_len) {
 			bv->bv_len -= nbytes;
 			break;
@@ -1211,9 +1209,10 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 		if (bio_flagged(bio, BIO_PAGE_PINNED))
 			unpin_user_page(bv->bv_page);
 
-		bio->bi_vcnt--;
 		nbytes -= bv->bv_len;
-	} while (nbytes);
+		bio->bi_vcnt--;
+		bv--;
+	}
 
 	if (!bio->bi_vcnt)
 		return -EFAULT;
@@ -1276,7 +1275,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
-	return bio_iov_iter_align_down(bio, iter, len_align_mask);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
 }
 
 static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
@@ -1360,7 +1360,8 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 
 	if (!bio->bi_iter.bi_size)
 		return -ENOMEM;
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], minsize - 1);
 }
 
 static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
@@ -1398,7 +1399,10 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
 	bvec_set_folio(&bio->bi_io_vec[0], folio, bio->bi_iter.bi_size, 0);
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+
+	/* The first vec stores the bounce buffer, so do not subtract 1 here. */
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt], minsize - 1);
 }
 
 /**
-- 
2.53.0


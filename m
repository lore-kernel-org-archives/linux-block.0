Return-Path: <mwilck@suse.com>
Message-ID: <2311947c2f0f368bd10474edb0f0f5b51dde6b7d.camel@suse.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>
Date: Fri, 13 Jul 2018 18:56:38 +0200
In-Reply-To: <a0b0e59b-60cd-9933-6752-4c21a7a975fe@kernel.dk>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
	 <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
	 <a1679897-ed41-1ceb-f94f-bd1be537ce4e@suse.de>
	 <57a2b121-9805-8337-fb97-67943670f250@kernel.dk>
	 <a0b0e59b-60cd-9933-6752-4c21a7a975fe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-12 at 10:42 -0600, Jens Axboe wrote:
> 
> Hence the patch I sent is wrong, the code actually looks fine. Which
> means we're back to trying to figure out what is going on here. It'd
> be great with a test case...

We don't have an easy test case yet. But the customer has confirmed
that the problem occurs with upstream 4.17.5, too. We also confirmed
again that the problem occurs when the kernel uses the kmalloc() code
path in __blkdev_direct_IO_simple().

My personal suggestion would be to ditch __blkdev_direct_IO_simple()
altogether. After all, it's not _that_ much simpler thatn
__blkdev_direct_IO(), and it seems to be broken in a subtle way.

However, so far I've only identified a minor problem, see below - it
doesn't explain the data corruption we're seeing.

Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSELinux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)


>From d0c74ef1fc73c03983950c496f7490da8aa56671 Mon Sep 17 00:00:00 2001
From: Martin Wilck <mwilck@suse.com>
Date: Fri, 13 Jul 2018 18:38:44 +0200
Subject: [PATCH] fs: fix error exit in __blkdev_direct_IO_simple

Cleanup code was missing in the error return path.
---
 fs/block_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e..b82b516 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -218,8 +218,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb,
struct iov_iter *iter,
 	bio.bi_end_io = blkdev_bio_end_io_simple;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		if (vecs != inline_vecs)
+			kfree(vecs);
+		bio_uninit(&bio);
 		return ret;
+	}
 	ret = bio.bi_iter.bi_size;
 
 	if (iov_iter_rw(iter) == READ) {
-- 
2.17.1

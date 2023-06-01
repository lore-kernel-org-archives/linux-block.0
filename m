Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED10C77B7E
	for <linux-block@archiver.kernel.org>; Thu,  1 Jun 2023 07:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjFAH25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjFAH2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 03:28:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C341134
        for <linux-block@vger.kernel.org>; Thu,  1 Jun 2023 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OQqxeuooWslgENX++0vagbyt91ALuaHzSzMiOyBjoDA=; b=ubyLLQI3LOc98jwxWp3d0/85dq
        +9ibaJQRSw5AqPvpQMB+teRi5xAsEc8h/Fk2tB4CM1Rk2SwEUGmqpfzAZGdgHMlFNjelt3VtGOZnW
        10WeROJjf8Czu6s7D8kGlH8SV0g4Dp9D6kUuAZiZbrinpZHSElIg62jpmHU/Fwope0vonSPE9FBSf
        4fi7jw/GaepyUhuR/Li0Qcwkr0aJUxoB1IolHa/zts9W2oIquvNjYPhAqUPgxLh8RPuImTWgghdhh
        EwiRHKzbqsz+fABILLCDXmNK6clRh5BmQUuRxujnaoyY5chXItYiw8/Pp1zYtmmspyvAs3l7GCP07
        TaqebhEg==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4cjk-002MMU-1I;
        Thu, 01 Jun 2023 07:28:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: fail writes to read-only devices
Date:   Thu,  1 Jun 2023 09:28:29 +0200
Message-Id: <20230601072829.1258286-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601072829.1258286-1-hch@lst.de>
References: <20230601072829.1258286-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently callers can happily submit writes to block devices that are
marked read-only, including to drivers that don't even support writes
and will crash when fed such bios.

While bio submitter should check for read-only devices, that's not a
very robust way of dealing with this.

Note that the last attempt to do this got reverted by Linus in commit
a32e236eb93e ("Partially revert "block: fail op_is_write() requests to
read-only partitions") because device mapper relyied on not enforcing
the read-only state when used together with older lvm-tools.

The lvm side got fixed in:

    https://sourceware.org/git/?p=lvm2.git;a=commit;h=a6fdb9d9d70f51c49ad11a87ab4243344e6701a3

but if people still have older lvm2 tools in use we probably need
to find a workaround for this in device mapper rather than lacking
the core block layer checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4ba243968e41eb..ef41816bd0eade 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -492,16 +492,6 @@ static int __init fail_make_request_debugfs(void)
 late_initcall(fail_make_request_debugfs);
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline void bio_check_ro(struct bio *bio)
-{
-	if (op_is_write(bio_op(bio)) && bio_sectors(bio) &&
-	    bdev_read_only(bio->bi_bdev)) {
-		pr_warn("Trying to write to read-only block-device %pg\n",
-			bio->bi_bdev);
-		/* Older lvm-tools actually trigger this */
-	}
-}
-
 static noinline int should_fail_bio(struct bio *bio)
 {
 	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
@@ -735,7 +725,14 @@ void submit_bio_noacct(struct bio *bio)
 
 	if (should_fail_bio(bio))
 		goto end_io;
-	bio_check_ro(bio);
+
+	if (op_is_write(bio_op(bio)) && bio_sectors(bio) &&
+	    bdev_read_only(bdev)) {
+		pr_warn("Trying to write to read-only block-device %pg\n",
+			bdev);
+		goto end_io;
+	}
+
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
-- 
2.39.2


Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B25C46470
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8F82084A
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="iC+IQo9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfEDSkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:40:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34274 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfEDSij (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id s7so2438098ljh.1
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmGpk7ZUHL8Q0bStKqXOqyguC9W0njoYT9sYdEGeaAs=;
        b=iC+IQo9UqYv33GPSBkLM1zgc1h5+AE3FZIuiC7eKTBpoilJwL7ECAneuqkllAh96U6
         wfHw7Xr85L/UbDLnDt8O0a8/tdfJIFV7lqnLgP8KLIr0A3ikK9M5dBtUz/nlwfG/mBH4
         2njGj97PybYBeSqZ4pi5Ao9InKOeQHYn2NyeHOeHwc2TYU/2mULXCOFRo39PocfoeQCe
         yTsYsl68/606bo3eV6qD5teYL+x+qWY1oA76E1KL1FPdEHMUcRUbV/+S7RWsY1q76ihV
         D9CHQJ8q0XgMDXbC5D2PxiFM5AIeuc6hUaib+1LyhZX10jX7kBuaJIo2H3TezONORunm
         7ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmGpk7ZUHL8Q0bStKqXOqyguC9W0njoYT9sYdEGeaAs=;
        b=AS9nHBnKSg6X4E+Z/svHIPuO2fJQErAj1hSGxrXRZXhP57oNcTux78aTRmE7EzEKK9
         Grm8nv9gJ4iqY1z+BLGH8fEr9qObCOVEsz5ZDS4Tqe5x2IVgu7vLdLsKI29MdXTZV+yn
         5wsQXxhayjWRcS1sUhKw0FpuBF26AJkWdRGfb+eHb35ZK4qus2hINSKvXXAMU7MDj9dC
         akj2dFpCiQi5g7oQwb0nseYzGsGuXBmOS1P+aQFqXRE+fjVsfVMF4YbZ2NFlcJvMKVt5
         Zzyjd112XTvh7ePeFoL25TDUwx2H85ll+EeaWjhzZ/U3wrV9Ee1QtsSRhSluRuoV/OOx
         0lQw==
X-Gm-Message-State: APjAAAVahffjrii4voQfsQpYvZQBDRE1bJNg9qHRfUWcwXW/GUAonkwD
        gHg4jOnQ0q3QUNhyOTs311jh/Q==
X-Google-Smtp-Source: APXvYqzth9Zk3D3NyiSbi5AuOFlUqaxipPyz4ZJEzAdJU7hL4/Ia0W/QJGcd/9TrKDS6dYBlviQlUQ==
X-Received: by 2002:a2e:92ce:: with SMTP id k14mr8884170ljh.83.1556995116575;
        Sat, 04 May 2019 11:38:36 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:36 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chansol Kim <chansol.kim@samsung.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 11/26] lightnvm: pblk: fix bio leak when bio is split
Date:   Sat,  4 May 2019 20:37:56 +0200
Message-Id: <20190504183811.18725-12-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chansol Kim <chansol.kim@samsung.com>

For large size io where blk_queue_split needs to be called inside
pblk_rw_io, results in bio leak as bio_endio is not called on the
newly allocated. One way to observe this is to mounting ext4
filesystem on the target and issuing 1MB io with dd, e.g., dd bs=1MB
if=/dev/null of=/mount/myvolume. kmemleak reports:

unreferenced object 0xffff88803d7d0100 (size 256):
  comm "kworker/u16:1", pid 68, jiffies 4294899333 (age 284.120s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 60 e8 31 81 88 ff ff  .........`.1....
    01 40 00 00 06 06 00 00 00 00 00 00 05 00 00 00  .@..............
  backtrace:
    [<000000001f5aa04f>] kmem_cache_alloc+0x204/0x3c0
    [<0000000040945aab>] mempool_alloc_slab+0x1d/0x30
    [<00000000b4959ab4>] mempool_alloc+0x83/0x220
    [<00000000646bad9b>] bio_alloc_bioset+0x229/0x320
    [<000000009264b251>] bio_clone_fast+0x26/0xc0
    [<0000000008250252>] bio_split+0x41/0x110
    [<00000000e365cad0>] blk_queue_split+0x349/0x930
    [<00000000eb5426bc>] pblk_make_rq+0x1b5/0x1f0
    [<00000000eea09cec>] generic_make_request+0x2f9/0x690
    [<00000000ae6acede>] submit_bio+0x12e/0x1f0
    [<00000000f9b8b82a>] ext4_io_submit+0x64/0x80
    [<000000009e4f817d>] ext4_bio_write_page+0x32e/0x890
    [<00000000cbd0d106>] mpage_submit_page+0x65/0xc0
    [<000000000eec7359>] mpage_map_and_submit_buffers+0x171/0x330
    [<000000009a7afcb6>] ext4_writepages+0xd5e/0x1650
    [<000000004476b096>] do_writepages+0x39/0xc0

In case there is a need for a split, blk_queue_split returns the newly
allocated bio to the caller by changing the value of pointer passed as
a reference, while the original is passed to generic_make_requests.

Although pblk_rw_io's local variable bio* has changed and passed to
pblk_submit_read and pblk_write_to_cache, work is done on this new
bio*, and pblk_rw_io returns NVM_IO_DONE, pblk_make_rq calls bio_endio
on the old bio* because it passed bio pointer by value to pblk_rw_io.

pblk_rw_io is unfolded into pblk_make_rq so that there is no copying
of bio* and bio_endio is called on the correct bio*.

Signed-off-by: Chansol Kim <chansol.kim@samsung.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 47 +++++++++++++++---------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e0df3de1ce83..1e227a08e54a 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -47,36 +47,10 @@ static struct pblk_global_caches pblk_caches = {
 
 struct bio_set pblk_bio_set;
 
-static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
-			  struct bio *bio)
-{
-	int ret;
-
-	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
-	 * constraint. Writes can be of arbitrary size.
-	 */
-	if (bio_data_dir(bio) == READ) {
-		blk_queue_split(q, &bio);
-		ret = pblk_submit_read(pblk, bio);
-		if (ret == NVM_IO_DONE && bio_flagged(bio, BIO_CLONED))
-			bio_put(bio);
-
-		return ret;
-	}
-
-	/* Prevent deadlock in the case of a modest LUN configuration and large
-	 * user I/Os. Unless stalled, the rate limiter leaves at least 256KB
-	 * available for user I/O.
-	 */
-	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
-		blk_queue_split(q, &bio);
-
-	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
-}
-
 static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
 {
 	struct pblk *pblk = q->queuedata;
+	int ret;
 
 	if (bio_op(bio) == REQ_OP_DISCARD) {
 		pblk_discard(pblk, bio);
@@ -86,7 +60,24 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
 		}
 	}
 
-	switch (pblk_rw_io(q, pblk, bio)) {
+	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
+	 * constraint. Writes can be of arbitrary size.
+	 */
+	if (bio_data_dir(bio) == READ) {
+		blk_queue_split(q, &bio);
+		ret = pblk_submit_read(pblk, bio);
+	} else {
+		/* Prevent deadlock in the case of a modest LUN configuration
+		 * and large user I/Os. Unless stalled, the rate limiter
+		 * leaves at least 256KB available for user I/O.
+		 */
+		if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
+			blk_queue_split(q, &bio);
+
+		ret = pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
+	}
+
+	switch (ret) {
 	case NVM_IO_ERR:
 		bio_io_error(bio);
 		break;
-- 
2.19.1


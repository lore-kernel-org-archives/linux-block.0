Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69443C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F4020840
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 07:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QFNp0C7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfCGHX7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:23:59 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24458 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHX7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 02:23:59 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190307072355epoutp03c8cf82d8894e2b1bef909930bbecd3d0~JnFUCcbg-1302213022epoutp037
        for <linux-block@vger.kernel.org>; Thu,  7 Mar 2019 07:23:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190307072355epoutp03c8cf82d8894e2b1bef909930bbecd3d0~JnFUCcbg-1302213022epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551943435;
        bh=CqucmCI/sVdNSCsYwD/7kMEQjXu0IuY4Dw/ownymybo=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=QFNp0C7FYD9xbq42Jnu0Gq1ZPIJv9OTz3rDpSZM4AQvxaCbJv32su0/9k1Guyrtsk
         jS8wjpDM/tKIa3EwvNiCv2gkQcoi3RtblCzuDYd6Pi840uTKWQttH7UqROc91D1xI3
         DZRKqgX5ZVA5RLqVUOt41iG23z5zQBHXmsiLya9k=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.191]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190307072353epcas2p25b60f3eaf9b51e70a22a6b6f2a15df93~JnFSDrtc_0445404454epcas2p2u;
        Thu,  7 Mar 2019 07:23:53 +0000 (GMT)
X-AuditID: b6c32a45-5f3ff7000000102a-9f-5c80c708535f
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.08.04138.807C08C5; Thu,  7 Mar 2019 16:23:52 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] lightnvm: pblk: fix bio leak on large sized io
Reply-To: chansol.kim@samsung.com
From:   Chansol Kim <chansol.kim@samsung.com>
To:     "mb@lightnvm.io" <mb@lightnvm.io>,
        "javier@javigon.com" <javier@javigon.com>,
        "hans.holmberg@cnexlabs.com" <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987@epcms2p1>
Date:   Thu, 07 Mar 2019 16:23:51 +0900
X-CMS-MailID: 20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmmS7H8YYYg7bLvBYfzzexWHSevsBk
        sfeWtsWK7UdYHFg8+hY+Z/JoXnCHxaP76g9Gj8+b5AJYonJsMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4A2KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslVILUnIKDA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjK6GycyFvQpVxyYsY21gfGcTBcj
        J4eEgInEr6OdrF2MXBxCAjsYJX7+W8jYxcjBwSsgKPF3hzBIjbCAk8Spfc0sILaQgKJEz6I5
        LBBxXYlnt/vZQWw2AW2JDRsnMIPYIgLnGCUOrSiAmM8rMaP9KQuELS2xfflWRghbVOLm6rfs
        MPb7Y/Oh4iISrffOMkPYghIPfu6GiktK7FhwHOw0CYF6ic1XJUBOlhDoYZR4tWwO1Bx9iWsd
        G8F28Qr4Srz7cRnMZhFQlXjZuh6qxkVi0o6/rCA2s4C8xPa3c5hBZjILaEqs36UPMV5Z4sgt
        FogKPomOw3/ZYT7ZMe8JE4StKvH27hRWmK+a+nexQdgeElfWXmWChFSgxPrP09knMMrNQoTn
        LCR7ZyHsXcDIvIpRLLWgODc9tdiowBA5CjcxgtOYlusOxhnnfA4xCnAwKvHwRpyujxFiTSwr
        rsw9xCjBwawkwrtrdkOMEG9KYmVValF+fFFpTmrxIUZToPcnMkuJJucDU2xeSbyhqZGZmYGl
        qYWpmZGFkjjvI+m50UIC6YklqdmpqQWpRTB9TBycUg2MLzWu71e3jmIu5uzLlJbZ9c00akVb
        3eW/P48231i5NCi2+4psfdnlg3EzDxSu/baE58SJ/5M9rsleO/i5efHfZJXlbJxXdm+K1LF6
        9swhdL+DYiOX06VLHk8NPA/48n4Q+MjYbS9e+3VJn+o81swT22enXQ2SfLW/rs3OW7aN3/7z
        SR7BOZElSizFGYmGWsxFxYkArF0zuHkDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987
References: <CGME20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987@epcms2p1>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
---
v2:
- Instead of changing pblk_rw_io's parameter, unfolded it into pblk_make_rq

 drivers/lightnvm/pblk-init.c | 47 ++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8b643d0..0c98305 100644
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
2.7.4


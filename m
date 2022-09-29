Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79704C6FA83
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiI2GYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiI2GYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 02:24:37 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1065ADA8
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 23:24:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220929062430euoutp010b1bd3dbad0e833899dcb684d682f01d~ZQLH2EK8_2289322893euoutp01c
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:24:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220929062430euoutp010b1bd3dbad0e833899dcb684d682f01d~ZQLH2EK8_2289322893euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664432670;
        bh=IRlCLrDK6rc31/KK+cmzjEqI+n7MfAyxKsU0+O5vXe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYxhaJ6skKadq0CvSYwrpwp0Stkhq4rMCZdCqRD9Nqt5vArRZ4OCD+3sngsIOQT0r
         Ox6bNaPsoBnItlpEFEe9ZpZNK30vmgsoahdmknjhLIm8IR0McVz1Ikp8aTyDAMNbqH
         4ILBf5jsbFMBuA+25uqsa+iuIurCGP7FS5mcqIoI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929062429eucas1p16bc65f775ceb0a86e38b9d41e0500dac~ZQLHEYKui0219102191eucas1p1C;
        Thu, 29 Sep 2022 06:24:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.83.07817.D1A35336; Thu, 29
        Sep 2022 07:24:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e~ZQLGmbQE80037300373eucas1p2e;
        Thu, 29 Sep 2022 06:24:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929062429eusmtrp145528788bf054d3d24b75ef21ded757f~ZQLGltHeI0651006510eusmtrp1f;
        Thu, 29 Sep 2022 06:24:29 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-6c-63353a1d6c1f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.98.10862.C1A35336; Thu, 29
        Sep 2022 07:24:28 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220929062428eusmtip1dabbfca2c2c94472f63e0f8ce4bc1a8d~ZQLGQhzuq1082310823eusmtip1p;
        Thu, 29 Sep 2022 06:24:28 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 2/2] block: use blk_mq_plug() wrapper consistently in the
 block layer
Date:   Thu, 29 Sep 2022 08:24:25 +0200
Message-Id: <20220929062425.91254-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929062425.91254-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV1ZK9NkgyPzpSxW3+1ns/h99jyz
        xc0DO5ksVq4+ymSx95a2xeelLewObB6Xz5Z67L7ZwOaxs/U+q0ffllWMHp83yQWwRnHZpKTm
        ZJalFunbJXBlbJm2h73gLFfFtPcf2BsYX3B0MXJySAiYSGy7OJMZxBYSWMEosbw1GcL+wijx
        65x6FyMXkP2ZUeLp3HksMA3rj3YwQySWM0osaDrFBOG8ZJR48xBkFAcHm4CWRGMnO0iDiIC8
        xJfba8GamQXqJVZe72YEsYUFoiSWPnrCCmKzCKhKtPyZCRbnFbCUOPDgLCPEMnmJmZe+g83h
        FLCSaD32DapGUOLkzCdQM+UlmrfOBjtIQmAlh8TkOS1QzS4Sl9fshLKFJV4d38IOYctInJ7c
        A/VNtcTTG7+hmlsYJfp3rmcDeUBCwFqi70wOiMksoCmxfpc+RNRR4vTxLAiTT+LGW0GIC/gk
        Jm2bzgwR5pXoaBOCmK0ksfPnE6idEhKXm+awQJR4SLz7VT6BUXEWkldmIXllFsLWBYzMqxjF
        U0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJTyul/x7/sYFz+6qPeIUYmDsZDjBIczEoivL+P
        GiYL8aYkVlalFuXHF5XmpBYfYpTmYFES52WboZUsJJCeWJKanZpakFoEk2Xi4JRqYBKICJrC
        KGO7dGXvuq0WO+ed5GnZfF32ivup13uW6L653HONZTq/7Gr/xj3qr4MrmH+ozVqb0si2zKJ+
        eoJPsEHnNvb7nDtn8ofpyfOxxuUeklZa0+BRfVJ3x7G/cZLRby5e9c9ND7t7mbP8ww4rSYdN
        WoKZlRp6rG4lpk6ss9x4nfxSTjbWNa6Lc9nYVGVy2GZ/1Bztn6d8E6vdFshUX/56rkyPm5VB
        4rXVjI0r0+bwvGJyeTH7yrL8kP5jNw9Vn3aRPbgw//fR9XVJv8qO3beI99l4udLivOyHNKXD
        PQu+zl75jfXkl8erG7U+MO8Q5Nvfc+TsvRLW2fMuWl1wiOH2XFEXtMssOIzz0PO7B5VYijMS
        DbWYi4oTAb+ZUFKYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xu7oyVqbJBifvWlisvtvPZvH77Hlm
        i5sHdjJZrFx9lMli7y1ti89LW9gd2Dwuny312H2zgc1jZ+t9Vo++LasYPT5vkgtgjdKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL2DJtD3vBWa6K
        ae8/sDcwvuDoYuTkkBAwkVh/tIO5i5GLQ0hgKaPE/BPzGCESEhK3FzZB2cISf651sUEUPWeU
        aPx6B6iDg4NNQEuisZMdpEZEQFFi40eQei4OZoFmRonLN/tZQWqEBSIk1r1JA6lhEVCVaPkz
        E2wmr4ClxIEHZ6Hmy0vMvPQdbA6ngJVE67FvYHEhoJqHV3tZIOoFJU7OfAJmMwPVN2+dzTyB
        UWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqNg27GfW3Ywrnz1Ue8QIxMH
        4yFGCQ5mJRHe30cNk4V4UxIrq1KL8uOLSnNSiw8xmgLdPZFZSjQ5HxiHeSXxhmYGpoYmZpYG
        ppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTN52McvOSbuIb/LnTwoKiVl86UNa3lHP
        j+dYb1dOzb09JXzCGcVzImXr1P2Cax75J12bbr+X5XLrAo1bz7es2eC96mvtlw8TrR+3MC++
        Pi10+2aZatEmhdcMG3k7ew3Xva7Sm/vgz/11v2z35ItN7Z7rrTO7qmzHzYcdkb194RvyZ1tr
        7n6ta+Z6IPf0ArbJ0vVRaunmMcv9LC7JXmRQKtlkZW3RUHMl4PciG6uCqPNvj5qFGsm5mC64
        udTWsq0vzNuvtN85y60xQzD054sOaUPznmPTLr34JarWezTiW3LzCe7sim/ba34sk51keEJx
        QtTsk3v6dKa4r9838dUhe6kXOVO2elxe05218J5XixJLcUaioRZzUXEiAOm1LMsLAwAA
X-CMS-MailID: 20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e
References: <20220929062425.91254-1-p.raghav@samsung.com>
        <CGME20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blk_mq_plug() wrapper to get the plug instead of directly accessing
it in the block layer.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 203be672da52..d0e97de216db 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -850,7 +850,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
-	blk_flush_plug(current->plug, false);
+	blk_flush_plug(blk_mq_plug(bio), false);
 
 	if (bio_queue_enter(bio))
 		return 0;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..5bf245c4bf0a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1209,12 +1209,14 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  */
 void blk_execute_rq_nowait(struct request *rq, bool at_head)
 {
+	struct blk_plug *plug = blk_mq_plug(rq->bio);
+
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
 
 	blk_account_io_start(rq);
-	if (current->plug)
-		blk_add_rq_to_plug(current->plug, rq);
+	if (plug)
+		blk_add_rq_to_plug(plug, rq);
 	else
 		blk_mq_sched_insert_request(rq, at_head, true, false);
 }
-- 
2.25.1


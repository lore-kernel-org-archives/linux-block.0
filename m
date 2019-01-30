Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A349FC169C4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 01:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375ED20823
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 01:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oFYUtYP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfA3Bxu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:53:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:44465 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfA3Bxu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 20:53:50 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190130015347epoutp012eb92211b86e24ecfbb22df5a357cb30~_fWyoG40l0967609676epoutp01f
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 01:53:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190130015347epoutp012eb92211b86e24ecfbb22df5a357cb30~_fWyoG40l0967609676epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548813227;
        bh=ShQEykOmemmOzoZyUq62DpQZEwLC25k2GQi/1OIxa38=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=oFYUtYP6z1GIurmYlBiespKqZsOVhsJZ8b74qMuUbaevSd5y3yyLCbd5dHZ4dytat
         Z4ccK8lb5xmKwvIU/zOLPmGfuL12ZKS262cBIizmTR1ohMl1S6Se5E9g7NiR9q2rGr
         7cr+3Fk/cnijPI1BKcyZYWWeN6owUOptWQ1SvCrs=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.191]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190130015344epcas2p4f10e886cc19dcfae6df77e3068d171a9~_fWwR3Zv00927909279epcas2p4e;
        Wed, 30 Jan 2019 01:53:44 +0000 (GMT)
X-AuditID: b6c32a48-173ff70000000ffd-f1-5c5103a79633
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.54.04093.7A3015C5; Wed, 30 Jan 2019 10:53:43 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] lightnvm: pblk: fix bio leak on large sized io
Reply-To: chansol.kim@samsung.com
From:   =?UTF-8?B?6rmA7LCs7IaU?= <chansol.kim@samsung.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "javier@javigon.com" <javier@javigon.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: Y,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
Date:   Wed, 30 Jan 2019 10:53:43 +0900
X-CMS-MailID: 20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmqe5y5sAYg+7X5hadpy8wWey9pW0x
        oe0rswOzR/OCOywenzfJebQf6GYKYI7KsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wB2qOkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0
        LNArTswtLs1L10vOz7UyNDAwMgWqTMjJWHGklbFgvXDF/SunWBoYT/N3MXJySAiYSHT+usIG
        YgsJ7GCU6P0j3sXIwcErICjxd4cwSFhYwF6i59t2FogSRYmeRXNYIOJWEu17T4C1sglYSEzt
        7GQHsUWA6vefWgdWwyyQIvHvWhczxCpeiRntT1kgbGmJ7cu3MkLYohKtTY+ZYez3x+ZDxUUk
        Wu+dhYoLSjz4uRsqLimxY8FxRpAzJQTqJTZflehi5AIyexglXi2bww5Roy9xrWMj2C5eAV+J
        S9+nsIPUswioSlw6KAxR4iJx5s47Zogz5SW2v53DDFLCLKApsX6XPkSYT6Lj8F92mOt3zHvC
        BGGrSry9O4UV5pOm/l1sELaHxNx936EhFShx+Ph91gmMcrMQ4TkLybJZCMsWMDKvYhRLLSjO
        TU8tNiowQY7BTYzghKXlsYPxwDmfQ4wCHIxKPLwMwQExQqyJZcWVuYcYJTiYlUR4DX/7xwjx
        piRWVqUW5ccXleakFh9iNAV6eSKzlGhyPjCZ5pXEG5oamZkZWJpamJoZWSiJ8z6UnhstJJCe
        WJKanZpakFoE08fEwSnVwCihuPqp6s5qlpvhtW8fTJiy//xlDV+102wc2qdM9GYyPuKz/icj
        GVizUWGb87b95llzWieUaqwLuKm2uI7hsfizs67SW088DA/ZnuARuy+n8YZ+kdDWte+++X/O
        iugMX+bwQPRQhq9BheXbQ3pnLSLWKa7ecN7s3fM7wms3BoV4Hnk7x+3aFH0lluKMREMt5qLi
        RAB0EuDnbgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a
References: <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Changes:
 1. Function pblk_rw_io to get bio* as a reference
 2. In pblk_rw_io bio_put call on read case removed

A fix to address issue where
 1. pblk_make_rq calls pblk_rw_io passes bio* pointer as a value (0xA)
 2. pblk_rw_io calls blk_queue_split passing bio* pointer as reference
 3. In blk_queue_split, when there is a split, the original bio* (0xA)
    is passed to generic_make_requests, and the newly allocated bio is
    returned
 4. If NVM_IO_DONE returned, pblk_make_rq calls bio_endio on the bio*,
    that is not the one returned by blk_queue_split
 5. As a result bio_endio is not called on the newly allocated bio.

Signed-off-by: chansol.kim <chansol.kim@samsung.com>
---
 drivers/lightnvm/pblk-init.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b57f764d..4efc929 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -31,30 +31,24 @@ static DECLARE_RWSEM(pblk_lock);
 struct bio_set pblk_bio_set;
 
 static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
-			  struct bio *bio)
+			  struct bio **bio)
 {
-	int ret;
-
 	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
 	 * constraint. Writes can be of arbitrary size.
 	 */
-	if (bio_data_dir(bio) == READ) {
-		blk_queue_split(q, &bio);
-		ret = pblk_submit_read(pblk, bio);
-		if (ret == NVM_IO_DONE && bio_flagged(bio, BIO_CLONED))
-			bio_put(bio);
-
-		return ret;
+	if (bio_data_dir(*bio) == READ) {
+		blk_queue_split(q, bio);
+		return pblk_submit_read(pblk, *bio);
 	}
 
 	/* Prevent deadlock in the case of a modest LUN configuration and large
 	 * user I/Os. Unless stalled, the rate limiter leaves at least 256KB
 	 * available for user I/O.
 	 */
-	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
-		blk_queue_split(q, &bio);
+	if (pblk_get_secs(*bio) > pblk_rl_max_io(&pblk->rl))
+		blk_queue_split(q, bio);
 
-	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
+	return pblk_write_to_cache(pblk, *bio, PBLK_IOTYPE_USER);
 }
 
 static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
@@ -69,7 +63,7 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
 		}
 	}
 
-	switch (pblk_rw_io(q, pblk, bio)) {
+	switch (pblk_rw_io(q, pblk, &bio)) {
 	case NVM_IO_ERR:
 		bio_io_error(bio);
 		break;
-- 
2.7.4


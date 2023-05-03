Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DF6C77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 10:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjECKJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjECKJM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 06:09:12 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D068844A1
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 03:09:09 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230503100908epoutp03ac55905eeb668e910adf6229943446d0~bmk6epIIR1928519285epoutp03e
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 10:09:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230503100908epoutp03ac55905eeb668e910adf6229943446d0~bmk6epIIR1928519285epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108548;
        bh=kra6K6+UrYLIE+JQHy/nrTmW6GTWNgEH+aD6dQYjQ8E=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=WsAfJpBqvVnJDYUH62PLtpP/C7VxG63VKV4tLsVXFUfWa0Fup+Ut6FVbmDxfsqHjT
         rVyWf08TUWJtHTYDtqp2k1LU4+wsRH4BaHqKES/nXkiseGUSMKVtJydBBJLjcebNN9
         b1PH+MXzvU7uLN2zzb7Ewo9VW1UxWYe2TyhdPnpg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503100907epcas2p3449f6572ea0db3a9b054da777cfb6efc~bmk6Aaucn2526925269epcas2p33;
        Wed,  3 May 2023 10:09:07 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QBCN3198vz4x9Pr; Wed,  3 May
        2023 10:09:07 +0000 (GMT)
X-AuditID: b6c32a45-c6fb9a8000020cc1-43-645232c276f4
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.1D.03265.2C232546; Wed,  3 May 2023 19:09:07 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 04/15] block: bio-integiry: cleanup bio_integrity_prep
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503100906epcms2p35226430da085d7449840bb122a6b193c@epcms2p3>
Date:   Wed, 03 May 2023 19:09:06 +0900
X-CMS-MailID: 20230503100906epcms2p35226430da085d7449840bb122a6b193c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmhe5ho6AUg3e9TBar7/azWbw8pGmx
        cvVRJove/q1sFntvaVtc3jWHzWL58X9MDuwel8+Weuy+2cDm8fHpLRaPvi2rGD0+b5ILYI3K
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ2x
        a8lR9oI5fBWNW7cyNjDu4O5i5OSQEDCReLj1G3sXIxeHkMAORom+Z5+AHA4OXgFBib87hEFq
        hAXcJB4tucwMYgsJKEmcWzOLEaREWMBA4lavOUiYTUBP4ueSGWwgtojAaiaJ5uc1EON5JWa0
        P2WBsKUlti/fyghicwr4STzecIsRIq4h8WNZLzOELSpxc/Vbdhj7/bH5UDUiEq33zkLVCEo8
        +LkbKi4pcejQVzaQcyQE8iU2HAiECNdIvF1+AKpEX+Jax0awE3gFfCV29J8FO5NFQFVixdQ5
        UKe5SPTPOA82nllAXmL72znMICOZBTQl1u/Sh5iuLHHkFgtEBZ9Ex+G/7DAPNmz8jZW9Y94T
        JohWNYlFTUYQYRmJr4fns09gVJqFCORZSNbOQli7gJF5FaNYakFxbnpqsVGBITxek/NzNzGC
        U6KW6w7GyW8/6B1iZOJgPMQowcGsJML7odAvRYg3JbGyKrUoP76oNCe1+BCjKdDDE5mlRJPz
        gUk5ryTe0MTSwMTMzNDcyNTAXEmcV9r2ZLKQQHpiSWp2ampBahFMHxMHp1QDU9/9+fNsfW+v
        0f0hZrSx00uP13G3eOpkaUtd7vk/54cVfHD7ZsFXe3HS/rBHrlcZ0s+zLXP6eNLnXpznne19
        0oUs89TScjs+TC5dafSZ9/ihldrP37f8kuH43+66eH/eg7NHg7qVii3XZOn4eNhozb5reF1/
        yb5dDv5ssjIP7MJXdJ74v+3P35XvDt88W71U+W95amLoN6cby9NeK4vPjchMvv5Hr2rXo+4t
        l4OUpoSyphqd0lY76+Xo3WdnVxaqN6/35rvunYbt4mt1umrqAuMdH03L1zxlmaS4ZFX40wCd
        R/7LRGS6Lz/elPl/boxIkfbGfmuOR5fklsb7c9aaPLef9H1qqtCF/k6XmBhLJZbijERDLeai
        4kQAQxDxARIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p3>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a problem occurs in the process of creating an integrity payload, the
status of bio is always BLK_STS_RESOURCE.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 74cf9933c285..329c44eca83d 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -278,7 +278,6 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
 	unsigned int intervals;
-	blk_status_t status;
 
 	if (!bi)
 		return true;
@@ -307,7 +306,6 @@ bool bio_integrity_prep(struct bio *bio)
 	/* Allocate kernel buffer for protection data */
 	len = intervals * bi->tuple_size;
 	buf = kmalloc(len, GFP_NOIO);
-	status = BLK_STS_RESOURCE;
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
 		goto err_end_io;
@@ -322,7 +320,6 @@ bool bio_integrity_prep(struct bio *bio)
 	if (IS_ERR(bip)) {
 		printk(KERN_ERR "could not allocate data integrity bioset\n");
 		kfree(buf);
-		status = BLK_STS_RESOURCE;
 		goto err_end_io;
 	}
 
@@ -346,7 +343,6 @@ bool bio_integrity_prep(struct bio *bio)
 		if (bio_integrity_add_page(bio, virt_to_page(buf),
 					   bytes, offset) < bytes) {
 			printk(KERN_ERR "could not attach integrity payload\n");
-			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
 
@@ -365,10 +361,9 @@ bool bio_integrity_prep(struct bio *bio)
 	return true;
 
 err_end_io:
-	bio->bi_status = status;
+	bio->bi_status = BLK_STS_RESOURCE;
 	bio_endio(bio);
 	return false;
-
 }
 EXPORT_SYMBOL(bio_integrity_prep);
 
-- 
2.34.1

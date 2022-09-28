Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16FAC32771
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 11:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiI1L5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiI1L5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 07:57:22 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA7647D0
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 04:57:21 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220928115716euoutp01a64568726fca054373d221df89a0f216~ZBEYfANmu0385303853euoutp01f
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 11:57:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220928115716euoutp01a64568726fca054373d221df89a0f216~ZBEYfANmu0385303853euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664366236;
        bh=vaGYGFuMZ/uqlTVkiRH+00rcbs8NspHnrYa/+AQ8J4E=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=kHaKoiqRwVgNZ6oXVLXgsshqa5QNSkT5AYC1GkFjy3gbWVXRVYMhgvgyMpk4FSeV+
         KkvVg0ki5DTqgOyv9STlauMGTyzrfePXMs6Xck2bmDCPn799HlrTN/flnt1U9LH974
         RWSMxOc6mmxLZzv+ahQzaE5vAyrv0SLnKBRQJjaM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220928115716eucas1p1d7b5b8505d1d2f044699b7d6a98e1948~ZBEYL7Dz72105321053eucas1p14;
        Wed, 28 Sep 2022 11:57:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9B.A7.19378.C9634336; Wed, 28
        Sep 2022 12:57:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220928115715eucas1p242a31b0669b84b31968f75c7dace167a~ZBEX7GmcM2212122121eucas1p2w;
        Wed, 28 Sep 2022 11:57:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220928115715eusmtrp1fcec6c9799fae6a657fd3d6abed0c14a~ZBEX6cQgZ2558425584eusmtrp1h;
        Wed, 28 Sep 2022 11:57:15 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-b2-6334369c8038
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.77.07473.B9634336; Wed, 28
        Sep 2022 12:57:15 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220928115715eusmtip22e1f92c0f7ec0dd6208867b5439f5b8f~ZBEXxdB031156711567eusmtip2f;
        Wed, 28 Sep 2022 11:57:15 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.168) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 28 Sep 2022 12:57:14 +0100
Message-ID: <43776c04-8a84-a0e7-b77f-a0aa30fdc47f@samsung.com>
Date:   Wed, 28 Sep 2022 13:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-block@vger.kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.168]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd05ZibJBg0H2S1W3+1ns/h99jyz
        xekJi5gs9t7SdmDx2LxCy+Py2VKPna33WT0+b5ILYInisklJzcksSy3St0vgypj2/wtTQYto
        RdfhVqYGxj2CXYycHBICJhL3l15k7GLk4hASWMEosXtxAxOE84VRonvXbSjnM6PEnBWTWWBa
        1j5YwgqRWM4o8eD6Bla4qqUTp7JBOLsZJQ4uugbWwitgJ/F80nagLRwcLAKqEjeem0CEBSVO
        znwCViIqECmxZvdZdhBbWCBJ4uCf86wgNrOAuMStJ/OZQGwRgVyJ2S3HWUHGMAtYSvTPMQYx
        2QS0JBo72UFMTgFbiVUzZCEaNSVat/9mh7DlJba/ncMMcb6yxPLTM6HsWom1x86wgxwsIfCA
        Q2LD1mlsEAkXiV/LrzBC2MISr45vYYewZSROT+6BhkO1xNMbv5khmlsYJfp3rmcDOUJCwFqi
        70wORI2jxJl/C5ghwnwSN94KQtzDJzFp23TmCYyqs5DCYRaSf2cheWEWkhcWMLKsYhRPLS3O
        TU8tNs5LLdcrTswtLs1L10vOz93ECEwqp/8d/7qDccWrj3qHGJk4GA8xSnAwK4nw/j5qmCzE
        m5JYWZValB9fVJqTWnyIUZqDRUmcl22GVrKQQHpiSWp2ampBahFMlomDU6qByXtRgKBG6b/m
        iWwr/qTdUMi9GHdhQ/LXZ+eKOJTCJ76rvSX5ZEdwatnFFHeG9avnxT7MnvvqVujzJwe2tdx4
        239V/M7nupocj1v6bDo3RfXmKq7vcGQx1zjuJORx6/phTe7Zojal6tskT2bG1M0xisxriTmx
        Un3BlngtKZGcyNfir1frc/mLNHFU8mxfacfPcynKd2WgSnOhweRf0geX3djW+rlxctblr+aH
        DON9DeaWikmyrni4+NQhu/u2S+0PbpGeyrd98f/6K9dfcE6qvmYX8njW+q5tFk2t9RMcZ2Ud
        XDHlt+nL0zsPt7O+PfF6wufdN2aJf3j16l7wtjMNFXrl7LuO2k1OfH5HOcXn+lklluKMREMt
        5qLiRABSZ1/UmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7qzzUySDRqPG1usvtvPZvH77Hlm
        i9MTFjFZ7L2l7cDisXmFlsfls6UeO1vvs3p83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hp
        oWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzHt/xemghbRiq7DrUwNjHsEuxg5OSQETCTW
        PljC2sXIxSEksJRR4sTbjawQCRmJT1c+skPYwhJ/rnWxQRR9ZJT4PWcWO4Szm1Fi+9qVLCBV
        vAJ2Es8nbWfsYuTgYBFQlbjx3AQiLChxcuYTsBJRgUiJh8uamEBsYYEkiYN/zoMtYxYQl7j1
        ZD5YXEQgV2J2y3FWkDHMApYS/XOMIVY9YJE4dbKfHSTOJqAl0dgJZnIK2EqsmiELMUVTonX7
        b3YIW15i+9s5zBDnK0ssPz0Tyq6VeHV/N+MERtFZSI6bheSIWUhGzUIyagEjyypGkdTS4tz0
        3GJDveLE3OLSvHS95PzcTYzAWNx27OfmHYzzXn3UO8TIxMF4iFGCg1lJhPf3UcNkId6UxMqq
        1KL8+KLSnNTiQ4ymwACayCwlmpwPTAZ5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Yklqdmp
        qQWpRTB9TBycUg1MU1JrdtrN1Kx/rWe1SXD1Ma26/1/2uR+S+r3h5QzOn5ZXGoJNb7plWjC9
        //Vvvr9iHUvaU71bR+Vzmyasf1JtcfznFAHzuG+BB41n/u56vTDqZqytLNOWY6cnJ35M+a3x
        +XvYOUOzCLXIhX4/rY6vNkpyVj3y6KKWAfsWpfT5xkvP+DkpWq0y5r8hMuFBudRNpb4tr04u
        F7l0YPv1F8t1V9xb3aim8KRRZObF2tiW0tv3l239aVHyYJne3517Htw/a79vVsAlayOLGt9U
        GX/feO8N+2ZwTv6yX/5prf6m8I9lZa1ya3dM5dM71xGXsntic6sYf7LaG3aNlRnT7QUFjD+7
        Ptc1P3B4pen6yY8tfyuxFGckGmoxFxUnAgDEJIeATgMAAA==
X-CMS-MailID: 20220928115715eucas1p242a31b0669b84b31968f75c7dace167a
X-Msg-Generator: CA
X-RootMTR: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
        <20220925185348.120964-2-p.raghav@samsung.com>
        <YzG5RgmWSsH6rX08@infradead.org>
        <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
        <YzG6fZdz6XBDbrVB@infradead.org>
        <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
        <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
        <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
        <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
        <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
        <YzMp+SIsv6Aw4bFW@infradead.org>
        <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-09-27 18:52, Jens Axboe wrote:
>> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
>> REQ_OP_WRITE_ZEROES.  So this should be:
>>
>> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
>> 		return NULL;
> 
> I'd rather just make it explicit and use that. Pankaj, do you want
> to spin a v2 with that?
> 

Based on all the suggestions:

block: adapt blk_mq_plug() to not plug for writes that require a zone lock

The current implementation of blk_mq_plug() disables plugging for all
operations that involves a transfer to the device as we just check if
the last bit in op_is_write() function.

Modify blk_mq_plug() to disable plugging only for REQ_OP_WRITE and
REQ_OP_WRITE_ZEROS as they might require a zone lock.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8ca453ac243d..297289cdd521 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -312,7 +312,8 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 static inline struct blk_plug *blk_mq_plug( struct bio *bio)
 {
 	/* Zoned block device write operation case: do not plug the BIO */
-	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    blk_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
 		return NULL;

 	/*
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a264621d4905..fa926424edb6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -63,13 +63,10 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;

-	switch (req_op(rq)) {
-	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE:
+	if (blk_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
 		return blk_rq_zone_is_seq(rq);
-	default:
-		return false;
-	}
+
+	return false;
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8038c5fbde40..719025028fa4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1300,6 +1300,15 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
 	return false;
 }

+static inline bool blk_op_is_zoned_write(struct block_device *bdev,
+					 blk_opf_t op)
+{
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
+}
+
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);


Does this look fine?

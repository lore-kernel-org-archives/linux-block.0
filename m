Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8D6C05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 14:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBQO1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBQO1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 09:27:18 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FBF9779
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 06:27:15 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230217142711euoutp01d6db9fb09faff47c74b57b0436da0c74~Eot0esZSA2898728987euoutp01b
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 14:27:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230217142711euoutp01d6db9fb09faff47c74b57b0436da0c74~Eot0esZSA2898728987euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676644031;
        bh=ZFjusZdw7p9y9af3qIc6LJXgm9LI3j+0vstRFRMrsbA=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=ewpg2KynJejqhOtw+TTKkuGaTCRCl5cnlwle84eZiQDrptM5SSiZCUVlWk9HSnXkO
         E1YzLXRdX1ONz23fhMHDas6RODr8g2JFVnSNCKKUajy+qS5kyy4nHYXQ6dzwUaIVht
         CK6iWkFFnaFbuZgYyADFAAML5pXHLtuQHNZiImPA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230217142711eucas1p2ef4fae851b086f0195e41662d570857d~Eotz7Bq-81179811798eucas1p2V;
        Fri, 17 Feb 2023 14:27:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 06.20.13597.FBE8FE36; Fri, 17
        Feb 2023 14:27:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230217142710eucas1p29f1f9cb860c8e7dd9cdbeb64e0a0cad3~EotzjstnT1142211422eucas1p2d;
        Fri, 17 Feb 2023 14:27:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230217142710eusmtrp10c50f34550164306e584fa3f290fcf62~EotzjDuxm1206212062eusmtrp1V;
        Fri, 17 Feb 2023 14:27:10 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-f2-63ef8ebf66f4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.59.00518.EBE8FE36; Fri, 17
        Feb 2023 14:27:10 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230217142710eusmtip202735ec72d160a48221ea13b3b11942f~EotzW7ajT0254502545eusmtip2H;
        Fri, 17 Feb 2023 14:27:10 +0000 (GMT)
Received: from [192.168.1.19] (106.210.248.118) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 17 Feb 2023 14:27:08 +0000
Message-ID: <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
Date:   Fri, 17 Feb 2023 19:57:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.7.1
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
To:     Jens Axboe <axboe@kernel.dk>
CC:     <hch@lst.de>, <mcgrof@kernel.org>, <gost.dev@samsung.com>,
        <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.118]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7r7+94nGxzexW2x+m4/m8XK1UeZ
        LPbe0ra4MeEpo8Whyc1MDqwel8+Wemxa1cnmsftmA5vH+31X2Tw+b5ILYI3isklJzcksSy3S
        t0vgyvgyT7TgiHbFx56DbA2Ms5S6GDk4JARMJOb/4O5i5OIQEljBKPF//mpWCOcLo8S+5dMZ
        IZzPjBIfLmxi72LkBOu49WQOVGI5o8SEx9dY4KqutfdDZXYxSmw6u5MJpIVXwE7i5MavYDaL
        gKrEplNnmSHighInZz5hAbFFBaIkTv18zQRyFJuAlkRjJ9g2YQEbiXVz9oGViwgoSPT8XskG
        YjML1En0N7UxQ9jiQBfNBxvPKWArMfP6Jai4pkTr9t/sELa8xPa3c5ghPlCWOPXkASuEXStx
        asstJpCbJQRecEjs7l/NBJFwkVj6aD0jhC0s8er4Fqj3ZSROT+5hgbCrJZ7e+M0M0dzCKNG/
        cz0bJFStJfrO5EDUOEo0nnvCChHmk7jxVhDiHj6JSdumM09gVJ2FFBKzkLwzC8kLs5C8sICR
        ZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgsjn97/iXHYzLX33UO8TIxMF4iFGCg1lJ
        hHfTzTfJQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODilGpji
        jbX2qNn8lZr09JSboMtuptd5jRV3ZMomVvY276stT/3c23Vv60TbKgv2UMMZj/SkDmhP8C7i
        /dhQ/+XpAqUlq4XFhFf9nXTEO2GGGfMzB9mvv1cvmTHpm2mDxrWdO0o/dB0Ra56iNq0waUdn
        zNWdn+Y57ZnPcn2++esNH99NX2WpYdCmxJpz60vVH9E7bDunT62s572QdjurSmK1+P8I3nUn
        ulS2/HWZ4qbmwfJz82nue1GHzHutDGVkf/qa15gms76+ps9osYH/ppW9p93rl9GnrT2jrhnv
        DDYVvLtQzlSF866ggYLew+e7MmXvCfuvvRt26+P6mH2880J9Pe8K7xVR/DW18v7Hi6u+57cr
        sRRnJBpqMRcVJwIAXJS3GKUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7r7+t4nG/Ss17dYfbefzWLl6qNM
        FntvaVvcmPCU0eLQ5GYmB1aPy2dLPTat6mTz2H2zgc3j/b6rbB6fN8kFsEbp2RTll5akKmTk
        F5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXyZJ1pwRLviY89BtgbG
        WUpdjJwcEgImEreezGHsYuTiEBJYyiixYEc7C0RCRuLTlY/sELawxJ9rXWwQRR8ZJfbe2QvV
        sYtRYuaaT2AdvAJ2Eic3fmUCsVkEVCU2nTrLDBEXlDg58wlYjahAlMTpleuApnJwsAloSTR2
        gi0QFrCRWDdnH1i5iICCRM/vlWwgNrNAnUR/UxszxK5bTBJHXz9gh0iIA509H2wXp4CtxMzr
        l5gh4poSrdt/Q9XIS2x/O4cZ4gNliVNPHrBC2LUSn/8+Y5zAKDoLyXmzkIydhWTULCSjFjCy
        rGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM0m3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeDfd
        fJMsxJuSWFmVWpQfX1Sak1p8iNEUGEYTmaVEk/OBaSKvJN7QzMDU0MTM0sDU0sxYSZzXs6Aj
        UUggPbEkNTs1tSC1CKaPiYNTqoGJM1dihePM/ueHznIHvolyadruucP74QqbPWZckxVnS0Rq
        N9UGrUoulkybJrB9x78svrKo+Dn7TG7ufb9QoW1+yon11+58Zpht1HGQV/zaURa7iSLH721T
        rxCo+/Vtm920ptpspvU7q41vzHb40humcOVnrY/C3Pl3lRn+S/FabLapivNzUpmzY/lSi7cR
        ES7GLvN/OF/eNb96adWq7R8+rLq4/Wanwi3TkMc/D2pVbthpd0hw2YGK8OV6XeYx+9al230X
        P3D1g+KibpWLyfMP2EQrmWRIz2TdtTLmiA9DZI/9B/5v28OOq4dOiGDz1kjuZvR5IvM5IPVK
        /Vv1+as+NlV+y/T/GvVP9F3Zrg8RSizFGYmGWsxFxYkAX2GNg1sDAAA=
X-CMS-MailID: 20230217142710eucas1p29f1f9cb860c8e7dd9cdbeb64e0a0cad3
X-Msg-Generator: CA
X-RootMTR: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
        <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
        <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
        <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
        <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 2023-02-16 05:08, Jens Axboe wrote:

> I think your numbers are skewed because brd isn't flagg nowait, can you
> try with this?
> 
> I ran some quick testing here, using the current tree:
> 
> 		without patch		with patch
> io_uring	~430K IOPS		~3.4M IOPS
> libaio		~895K IOPS		~895K IOPS
> 
> which is a pretty substantial difference...
> 

I rebased my blk-mq changes on top of your nowait patches, but still I see a
regression with blk-mq. When I tried to trace and run perf, nothing odd
stood out, except for the normal blk-mq overhead.

Could you try it in your setup and see if you are noticing a similar trend?
Because based on the numbers you shared yesterday, I didn't see this regression.

fio script I run to benchmark:

$ fio --name=<workload>  --rw=<workload>  --ramp_time=5s --size=1G
--io_size=10G --loop=4 --cpus_allowed=1 --filename=/dev/ram0 --direct=1
--iodepth=128 --ioengine=<engine>

+-----------+-----------+--------+--------+
| io_uring  | bio(base) | blk-mq | delta  |
+-----------+-----------+--------+--------+
|   read    |    577    |  446   | -22.7  |
| randread  |    504    |  416   | -17.46 |
|   write   |    554    |  424   | -23.47 |
| randwrite |    484    |  381   | -21.28 |
+-----------+-----------+--------+--------+

+-----------+-----------+--------+--------+
|  libaio   | bio(base) | blk-mq | delta  |
+-----------+-----------+--------+--------+
|   read    |    412    |  341   | -17.23 |
| randread  |    389    |  335   | -13.88 |
|   write   |    401    |  329   | -17.96 |
| randwrite |    351    |  304   | -13.39 |
+-----------+-----------+--------+--------+

My rebased blk-mq diff:

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 34177f1bd97d..726c4b94c7b6 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -16,6 +16,7 @@
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
+#include <linux/blk-mq.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
@@ -46,6 +47,7 @@ struct brd_device {
 	spinlock_t		brd_lock;
 	struct radix_tree_root	brd_pages;
 	u64			brd_nr_pages;
+	struct blk_mq_tag_set tag_set;
 };

 /*
@@ -284,40 +286,48 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	return err;
 }

-static void brd_submit_bio(struct bio *bio)
+static blk_status_t brd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd)
 {
-	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
-	sector_t sector = bio->bi_iter.bi_sector;
+	struct request *rq = bd->rq;
+	struct brd_device *brd = hctx->queue->queuedata;
+	sector_t sector = blk_rq_pos(rq);
 	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct req_iterator iter;
+	blk_status_t err = BLK_STS_OK;

-	bio_for_each_segment(bvec, bio, iter) {
+	blk_mq_start_request(bd->rq);
+	rq_for_each_segment(bvec, rq, iter) {
 		unsigned int len = bvec.bv_len;
-		int err;
+		int ret;

 		/* Don't support un-aligned buffer */
 		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
+			     (len & (SECTOR_SIZE - 1)));

-		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-				  bio->bi_opf, sector);
-		if (err) {
-			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
-				bio_wouldblock_error(bio);
-				return;
-			}
-			bio_io_error(bio);
-			return;
+		ret = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
+				  rq->cmd_flags, sector);
+		if (ret) {
+			if (ret == -ENOMEM && rq->cmd_flags & REQ_NOWAIT)
+				err = BLK_STS_AGAIN;
+			else
+				err = BLK_STS_IOERR;
+			goto end_request;
 		}
 		sector += len >> SECTOR_SHIFT;
 	}

-	bio_endio(bio);
+end_request:
+	blk_mq_end_request(bd->rq, err);
+	return BLK_STS_OK;
 }

+static const struct blk_mq_ops brd_mq_ops = {
+	.queue_rq = brd_queue_rq,
+};
+
 static const struct block_device_operations brd_fops = {
 	.owner =		THIS_MODULE,
-	.submit_bio =		brd_submit_bio,
 };

 /*
@@ -361,7 +371,7 @@ static int brd_alloc(int i)
 	struct brd_device *brd;
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
-	int err = -ENOMEM;
+	int err = 0;

 	list_for_each_entry(brd, &brd_devices, brd_list)
 		if (brd->brd_number == i)
@@ -370,6 +380,15 @@ static int brd_alloc(int i)
 	if (!brd)
 		return -ENOMEM;
 	brd->brd_number		= i;
+	brd->tag_set.ops = &brd_mq_ops;
+	brd->tag_set.queue_depth = 128;
+	brd->tag_set.numa_node = NUMA_NO_NODE;
+	brd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING |
+			     BLK_MQ_F_NO_SCHED_BY_DEFAULT;
+	brd->tag_set.cmd_size = 0;
+	brd->tag_set.driver_data = brd;
+	brd->tag_set.nr_hw_queues = 1;
+
 	list_add_tail(&brd->brd_list, &brd_devices);

 	spin_lock_init(&brd->brd_lock);
@@ -380,9 +399,17 @@ static int brd_alloc(int i)
 		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
 				&brd->brd_nr_pages);

-	disk = brd->brd_disk = blk_alloc_disk(NUMA_NO_NODE);
-	if (!disk)
+	err = blk_mq_alloc_tag_set(&brd->tag_set);
+	if (err) {
+		err = -ENOMEM;
 		goto out_free_dev;
+	}
+
+	disk = brd->brd_disk = blk_mq_alloc_disk(&brd->tag_set, brd);
+	if (IS_ERR(disk)) {
+		err = PTR_ERR(disk);
+		goto out_free_tags;
+	}

 	disk->major		= RAMDISK_MAJOR;
 	disk->first_minor	= i * max_part;
@@ -414,6 +441,8 @@ static int brd_alloc(int i)

 out_cleanup_disk:
 	put_disk(disk);
+out_free_tags:
+	blk_mq_free_tag_set(&brd->tag_set);
 out_free_dev:
 	list_del(&brd->brd_list);
 	kfree(brd);
-- 
2.39.1

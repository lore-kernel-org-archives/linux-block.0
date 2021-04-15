Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D37C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D7C61222
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 10:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDOK4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:56:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45769 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOK4g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 06:56:36 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210415105611epoutp048c45d9fb4e47c483e3f27f7e2da73a2f~2Asd18QcV2398623986epoutp04n
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 10:56:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210415105611epoutp048c45d9fb4e47c483e3f27f7e2da73a2f~2Asd18QcV2398623986epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618484171;
        bh=Z44z3Lkz3Z/wDbPAEE/WCSjzDxeBal58wKN8vdQlIX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=me1UcxdyOH/Yen5ZCezEz8+xX2hG9GMzPS1wMCZ6TcP/YbxFGoN6mNIDyJIma3R9U
         ww0vRECdmXneDecO+Y+I2G0KEoc5cwO4Q5uiz0setiH203pS8qwCnzwZunCgQ+xdDE
         43ZEmUJZT5SyIlR7HfN+OK3x1/nAiG5VXLLPQ/Cs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210415105610epcas1p1f09c03ed76c5e2de6ed6cf39521ea70b~2AscphuE11703717037epcas1p1N;
        Thu, 15 Apr 2021 10:56:10 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FLbqY1bwgz4x9Pq; Thu, 15 Apr
        2021 10:56:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.E9.02277.9CB18706; Thu, 15 Apr 2021 19:56:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210415105608epcas1p269bae87b8a7dab133753f7916420251e~2Asac748W0970809708epcas1p2T;
        Thu, 15 Apr 2021 10:56:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210415105608epsmtrp2488d3100a157adb1b392ca8481050c21~2Asaben-W1601216012epsmtrp25;
        Thu, 15 Apr 2021 10:56:08 +0000 (GMT)
X-AuditID: b6c32a36-4edff700000108e5-3e-60781bc9caf8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.A2.33967.7CB18706; Thu, 15 Apr 2021 19:56:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210415105607epsmtip1fe2d434b793a03a751722f2556893984~2AsaICRa70849408494epsmtip17;
        Thu, 15 Apr 2021 10:56:07 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v7 1/3] bio: limit bio max size
Date:   Thu, 15 Apr 2021 19:38:20 +0900
Message-Id: <20210415103820.23272-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <2e54f27a-ae4c-af65-34ba-18b43bd4815d@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGc3rb2xZXcymMnTHHSjMg4MCWWrwT2FzGzM1wyj7YksUMbuAO
        0NJ2/WCwmIxRKAhYAck2CohQoozpcHwIOPEDRGR2E2wpGYkiVoegfKyVigpuLRcy/nve9/ye
        +5z3nHM5CN+B+nMy5BpKJSdlQtSLeaYvVBQ++Ep2sui2noPXNJ8B+M83D6P49/NPELyg0MXA
        daYWFL9W1sDAS+/msfDl4lsMfGFCjfeMbcYtZ2tQvPeIjoH/0FaD4LZxMxvvuzXCxCcayxH8
        z0EHCz9q34E/PdEP8LnFUTb+e9cRBG/peYLu8CMs1niiXDfLJrqNN9lEW1MYYflDS7Q2H0SJ
        C7Un2cTc+RGUMLQ3A8LZGkAUXixhJGz4XBaTTpGplEpAyVMUqRnytFhh/MdJ7yZJo0TicPGb
        +DahQE5mUrHCuF0J4TszZO5JhYIsUqZ1txJItVq45a0YlUKroQTpCrUmVkgpU2VKsUgZoSYz
        1Vp5WkSKInO7WCSKlLrJZFl6nTleORCQfeJvOzMXHHq5GHA5ENsKH9+4zi4GXhw+1gWgveo4
        gy4cABqrriIeio+5ALSO8tYcTXPnWTTUA2Djb60oXTgBfDg4zPJQKPYGNMyMoR7ti/lByyMX
        8EAIpmfCsXzbyoIPJoGdy/Vsj2ZiQbDMZGR4NA+LhpX59YCOew0ujZeubIPr7pv+OYzQjDcc
        rLrL9GjEzeg6qhFPAMQWOXB44DKDNsfBqw+/Y9PaB04PtK9qf+ic7UFpQwmAOn0doIsy90CT
        x1fdEuhwOt0LHHdEKGw5u4VuB8LuZ7WATt4IZxdKWR4EYjxYpOfTyOvQnD+OrGVNnupe/SIB
        p62NCH1cBgDnTAakDAiM6wYyrhvI+H/yMYA0Az9Kqc5Mo9RiZeT6O24FK48/LKoLVMzMR/QC
        Bgf0AshBhL68nZWaZD4vlcz5hlIpklRaGaXuBVL3cZcj/i+mKNx/j1yTJJZGSiQSfGvUtiip
        RPgSjxTdTuJjaaSG2k9RSkq15mNwuP65jKplS8VQ7cHrpv0PrFadd8C+T8yXjRtD2Xmkz9et
        1fdyCt/OTRyNLWi6P/xsKeP0naJpje4vx+ZgJ+ej/phE7l79c57UGhIgqCj6xXo6iDnE9DPt
        qmxIjEdy67iTI6ir3SYURj/9se/V5Uvfavdm767uMJYsmHWHfs0/MGVfejA01fhFcMhXUl+f
        fsupCy05aDXxzgf/nsve8+jijXvWCYb+y922IZK7vc41dWWqpWbOfulxQVZg+aJrz7Er+fts
        hiD0J+9P7+uC7bLOkvdfQLjRSP1y3IGjbXees1xET0r7TKfNZDBnTc43hERsqJb5nzRsKjn3
        WR7L4RXYcW3Th+/NQiFTnU6KwxCVmvwPdMkQPIUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnO5x6YoEg0PTrSzmrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        XDYpqTmZZalF+nYJXBnzz3gXHJerWP7sMUsDY69kFyMnh4SAicSK9/tYQWwhgd2MEo2LOCHi
        UhLHT7wFinMA2cIShw8XdzFyAZV8ZJRYN+0qE0gNm4CORN/bW2wgtoiAmMTlL98YQYqYBRaw
        SBzceYIdJCEsYCyx/e9CMJtFQFViwuJZYM28AtYSU1oWMkIsk5f4c7+HGcTmBIov/tjPDHGQ
        lcSnxb1sEPWCEidnPmEBsZmB6pu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwZGppbmDcfuqD3qHGJk4GA8xSnAwK4nwuk0pSRDiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBSe+x8OOsc8V1bxlMozP2P8hYuKBe
        NIx/fRdL5dSKFr7VzwpNJgadOHQw/ItwXLqYuOVBYfG/m0VcI77NXX7P8ubZmuM/Nnh84XTW
        dqv6Jvxxh8nSKwK9rZfWMKjX6784YPxJpu/vtNi5rWe2pkVMmKbUcPLUBy7W1h/TT3hsfx6r
        VrDGxU/05b+89dWvZ+v0buzena64adFf4y2VKl7BCY5Xp906L1B3qj7LeI/Ozc9+tx5ot2xs
        Oqe5Wnedr9yyq+VHUn+/32nmJ6/WwnppMof656/vj0Temz8tLez59UU7YqzuTlHkadSfv7dA
        Wd3kCUONxiLx4m+PZ3W9T+VyC49VF/+1gpkjYPUDhj71zUosxRmJhlrMRcWJAHbf3oU7AwAA
X-CMS-MailID: 20210415105608epcas1p269bae87b8a7dab133753f7916420251e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210415105608epcas1p269bae87b8a7dab133753f7916420251e
References: <2e54f27a-ae4c-af65-34ba-18b43bd4815d@acm.org>
        <CGME20210415105608epcas1p269bae87b8a7dab133753f7916420251e@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/12/21 7:55 PM, Changheun Lee wrote:
> > +unsigned int bio_max_size(struct bio *bio)
> > +{
> > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > +
> > +	if (blk_queue_limit_bio_size(q))
> > +		return blk_queue_get_max_sectors(q, bio_op(bio))
> > +			<< SECTOR_SHIFT;
> > +
> > +	return UINT_MAX;
> > +}
> 
> This patch adds an if-statement to the hot path and that may have a
> slight negative performance impact. I recommend to follow the approach
> of max_hw_sectors. That means removing QUEUE_FLAG_LIMIT_BIO_SIZE and to
> initialize the maximum bio size to UINT_MAX in blk_set_default_limits().
> 
> Thanks,
> 
> Bart.

I modified as Bart's approach. Thanks for your advice.
It's more simple than before. I think it looks good.
Please, review below. I'll prepare new version base on this.


diff --git a/block/bio.c b/block/bio.c
index 50e579088aca..9e5061ecc317 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+unsigned int bio_max_size(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+
+	return q->limits.bio_max_bytes;
+}
+
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
@@ -866,7 +873,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
 				*same_page = false;
 				return false;
 			}
diff --git a/block/blk-settings.c b/block/blk-settings.c
index b4aa2f37fab6..b167e8db856b 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -37,6 +37,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
  */
 void blk_set_default_limits(struct queue_limits *lim)
 {
+	lim->bio_max_bytes = UINT_MAX;
 	lim->max_segments = BLK_MAX_SEGMENTS;
 	lim->max_discard_segments = 1;
 	lim->max_integrity_segments = 0;
@@ -167,6 +168,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	max_sectors = round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
+	limits->bio_max_bytes = max_sectors << SECTOR_SHIFT;
 
 	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
 }
@@ -538,6 +540,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 {
 	unsigned int top, bottom, alignment, ret = 0;
 
+	t->bio_max_bytes = min_not_zero(t->bio_max_bytes, b->bio_max_bytes);
+
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d0246c92a6e8..e5add63da3af 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
 	return NULL;
 }
 
+extern unsigned int bio_max_size(struct bio *bio);
+
 /**
  * bio_full - check if the bio is full
  * @bio:	bio to check
@@ -119,7 +121,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return true;
 
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
 		return true;
 
 	return false;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 158aefae1030..c205d60ac611 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -312,6 +312,8 @@ enum blk_zoned_model {
 };
 
 struct queue_limits {
+	unsigned int		bio_max_bytes;
+
 	unsigned long		bounce_pfn;
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;

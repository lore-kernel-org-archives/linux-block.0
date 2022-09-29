Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93097C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 14:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiI2OmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiI2Olu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 10:41:50 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8011C4808
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 07:41:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220929144144euoutp017ec255f5e598197d759aeca78adca5b5~ZW9Qyq36G2760127601euoutp01N
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 14:41:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220929144144euoutp017ec255f5e598197d759aeca78adca5b5~ZW9Qyq36G2760127601euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664462504;
        bh=C4E2HONia25jRNHQskZeQL5acihlPfRFdJJN0aBzVXo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jnyEVNx9ynSKhokcvF0Vtp+84k1vhb7C+GG/5ipaUF2r6vrxucL5t3DKspMF7GkmU
         foE333X85Sf498X+r33c+4aqD40WqQtNXiT+/TRLsPsezHDqVuU0XoaPHMWK0pTrE4
         AggiZw5cVuQUVsYiGdorQKFOVACeBj0tne2N0Bv4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929144143eucas1p1256133a462cb633efb8c7dddcc2655c8~ZW9P-rWTb1886718867eucas1p1P;
        Thu, 29 Sep 2022 14:41:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0D.5B.19378.7AEA5336; Thu, 29
        Sep 2022 15:41:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220929144143eucas1p2a68d7cb3f5e347954e3a5a5e335cf620~ZW9Pt_B7D2144821448eucas1p2D;
        Thu, 29 Sep 2022 14:41:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220929144143eusmtrp288f58fcf0b9ea910036b6069a171754b~ZW9PtLpwo2386223862eusmtrp2B;
        Thu, 29 Sep 2022 14:41:43 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-c6-6335aea7c46b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.F8.07473.6AEA5336; Thu, 29
        Sep 2022 15:41:42 +0100 (BST)
Received: from localhost (unknown [106.210.248.199]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220929144142eusmtip298b85c94c55d31d0823329e74c3ecf24~ZW9PXoxGG0554405544eusmtip2W;
        Thu, 29 Sep 2022 14:41:42 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, axboe@kernel.dk
Cc:     gost.dev@samsung.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] block: add rationale for not using blk_mq_plug() when
 applicable
Date:   Thu, 29 Sep 2022 16:41:41 +0200
Message-Id: <20220929144141.140077-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzned3l60yTDX62CFusvtvPZvH77Hlm
        i5sHdjJZrFx9lMli7y1ti89LW9gd2Dwuny312H2zgc1jZ+t9Vo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKWPB0DmvBbr6Ka5d/sTUw/uLuYuTkkBAwkbh14QFbFyMXh5DACkaJZW82QTlf
        GCX+LOhkgnA+M0p8vf8LyOEAa7ncmAwRX84o8WzObnYI5yWjxJ4HfawgRWwCWhKNnewgK0QE
        5CVuLFjHAmIzC9RLzPsziRXEFhYIlti08ikjiM0ioCrxa/NSMJtXwEqi5+FZdojz5CVmXvrO
        DhEXlDg58wnUHHmJ5q2zmUH2SgjM5JD4NXsWE0SDi0Rz20EWCFtY4tXxLVCDZCT+75wPVVMt
        8fTGb6jmFkaJ/p3r2SA+s5boO5MDYjILaEqs36UPUe4o8ffdBEaICj6JG28FIU7gk5i0bToz
        RJhXoqNNCKJaSWLnzydQSyUkLjfNYYEo8ZA43i0JEhYSiJV4cK6fdQKjwiwkf81C8tcshBMW
        MDKvYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEwrp/8d/7qDccWrj3qHGJk4GA8xSnAw
        K4nwiheYJgvxpiRWVqUW5ccXleakFh9ilOZgURLnZZuhlSwkkJ5YkpqdmlqQWgSTZeLglGpg
        8olS3Cd3Ne+V/n6/zz9rNqzl1Fl8oqHNIsLx4tNNdR72Ivueqym1sF2TKX3brZza5fotd/rP
        yfcuMRrcXqAa823jJkMh4w1ZDhtZV916Y/mzd1a47aQlJzvZ3xzefe3Vz6NnN+yQ9TuRfGLl
        3/Qy84iDh1xmSX94E2eozp963kO2ilmD9+XM8omJ6xImRTWYOvKapB9z391pdPjw9/qP3svv
        B4sdedlwQs3goOF04TOfxWwz1mruST94vZFdP0H2ydecWruwdFHNydcP8caUH5cKvVKvutsi
        eKXOzYezTcOny1rmfH4hzfRg1l4X1d0/sycsUBCfHHM00OqTZ2PVJM8TPxekK24VjHvI9XZK
        rhJLcUaioRZzUXEiAHbqL7uaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t/xe7rL1pkmGzy/YG2x+m4/m8Xvs+eZ
        LW4e2MlksXL1USaLvbe0LT4vbWF3YPO4fLbUY/fNBjaPna33WT36tqxi9Pi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8HTOawFu/kq
        rl3+xdbA+Iu7i5GDQ0LAROJyY3IXIxeHkMBSRomPv06xdTFyAsUlJG4vbGKEsIUl/lzrYoMo
        es4o8enaFxaQZjYBLYnGTnaQGhEBRYmj21pYQGqYBZoZJY5cfskKkhAWCJRo2n6aBcRmEVCV
        +LV5KdhQXgEriZ6HZ9khFshLzLz0nR0iLihxcuYTsHpmoHjz1tnMExj5ZiFJzUKSWsDItIpR
        JLW0ODc9t9hQrzgxt7g0L10vOT93EyMwqLcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4RUvME0W
        4k1JrKxKLcqPLyrNSS0+xGgKdN9EZinR5HxgXOWVxBuaGZgamphZGphamhkrifN6FnQkCgmk
        J5akZqemFqQWwfQxcXBKNTD583EqfbN9sy2t3fdt5/zn+zV0dV1vd7utUNt0abuoWf89+zsT
        qk5lSS+z+3rKjffP3EOvC+LdnJ1zP8+qOPdEuVLgnuH+2c5LVSZ1OTJ9SVi0U1+3UGvZ9Ocb
        ZdO/S/OnbnZuWbghMUDpwCrj00Lbz4mZhNV/Lkuv9nj/4lj+9CVi6ueLTvMfaPaUbn0UN4fl
        oWTGx3Yb0Wni/+aqN4bbXkmJPqE1NWir2oL6P8ezJLpeL/ZXLoyefPb3y46Vczd8jLv8IHDJ
        TdlzK8T6P/eWRaZfvLw+f64By7pMhjvb639O9t/PvWxn8wW5JZwXj7589nnT2sUPMmazCi1L
        sTk+L4uLM+WQrznn/u3dFRV2SizFGYmGWsxFxYkACR2jj/MCAAA=
X-CMS-MailID: 20220929144143eucas1p2a68d7cb3f5e347954e3a5a5e335cf620
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220929144143eucas1p2a68d7cb3f5e347954e3a5a5e335cf620
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929144143eucas1p2a68d7cb3f5e347954e3a5a5e335cf620
References: <CGME20220929144143eucas1p2a68d7cb3f5e347954e3a5a5e335cf620@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are two places in the block layer at the moment where
blk_mq_plug() helper could be used instead of directly accessing the
plug from struct current. In both these cases, directly accessing the plug
should not have any consequences for zoned devices.

Make the intent explicit by adding comments instead of introducing unwanted
checks with blk_mq_plug() helper.[1]

[1] https://lore.kernel.org/linux-block/f6e54907-1035-2b2c-6387-ed178be05ccb@kernel.dk/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Suggested-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 5 +++++
 block/blk-mq.c   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 203be672da52..c19d084b2a74 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -850,6 +850,11 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
+	/* As the requests that require a zone lock are not plugged in the
+	 * first place, directly accessing the plug instead of using
+	 * blk_mq_plug() should not have any consequences during flushing for
+	 * zoned devices.
+	 */
 	blk_flush_plug(current->plug, false);
 
 	if (bio_queue_enter(bio))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..c0b5b2c027f7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1213,6 +1213,11 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	WARN_ON(!blk_rq_is_passthrough(rq));
 
 	blk_account_io_start(rq);
+
+	/* As plugging can be enabled for passthrough requests on a zoned
+	 * device, directly accessing the plug instead of using blk_mq_plug()
+	 * should not have any consequences.
+	 */
 	if (current->plug)
 		blk_add_rq_to_plug(current->plug, rq);
 	else
-- 
2.25.1


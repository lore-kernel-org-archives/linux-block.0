Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABFC43462
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DA56103D
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhDLDQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:16:41 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:40667 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbhDLDQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 23:16:40 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210412031621epoutp04affaa7ce4ac47cfe7824f10079a5cee1~0-fH_HmdX0885408854epoutp04X
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:16:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210412031621epoutp04affaa7ce4ac47cfe7824f10079a5cee1~0-fH_HmdX0885408854epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618197381;
        bh=WK5F/GR0LHJuohdPUrFdSYQgBi94i/jQRwh9sI/W3IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgTo7bYuqgMZ/ex26lqRTNDl0YEyFto0akpBp5/F0cqlkPgvd112h/MHJq6Qk7w1E
         x145w+VGvXA9Ro8yFs3CXxi1ZYrDJwSKGEQEqaJsWFhxfNRy15KO4bUwVCmjdZ+t+A
         +sNcPZzKzKxxOEb+evUjTtFhgnKtgRREhRrUREks=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210412031621epcas1p19a94bbea9a9d0a1348c4a79167f6d4d1~0-fHT_t821463714637epcas1p1Z;
        Mon, 12 Apr 2021 03:16:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FJYmN18C3z4x9QC; Mon, 12 Apr
        2021 03:16:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.03.10347.48BB3706; Mon, 12 Apr 2021 12:16:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210412031619epcas1p4ac266f3a7079d3719131977616320fbd~0-fFwl2yB2069720697epcas1p4-;
        Mon, 12 Apr 2021 03:16:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210412031619epsmtrp1b96ac3670b924c3450b16634eddfd72d~0-fFvetGP0530505305epsmtrp1f;
        Mon, 12 Apr 2021 03:16:19 +0000 (GMT)
X-AuditID: b6c32a39-147ff7000002286b-f3-6073bb83f2dd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.74.33967.38BB3706; Mon, 12 Apr 2021 12:16:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210412031619epsmtip105bbf8c841fe340edabb7cb3150cf665~0-fFi0iqa2593825938epsmtip1Z;
        Mon, 12 Apr 2021 03:16:19 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v6 3/3] bio: add limit_bio_size sysfs
Date:   Mon, 12 Apr 2021 11:58:31 +0900
Message-Id: <20210412025831.31498-4-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210412025831.31498-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxTefa99LSjkrWK9Y9nsXuYWO4GWUrg6YC4j7mXqQrIsWSEGKrxB
        Y2lrX2vQmI1QLA47C7oVRUB0DBmC3ZApZWE4DDJ+SImIZI7yswN1EUwJDAbOtbyZ8d93zv2+
        851z7r1CXOQjwoUanYkx6tRaigjmXbu5NTKi4Cc2XTb+FEflddcAuuyxE8jxZAlHxwoXMGT5
        xkmgnuKLGLJ58/noadEIhubHWdR6/y000FJOoPbTFgyVXi3H0b3RXgG6OTLIQ+PVJTjq6/Lx
        UeXkTvT3pQ6AZheHBKi7+TSOnK1LxE4xPXB3N11imRHQrjKPgL5aK6UHbpvpxrovCLqtol5A
        z/48SNAnm+oAPdf4Kl144wSWvC5FG5/NqDMZo4TRZegzNbqsBGr3R2nvpSljZfII+XYUR0l0
        6hwmgUrakxyxS6P1T0pJDqm1Zn8qWc2yVFRivFFvNjGSbD1rSqAYQ6bWIJcZIll1DmvWZUVm
        6HN2yGWyaKWfma7Nfjb0O8/wZXjuTP0beaBKXASChJCMgdX5zVgAi8hmAF2lR4pAsB/7APwr
        /x7gggUA+5YHiCIgXFVc8aRy+VYAW7qtGBfMAbjg6hMEShHkNnjy8X0icBBGdmFw8XLPaimc
        nATwbpeVCLA2kErYV+ziBTCP3AJtC3MggEPIt+Hc2WEe1+BmuDJqwwM4iIyHw79OEBznRdh1
        1rvKwf0cy4/n8IABJJ8Jof27DoITJ8GVeg/g8Ab4qLNJwOFw+NBuFXCCEwBarOcBFxQDWD1d
        g3EsBfTNBVoS+i22QmdLFJd+DbqWKwDnHApn5m18bjEh8LhVxFFeh70Fo/hzr+kG138VaXjH
        O4Rz+7ID+MvEb/xiIClbM1DZmoHK/neuAngdEDMGNieLYeUG5do7bgSrj1+6vRmUPn4S2Q4w
        IWgHUIhTYSH7D7PpopBM9eEjjFGfZjRrGbYdKP3rLsHDN2bo/b9HZ0qTK6MVCgWKiY2LVSqo
        TSH7ZWNpIjJLbWIOMIyBMT7XYcKg8Dzsg/cVdsf4O41/foz2OaK0Pd4Hrr1ARjc+6E/xUj/0
        XqoGye7hxPWq+Z4SSW7sBG2uGJNvuW2lBqYcTZtGNMEtYl9hR5IidFDKE3hz20wptYMoHUlf
        Of7m8svOpYTF6Kp1mr5KR9Oe0kffXpjErpy/8e6ZW3n9mcSnrWdqq27FxG+Tfz57Knp9gTDx
        wOxBu7vebHdPJ3iOlpxS2YKnN4Kvwi5M0ddrbIc6U90Nyoy8oLClF7qRqaZS1pAqruJLzyVO
        Xvz6oC/5TpOVvj61t6G65ZMulWfFWVnq/n5ff1uc86Uxn0xztPOPzcfi+DssodqHqmJV+z+z
        uz4crv1MP+ajeGy2Wi7Fjaz6X7U0ScOFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnG7z7uIEg217ZCzmrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        XDYpqTmZZalF+nYJXBn/r99mKeiVqni3Rq2BcYFYFyMHh4SAicS6u9FdjFwcQgK7GSV+9p1g
        6mLkBIpLSRw/8ZYVokZY4vDhYoiaj4wSR7s/sYPUsAnoSPS9vcUGkhARuM0kcWnLURYQh1ng
        NaNE1+NFLCBVwgKmEucm7ASzWQRUJXq+fWYEsXkFrCU+z7zDArFNXuLP/R5mEJtTwEbizolH
        bCC2EFDN2zUv2SDqBSVOznwCVs8MVN+8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxL
        LdcrTswtLs1L10vOz93ECI5NLc0djNtXfdA7xMjEwXiIUYKDWUmEN6myOEGINyWxsiq1KD++
        qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGposL4mfdDrApmmx5MHmlsYta
        crOm1nkvKZlntVt3zZObuNzuThbDkZ1zT/+o+RtkcOac7QFvX/ff50sKDBubkhr+GvSV7dhr
        lHe264evzswdX34khUix/D6lcFvlaealWufdYou1Hn/1m/L9gXTHx9ZDwj17d/hs5OC7rxHw
        6PrB2jKR/tD9EcVifx/fn/bxnMdjpz7l9TkXvPzmbZS8+WuHcqO3VA7HtvQEpq22J2Zqsx/d
        rsdikHlmzZyvv7zsHZz39K9dW7f0uI1JZneUmFOECqupnsoTjtub3SUepezPefaj39E2Zo/5
        4QMbatgv2f64I1x5e6LsMd+fiQx9ryOtSp7ciA9ed/h6VK+7shJLcUaioRZzUXEiAF4oW7Q8
        AwAA
X-CMS-MailID: 20210412031619epcas1p4ac266f3a7079d3719131977616320fbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210412031619epcas1p4ac266f3a7079d3719131977616320fbd
References: <20210412025831.31498-1-nanich.lee@samsung.com>
        <CGME20210412031619epcas1p4ac266f3a7079d3719131977616320fbd@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add limit_bio_size block sysfs node to limit bio size.
Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
And bio max size will be limited by queue max sectors via
QUEUE_FLAG_LIMIT_BIO_SIZE set.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 Documentation/ABI/testing/sysfs-block | 10 ++++++++++
 Documentation/block/queue-sysfs.rst   |  7 +++++++
 block/blk-sysfs.c                     |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index e34cdeeeb9d4..86a7b15410cf 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -316,3 +316,13 @@ Description:
 		does not complete in this time then the block driver timeout
 		handler is invoked. That timeout handler can decide to retry
 		the request, to fail it or to start a device recovery strategy.
+
+What:		/sys/block/<disk>/queue/limit_bio_size
+Date:		Feb, 2021
+Contact:	Changheun Lee <nanich.lee@samsung.com>
+Description:
+		(RW) Toggle for set/clear QUEUE_FLAG_LIMIT_BIO_SIZE queue flag.
+		Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size
+		is set. And bio max size will be limited by queue max sectors.
+		QUEUE_FLAG_LIMIT_BIO_SIZE will be cleared if limit_bio_size is
+		cleard. And limit of bio max size will be cleard.
diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 4dc7f0d499a8..220d183a4c11 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -286,4 +286,11 @@ sequential zones of zoned block devices (devices with a zoned attributed
 that reports "host-managed" or "host-aware"). This value is always 0 for
 regular block devices.
 
+limit_bio_size (RW)
+-------------------
+This indicates QUEUE_FLAG_LIMIT_BIO_SIZE queue flag value. And
+QUEUE_FLAG_LIMIT_BIO_SIZE can be changed via set(1)/clear(0) this node.
+bio max size will be limited by queue max sectors via set this node. And
+limit of bio max size will be cleard via clear this node.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0f4f0c8a7825..4625d5319daf 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -294,6 +294,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
+QUEUE_SYSFS_BIT_FNS(limit_bio_size, LIMIT_BIO_SIZE, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -625,6 +626,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_ENTRY(queue_limit_bio_size, "limit_bio_size");
 
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
@@ -659,6 +661,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
+	&queue_limit_bio_size_entry.attr,
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
-- 
2.29.0


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FFFC433E9
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 08:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C064364FFC
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 08:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhCPIBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:01:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:57006 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhCPIBQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 04:01:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210316080114epoutp01b8e675ea36c6f2c5e6a1d9ef722e25ea~sw9Jw6vAF1118811188epoutp01j
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 08:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210316080114epoutp01b8e675ea36c6f2c5e6a1d9ef722e25ea~sw9Jw6vAF1118811188epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615881674;
        bh=GKtSnRxBYmtdHSUms4CFm87ZP5zqKOQgz4TyA4OJyMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNOEukTU1DVsXXkMDHEPcjqS4RbQHZIUpqDZSaRSipEkX8w2uPrs8vdudA1/akGXZ
         XXHKMw2VZ8eqfF6k0gIwzOMLrKHdCJtKwTLdMZw3YnjDR/pBH0GZT9nAmObwwHKukW
         qb7Zdrkl3thlBtKmquzovgrUfM3dGSV03WDnsXao=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210316080109epcas1p4fb3f085bafe533731330aabe8cc411bb~sw9EQv9gW1333813338epcas1p4l;
        Tue, 16 Mar 2021 08:01:09 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F05MR4s27z4x9Q9; Tue, 16 Mar
        2021 08:01:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.9C.63458.3C560506; Tue, 16 Mar 2021 17:01:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210316080106epcas1p3522dda95e9c97fc39b40b008bbf87c04~sw9Bl96UO1805518055epcas1p3P;
        Tue, 16 Mar 2021 08:01:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210316080106epsmtrp2f5785856186c8284d33dde51b418adf8~sw9Bk6w3z0257002570epsmtrp29;
        Tue, 16 Mar 2021 08:01:06 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-a3-605065c3f757
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.73.08745.1C560506; Tue, 16 Mar 2021 17:01:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210316080105epsmtip280ff3c191e2f79a2f14c8b30c8704a1a~sw9BVsjv51117011170epsmtip2U;
        Tue, 16 Mar 2021 08:01:05 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [RESEND PATCH v5 2/2] bio: add limit_bio_size sysfs
Date:   Tue, 16 Mar 2021 16:44:01 +0900
Message-Id: <20210316074401.4594-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210316074401.4594-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzH59y7e3dhWrvy6oRWdJMpiMc+BI4IYSNjdwoSsmGadFo2uLO7
        477cuzCBU0MsgizI04FpY3uoY84SkKgEGNjAqFBggwSSygKBYyG7AitSkEO7XC3+O7/z+3zP
        9/f7nXOEuN+fRLBQrTMxRp1CQxG+vLbesMjIXiYtUzw8uA012NsAahyvJNCRkocYMp9sIdDP
        VScwVD5TyEePLA4MLU2xqOvmq2i4s4FAPbVmDNWfa8DR6MSAAPU6Rnho6lQ1jq71L/LRF9O7
        0Mo3lwG6/9cNAfqpvRZHLV1/E7sC6WqzS0B3WMcF9Lkz4fTwYA7dai8l6Eu2bwX0/e4Rgq44
        bwe0u/V5uuTHMizN931NgopRZDPGEEaXpc9W65SJ1Fv75LvlMbFiSaRkB4qjQnQKLZNIJaek
        Re5RazwNUiG5Ck2OZytNwbJU9GsJRn2OiQlR6VlTIsUYsjUGidgQxSq0bI5OGZWl18ZLxGJp
        jIfM1KharnXzDRXBHzVb6/ECYAuyAKEQktvhwlqCBfgK/ch2AK+XLvC5YBHAyt+P8LjADWCt
        fRa3AJ91RcNSJeASnZ7E15X4f1RXXx/wUgQZASucNwlvIoC8gMGi0d51CienAfy1v5jwUv5k
        AiyxX11X8MhQ+MONFcy7FpHxcMRSJuD8XoD/TJTj3mp9yJ2wuekAh2yG/Z/N8Lxr3IOYL3y+
        fj4k54Xw2O0xPqdNhq2DY4/r9oezV88/PjMYul1dBCcoA9Bc/CXggioAT909jXGUDC663cDr
        jJNhsKUzmtt+EXas2gDnvAm6lsr53ChF8GixH4dsgwNFE/gTr7tNHRiH0LCtUM1NqwLAktUu
        ogqEWDf0Y93Qj/V/468AbgdBjIHVKhlWYpBuvONWsP7mw2PbQY1zPqoHYELQA6AQpwJE7ojU
        TD9RtiIvnzHq5cYcDcP2gBjPsKvx4MAsvefT6ExySYxUJpOh7bFxsTEy6hmRQjwp9yOVChNz
        kGEMjPGJDhP6BBdg8qP4w8gDd2I/9FG9Q5SVb73tPHR5tSigoG7Lb6G/WAc/Uep1k46d7HOd
        zMl0H5uTntldd3q2MckxvwMMl/aWJqs/TbcNfVw1+ihrv5JnaULoXXV6/Svaxr7X+/fXHBZP
        V+Q3H17eVwimLsGMlHzz8lk2fc/cctwfESeOZbyXp1vR4YvOZx8kTb6JR4/NbfV/yeHam3em
        cODl799odcTL713pK386rcaVGlAwJ9vyIDAsqSPAtdAdNuiaWruYkTWy6YOhvFxbXV/2warN
        ayBdahLJ84a01Kj0+D298FDuLSCeTAl6W5WafCtDfPGplNDrCxPj0oLjqXeI78467XuvaPsp
        HqtSSMJxI6v4F8kiCOd8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvO6h1IAEg3vTmSzmrNrGaLH6bj+b
        RWv7NyaL5sXr2SxOT1jEZNHzpInV4m/XPSaLrw+LLfbe0ra4vGsOm8Whyc1MFtM3z2G2uHb/
        DLvF4XtXWSweLpnIbHHu5CdWi3mPHSx+LT/KaPH+x3V2i1M7JjNbrN/7k81B1GNi8zt2j52z
        7rJ7bF6h5XH5bKnHplWdbB77565h93i/7yqbR9+WVYwenzfJebQf6GYK4IrisklJzcksSy3S
        t0vgylh/bh9rQZ9UxbpZ05kbGOeKdTFyckgImEjM+drP2MXIxSEksINR4lTTaWaIhJTE8RNv
        WbsYOYBsYYnDh4shaj4ySkx4/5kRpIZNQEei7+0tNpCEiMBRJokNV48xgzjMAq8ZJboeL2IB
        qRIWsJFoX3UcrINFQFViz/VfTCA2r4CVxNWubnaIbfISf+73MINs4xSwlli3NgbEFAIqub3D
        AKJaUOLkzCdgE5mBqpu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnp
        esn5uZsYwZGopbWDcc+qD3qHGJk4GA8xSnAwK4nwftbxTRDiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qByS+lsnX/g8cBfn+mRTctjgvhv1f0SXZSwP+o
        3sXuf2RWx3wylIpb8dj01HfVgLWV87dqrkiwCvHlmfv/749HM1V53q74mfrgTdst1sLEBu5J
        DRwL+4+u/l6Q3b5vd/bKazJuC+8eetPJnPZp9kNHZ88XRZmFURI7U9W7j2l+bPDrcYzY8WKR
        mODTphfei1/qmz3jOdYw6eEJtZ9picaiAbMSrvnsu5AwR03y777Hv/tZDafXbVy0gf0JUzLb
        lhItI5YmcddeTTexVXX3DBrD5pZcfTD/oArD1mRD1lt61/e/mjutWs3hNOudfsu3/RFRVeHc
        yZ3MhUL1en0u38WVc3zNZwftepFrfzU9w+qqEktxRqKhFnNRcSIAuYbhJTMDAAA=
X-CMS-MailID: 20210316080106epcas1p3522dda95e9c97fc39b40b008bbf87c04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210316080106epcas1p3522dda95e9c97fc39b40b008bbf87c04
References: <20210316074401.4594-1-nanich.lee@samsung.com>
        <CGME20210316080106epcas1p3522dda95e9c97fc39b40b008bbf87c04@epcas1p3.samsung.com>
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
index 2638d3446b79..cd371a821855 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
 do not support zone commands, they will be treated as regular block devices
 and zoned will report "none".
 
+limit_bio_size (RW)
+-------------------
+This indicates QUEUE_FLAG_LIMIT_BIO_SIZE queue flag value. And
+QUEUE_FLAG_LIMIT_BIO_SIZE can be changed via set(1)/clear(0) this node.
+bio max size will be limited by queue max sectors via set this node. And
+limit of bio max size will be cleard via clear this node.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..840d97f427e6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -288,6 +288,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
+QUEUE_SYSFS_BIT_FNS(limit_bio_size, LIMIT_BIO_SIZE, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -615,6 +616,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_ENTRY(queue_limit_bio_size, "limit_bio_size");
 
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
@@ -648,6 +650,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
+	&queue_limit_bio_size_entry.attr,
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
-- 
2.28.0


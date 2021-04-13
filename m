Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75566C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A5613AD
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344101AbhDMDNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 23:13:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19224 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbhDMDNX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 23:13:23 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210413031303epoutp04810016351e1ac4940a935829255e870d~1TFg_s7Rn0396603966epoutp04c
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:13:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210413031303epoutp04810016351e1ac4940a935829255e870d~1TFg_s7Rn0396603966epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618283583;
        bh=WK5F/GR0LHJuohdPUrFdSYQgBi94i/jQRwh9sI/W3IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmZbMk9R98lB2i/TF1o5L97BDSkdwXTWiXY8A/acId3LCC3uARyxnGDemMGgiwlS2
         cUKyD3mhH+uD3yaOoNHas8BN/lBnPaZHHlY7JSG6SR2/NIhEqHxC/dvKofimeXAigv
         UPdytuQxJh+Z9hcUvQB0NSG8gVannk6AIM12r4JQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210413031302epcas1p40ce82f736800e19d1c7a906e2b69a300~1TFgOLQgO0918909189epcas1p4n;
        Tue, 13 Apr 2021 03:13:02 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FK9f45wrMz4x9Pp; Tue, 13 Apr
        2021 03:13:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.25.07927.C3C05706; Tue, 13 Apr 2021 12:13:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210413031259epcas1p4406eaed9ba20e684fc038bf1937b94ff~1TFeFgCVr0918909189epcas1p4k;
        Tue, 13 Apr 2021 03:12:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210413031259epsmtrp2fc064183fac0eec4e3a0431161a92e5e~1TFeEREhR3149931499epsmtrp2e;
        Tue, 13 Apr 2021 03:12:59 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000011ef7-4c-60750c3cbc05
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.C5.08745.B3C05706; Tue, 13 Apr 2021 12:12:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413031259epsmtip2d16d0608920fd61652a9cb65a841453e~1TFdx2Tgl1215112151epsmtip2V;
        Tue, 13 Apr 2021 03:12:59 +0000 (GMT)
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
Subject: [PATCH v7 3/3] bio: add limit_bio_size sysfs
Date:   Tue, 13 Apr 2021 11:55:02 +0900
Message-Id: <20210413025502.31579-4-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210413025502.31579-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd3rb21ZhXgqDs67RWsUgCrRA4TjLNBHJNUqELWYJLJYO7nis
        r/XBdLKEWAQEBBqIZpW3RBmPoch7MBbYmB3IUGQVFwQDxrHMgiAGJsy1XMj47/c7v8/3fM/v
        d87hYLwXOJ+TrDZQOrVCKcK3MFv79vr5yVyMceK+ZW9UUtsKUN14AY4uzy1j6ELWKwYyXWvE
        0UBhFQPlTZ9nodWcxwy0+ESPuh/tQyOdJTjqLTIx0JXbJRj6fWKQjfoejzLRk2ozhoas8yxU
        NnUY/XPjZ4Bml2xs9Gt7EYYau5fxw57kyIPjpNlkZ5MdlnE2ebvGlxy5aySbai/iZE9pPZuc
        /WEUJ/ObawG50LSdzPoxlxG1NUYpS6IUCZROSKnjNQnJ6sQw0fGP5Efk0hCxxE9yAIWKhGqF
        igoThZ+I8otIVjo6FQlTFUqjYylKodeLAj6Q6TRGAyVM0ugNYSJKm6DUSsRaf71CpTeqE/3j
        Nar3JWJxoNRBximT3tj+YGov8c/Y6/ekgwrPHMDlQCIY3n/4PSsHbOHwiHYAm2/cZdLJPIBP
        Lf0YnSwAOPNvF2NDUnbZzqALnQBefFiPOwtrVPHLY84YJ/bD/OePcCfkQVgZcKluADgTjJgC
        8IE101HhcNwJKbw2w3IKmIQ3rCorZjpjV+IgvDlqw2i3HXBlIg9z4lxCBkerVDTiBq3fTK/h
        mAMxtVxdOykkTFw41JGN09pw2Nx6i0XH7vCvX5rZdMyHC/ZunBbkAmjKLAd0Ughg9bPr630G
        wfmFBeB0xoi9sLEzgF7eCTtelwLa+W1oX8xjORFIuMLsTB6N7IaDGRPYhtezho71HUk4PPb3
        +rALAHxRfgUUAqFlU0OWTQ1Z/neuAFgt8KS0elUipZdoJZuvuAmsvX1faTswP5/z7wUMDugF
        kIOJPFwjig1xPNcExdmvKJ1GrjMqKX0vkDqmbcb478RrHJ9HbZBLpIFBQUEoOCQ0RBok8nL9
        VDwp5xGJCgP1OUVpKd2GjsHh8tMZPj6Tp7qEW/efYEbJw3a+WdJWcLMiybajmT1epysCLwjA
        xz1dtqqWL9XxIKDvNYsbKzhYzotMDl126eef3f1FarR9Lq101HdFEq2PXeWKuD3uu2wBh66m
        DKTY+gVp1qnKnwBTAmMFYPWt6bBg2Z6YjMnKIllG2v30bfeYbjWeQ41d4dkNOwR2t3bpEWlL
        GfmJh7ivcjjjWP6p6pozJ1cyTrdd2u79KtfrkHX2uuqzfX/OciKfiusifHaB3w4vKszy+TGL
        lndv9Vuj58rLW2Md562h0jt5733HS5lKPXB05uvx6JN30nNtBR+eGy4s8BUMntO+W+4iaBuI
        udkjlDU0mkVMfZJC4ovp9Ir/AKawa+CEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK41T2mCwa/52hZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO4o
        LpuU1JzMstQifbsEroz/12+zFPRKVbxbo9bAuECsi5GTQ0LARGLetHdMXYxcHEICOxgl/vbO
        YIZISEkcP/GWtYuRA8gWljh8uBii5iOjxPbb/WA1bAI6En1vb7GBJEQEbjNJXNpylAXEYRZ4
        zSjR9XgRC0i3sICpxOKXrCANLAKqEovmTWEBsXkFrCU2XL0OtUxe4s/9HmaQck4BG4mri3JB
        wkJAJX93HWWGKBeUODnzCVgrM1B589bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM4MrW0djDuWfVB7xAjEwfjIUYJDmYlEV63KSUJQrwpiZVVqUX58UWl
        OanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDJfz10avNO5huTHr5+fHdK/muB
        hmc+7o73Q1yeLC3dPWm5KMujvi1O8VxHaq00lnmnLT149PGFJbN+5PLoeoQV3OS0S49JmT91
        Z9eUNVlXvu/fdm5VRb+clH1Y7Ap/UacLuVPuH2U12mU1RWyl4gejg4b7mj/16marFk48/P3X
        o/cbfNYtvjb5CkPAy2Xru9POBxl9PnPu4v9Ats2npvouZH24YNae+1Ixyna9fCt/TFubtXeS
        l9uXfV9dFzRe+pIj6TWXjc/qVM4drQ2y8Y/2yTzJnMW85WXpVPa3vQHp0jp/5Y+szljdYG3J
        KCjuWcj4tdBpaYP5sbVLJ5nt+26mUXjhykUnLvcdXuszHk09ukKJpTgj0VCLuag4EQBH07cs
        OwMAAA==
X-CMS-MailID: 20210413031259epcas1p4406eaed9ba20e684fc038bf1937b94ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413031259epcas1p4406eaed9ba20e684fc038bf1937b94ff
References: <20210413025502.31579-1-nanich.lee@samsung.com>
        <CGME20210413031259epcas1p4406eaed9ba20e684fc038bf1937b94ff@epcas1p4.samsung.com>
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


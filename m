Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068BAC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD20364E0F
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhBCLiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:38:24 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:54649 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbhBCLh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 06:37:56 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210203113653epoutp03405d20f264c37cf80206a3c34f1ece7e~gOcukzk9_1086210862epoutp03t
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 11:36:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210203113653epoutp03405d20f264c37cf80206a3c34f1ece7e~gOcukzk9_1086210862epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612352213;
        bh=HLhTdSPNvRZEoke9hAXZQYndHxV8j9rsdk5X9AlrZdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNikr+iG1xKzmQwVIUywL5+6LDeV3a4i4iX7nZolW2b1QqxohsdN8Hn/y0N27MuY9
         IpuuWV5pDwM1FYdLxWYiD+y9sAMW3b6vaHA7+/pPgBb2CPcFEX+hJBGv7hc2PXTvXe
         TEVJTjx0n8Huex3/4PsxPkyqKINq3doCpHjLenjU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210203113652epcas1p1f3ca086965769afd3e9ef5ed8cdd051b~gOctoFI4L1413214132epcas1p1R;
        Wed,  3 Feb 2021 11:36:52 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DW05H0SrKz4x9Pv; Wed,  3 Feb
        2021 11:36:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.AE.63458.2DA8A106; Wed,  3 Feb 2021 20:36:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210203113650epcas1p2ea64df5b6349975fa92c1605edc92961~gOcraZMg60872708727epcas1p2q;
        Wed,  3 Feb 2021 11:36:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210203113649epsmtrp2074590656f4ea6065faf0ba7667cf8b8~gOcrYc45a2720227202epsmtrp2V;
        Wed,  3 Feb 2021 11:36:49 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-98-601a8ad24e09
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.C7.13470.1DA8A106; Wed,  3 Feb 2021 20:36:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210203113649epsmtip17d32a97ab4e7a6ff6ef077cbd124a079~gOcrEsdxW2976029760epsmtip1c;
        Wed,  3 Feb 2021 11:36:49 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: [PATCH 2/2] bio: add limit_bio_size sysfs
Date:   Wed,  3 Feb 2021 20:21:07 +0900
Message-Id: <20210203112107.18279-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <YBp1nC+/P9Qcwzzm@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmvu6lLqkEg63TzC3mrNrGaLH6bj+b
        RWv7NyaL5sXr2SxOT1jEZNHzpInV4m/XPSaLrw+LLfbe0ra4vGsOm8Whyc1MFtM3z2G2uHb/
        DLvF4XtXWSweLpnIbHHu5CdWi3mPHSx+LT/KaPH+x3V2i1M7JjNbrN/7k81B1GNi8zt2j52z
        7rJ7bF6h5XH5bKnHplWdbB77565h93i/7yqbR9+WVYwenzfJebQf6GYK4IrKsclITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBelBJoSwxpxQoFJBYXKyk
        b2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTce2aa8EhqYpH
        7d9YGhjPinUxcnBICJhITL3D0cXIxSEksINRYt+3JWwQzidGia9PLrFDON8YJb4fb2TsYuQE
        69h7eSETRGIvo8TFW4tYIJzPjBKdH76CVbEJ6Ej0vb3FBmKLCMhJPLn9hxmkiFngBbPEtI47
        zCAJYQEjif8Pu8EaWARUJfp67oHFeQWsJfZ/+c0MsU5e4mnvcmaQYzkFNCXOPI+EKBGUODnz
        CQuIzQxU0rx1Nth8CYEPHBLbt51hheh1kXj2/CUThC0s8er4FnYIW0ri87u9bBAN3YwSzW3z
        GSGcCYwSS54vg+owlvj0+TMjyGZmoM3rd+lDhBUldv6eywixmU/i3dceVkhI8kp0tAlBlKhI
        nGm5zwyz6/nanVATPSTOrmtjAikXEqiRmPxNdgKjwiwk78xC8s4shL0LGJlXMYqlFhTnpqcW
        GxYYIUfwJkZwgtcy28E46e0HvUOMTByMhxglOJiVRHgT26QShHhTEiurUovy44tKc1KLDzGa
        AsN6IrOUaHI+MMfklcQbmhoZGxtbmJiZm5kaK4nzJho8iBcSSE8sSc1OTS1ILYLpY+LglGpg
        srhanql+IfTHySKb1sJp7w6Zmm/KCux2mFZdm6bwdL+wWHbBlQNZf5+pmE9ed1ujyVy43NF+
        S5TtuohlCXVPbWZfOh+7MiLJjX/eg5Mfnqh/0QxYnu7dpOqQMmvy6ZY9S1UEj+trblv3YffB
        hJshB2NX9VlemT7nkeAC1cqsVMk/X6UfCLYf/Bp+vtM3859JtXl/qJp6xfSeyC32n9I2myYG
        d78Uel7Am2GetKuoQuCSzpeoNQbXJ55dOqP3T2IDz8O9l8X4um8dUt7gx1ny5O7u+REO/stO
        +Tf8X1iw2fnENLv8EoZccVcPTYY00a3uT5RqPm14+nR/9Zc0rfn1bzZ0eXK7m3fHXplZceec
        EktxRqKhFnNRcSIAldGxYHkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnO7FLqkEgxUrDSzmrNrGaLH6bj+b
        RWv7NyaL5sXr2SxOT1jEZNHzpInV4m/XPSaLrw+LLfbe0ra4vGsOm8Whyc1MFtM3z2G2uHb/
        DLvF4XtXWSweLpnIbHHu5CdWi3mPHSx+LT/KaPH+x3V2i1M7JjNbrN/7k81B1GNi8zt2j52z
        7rJ7bF6h5XH5bKnHplWdbB77565h93i/7yqbR9+WVYwenzfJebQf6GYK4IrisklJzcksSy3S
        t0vgyrh2zbXgkFTFo/ZvLA2MZ8W6GDk5JARMJPZeXsjUxcjFISSwm1Fi8d8fLBAJKYnjJ96y
        djFyANnCEocPF0PUfGSUOH27BayGTUBHou/tLTYQW0RATuLJ7T/MIEXMAk0sEtfPr2YESQgL
        GEn8f9gNZrMIqEr09dxjBrF5Bawl9n/5zQyxTF7iae9yZpBlnAKaEmeeR4KYQgIaEo9ulUFU
        C0qcnPkEbC0zUHXz1tnMExgFZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85
        P3cTIzgKtTR3MG5f9UHvECMTB+MhRgkOZiUR3sQ2qQQh3pTEyqrUovz4otKc1OJDjNIcLEri
        vBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamDw9c3Uy/rsHlrolfHi+bDH/mxurfk20fHpc191f
        9MT8Qz8DZy/IzXdyTty5+2nzd73r+//yCVyfnfr6oX/bxAv3JswxW7/teCHH+d6zjy4KrNwo
        m/7V5+nH+zyTRL50dTG3KblGW29qZ9jgOMk15a2qAu8pwa9vtk2Qq+j1z83Lef187TGmNSwZ
        9hw2bZsKnz8t3SNplHP4gMF69qAJmW6cjPu2JZbH5Vw1dOiTtolmtYzkepN5Tu7Ve+Ez7Ac3
        h92z9rPpPa8nK1iTYH9C9uQWrh7nh42ftoYl7nPfx6fVcSr48LplXxfxzrvgbcv3wOFzSdFT
        ls3T1U8+uVy4a+3tSVWLGd0K7TcL1U379VyJpTgj0VCLuag4EQCc9SI+MQMAAA==
X-CMS-MailID: 20210203113650epcas1p2ea64df5b6349975fa92c1605edc92961
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210203113650epcas1p2ea64df5b6349975fa92c1605edc92961
References: <YBp1nC+/P9Qcwzzm@kroah.com>
        <CGME20210203113650epcas1p2ea64df5b6349975fa92c1605edc92961@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add limit_bio_size block sysfs node to limit bio size.
Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
And bio max size will be limited by queue max sectors via
QUEUE_FLAG_LIMIT_BIO_SIZE set.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
Signed-off-by: nanich.lee <nanich.lee@samsung.com>
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


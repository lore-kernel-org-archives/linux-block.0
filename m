Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1AAC433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C53229C4
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbhAZFdt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:49 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26295 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbhAZBtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 20:49:18 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210126014809epoutp0357226ebbd4c8981a892e7a0db9680fc0~dpQayPF_62147221472epoutp03c
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 01:48:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210126014809epoutp0357226ebbd4c8981a892e7a0db9680fc0~dpQayPF_62147221472epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611625689;
        bh=WZWRYxFQt5Vb3eG5u4M368QXhG7uK7mseqihDVcJmwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axBN5OYumLLV2iBhUdB6HDiUUND9mA3p4Ysi4dhC7Wg4Bta1hq5pMhhcuklsoArqT
         D3Q4y+jQ7NuwO8Vj+a8yGZMstgbBGSx07/DGBvE5d+QtsvEUAejg1o6O3XdE60UEUQ
         Ckoz3dn/qWWhu1P8u0MSNkvci3bduEqHYmmpWVt4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210126014809epcas1p3ab2cafa7277bd9759f2f66ce52b61446~dpQaQfZnS2232022320epcas1p37;
        Tue, 26 Jan 2021 01:48:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DPqPg5Br0z4x9QB; Tue, 26 Jan
        2021 01:48:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.13.09582.7D47F006; Tue, 26 Jan 2021 10:48:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210126014807epcas1p1a7274e9ba472286df03aac8e627b4633~dpQYWlDwB2739127391epcas1p1d;
        Tue, 26 Jan 2021 01:48:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210126014807epsmtrp1e4669d15ddca25f32fb18d60759d68ae~dpQYVWPK62628726287epsmtrp1D;
        Tue, 26 Jan 2021 01:48:07 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-9e-600f74d70dbc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.C4.13470.6D47F006; Tue, 26 Jan 2021 10:48:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210126014806epsmtip189c91ea1cbc3b6335f494c4e75249a36~dpQX-Y8f22087020870epsmtip1C;
        Tue, 26 Jan 2021 01:48:06 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v3 2/2] bio: add limit_bio_size sysfs
Date:   Tue, 26 Jan 2021 10:32:35 +0900
Message-Id: <20210126013235.28711-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210126013235.28711-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+5tb28JHZeC44w5YHevyKNPCwcGi1Hjqi4b7PEHzqRUuAFc
        X+ttnW7ZxoYWB0hlJhML6JYx2SAL8hAorMaUmAUim0GhjgiMhzyUh1BxDJis9ErGf9/f7/f5
        nW9+v3MOiYs9RDiZa7AwZoNWRxMBvOaObdI4jyUoQ9be/CqqqGkGqHbATqATBY8wVDz2FR/9
        WziIocVhFrn6Y9DNtgoCuc/kY+hsYwWO+oauC1DHYC8PDVeV4uj3zgU+Oj+6Ay1XXwNobskj
        QF2tZ3BU5/qH2BGiLs2fFaidjgGB+ma3Vd1Q8zWhnrvSS6hLmmqA2tsQoS64WoSlkgd0yTmM
        NosxRzGGTGNWriE7hd7/rmaXRhUvk8fJE1ECHWXQ6pkUevebqXF7cnW+aeioI1qd1ZdK1bIs
        LX092Wy0WpioHCNrSaEZU5bOJJeZJKxWz1oN2ZJMoz5JLpMpVD4yQ5ezXN/DM/0ccHSsZgTL
        A6tkIRCSkNoOBx+3CQpBACmmWgFcOf8nxgULAK5NDvHXKTH1CMD57nc2OkbGi59ALgCnf53g
        c4EXwKmTN4h1iqBiYclMP7FeCKWOY9A214evBzg1CuCtTpufCqFUsOP2sl/zqJehzdXi9xNR
        r8GSO3U45xcJ756q9mshlQwfeOZ4HBMMO8+N+TXuY/Ivl/sNIHWbhLWVNsA174ZNI5M8TofA
        e781CTgdDqfsNgHXUARgvu0C4ILTAFZNXMQ4SgkXvF5fgfRZbIN1bVIu/QJ0rlQCzvlpOLtY
        zF9HICWCJ21iDnkJXj8+hG94TfzifHKiGj683w64pdoB/OMh/zSIcmyax7FpHsf/xt8BvAY8
        w5hYfTbDyk3KzZfcAPwvPDqhFXw780DiBhgJ3ACSOB0qapcEZohFWdpjnzBmo8Zs1TGsG6h8
        2y7Fw7dkGn1fxGDRyFUKpVKJtscnxKuUdJjokOwvjZjK1lqYDxnGxJg3+jBSGJ6HJVvx/CC+
        8MTBlNhTPx5WAW//D5dHb0yNb105FrOlwnpwqIgXWC53NY2/EtF55W5s76giKHD63iV+7ZdP
        GUeq6Lcnc4NqL1CF0Q5F3mrPUthsxIJHat+b5N36xq6U7kRL0Vtl1fpGNjHMERD+TUtb5K2Z
        fXRofUBT8MVrPQOa5+odO4dXP0v3aJ6vCJ5xviidjkm6+rl63l5eeFj0ccHjloE0IlLVmN51
        KHPme0edBK8VNjdOLFcdTW5L+6Jf7658X/rekQOKJInK9ZNOmLdYNb7v78r7urW8c4ZLo2X4
        WcuzZZ+anDvxbuf8naWP1j4oUayZ9nSlZ7jTiOXOYE0H395H89gcrTwaN7Pa/wDs61tSagQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvd6CX+CwcJVTBZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBm/Nl5iKVjJVfFk1SOmBsY/
        HF2MnBwSAiYSj571MHUxcnEICexmlNi5YTsTREJK4viJt6xdjBxAtrDE4cPFEDUfGSVOd3ew
        gNSwCehI9L29xQaSEBGYxCSx9+BuZhCHWeA1o0TX40VgVcICphKHb/xiA7FZBFQl2vZuZwWx
        eQWsJfrurGeG2CYv8bR3OZjNKWAj8eH6e7BeIaCahZufMkLUC0qcnPkELM4MVN+8dTbzBEaB
        WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4zLc0djNtXfdA7xMjE
        wXiIUYKDWUmEd7ceT4IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTLX+ZzYHbDnGN/HQDC3JuVcWJjxW5meu3n/pwtQ3q7zOrG5fXDKnTsGlXWNOb1HP
        8eOWnqbtrXcOBy87d/nY4/nfWSe+vCdaXnmiWazFQpR/15XnL6+Jl5T869u7J9AucL5Y4/3V
        m1++kM3hN+ZcyL+R1TZH5MNm3rNRdzNTJKeft3xo9O5iTcjFHS9eZ/h+ktux8ESI3Tyl24q/
        voc8NXmWp8z3/27Ag46vm+4U2Hvqz++S4y7UmLdug2r8/eu1ngwsO/mcVk/a/Hv5TMbFRfN7
        th6+7Lr09dHDV01Vld+wd2q3/8pg7KnYVX/905rqMOGw3P9fN2Zf40r7Jfs91DNo9uS93ZXp
        C89rh/jYa2spsRRnJBpqMRcVJwIA2geL5SIDAAA=
X-CMS-MailID: 20210126014807epcas1p1a7274e9ba472286df03aac8e627b4633
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210126014807epcas1p1a7274e9ba472286df03aac8e627b4633
References: <20210126013235.28711-1-nanich.lee@samsung.com>
        <CGME20210126014807epcas1p1a7274e9ba472286df03aac8e627b4633@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add new sysfs node to limit bio size.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 block/blk-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

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


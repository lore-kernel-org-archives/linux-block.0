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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77084C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2057464DFF
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhA2EHg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 23:07:36 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28225 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhA2EHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 23:07:34 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210129040650epoutp017d28cf925ae4c8eb98b263b5a12373cd~emFXD9LZJ2002420024epoutp01i
        for <linux-block@vger.kernel.org>; Fri, 29 Jan 2021 04:06:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210129040650epoutp017d28cf925ae4c8eb98b263b5a12373cd~emFXD9LZJ2002420024epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611893210;
        bh=WZWRYxFQt5Vb3eG5u4M368QXhG7uK7mseqihDVcJmwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkgfgx5wXpCRqTkt818jDXl4RE2LEqDJg1xUn2vLgTH0Yh40+4SvSeih9FieNt1fk
         jjumWk+mYW+uIc1lnBcpEKAoRRZj+qfEiIHIDZajyPwFCTONnAQcyJ9Sa9FH35D8rx
         H7zllb61ceCsmkBKE0HOwg3tjzTZmvfUigQEoy+I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210129040649epcas1p46013feedbc3a015895fe05dbe74de32d~emFVtTOFM0594205942epcas1p4M;
        Fri, 29 Jan 2021 04:06:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DRkJ11zl9z4x9Q9; Fri, 29 Jan
        2021 04:04:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.EE.02418.16983106; Fri, 29 Jan 2021 13:04:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210129040448epcas1p44da94c82ac4fb82d77c452bda56d6b09~emDldKF071322813228epcas1p4Q;
        Fri, 29 Jan 2021 04:04:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210129040448epsmtrp245af0a01e82c7b0a7f5c673073d94f5e~emDlcUR-80874008740epsmtrp2g;
        Fri, 29 Jan 2021 04:04:48 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-0f-60138961b2b1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.39.08745.06983106; Fri, 29 Jan 2021 13:04:48 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210129040448epsmtip2574986e8da2ce63b8b7ea1c1373088af~emDlJFu1P1343513435epsmtip2J;
        Fri, 29 Jan 2021 04:04:48 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v4 2/2] bio: add limit_bio_size sysfs
Date:   Fri, 29 Jan 2021 12:49:09 +0900
Message-Id: <20210129034909.18785-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210129034909.18785-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta1ATVxTH5+6GZGEaZlmw3vKhpTsyHaCBxJBwa8HS0dq1dkamTh+0H8IK
        28AQkjQb+nSmKg81gJJBJ4IRsZVSKIGWV4EWR0BwKFhn5FGFQYhQA3aAlpQKAtokKy3f/uec
        37n/e+6DwKlJcSiRoTdzJj2ro8UBopbuCJmMPRGcIj+SG4DsNS0AfTd+Sozyjv2Dof7irzBU
        OH3UD61b7mBoycmjjtEoNNhuF6OukhwM2RrtOBqZGJCg7jvDIuS8ZMXRr32Lfqh8KhE9rOoB
        aGH5Nwn6pbUER/UdK+LEEMaaMy9h2srGJUzjt5HM4PVspqHmhJhZuDwsZk421QDG3fAsc+xK
        AZbk/74uPp1j0zhTGKdPNaRl6LUJ9L4Dml0alVqukCleQnF0mJ7N4hLo3W8myfZk6Dxj0WEf
        s7psTyqJ5Xk6Zme8yZBt5sLSDbw5geaMaTqjQm6M5tksPluvjU41ZO1QyOXbVR4yRZf+8Ieb
        ImN1wKfTNXexw2CNsAB/ApKxsPfGY8wCAgiKbAXQNWHHhWARwNl7TX5C4AbwzP1Rv42WW90N
        YqHQDuCj5gXRf5RzMNdHickX4cm5UR8VQtowuLTSI/EGODkF4FBfvthLBZMqeLX/rk+LyHDo
        GujHvFpKvgwrOzslgt9z8PeiKtyr/cl4eLuiHAhMEOwrnRZ5Ne5hcprP4QI/Q8D19tcEvRt2
        OCaAoIPh/WtNT9YMhe75Dt/uIFkAYE7+BSAExQBecn2DCZQSLrrdngLhcYiA9e0xQvp52LZ6
        HgjGgXB+qdDPi0BSCo/nUwKyDQ7kTuAbXi5H25MVGXi5ttiXp8hTAJbYDMUgrGzTOGWbxin7
        37gC4DXgac7IZ2k5XmFUbL7kBuB76pGqVmCd+zO6C2AE6AKQwOkQ6ZydSqGkaexnn3Mmg8aU
        reP4LqDyHLYVD92SavD8Fb1Zo1BtVyqVKFYdp1Yp6a3Sg/JJDUVqWTOXyXFGzrTRhxH+oYex
        T25fvPGKdVspt+UMwT42vzccdO5iU8Hx6pFZm2NHasQ7UZYiQ0rd5MDZipXAGGV9eE9CJzXS
        G1pYd/YF1+krO+1H91dPRUL70D2HEc1kAatz70H6j4mbiarAsdiW8fC1POstmKuqHLqa/4Em
        9m+X7UvJ93lTbV11gT/K2D2zbwz2rj7KnHvr3dWxztONQwcUM0F5mYfW5i359gcf1TrXZyrb
        3v6rqG5MjVFx7p9q83otq1hl8qF9gfjP0eoLxg+bd+154JBJ92vtcG6Z0drilhPZ6vbkqGRH
        lftIwdZy0evOZ8zGipBween1kkjLq0HU19fUC0+Fn/+icGoep1qHqmgRn84qInETz/4LRCWm
        HHMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvG5Cp3CCwbpLahZzVm1jtFh9t5/N
        orX9G5PF6QmLmCx6njSxWvztusdk8fVhscXeW9oWl3fNYbM4NLmZyWL65jnMFtfun2G3OHzv
        KovFwyUTmS3OnfzEajHvsYPFr+VHGS3e/7jObnFqx2Rmi/V7f7I5iHhMbH7H7rFz1l12j80r
        tDwuny312LSqk83j/b6rbB59W1YxenzeJOfRfqCbKYAzissmJTUnsyy1SN8ugSvj18ZLLAUr
        uSqerHrE1MD4h6OLkZNDQsBE4sbhTWwgtpDADkaJiy8NIOJSEsdPvGXtYuQAsoUlDh8u7mLk
        Air5yCixaPFXZpAaNgEdib63t9hAEiICy5kkDvxezQriMAu8ZpToeryIBaRKWMBU4sjpR2Ab
        WARUJZ6fOc0EYvMKWEssPXiQHWKbvMTT3uVgUzkFbCRuLpjHCLJZCKjm2yMtiHJBiZMzn4CN
        ZAYqb946m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER52W
        1g7GPas+6B1iZOJgPMQowcGsJML7do5QghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1MZxYrZfVN1TlzNWQxb/qMENmNWnbh/yUFlRYwxTW9XZE8YzuH
        20SLhzbzsh7z3zu9dLlh269T/wL3+1Z+00gXm7jkwZNjGWucxFKzTvy44H/DLvXXhk12Rgw3
        Pvac3HSSpWf2oc/ll31ym53mvVuzzPWEotKRNIfgA0yOjGtOy1yPfb6O9dertLczRRcftC4R
        8f6/dGGVrmGilPudVPld9fMKPS/eybqvcnr7TSGV3xtncaeEPqt/vy70cvNJ6a31xgxZLzdW
        9nxqXBGqlnz6yoLSnJNzn50on5twyUV7+tkzMkoZBvEVf/4tvLbpyDv1MwmTQtO7p533ZI/7
        eU1R5CnDl9KpFzT2VE+qiZctzVFiKc5INNRiLipOBADQqmIrKQMAAA==
X-CMS-MailID: 20210129040448epcas1p44da94c82ac4fb82d77c452bda56d6b09
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210129040448epcas1p44da94c82ac4fb82d77c452bda56d6b09
References: <20210129034909.18785-1-nanich.lee@samsung.com>
        <CGME20210129040448epcas1p44da94c82ac4fb82d77c452bda56d6b09@epcas1p4.samsung.com>
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


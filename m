Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F7BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F7022D58
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405676AbhALItH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:07 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:44916 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbhALItG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:06 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210112084822epoutp04be278500117e382772001daa719e66fa~Zb9UAF-UX1856118561epoutp04Z
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 08:48:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210112084822epoutp04be278500117e382772001daa719e66fa~Zb9UAF-UX1856118561epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610441302;
        bh=+E8s70l9kpR0baCbjneTmLZGRzfjdnLzE9LHofZOmG0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XTA8bKloFjRjWM2GEOD4Fxd70VXLExvXPmMhJxXBKA5N0eNj2AcbYRS3N1JNK8KM4
         bl03wOz8R5cH6TNo32g5ojBLcHxrcy6xf/1jJWWGpYQ56/0zvVFS++Lg77cCxKlDzT
         7FMMAghoVoJD0/kUISoVdwf0O+2xly6yrVbPARZQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210112084821epcas1p41dd8b1e3a6b8f6ae5bb620cc259dbda0~Zb9S1a7Yt2227322273epcas1p4N;
        Tue, 12 Jan 2021 08:48:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DFPNz68Gpz4x9Q2; Tue, 12 Jan
        2021 08:48:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.CB.09577.3526DFF5; Tue, 12 Jan 2021 17:48:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210112084819epcas1p2389fe5fd665e4ff7b41ad92344547294~Zb9RMTJpC2575825758epcas1p21;
        Tue, 12 Jan 2021 08:48:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210112084819epsmtrp1d6cdfacb2929530cedfef9c951152a97~Zb9RLRF9G2636026360epsmtrp1m;
        Tue, 12 Jan 2021 08:48:19 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-f6-5ffd6253c9ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.2D.13470.3526DFF5; Tue, 12 Jan 2021 17:48:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210112084819epsmtip251c11c406ce80c0bd59253170c341cb1~Zb9Q89Dmw0209002090epsmtip2W;
        Tue, 12 Jan 2021 08:48:19 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, johannes.thumshirn@wdc.com, tj@kernel.org
Cc:     seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        yt0928.kim@samsung.com, mj0123.lee@samsung.com,
        junho89.kim@samsung.com, jisoo2146.oh@samsung.com,
        "Changheun Lee" <nanich.lee@samsung.com>
Subject: [PATCH] bio: limit bio max size.
Date:   Tue, 12 Jan 2021 17:33:11 +0900
Message-Id: <20210112083311.30013-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmvm5w0t94g50dhhar7/azWfQ8aWK1
        +Nt1j8ni68Nii723tC0u75rDZjF98xxmi2v3z7BbnDv5idVi3mMHi1/LjzJarN/7k82Bx+Py
        2VKPTas62Tz6tqxi9Pi8Sc6j/UA3UwBrVI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtBtSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        Q4MCveLE3OLSvHS95PxcK0MDAyNToMqEnIxv1w4xFlznrXg3dRt7A+M/ri5GTg4JAROJEzfP
        s4DYQgI7GCV+zsjrYuQCsj8xSrya9ZUVwvnGKDF7XQcjTMeNBfsYIRJ7GSU2XNrCDuF8ZpRY
        tOIdE0gVm4CORN/bW2wgtohAtcSLR7vAOpgFTjJKzO19DrSQg0NYQFNiwjMRkBoWAVWJyW/e
        soLYvALWEo9uXofaJi/xtHc5M0RcUOLkzCdgtzIDxZu3zmaGqPnILvH0mBGE7SJxeuEpFghb
        WOLVcZDjQGwpiZf9bWCHSgh0M0o0t81nhHAmMEoseb6MCaLKWOLT58+MIMcxAx23fpc+RFhR
        YufvuYwQi/kk3n3tYQUpkRDglehoE4IoUZE403KfGWbX87U7mSBKPCRub9GGBG+sRMvHN4wT
        GOVnIflmFpJvZiHsXcDIvIpRLLWgODc9tdiwwBQ5UjcxgtOnluUOxulvP+gdYmTiYDzEKMHB
        rCTC67XhT7wQb0piZVVqUX58UWlOavEhRlNg+E5klhJNzgcm8LySeENTI2NjYwsTM3MzU2Ml
        cd4kgwfxQgLpiSWp2ampBalFMH1MHJxSDUwSNw/tb3HiOVwhvrxk+d/m2X2a3zZveddSG/sp
        Qe9T2qHO+i0nXOyZ/69bqhWwRaTq1Dq586xSn7/zmb3L++n88uOqJ6/3iifuYNZsWX1g2tkF
        sd3HSiXl5a7Nu5tst+ToZb9TC5Jj1/2s3pdULHJ3c9EstnlXjYQ5lUJufebpuXzWsbb+/4+C
        jdHO+Y9PzWm92+q25KXhLWld3scX6iZ0P63xKl8cdM7zd5xcsdPKXnHlEzNfnVPU1jvIq2fF
        6FHGLKNw3/qeso/AFTOLfUvjGo+3H3M+0f6l8tXP4//WCTp4CDXdv3hUR+PG8Yg7ghJOGmnx
        i2ac7N3dwlBm1B7f3/tZhkfg+dwYq/I8+RolluKMREMt5qLiRAAtjYJdKAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSvG5w0t94gytb+SxW3+1ns+h50sRq
        8bfrHpPF14fFFntvaVtc3jWHzWL65jnMFtfun2G3OHfyE6vFvMcOFr+WH2W0WL/3J5sDj8fl
        s6Uem1Z1snn0bVnF6PF5k5xH+4FupgDWKC6blNSczLLUIn27BK6Mb9cOMRZc5614N3UbewPj
        P64uRk4OCQETiRsL9jF2MXJxCAnsZpR4MWc9K0RCSuL4ibdANgeQLSxx+HAxRM1HRok3P3Yw
        g9SwCehI9L29xQaSEBFoZJTYtOcQmMMscJFR4um+Ccwg3cICmhITnomANLAIqEpMfvMWbAGv
        gLXEo5vXGSGWyUs87V3ODBEXlDg58wkLiM0MFG/eOpt5AiPfLCSpWUhSCxiZVjFKphYU56bn
        FhsWGOallusVJ+YWl+al6yXn525iBAe0luYOxu2rPugdYmTiYDzEKMHBrCTC67XhT7wQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTFUcrBqOQi+uaD6L
        1eoKcIh7xe7+4+zva7F7K86+ubLmxjpX1n2pUfKJhncz1tS+uSmaqLdK+3rT6gUxTf9XdDyQ
        01PcKsdW3Tc1K9nGtT2y4Md8H84j5VbXMy6Ur97xwHjtxtK2j7e/WEbNfx8ooLHmR8yqsFxj
        p9M3W44f/f5TPytepClPIEnN/Kr49bhrez8/l1khccoy5K+VYFF86qoKpnlWne3rtbmmzP12
        72jFhP1C/IWXXu3l2V7dN+HPptQFmjdq+YK1v9Ycbv38dv1N1XlOulI7Zy1Umrw9oDnVabWU
        h3nuvwbWwMu709594fyrKXqXkZdBinfSns+T0964bDsm/fCmo43pDw8uTiWW4oxEQy3mouJE
        AGXAxnbXAgAA
X-CMS-MailID: 20210112084819epcas1p2389fe5fd665e4ff7b41ad92344547294
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210112084819epcas1p2389fe5fd665e4ff7b41ad92344547294
References: <CGME20210112084819epcas1p2389fe5fd665e4ff7b41ad92344547294@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "Changheun Lee" <nanich.lee@samsung.com>

bio size can grow up to 4GB when muli-page bvec is enabled.
but sometimes it would lead to inefficient behaviors.
in case of large chunk direct I/O, - 64MB chunk read in user space -
all pages for 64MB would be merged to a bio structure if memory address is
continued phsycally. it makes some delay to submit until merge complete.
bio max size should be limited as a proper size.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 block/bio.c         | 2 +-
 include/linux/bio.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..dbe14d675f28 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {
 				*same_page = false;
 				return false;
 			}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..0f49b354b1f6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -20,6 +20,7 @@
 #endif
 
 #define BIO_MAX_PAGES		256
+#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)
 
 #define bio_prio(bio)			(bio)->bi_ioprio
 #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
@@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return true;
 
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
 		return true;
 
 	return false;
-- 
2.28.0


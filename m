Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9ECC47093
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4640613BA
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFBMbA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:31:00 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25768 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFBMa7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 08:30:59 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210602122914epoutp037c0f423a754454b40c888845512324fa~Ew7aT9kaK3228932289epoutp03s
        for <linux-block@vger.kernel.org>; Wed,  2 Jun 2021 12:29:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210602122914epoutp037c0f423a754454b40c888845512324fa~Ew7aT9kaK3228932289epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622636954;
        bh=dBTkcRF1EwwTLRDQEUEpnUBw+DAWxtwHogmD1mCaBqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBAOORxtD5HH7SNOvrvoSESyElmSOt8vXAEhkpYvwVF4byF0n/qrQokyFPROShSP6
         VXW3lkCqDnk9FeG1TR3BxoEmN58YiG6Ucouub9GU40g7uJeoGqF1b0YdVspmjTqbp+
         9A/TsLmyaA7w243tE4JCxoJ4IoV3GFwiTlgsy5x0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210602122913epcas1p44743ca81a680b92abce4d253f0948de1~Ew7Zikku-2784327843epcas1p4z;
        Wed,  2 Jun 2021 12:29:13 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Fw7cm41pMz4x9Q0; Wed,  2 Jun
        2021 12:29:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.CD.09701.89977B06; Wed,  2 Jun 2021 21:29:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210602122911epcas1p1c7574ee73f4da9ce17605a78f864ce95~Ew7XeehdJ3271632716epcas1p15;
        Wed,  2 Jun 2021 12:29:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210602122911epsmtrp1b42379061d6fae8cfecec6ec44040bf4~Ew7XdI6ik2602326023epsmtrp19;
        Wed,  2 Jun 2021 12:29:11 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-a4-60b7799831a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.1C.08637.79977B06; Wed,  2 Jun 2021 21:29:11 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210602122911epsmtip1415a1846e1d00543d9437ed454e43222~Ew7XMq5NJ0228902289epsmtip1w;
        Wed,  2 Jun 2021 12:29:11 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org, Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, yi.zhang@redhat.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v11 2/3] blk-sysfs: add max_bio_bytes
Date:   Wed,  2 Jun 2021 21:10:36 +0900
Message-Id: <20210602121037.11083-3-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210602121037.11083-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjm9PaLba13HcwDi642zmxAGQUKR4SFZWReM2eIc2pGtNzAtW0s
        bdNLcdPg0G5FGZ8j1MH42CZhCxSQMr6qnaTIXIWRAGMowhhCQCdfUoGBmNjSEvn3vO/zPOfJ
        +568XEyQywnkKtXplE5NqkTsHczWrkNi8ZVzbclhJnMAahg1c1B5bStAdWMFbGTtrwLItLiG
        oYvZKwxk+LqRjXoKbzDQVGMZhnKnPmehf3MeMdDyBI1sI8Fo0FrORvZiAwN91VyOoYfjvRzU
        9WiIiSaqizDU51hiocrJeLR+sxughafDHPRTezGGhvtMbNRoW2PHBxKDD04QRYZ5DtFRNsYh
        mm8FEYP39YSl9ks28X2FmUMs3BliE/m3awHhtDxPZHdeYhB2ew2WuOuMKlZBkamUTkipUzSp
        SrU8TnTilOyYTBoVJhFLXkbRIqGaTKPiRAmvJ4qPK1WuFYiEGaRK72olkjQtOnwkVqfRp1NC
        hYZOjxNR2lSVVhKmDaXJNFqvloemaNJiJGFh4VKXMlml+K6/Ami7As4WVQ4zssBD/xzgy4V4
        JLw+ncfJATu4ArwdQEdzu7dYArDNNuQtVgC0TfZwtiz36+55CRuAHd3TwE0IcCeAv9+Md2M2
        HgLz50bYbuyHV2HQOka7DRg+CeADh3GT2INL4cBKK9ONmfgBmN1UgrkxD38FLt7oZXnS9sON
        8dzNvi8eCy2PLWyPZjd0lE5tejGXxtByFXMHQLzKFxb3PvaaE2BpnZXpwXvgkx9ve0cIhH8U
        GDkewyUADcYq4CkKAayeqWF4VBFwyel0EVxXxCHYaD3sab8AO/6pAJ5kPpxfzmW5JRDnwS+M
        Ao/kRdh7YRzbypqp7/C+SMDV0nrMs7oCABt+a8cKgbBs20Bl2wYq+z/5GsBqwV5KS6fJKVqi
        Dd/+yRaweRZBUe3g8txiqB0wuMAOIBcT+fFeVbckC3ip5LmPKZ1GptOrKNoOpK51F2GB/ika
        112p02USaXhERASKjIqOkkaInuXJj32SLMDlZDr1IUVpKd2Wj8H1DcxivHEs+K3ZT7MS+AvD
        BvL8RN9Kzmn5t4vcgwGZc2f+3hXCN4dcHx7hGTMqJm4lJapVE7IEC6v8ZEB1Ff7SnP7uc6a3
        /1w2izM1EsfoX591Pcn75iA/WtRwd+P0m+PskmLJO+/9cmRyX0/LwK8Xjgrj7g0q+Mup9YIu
        Yc7qepLJR7Wz0hRsvRikvKprdPRn/yzMO8AfsM84Zz/YaLhzllXIPFUqm5HJldG4za8umJxK
        D21KOM8v+cEZ8lrw7oxF/+7svihrDK2IfNdv9Np676rPM/MnRSudRzPNSXDfU/8FslKmbXt/
        1i8v5vLgzmmec7+4yTi3VqO0QkO+ZK++84r4Ix8Rk1aQkiBMR5P/Ab/MGGmfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSnO70yu0JBht/ylmsu7OG3WLOqm2M
        Fqvv9rNZ7Lo4n9Fi2oefzBat7d+YLJoXr2ezOD1hEZPFk/WzmC16njSxWvztusdk8fVhscXe
        W9oWl3fNYbM4NLmZyWL65jnMFtfun2G3OHzvKovFwyUTmS3OnfzEajHvsYPFr+VHGS3e/7jO
        bnFqx2Rmi+vnprFZrN/7k81ByuPyFW+Pic3v2D12zrrL7rF5hZbH5bOlHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJOfRfqCbyePQoWXMATxRXDYpqTmZZalF+nYJXBl7Ls5lLDgsWTFx3nWm
        BsZrol2MnBwSAiYSZ1efYAexhQR2M0ocvV4EEZeSOH7iLWsXIweQLSxx+HAxRMlHRon1a/xA
        bDYBHYm+t7fYQGwRga3MEo9b5LsYuTiYBV4zSnQ9XsQCkhAWMJW49G0bmM0ioCrRvnEqM4jN
        K2At8WHRGVaIXfISf+73gMU5BWwkNj3YxAayVwioZtqUSIhyQYmTM5+AjWEGKm/eOpt5AqPA
        LCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeyluYOxu2rPugdYmTi
        YDzEKMHBrCTC6563NUGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUw
        WSYOTqkGprMdrn08qy4svOUi/6fCueS9mszKQF0TlqdSHnyVeRlv70+VcTHWkU5eK3l7SqJq
        vLgj387ba1bnhrLIXGhOOJfPvePck5tNb89Y7bj9vFbJIi/7jcAkoQM5ewta4uN3bnnA6bTR
        cYmF4s9Hfcuft1+WOS3KcPdVf8PW43skd3/cqB+pVT/rKM+pMFXHg+pHmU7eyPr9W9njtvE1
        p8l1F5cc9hNpKmrpCpsbJZ5oZcpyRO3NJ3bx1oKqRBdGG75bjLbvfRbFPPG6sy07aJbczjfd
        mm3RWrHnl5ZOan+27anZ9cl9615MylXwqv99kc9fRufjhm+nN75mcly4duuvup9J8ZFml7/8
        SOiMTHubrcRSnJFoqMVcVJwIACe9OJRTAwAA
X-CMS-MailID: 20210602122911epcas1p1c7574ee73f4da9ce17605a78f864ce95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602122911epcas1p1c7574ee73f4da9ce17605a78f864ce95
References: <20210602121037.11083-1-nanich.lee@samsung.com>
        <CGME20210602122911epcas1p1c7574ee73f4da9ce17605a78f864ce95@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add max_bio_bytes block sysfs node to show current maximum bio size.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 Documentation/ABI/testing/sysfs-block | 10 ++++++++++
 Documentation/block/queue-sysfs.rst   |  7 +++++++
 block/blk-sysfs.c                     |  7 +++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index e34cdeeeb9d4..8c8a793c04b4 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -316,3 +316,13 @@ Description:
 		does not complete in this time then the block driver timeout
 		handler is invoked. That timeout handler can decide to retry
 		the request, to fail it or to start a device recovery strategy.
+
+What:		/sys/block/<disk>/queue/max_bio_bytes
+Date:		June 2021
+Contact:	Changheun Lee <nanich.lee@samsung.com>
+Description:
+		max_bio_bytes is the maximum bio size to be submitted in bytes.
+		It shows current maximum bio size, and bio size to be submitted
+		will be limited with this. Default value is UINT_MAX, and
+		the minimum value is 1MB. 1MB(=BIO_MAX_VECS * PAGE_SIZE) is
+		legacy maximum bio size.
diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 4dc7f0d499a8..90af56899aa9 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -286,4 +286,11 @@ sequential zones of zoned block devices (devices with a zoned attributed
 that reports "host-managed" or "host-aware"). This value is always 0 for
 regular block devices.
 
+max_bio_bytes (RO)
+---------------------------
+This is the maximum number of bytes that bio size to be submitted will be
+limited. A value of 4,294,967,295(UINT_MAX) means no limit of bio size,
+and it's a default value. The minimum value is 1MB. It's legacy maximum
+bio size. (=BIO_MAX_VECS * PAGE_SIZE)
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e03bedf180ab..c4cae6bbcb3b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -108,6 +108,11 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_max_bio_bytes_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.max_bio_bytes, (page));
+}
+
 static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = queue_max_sectors(q) >> 1;
@@ -577,6 +582,7 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
+QUEUE_RO_ENTRY(queue_max_bio_bytes, "max_bio_bytes");
 QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
@@ -635,6 +641,7 @@ QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
+	&queue_max_bio_bytes_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
-- 
2.29.0


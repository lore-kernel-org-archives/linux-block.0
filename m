Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AE6C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 01:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A026564F65
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 01:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhBDBS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 20:18:27 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28975 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhBDBS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 20:18:27 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210204011744epoutp01f55d1a06def36c7945ddef85f4a99506~gZpbrSCfJ2762327623epoutp01X
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 01:17:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210204011744epoutp01f55d1a06def36c7945ddef85f4a99506~gZpbrSCfJ2762327623epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612401465;
        bh=GKtSnRxBYmtdHSUms4CFm87ZP5zqKOQgz4TyA4OJyMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Op15mIkwKO62wgfScUjJKMITHW93U6i7A6cGERoPK3kiKWaqekN5EJUlNEsMrCf//
         H96MW2IZSTYSWoQI1lZIESmVXgPmEarFaKBG7lByvjAcSySog0demxm9OB18XmjPk/
         HaEW9Rs/sqb1bW6xejgNv2Ecqu4Uiswv/VmaEShI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210204011744epcas1p4f5c158fc41e42305d1768ef8c4e7baa8~gZpa-XIiI2085520855epcas1p4h;
        Thu,  4 Feb 2021 01:17:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DWLJQ5ZgRz4x9Q8; Thu,  4 Feb
        2021 01:17:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.A0.09582.63B4B106; Thu,  4 Feb 2021 10:17:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210204011742epcas1p25d4f306a4de25a927db6e8f85de13db0~gZpZIcK242394323943epcas1p2t;
        Thu,  4 Feb 2021 01:17:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210204011742epsmtrp281c4c3ad7c4bceee46e297382a99601e~gZpZHZYmY2337923379epsmtrp2f;
        Thu,  4 Feb 2021 01:17:42 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-30-601b4b36b08e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.51.08745.63B4B106; Thu,  4 Feb 2021 10:17:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210204011741epsmtip13080d1a262b4e6665064cfc84fa9ae13~gZpY18mJ70398803988epsmtip11;
        Thu,  4 Feb 2021 01:17:41 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     ming.lei@redhat.com, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com,
        gregkh@linuxfoundation.org
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v5 2/2] bio: add limit_bio_size sysfs
Date:   Thu,  4 Feb 2021 10:01:56 +0900
Message-Id: <20210204010156.5105-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210204010156.5105-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+5tbwsbeK2vkzbZum44YQIttXAm1LiMkOtwCZtmbotLudIb
        iva1luIjGsQqT4cFpmzlpUKEAFoHSICJbjhlIDIRhE0ExmPTjadtHDKjruXCxn+/x+d3vr/f
        75zDxwXjhJCfoE9kTHpaKyG8OfXX/IMDQ6NFsdI/L/ijwsp6gKoGThDoWNrfGLKWOgh003YW
        Q8fHjnDRs8xBDD0eNqPme2+j7qZCArXkWTGUX1uIo96hDh66NniXg4bLcnDU2ebkouLRzeif
        8usATT/p46H2hjwcOZrniM2rqBzrFI9qtA/wqNqKAKr7loWqqcwgqKtF1Txq+spdgsquqwSU
        q+ZVKu37LCzG+zNthIah1YxJzOjjDOoEfbxSEr1N9Z5KESqVBcreQWESsZ7WMUpJ5NaYwKgE
        rXtAiTiJ1lrcoRjabJYEb4owGSyJjFhjMCcqJYxRrTXKpMYgM60zW/TxQXEG3UaZVBqicJOx
        Wo2j8wrXmC3cd8Gejx8GRaszgRcfkhug404ulgm8+QKyAcBHBbM46zgBfFbVvZBxAfjLw1+x
        xZKuziIem2gC8MiAjfcfVTdykuehCHI9zJ68R3gSK8lLGDxz/wTX4+DkKIA9bamEh1pBKuCN
        0hS3Ip/PIf2gM5/jCfuQG2HPt6k4K/ca/P3L8nnbiwyH6WU9BMssh23fjM3zuJuxXiqYbxyS
        E3w4VXMVsMWRcC67msvaK+BfrXU81hZC11QzwRZkAWhNLQGsYwOw7MG5hUnl0OlyAU93OOkP
        HU3BbPh12Pi0CLDKvnDq8XGuB4GkD0xPFbDIm7Dj6BC+qPXgfOPCiRTMrfh6YanZAJa0d2E2
        ILYvGci+ZCD7/8qnAV4JVjNGsy6eMcuM8qW3XAPmX31AWAM4NTkT1AIwPmgBkI9LVvrQqcJY
        gY+a3n+AMRlUJouWMbcAhXvbObhwVZzB/W30iSqZIkQul6MNoWGhCrlkjc8u6W8qARlPJzJ7
        GMbImBbrML6X8DBG//D8vumPfbeHCkRcZmRLg1fk1uLzJXd+qt8B/Ao/9S09sGyLr+7zN8JT
        sMsXqWSfbS9ul+/O8HpoqciytD+fnNlbfGZTqEIjPjpR3uWX/JYzGk04K04WfddaRaeUhemm
        x3t3hX01mpIRwuk91FGh/ESu7LgFbZHXe23ps6LuqJkPfxStfens7otRw/qkd0VjN0+1BuaR
        rp2CdqWz2dRMJidkWOfOcZ8E7X+RWbvngy9GAZYrG0tT5+Y+ygySrvEL/3hv0st9l9drHHWD
        65b192dtH8G2i4jTfbzxmoidT9ctt6t6ZOqPfs63ySPKDqLK9/lrD90YDp6p3vHKsX5ffzR7
        UMIxa2hZAG4y0/8C2sz92X4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnK6Zt3SCwb39rBZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbXLt/
        ht3i8L2rLBYPl0xktjh38hOrxbzHDha/lh9ltHj/4zq7xakdk5kt1u/9yeYg6jGx+R27x85Z
        d9k9Nq/Q8rh8ttRj06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkPNoPdDMFcEVx2aSk5mSWpRbp
        2yVwZaw/t4+1oE+qYt2s6cwNjHPFuhg5OSQETCQunpvL3sXIxSEksINRYsaLWcwQCSmJ4yfe
        snYxcgDZwhKHDxdD1HxklHjx/zEjSA2bgI5E39tbbCC2iMBRJok76/JAipgFXjNKdD1exAKS
        EBYwlTi2uJEZZBCLgKrEp+lgYV4BK4krG9ugdslLPO1dDmZzClhLdCy5AjZTCKjm+If1jBD1
        ghInZz4B62UGqm/eOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBEeiltYOxj2rPugdYmTiYDzEKMHBrCTCm9gmlSDEm5JYWZValB9fVJqTWnyIUZqDRUmc
        90LXyXghgfTEktTs1NSC1CKYLBMHp1QD05LkH5MWHVzXkbn9ksVyFbnLvvd4FrvMKa9iPqhr
        ofB2y6uUYtNvgi8XVnHeejPzSELu+XlzZHzjwj+Yz/roHb/3xlyD/VtCPPj1d6jrXz1RLnbw
        1aNzl4pf2N7V11T4f/AQ1/G3uxxlvNN+SFteOXX78opNlsLuqyae7St1+cgp1+Cjy5rv+TfM
        YH8HA9+Lh2kaB+eJfCmKzjw8qSxBU8RDfIl6r8fqmAXbXNlTFqh6nFpRWx4Un63H8Zw/v84y
        2tAz5+fPXVsnyjyv9Pd/9/zY6arrPrWzgqxWGX40Kql6KHVxK7fqLwcz0eVfFqrft7rQOHVn
        y3n5o7MjOHe2POw49OZWqXR+iOHzwu+xf5VYijMSDbWYi4oTAX3chR8zAwAA
X-CMS-MailID: 20210204011742epcas1p25d4f306a4de25a927db6e8f85de13db0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210204011742epcas1p25d4f306a4de25a927db6e8f85de13db0
References: <20210204010156.5105-1-nanich.lee@samsung.com>
        <CGME20210204011742epcas1p25d4f306a4de25a927db6e8f85de13db0@epcas1p2.samsung.com>
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


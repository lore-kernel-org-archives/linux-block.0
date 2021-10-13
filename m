Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517ACC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 02:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305C360E78
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 02:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJMCSP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 22:18:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14505 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhJMCSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 22:18:15 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211013021610epoutp015afcc0d88149787c04b56368fe9b6019~tdXGS7mCQ1397413974epoutp01Z
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 02:16:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211013021610epoutp015afcc0d88149787c04b56368fe9b6019~tdXGS7mCQ1397413974epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634091370;
        bh=iBlDvHB/OsQgZeiVFRhnDt3AUZmGw5uX/LXkxr2NQ2U=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=iKbonuHCFzZHkNZnM0i7tppseK3P8qq9ViFB4Un7CVc8eLqFCt/kDh9H6GPeA7Ysc
         2LsQRPAi7mNqAfVxKplMZzDYBqZSQtBor0SxZFiScyikSP/JXTZJEmzw8MpZCCCxQP
         1STnwnWz302Xm9B9WPwQo+/juiV4IvHKMUxYsmtQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20211013021609epcas2p4af48ddd86dbd7542c9053cd5f078d8ec~tdXF2Po-q2449924499epcas2p4M;
        Wed, 13 Oct 2021 02:16:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HTbjy0smyz4x9QZ; Wed, 13 Oct
        2021 02:16:06 +0000 (GMT)
X-AuditID: b6c32a45-4c1ff700000025f5-7f-6166416389a4
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.45.09717.36146616; Wed, 13 Oct 2021 11:16:03 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH RESEND v2] block-map: added error handling for
 bio_copy_kern()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20211013021602epcms2p408b3eb79d4861bf8c340542ac92c23ec@epcms2p4>
Date:   Wed, 13 Oct 2021 11:16:02 +0900
X-CMS-MailID: 20211013021602epcms2p408b3eb79d4861bf8c340542ac92c23ec
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmqW6yY1qiwf5dLBar7/azWbw8pGlx
        esIiJove/q1sFntvaVtc3jWHzYHNY/MKLY/LZ0s9+rasYvT4vEkugCUq2yYjNTEltUghNS85
        PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLGSQlliTilQKCCxuFhJ386m
        KL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj3qwNLAV/+CqePdjK
        3MD4nKuLkYNDQsBE4kWbQxcjF4eQwA5GiZW/ehhB4rwCghJ/dwh3MXJyCAsESDx+tIAZxBYS
        UJI4t2YWWImwgIHErV5zkDCbgJ7EzyUz2EDGiAhcYJRYPGEnWL2EAK/EjPanLBC2tMT25VsZ
        IWwNiR/LeqFqRCVurn7LDmO/PzYfqkZEovXeWagaQYkHP3dDxSUlGidMg5pZLnF1+RwWkMUS
        Ah2MEpeX3IRK6Etc69gIZvMK+Eqsmn6ODcRmEVCVuNJwGWqZi8S8P1dZQWxmAXmJ7W/nMIM8
        xiygKbF+lz4keJQljtxigXmlYeNvdnQ2swCfRMfhv3DxHfOeMEG0qkksajKCCMtIfD08H6rE
        Q2LmnA7mCYyKsxDhPAvJCbMQTljAyLyKUSy1oDg3PbXYqMAQHrPJ+bmbGMEJUMt1B+Pktx/0
        DjEycTAeYpTgYFYS4TUEpish3pTEyqrUovz4otKc1OJDjKZAz09klhJNzgem4LySeEMTSwMT
        MzNDcyNTA3Mlcd65/5wShQTSE0tSs1NTC1KLYPqYODilGphEV13+zGXdO69HPe/5B/dvujvY
        F+rkPeVxlRDZ13HZTOX8JOkU3TANpRfv1IxiBQ7O41p2NkszOF1uJt//nxKdjt96Hmbc/fSh
        rVrloJbngmfFh+7ceuhxVnfq9gdnFBbl8MZOZ19yd8fvrBNPTlXMfr2xSsVy6Smb+yZpflei
        Lz7ZvMtjEedN5pftxd9F7l4+c9/GkK0v/qDfceaSlIeK2e2tAtxTNz1L6lRsy3C37/u3Zs1e
        JWuReofZ1htyjttOvn/D0tN8aUXoMudJT6VufPkhMoFdt39TyaeyImbx37dX9N6d3RGxUrZo
        nmdpugybhcZfVh87M4kfn6MNK6+5sz8Xz6uZEckgo62oVKDEUpyRaKjFXFScCAAZNUxGCQQA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211013014256epcms2p5485187a369a9f8c74c2b3ab925df88fb
References: <CGME20211013014256epcms2p5485187a369a9f8c74c2b3ab925df88fb@epcms2p4>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When new pages are allocated to bio through alloc_page() in
bio_copy_kern(), the pages must be freed in error handling after that.

There is little chance of an error occurring in blk_rq_append_bio(), but
in the code flow, pages additionally allocated to bio must be released.

V2:
        - replace int with bool

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-map.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..b137a2f569f8 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -628,6 +628,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
        int reading = rq_data_dir(rq) == READ;
        unsigned long addr = (unsigned long) kbuf;
        struct bio *bio;
+       bool do_copy;
        int ret;

        if (len > (queue_max_hw_sectors(q) << 9))
@@ -635,8 +636,9 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
        if (!len || !kbuf)
                return -EINVAL;

-       if (!blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
-           blk_queue_may_bounce(q))
+       do_copy = !blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
+               blk_queue_may_bounce(q);
+       if (do_copy)
                bio = bio_copy_kern(q, kbuf, len, gfp_mask, reading);
        else
                bio = bio_map_kern(q, kbuf, len, gfp_mask);
@@ -648,8 +650,11 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
        bio->bi_opf |= req_op(rq);

        ret = blk_rq_append_bio(rq, bio);
-       if (unlikely(ret))
+       if (unlikely(ret)) {
+               if (do_copy)
+                       bio_free_pages(bio);
                bio_put(bio);
+       }
        return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_kern);
--
2.25.1

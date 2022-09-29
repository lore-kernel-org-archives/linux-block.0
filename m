Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2409EC6FA82
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 07:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiI2Hrz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiI2Hrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 03:47:53 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5398B139F76
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 00:47:52 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220929074751euoutp01a5916f4889ff9caa8185a6aed21553a1~ZRT5PAkq41529715297euoutp01k
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 07:47:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220929074751euoutp01a5916f4889ff9caa8185a6aed21553a1~ZRT5PAkq41529715297euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664437671;
        bh=uBgdqevbaKPlqv9MNZMcer/p3GljEYLiI4i1BnQgJlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrMvSSG6rGrk1qM7NLN0rNpmWW0SEmpUGC3FV41JenQs0qtJL13nz8UQHnYl9cYKi
         g/zUaN2HGW1Pdk42wXDy2txn/aamgHO0HfcVw/ePLAZAocFNXjGwcYlbY2px4tzjRJ
         1LCJAFZtA/Ga61f431czOayBrb7N4iwVV0a/Xgvg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929074750eucas1p1f3314c5972d99f875ac580990175efc5~ZRT4Sm-ds2536125361eucas1p1L;
        Thu, 29 Sep 2022 07:47:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.CC.19378.6AD45336; Thu, 29
        Sep 2022 08:47:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220929074749eucas1p206ebab35a37e629ed49924506e325554~ZRT3TeKYR2534025340eucas1p2o;
        Thu, 29 Sep 2022 07:47:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929074749eusmtrp1d99546e03142b5a0cf0ae35b30757e3e~ZRT3SzuVN2626326263eusmtrp1i;
        Thu, 29 Sep 2022 07:47:49 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-89-63354da61251
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.C5.10862.4AD45336; Thu, 29
        Sep 2022 08:47:49 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220929074748eusmtip1540c6a959d1cc932c84323865a339c06~ZRT3AFrjS2987129871eusmtip1e;
        Thu, 29 Sep 2022 07:47:48 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org,
        damien.lemoal@opensource.wdc.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 2/2] block: use blk_mq_plug() wrapper consistently in the
 block layer
Date:   Thu, 29 Sep 2022 09:47:45 +0200
Message-Id: <20220929074745.103073-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929074745.103073-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd1lvqbJBlf/sVisvtvPZvH77Hlm
        i5sHdjJZrFx9lMli7y1ti89LW9gd2Dwuny312H2zgc1jZ+t9Vo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKeDjhFWtBK3/F10/7GBsYl/J0MXJwSAiYSHxZxNvFyMUhJLCCUWLb1qesEM4X
        RokpZ2YxQjifGSU+XjnCAtOx5FYFRHw5o0TXladsEM5LRomX2xexgRSxCWhJNHaydzFycogI
        yEt8ub2WBcRmFqiXaL7wEywuLBAl0XXqABuIzSKgKvHh5GuwGl4BK4m/PfvBaiSAemde+g5m
        cwpYS6z68I8VokZQ4uTMJ1Az5SWat85mBrlBQmAlh8SL1tmsEM0uEkv/HWeEsIUlXh3fAjVU
        RuL05B4WCLta4umN31DNLYwS/TvXs0F8aS3RdyYHxGQW0JRYv0sfotxR4nz7CWg48EnceCsI
        cQKfxKRt05khwrwSHW1CENVKEjt/PoFaKiFxuWkO1FIPiZMPVjJOYFScheSZWUiemYWwdwEj
        8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAtHL63/GvOxhXvPqod4iRiYPxEKMEB7OS
        CO/vo4bJQrwpiZVVqUX58UWlOanFhxilOViUxHnZZmglCwmkJ5akZqemFqQWwWSZODilGpiW
        vr/m8qhvpt5Zz+xXi58GHmfyPPr/rkrFT/3zVxS+vfCeMbPkaMmvCU9/BKc75i93Tl3itIC5
        wOushrK2gFFwyif3aR7N8eqPazy1JS+65i3buPfeFdZXkw7sUtb83xD77kT5920K8x9MeDGD
        q/7pq2/LBJfknF6wJ2n/py0+2SEBoi03boqc799/5vbxZCbPmpcf83ZxxKUvtn578uCFRMuJ
        TU1rPz6dY7Uv3iyc+51D+NeKxzV2N35nzYy/nva++NFU994lh575qoe9+mNlH7u36G+4RlDo
        0au80UtvzV0v8XHjslfb+ooTrQ7tbNrbdfe+8xL1xU+iXnncNr3lJSq84upzrdY9y6NPyvtf
        varEUpyRaKjFXFScCADQc8ktmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7pLfU2TDVbFWqy+289m8fvseWaL
        mwd2MlmsXH2UyWLvLW2Lz0tb2B3YPC6fLfXYfbOBzWNn631Wj74tqxg9Pm+SC2CN0rMpyi8t
        SVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4OOEVa0Erf8XX
        T/sYGxiX8nQxcnBICJhILLlV0cXIxSEksJRR4vSGh0xdjJxAcQmJ2wubGCFsYYk/17rYQGwh
        geeMErNfWYP0sgloSTR2soOERQQUJTZ+hChnFmhmlHg+rwLEFhaIkFj2ZhNYnEVAVeLDydcs
        IDavgJXE35797BDj5SVmXvoOZnMKWEus+vCPFWKVlcTaW9uYIeoFJU7OfMICMV9eonnrbOYJ
        jAKzkKRmIUktYGRaxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERj+24793LKDceWrj3qHGJk4
        GA8xSnAwK4nw/j5qmCzEm5JYWZValB9fVJqTWnyI0RTo7onMUqLJ+cAIzCuJNzQzMDU0MbM0
        MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYKqKUl34b/mT087MMw8Ixjjvjg6qYgyd
        6G8SbVNXVLY0KTY+NTpDsqNs9qbaNalcP4yNBcwT5rfKrZxz7BnDq9lV/p/k/IMu3s4Nldhw
        9Wnzrl2rLXdoNPOqOryJ2Dbv3qKcXXu61+8vuvS5NvFmzR+VNged7DkKsSfDuwVP9/Kc/m/0
        n1+ci/VGSn+14039zbL3Dx84879sRX756YlxzxyWNJxj18kJVLaddGDSrn9V/TWcSYuWZbTY
        t8hNVg/PmLpnaaj4VbUVC2odjjQwuCcv6/D42vAv/6ndk8REecOfugb53/cL7pjuv2D+cba/
        cmuCni/mjPv5keHfcf3ISe5GYaadRicub5XzrYk1VWIpzkg01GIuKk4EAJuSxykIAwAA
X-CMS-MailID: 20220929074749eucas1p206ebab35a37e629ed49924506e325554
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220929074749eucas1p206ebab35a37e629ed49924506e325554
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929074749eucas1p206ebab35a37e629ed49924506e325554
References: <20220929074745.103073-1-p.raghav@samsung.com>
        <CGME20220929074749eucas1p206ebab35a37e629ed49924506e325554@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blk_mq_plug() wrapper to get the plug instead of directly accessing
it in the block layer.

Either of the changes should not have led to a bug in zoned devices:

- blk_execute_rq_nowait:
  Only passthrough requests can use this function, and plugging can be
  performed on those requests in zoned devices. So no issues directly
  accessing the plug.

- blk_flush_plug in bio_poll:
  As we don't plug the requests that require a zone lock in the first
  place, flushing should not have any impact. So no issues directly
  accessing the plug.

This is just a cleanup patch to use this wrapper to get the plug
consistently across the block layer.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 203be672da52..d0e97de216db 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -850,7 +850,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
-	blk_flush_plug(current->plug, false);
+	blk_flush_plug(blk_mq_plug(bio), false);
 
 	if (bio_queue_enter(bio))
 		return 0;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..5bf245c4bf0a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1209,12 +1209,14 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  */
 void blk_execute_rq_nowait(struct request *rq, bool at_head)
 {
+	struct blk_plug *plug = blk_mq_plug(rq->bio);
+
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
 
 	blk_account_io_start(rq);
-	if (current->plug)
-		blk_add_rq_to_plug(current->plug, rq);
+	if (plug)
+		blk_add_rq_to_plug(plug, rq);
 	else
 		blk_mq_sched_insert_request(rq, at_head, true, false);
 }
-- 
2.25.1


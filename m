Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C2C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643D1217D8
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NDJwzw+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeLRHI5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:08:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50643 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeLRHI5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 02:08:57 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so2624139iti.0
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 23:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HVnA6gNLAJJbGRnmjJSrKTONznADz2Idt1LWQFZBLSc=;
        b=NDJwzw+/VeE/E6rPIIJV7cRcPOEzRAbv2aA2oeaYAT51MrA6/O5LKT/55LbPIakLlK
         Sg4IpOZaa2vsdEg00qccq+l80nSZzWwqMRa5Pr2pfucvMGOAOG3ptYehN+Up5ohYjJqF
         rD7WLm9yxWRiocqdo60CRKQ3Jhx/+ulWZcA/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HVnA6gNLAJJbGRnmjJSrKTONznADz2Idt1LWQFZBLSc=;
        b=QczNue+4T7mY+dhqcGe8XJwJWTb/gTkt2kaXPdbpxKJzZxwweKx0UO/Ue/GkGu0NEp
         Im7e9uZLu32iyMN+4j4x22UuYHarslQHMd7QJepEz0KyyK3zjz9Wz20yTRaU3YHoN8l2
         gsIfLGAgvKAkLQRtfhCkkMBDMJcOiPtE5HFjpSbs3pvH9B0MSVaPrK82fFvueTKIZbcu
         MVMYlFSomA4hLKsi5ekRa6HvpJaUPgEjF/3bF0LoAPLXQ3TBu+1sqnO3wzNbEItOTe4d
         lr3itKCHmzkUcceS9cWAvi9KyrQ4dMPOKXtq2+tT2HufjyxRHe0Kb5kNAgR+cI2SBuKN
         UZPg==
X-Gm-Message-State: AA+aEWbbE+goFdFFzfMJ78cB3jCnzXFOYLghZ8e7EbJANuxVjXDacT7V
        6YYmGqvUp/oik32FYde6KB/NclWovp1uVqG2lbwPaBkH8YI=
X-Google-Smtp-Source: AFSGD/WGytnA4xRMJtzgRLold+uZhXRhy8DX5Gjye6LEs4C6SErAOa5F4j86nEPmxbHWNhWDfatQZKn06sSYGvhPPcI=
X-Received: by 2002:a24:c9c6:: with SMTP id h189mr2002755itg.175.1545116936044;
 Mon, 17 Dec 2018 23:08:56 -0800 (PST)
MIME-Version: 1.0
From:   Kashyap Desai <kashyap.desai@broadcom.com>
Date:   Tue, 18 Dec 2018 12:38:45 +0530
Message-ID: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
Subject: [PATCH V2] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

V1 -> V2
Added fix in __blk_mq_finish_request around blk_mq_put_tag() for
non-internal tags

Problem statement :
Whenever try to get outstanding request via scsi_host_find_tag,
block layer will return stale entries instead of actual outstanding
request. Kernel panic if stale entry is inaccessible or memory is reused.
Fix :
Undo request mapping in blk_mq_put_driver_tag  nce request is return.

More detail :
Whenever each SDEV entry is created, block layer allocate separate tags
and static requestis.Those requests are not valid after SDEV is deleted
from the system. On the fly, block layer maps static rqs to rqs as below
from blk_mq_get_driver_tag()

data.hctx->tags->rqs[rq->tag] =3D rq;

Above mapping is active in-used requests and it is the same mapping which
is referred in function scsi_host_find_tag().
After running some IOs, =E2=80=9Cdata.hctx->tags->rqs[rq->tag]=E2=80=9D wil=
l have some
entries which will never be reset in block layer.

There would be a kernel panic, If request pointing to
=E2=80=9Cdata.hctx->tags->rqs[rq->tag]=E2=80=9D is part of =E2=80=9Csdev=E2=
=80=9D which is removed
and as part of that all the memory allocation of request associated with
that sdev might be reused or inaccessible to the driver.
Kernel panic snippet -

BUG: unable to handle kernel paging request at ffffff8000000010
IP: [<ffffffffc048306c>] mpt3sas_scsih_scsi_lookup_get+0x6c/0xc0 [mpt3sas]
PGD aa4414067 PUD 0
Oops: 0000 [#1] SMP
Call Trace:
 [<ffffffffc046f72f>] mpt3sas_get_st_from_smid+0x1f/0x60 [mpt3sas]
 [<ffffffffc047e125>] scsih_shutdown+0x55/0x100 [mpt3sas]

Cc: <stable@vger.kernel.org>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

---
 block/blk-mq.c | 4 +++-
 block/blk-mq.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6a75662..88d1e92 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -477,8 +477,10 @@ static void __blk_mq_free_request(struct request *rq)
     const int sched_tag =3D rq->internal_tag;

     blk_pm_mark_last_busy(rq);
-    if (rq->tag !=3D -1)
+    if (rq->tag !=3D -1) {
+        hctx->tags->rqs[rq->tag] =3D NULL;
         blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
+    }
     if (sched_tag !=3D -1)
         blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
     blk_mq_sched_restart(hctx);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9497b47..57432be 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -175,6 +175,7 @@ static inline bool
blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
                        struct request *rq)
 {
+    hctx->tags->rqs[rq->tag] =3D NULL;
     blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
     rq->tag =3D -1;

--=20
1.8.3.1

Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1C6C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4542082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 10:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lha4EGU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4542082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDKAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:00:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55536 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDKAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 05:00:24 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so14398498itg.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 02:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gmbo766LGwjzdNTXE4pQ4XjK+N0K1PO3YhpgsMnbwSU=;
        b=Lha4EGU3ZEbxIyY0yOrJAO7S9GRgq1b1xvKBuktkjc78ZDKZLCguruf1cSFEcQeihi
         As0dFSDM+WTMGgZqZb5bZw4LtXBIxNkSA0AF5RNTvGEBDuK1w3imjgjjQbkpmnN0FbKz
         6NMoZ/R3Q184oGvijlzx+mYiYZynSwR941q0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gmbo766LGwjzdNTXE4pQ4XjK+N0K1PO3YhpgsMnbwSU=;
        b=Sv5aZH34gMJcVUxATINdbIBoAaBcWRGfWrpcehwWY18r3HXS9CkoPXtLtKJ74HZn6A
         PaHzxdCZquLnmMFnTSZ7zunS3SuW0QoS2Dh+jwwuOAqWyLVGLQYeTS9k+Sat2LPevewK
         yHJV67Ko6ZSLNszWoejEwO1nw4i6voes9zbW07I/qRFs9l2snNJ3Tl48kcXg+E/OqwKQ
         OiEbf1iOmJwlB7HrzTh24nXd/bjCz4ywevCRoY5zJRKneFtkalPGPOtyMIAeg1x8Ey45
         eLLFfI2rHQKF4x4UG3DdVkDBQtm984PpC64NzNBG69iO1WI8+z5JEOH6sqEp35i/iMD+
         N1hg==
X-Gm-Message-State: AA+aEWbMIeaudXIXxhFzYf6Hk4kBthNLlgpm/yQq0MC8pFwCq2/8IUQZ
        S6gI/izrcG/TozFfk5Ud7iAH4r9kOYMnyvfu1sAWdfXJtTU=
X-Google-Smtp-Source: AFSGD/UDf+InyLrr8LTHAx7G9ed2WD4rmnhT9Qnz1wW8uuj3ReXddGh3nQ4UsLC0X4cbVjh5SShclR+OBpiGvPPs/xk=
X-Received: by 2002:a02:2303:: with SMTP id u3mr17912788jau.42.1543917623017;
 Tue, 04 Dec 2018 02:00:23 -0800 (PST)
MIME-Version: 1.0
From:   Kashyap Desai <kashyap.desai@broadcom.com>
Date:   Tue, 4 Dec 2018 15:30:11 +0530
Message-ID: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
Subject: [PATCH] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
 block/blk-mq.h | 1 +
 1 file changed, 1 insertion(+)

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

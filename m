Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CD9C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 21:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF522082A
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Sp3SgkGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDIVxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:53:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46951 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDIVxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 17:53:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id s81so11248113qke.13
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7pyMXwpQbZqEHPi/aCyWEBfA0A1BbmCszWUq1Ub6/0=;
        b=Sp3SgkGptSSrLUETQPF+PuH8DgW2EuphMexCDQAxV2b573fJVrB3obuvgz6LjKztDu
         Non/B22kP3rMsz31h4+jyKqMGtRj7JrIvEFRIAQB6AX4y3/2FQUx1DrCUEmCqbQlLhzj
         iwdz9kvhVXlcE+TZC1usTnqWRxssTmCQUtLM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7pyMXwpQbZqEHPi/aCyWEBfA0A1BbmCszWUq1Ub6/0=;
        b=BgFdycH+juU/mgjG4a3b8NBpj32f+5deyNhVEs54D/f2x5UOmCM5srNvwKX7HS2W6I
         opQqjzhNEjyUQvQBOTJAYO2w8qVWNDMcBLVcz3y/TyTHAU51GfFCdrY7uM0pQ67lDw3Z
         JLUyIb/X5T/OWQIZw+MiqNLjgviKIsC1nHuBPt0DE3Inx9xuSrbfHBCTB2a8XY6biFVV
         dZLYXqaHTtW1H4AySHvacH5/0I1HvWUh+rcnTQ48U0/MEW7ztaCjQOrdQo4JXBtx7UD5
         cgaHDxJk2iHgZVfcj/A6dkyUBUaDZr2li0opZBX1FVIjGXvz+T7FFuHlKyt3ewxQYTXN
         dKwA==
X-Gm-Message-State: APjAAAUhrAvFdw3jQdVryWiae1g8IJBzf+qbkeYHil5yTphePrFh5i2g
        eItxiImVZXpeQUIZNsycxfuihsmgVdao6aEOFuLYQw==
X-Google-Smtp-Source: APXvYqzZjGxV/LHLwnzKXzeWCUse1D/5RuexUKRTVivI0g4FIlukrNQxZmAfRIJWnIwsjMgQJ7BVj9mRtNTExdig6LI=
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr30881640qkj.221.1554846814859;
 Tue, 09 Apr 2019 14:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <1554846371-33660-1-git-send-email-jalee@purestorage.com>
In-Reply-To: <1554846371-33660-1-git-send-email-jalee@purestorage.com>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 9 Apr 2019 14:53:24 -0700
Message-ID: <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com>
Subject: [PATCH] scsi: core: set result when the command cannot be dispatched
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When SCSI blk-mq is enabled, there is a bug in handling errors in scsi_queue_rq.
Specifically, the bug is not setting result field of scsi_request correctly when
the dispatch of the command has been failed. Since the upper layer code
including the sg_io ioctl expects to receive any error status from result field
of scsi_request, the error is silently ignored and this could cause data
corruptions for some applications. This commit also fixes another bug that the
result field is not initialized when scsi_request is allocated.

Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
---
 block/scsi_ioctl.c      | 1 +
 drivers/scsi/scsi_lib.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 533f4ae..f2d7979 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -723,6 +723,7 @@ void scsi_req_init(struct scsi_request *req)
        req->cmd = req->__cmd;
        req->cmd_len = BLK_MAX_CDB;
        req->sense_len = 0;
+       req->result = 0;
 }
 EXPORT_SYMBOL(scsi_req_init);

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2018967..af1488d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1699,6 +1699,7 @@ static blk_status_t scsi_queue_rq(struct
blk_mq_hw_ctx *hctx,
                        ret = BLK_STS_DEV_RESOURCE;
                break;
        default:
+               scsi_req(req)->result = DID_NO_CONNECT << 16;
                /*
                 * Make sure to release all allocated ressources when
                 * we hit an error, as we will never see this command
--
2.7.4

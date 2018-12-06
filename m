Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA0C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 05:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE12146D
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 05:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I5nlhea+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFE12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeLFFpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:45:17 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:41651 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbeLFFpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 00:45:17 -0500
Received: by mail-io1-f54.google.com with SMTP id s22so18729101ioc.8
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 21:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=ESxszga/9lbWfhjwnK/zLk3T36da5oTJNBT2CcojXG0=;
        b=I5nlhea+CU16g8NuDUy5b9s0JOEqgTSd9ou+ZqZaUIpQx0bh29b58Sz5nZ8XDP4v6d
         7391UB/fl/pf760M25lT8o3BROZlOSmUb39mhd/MD/0QrTw+3PgQwebrDFi2uQZiGFt+
         Y6R+PISRJy7ag7i/LcQtSSeXgZDSUTcvMtR28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=ESxszga/9lbWfhjwnK/zLk3T36da5oTJNBT2CcojXG0=;
        b=qK6ZZ3Q9+5XC3Zm7pKJJKscmjDpQP3+HWPwOrpBQ+gGR3Y4mPpyW9CLi1HyIH+w+R5
         gzsgbjV7R9N4pqmdnBDKfS/QXW03biDyxAXKFYCWhXMgEExmp/DguH9ZB/ql2I9r+CJo
         S636ES/L4xGllmVd6twPccYEAfi7KGic5nVBR8uFgOK1fknk/QIuqPKcoT4S4tKN0eK7
         ztWXSF3HzZy+kzCLo3UDZBFj2rJICQHS6gf6iYRs13vI7OpiPJitaUusE2MM2td6SSeg
         cfWlMD2K5/t6lw/SihaZNIH8Yro86BnTx1Rh1v3mKTdbIvU9XfHRm7pYOwivbwbSS1c5
         7zXw==
X-Gm-Message-State: AA+aEWZ/84R0aEgTwg0BktnkdFWKFkJ5l+lUs3iyYebSOH4a91puzpmb
        urS2tzAcddRc3SuXS5lHikliP0Km0puZxMGdnhiGVw==
X-Google-Smtp-Source: AFSGD/X3FBGjt+ofNeXVbL34zDJiYC3kjFF2v2X7HgB7mKO6hmJdIX5EDb2uIV0FwVQJf0s8/MLWv99dDmHPlfXZskE=
X-Received: by 2002:a6b:b90a:: with SMTP id j10mr22555829iof.172.1544075115996;
 Wed, 05 Dec 2018 21:45:15 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1543943674.185366.194.camel@acm.org> <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
 <20181206003323.GB3015@ming.t460p>
In-Reply-To: <20181206003323.GB3015@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIDGsA5xuRcZ0ZzYKBZCDlABhVdmwHqGsmwAaocH2ak93HZkA==
Date:   Thu, 6 Dec 2018 11:15:13 +0530
Message-ID: <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
Subject: RE: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>
> If the 'tag' passed to scsi_host_find_tag() is valid, I think there
> shouldn't have such issue.
>
> If you want to find outstanding IOs, maybe you can try
> blk_mq_queue_tag_busy_iter()
> or blk_mq_tagset_busy_iter(), because you may not know if the passed
'tag'
> to
> scsi_host_find_tag() is valid or not.

We tried quick change in mpt3sas driver using blk_mq_tagset_busy_iter and
it returns/callback for valid requests (no stale entries are returned).
Expected.
Above two APIs are only for blk-mq.  What about non-mq case ? Driver
should use scsi_host_find_tag for non-mq and blk_mq_tagset_busy_iter for
blk-mq case ?
I don't see that will be good interface. Also, blk_mq_tagset_busy_iter API
does not provide control if driver wants to quit in-between or do some
retry logic etc.

Why can't we add single API which provides the correct output.

scsi_host_find_tag () API works well in non-mq case because,
blk_queue_end_tag() set bqt->tag_index[tag] = NULL;.
We are missing similar reset upon request completion in blk-mq case. This
patch has similar approach as non-mq and there is no race condition I can
foresee.

BTW - My original patch is half fix. We also need below changes -

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f91c6e..d8f53ac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -477,8 +477,10 @@ static void __blk_mq_free_request(struct request *rq)
        const int sched_tag = rq->internal_tag;

        blk_pm_mark_last_busy(rq);
-       if (rq->tag != -1)
+       if (rq->tag != -1) {
+               hctx->tags->rqs[rq->tag] = NULL;
                blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
+       }
        if (sched_tag != -1)
                blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
        blk_mq_sched_restart(hctx);


>
>
> Thanks,
> Ming

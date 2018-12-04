Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD4C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7920834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DKYNPZPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF7920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLDQry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:47:54 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40925 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQry (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 11:47:54 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so15444589ita.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 08:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=6MtSRmCm6aVdDzQRFtm/H2PxQChCgFBt62rSyJRDfY4=;
        b=DKYNPZPFhTQN7x/R7ek88o7NDH9e7soL4Tc2g0LFGsIesKfOzkWbE7MFWzxX9/+ZsY
         ktjccDySznGxoDQuFyL3tM4uGz9IkKM1nHVQwlhhs3+kbDssi7/CN/96mmtaqSZCH2xK
         n1A/yK4NaOYtyMzxo9B1sFk0L8Hl3vp0oPEXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=6MtSRmCm6aVdDzQRFtm/H2PxQChCgFBt62rSyJRDfY4=;
        b=Q5tpb3wHS8j0MKolarPKiC5g/jp2vjHYWWOPHKobTVR23mRQDeEOSV5Mp7ViQJqnKy
         ffujphsb34FSnqsdgS5WsbBAtew+iMCn2JwB+E5vk/1fcUmzvtvNIHu3mEX8N00Tu7FI
         GpmbgMf0TB09/V0z14+fwjyLv5zzqd5dJj8TuMirjKfBOOJKT4j/CjuARHpdOSNMgr8W
         ovte48IIt+5Ur6Ib5G0BYpkZxnMablxZHcl9DZeB3yOmSXpdpWyAAM7rBu4TRq+qo7Vu
         kbvqCSnjwgk3e8hZkNxLkUTx52RicpKZ+ufsdra0I6p/UlCrMI5Q//IuN0zW9dVvP6zo
         PM2A==
X-Gm-Message-State: AA+aEWZKkyWEG/des+pduniqNG1V7B5JzeuTJWY95Bw+JBBv6BBZLa6o
        k0ScepBxbqZlGdP8cZsMZKVF9XAEo0CBhhlk8f4gRw==
X-Google-Smtp-Source: AFSGD/UZTVaRplDEr6WiA5Mq/xqho6/OXRNRvHRDKis3E0ogU98riKidymMdmrhWYkijBDhapdOXoYcf9hF1FnGmqhE=
X-Received: by 2002:a05:660c:3c7:: with SMTP id c7mr5300247itl.131.1543942073307;
 Tue, 04 Dec 2018 08:47:53 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
 <7e8e1fe2-9f91-a370-a98c-43cdad1f6e8e@acm.org>
In-Reply-To: <7e8e1fe2-9f91-a370-a98c-43cdad1f6e8e@acm.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQEyvrdX27HdOCj1DHPKEZclYJ8CJQEQPyI2pqnfvSA=
Date:   Tue, 4 Dec 2018 22:17:51 +0530
Message-ID: <d56ddf2b485c13445fff5f9c36dd3c87@mail.gmail.com>
Subject: RE: [PATCH] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Linux-scsi

> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 9497b47..57432be 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -175,6 +175,7 @@ static inline bool
> > blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
> >   static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
> >                          struct request *rq)
> >   {
> > +    hctx->tags->rqs[rq->tag] = NULL;
> >       blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
> >       rq->tag = -1;
>
> No SCSI driver should call scsi_host_find_tag() after a request has
> finished. The above patch introduces yet another race and hence can't be
> a proper fix.

Bart, many scsi drivers use scsi_host_find_tag() to traverse max tag_id to
find out pending IO in firmware.
One of the use case is -  HBA firmware recovery.  In case of firmware
recovery, driver may require to traverse the list and return back pending
scsi command to SML for retry.
I quickly grep the scsi code and found that snic_scsi, qla4xxx, fnic,
mpt3sas are using API scsi_host_find_tag for the same purpose.

Without this patch, we hit very basic kernel panic due to page fault.  This
is not an issue in non-mq code path. Non-mq path use
blk_map_queue_find_tag() and that particular API does not provide stale
requests.

Kashyap

>
> Bart.

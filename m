Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B32FC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E39217D8
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pI8bsaQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeLRHpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:45:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44877 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLRHpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 02:45:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so17110476qte.11;
        Mon, 17 Dec 2018 23:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtV7yIAgT9wNBI8rfWH+4+uHqMF61VwWhrb7Pnw318I=;
        b=pI8bsaQmC0xhvphmgKqVjuonB7dVBR7/wRFkc/lFNLSHetlGRLRg1w27PBMfFo2TMx
         Kn749pEpKOQz2Tx4jrObN3VNQXSr73fSMJcKzojEtq6NoA1Z/l0ClRanMbVqOsUucMmx
         gL4VO6eFOeYdvuez3Gyzt18Au3Fn2ehxZh2R68V+H+LDhfGdNq172IvBPcaYzRFIVCXO
         RlUewBSY5xpLER7ncIU7SGlj3QKHHie7uzx0dHs5mdXKnwPEqodCUMnRE1AuH4Mzq6xj
         ilhdXywyRbwPDT5edAsZhk1FpqhpUtv/gtasdP50pOhVHlRrCcvF5z6ZCcNXoclS3G2L
         zUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtV7yIAgT9wNBI8rfWH+4+uHqMF61VwWhrb7Pnw318I=;
        b=mT9loMKxfjKnkw/WGjj5kYoh+SlbaV4eH0vahYidYTmy94cMXenGZMyeYn/dSPTnar
         XtNmskUBDcO7f+SHVUh9/EZ+JPmcYwGIdkMvQGW4I5wcKgW+/DP/VUQy+6SLgdXzv3KB
         uHXmzFuej6L5pVWeI4+JxdLxbd5w3gKy7/AKPaFulauiUE40JfboGEs/UXq5bctFNhDm
         Kt+zGmDaE+oIulibj1yAo5KXMARqtRUAepdkvb1hE94NcjzORstsL2xCKlvmPe7gLN1I
         y0Mtt9hCsR7YB1udHUJR+BcLLBlPLHRCvYFCJ1+fQGfHu1obH00x/4RWHCWgJoIP4s1V
         G8oQ==
X-Gm-Message-State: AA+aEWbuJl8/NzLbBUuT9gSWesq2F5KHNjgCSJTTTmRYjHLZd5HVtS6A
        2OtW+carnlfckDFd2vN2AJDhZMA0DKRn0nWD0mA=
X-Google-Smtp-Source: AFSGD/VD4giZwmEwRdkfWzxPkm2Cl5s4RCj0nmV6BUo2h9YpN0psX2MxE9oFcimnJfVpIN6xg1/9ijz7SfwAZMJGj20=
X-Received: by 2002:ac8:21aa:: with SMTP id 39mr16815946qty.122.1545119103053;
 Mon, 17 Dec 2018 23:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20181218045138.4282-1-yupeng0921@gmail.com> <20181218045138.4282-2-yupeng0921@gmail.com>
 <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me>
In-Reply-To: <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me>
From:   peng yu <yupeng0921@gmail.com>
Date:   Mon, 17 Dec 2018 23:44:51 -0800
Message-ID: <CAG3TDc1Od_aAq7VC5y_cu0mms2muzWXrBv-fCsHQkXEdXsBmoQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] trace nvme submit queue status
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, jthumshirn@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 11:26 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > @@ -899,6 +900,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
> >       }
> >
> >       req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> > +     trace_nvme_sq(req->rq_disk,
> > +             nvmeq->qid,
> > +             le16_to_cpu(cqe->sq_head),
> > +             nvmeq->sq_tail);
>
> Why the newline escapes? why not escape at the 80 char border?
>

Sorry, I don't quite understand your meaning. Do you mean I'd better
change this:
        trace_nvme_sq(req->rq_disk,
                nvmeq->qid,
                le16_to_cpu(cqe->sq_head),
                nvmeq->sq_tail);
to something like below:
        trace_nvme_sq(req->rq_disk, nvmeq->qid, le16_to_cpu(cqe->sq_head),
                nvmeq->sq_tail);
Please let me know whether my understanding is correct.

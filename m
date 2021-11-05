Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F1C433FE
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 11:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C266126A
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 11:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKELQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 07:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232115AbhKELQR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Nov 2021 07:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636110817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4L8AX+w4Ke7CRvZlZWNnuwq05ggdhTDpEkQn90YoaUI=;
        b=ETxQO7lTOOnfw0QZbGRZe94WKz7BHwxphep0yKL3lLB9H4yGEknuCqj5BohBiYFgPDRECG
        GvG1IuYHnCOajkaJxgpXEDRqQ42votD6wLIm445MyPic3RH1Cokus+kx2b5fqIt5LmFYVp
        kWvli9bewJ+sRLkIHVLoucnKqLtgAl0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-RUJbpceNMI-agePYi9CkDA-1; Fri, 05 Nov 2021 07:13:36 -0400
X-MC-Unique: RUJbpceNMI-agePYi9CkDA-1
Received: by mail-yb1-f197.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso12974158ybj.18
        for <linux-block@vger.kernel.org>; Fri, 05 Nov 2021 04:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4L8AX+w4Ke7CRvZlZWNnuwq05ggdhTDpEkQn90YoaUI=;
        b=kNLtPHSFNcT03eRYDLnPWeyN1IsUocgthkO/pdie+j17L1N2E1SgZvxsvZgx3XbvO1
         IlXIEirlbkteg4H4TkVHL9U1Avqjxx5+SLqWutJ5vdInfR+CMdqFoZBeVm7VW4+asIQk
         15jIuH1w1Dz78s4bneKVxKbZUwpwHAU7z/2CoshIxIrh/WaQa44GU79RMBbPcb0v007I
         GchcShOCW2UdHNha+mc2oDZZVFwabm5UlbbEWJj2aLuxIduAliY1Q3y2HEXUkuHShawq
         zS1h5ksZwD57/id4jnAxF0CP8pt1doyUQrbjg8VUkvJ7GpP1SuMZhznrX5jQ06zyQYFT
         PaFg==
X-Gm-Message-State: AOAM533ganybMheg8Yn1BTM7nAXvvr4/mnI8LbdM5knBIxuUU+6Y7/IJ
        r8GcHOe5fKa49vF7np+0TJw4u9k4iM+YRW31+FcUArLQ2UX8gk+noMmAa+IjcdKMACZSWzOnDUT
        k+fzOWvRpAbnJJbUhlIUcmkH9dnEQCOoEJ5yaKoQ=
X-Received: by 2002:a25:b9cc:: with SMTP id y12mr40238508ybj.153.1636110816231;
        Fri, 05 Nov 2021 04:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGfbLlFgufRWMb5+uWNgX/+6tRc/bcxOQyuxeETqdgetXoJntR9Gi/r7ki1/xNipfvY/9Efcsm2BSJbU6sLOg=
X-Received: by 2002:a25:b9cc:: with SMTP id y12mr40238481ybj.153.1636110816070;
 Fri, 05 Nov 2021 04:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <YYIHXGSb2O5va0vA@T590> <85F2E9AC-385F-4BCA-BD3C-7A093442F87F@kernel.dk>
 <CAHj4cs-pTYoksSQDjfFpK13Xtg0jB6EOvhfOZu5cDHowZa=ueg@mail.gmail.com> <f95deb32-59a0-1fc1-b7b2-92583a5ef4de@kernel.dk>
In-Reply-To: <f95deb32-59a0-1fc1-b7b2-92583a5ef4de@kernel.dk>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 5 Nov 2021 19:13:24 +0800
Message-ID: <CAHj4cs_HyO5yJvP-2ZGZynioBeFWvmBS63PSo=W24+h0dBm1rg@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 1 PID: 1386 at block/blk-mq-sched.c:432
 blk_mq_sched_insert_request+0x54/0x178
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 4, 2021 at 3:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/2/21 10:00 PM, Yi Zhang wrote:
> >>>
> >>> Hello Jens,
> >>>
> >>> I guess the issue could be the following code run without grabbing
> >>> ->q_usage_counter from blk_mq_alloc_request() and blk_mq_alloc_reques=
t_hctx().
> >>>
> >>> .rq_flags       =3D q->elevator ? RQF_ELV : 0,
> >>>
> >>> then elevator is switched to real one from none, and check on q->elev=
ator
> >>> becomes not consistent.
> >>
> >> Indeed, that=E2=80=99s where I was going with this. I have a patch, te=
sting it locally but it=E2=80=99s getting late. Will send it out tomorrow. =
The nice benefit is that it allows dropping the weird ref get on plug flush=
, and batches getting the refs as well.
> >>
> >
> > Hi Jens
> > Here is the log in case you still need it. :)
>
> Can you retry with the updated for-next pulled into -git?

Hi Jens

Sorry for the delay, the issue cannot be reproduced now.

>
> --
> Jens Axboe
>


--=20
Best Regards,
  Yi Zhang


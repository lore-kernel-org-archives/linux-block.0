Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB7BC433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129EF208C2
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 15:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfHNPXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:23:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35735 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHNPXq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 11:23:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so15224472lje.2
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2019 08:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qz7Z2Fc44cwZREiMyH8d13QtVZz2oMJeswQns/7qg58=;
        b=pohdqEShuIQvFquXCqCIw/dXTcC+AOlnq4+s/b0wxKc/AgB7UbcEbKVMeQCy7hLtLv
         gvi1jCUAMaYA6E8mbZeGIQHCHpkmzDaPveLWdGzizofJBt+r/tNVdMOeFnfmIz40yB7e
         XySr/YCoeJOd3yz6tzR4lBSGtfm+hg/Ks0tTTaPNGkGI+alfxHW7YpNCIHoK/c8sMam2
         PW70ZPM1xtkgo64LewQX1+nmx0Fmlx6XD/b3UkVquuGxWumhKEsEXX4c93OqxHyBV6wU
         nbe6hFoYDG50MUyFs7lI0syehxK8RDV3S1HA2+Fd0uMTLwcRX8MA/OggMKclJLbwI8dh
         mYJA==
X-Gm-Message-State: APjAAAXjcqvTqKXduzG/8JKfXubVFh1rQ78NAGoCONPbf8ptWJrsR199
        JJVlPj97EDPPWY5M05QtwFON/ZkzDo21Y6Ktlij1mw==
X-Google-Smtp-Source: APXvYqzsR0MxMgI5hCLVVL4VPMgJeeth4xL8PEO/NyV/B3HoKwKpoX9EWEzSbvBuvNaiVPVor1dRAyV+dBsnmXYU49s=
X-Received: by 2002:a2e:824f:: with SMTP id j15mr169272ljh.117.1565796224496;
 Wed, 14 Aug 2019 08:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190812123933.24814-1-jusual@redhat.com> <592fe38c-1fa2-9ba5-cd6c-da69c95edb33@acm.org>
 <75c89da5-2ec1-9725-62c8-f6abd3a24202@kernel.dk>
In-Reply-To: <75c89da5-2ec1-9725-62c8-f6abd3a24202@kernel.dk>
From:   Julia Suvorova <jusual@redhat.com>
Date:   Wed, 14 Aug 2019 17:23:33 +0200
Message-ID: <CAMDeoFXJ3r_axyrDWwHkbz-9o42WyT-rcTfXZjrmmp7GK82brA@mail.gmail.com>
Subject: Re: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 12, 2019 at 6:03 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/12/19 7:55 AM, Bart Van Assche wrote:
> > On 8/12/19 5:39 AM, Julia Suvorova wrote:
> >> -#define mb()        asm volatile("mfence" ::: "memory")
> >> -#define rmb()       asm volatile("lfence" ::: "memory")
> >> -#define wmb()       asm volatile("sfence" ::: "memory")
> >> -#define smp_rmb() barrier()
> >> -#define smp_wmb() barrier()
> >> +#define io_uring_mb()               asm volatile("mfence" ::: "memory")
> >> +#define io_uring_rmb()              asm volatile("lfence" ::: "memory")
> >> +#define io_uring_wmb()              asm volatile("sfence" ::: "memory")
> >> +#define io_uring_smp_rmb()  io_uring_barrier()
> >> +#define io_uring_smp_wmb()  io_uring_barrier()
> >
> > Do users of liburing need these macros? If not, have you considered to
> > move these macros to a new header file that is only used inside liburing
> > and such that these macros are no longer visible to liburing users?
>
> The exposed API should not need any explicit barriers from the user,
> so this suggestion makes a lot of sense to me.

How about moving the definition of io_uring_cqe_seen() with whole
io_uring_cq_advance() and io_uring_for_each_cqe() from liburing.h to
queue.c? This way we can cover all barriers, and leave barrier.h local.

Do you need io_uring_cq_advance and io_uring_for_each_cqe in the
library?

Best regards, Julia Suvorova.

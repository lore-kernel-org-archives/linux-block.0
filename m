Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F371C3A589
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7DF2086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 00:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRa0hS4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfHPADn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:03:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40377 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfHPADm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 20:03:42 -0400
Received: by mail-io1-f68.google.com with SMTP id t6so2798912ios.7
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 17:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXs4frHkVp6VUNeQ5gGQhfiB6xxjh3OuHCvn6ipEVTI=;
        b=mRa0hS4x8IexSCpeyArhYqaFRrnov7u2h5IghDcC2yWiZ9CcXrb7FR4t3UGKFMc/mF
         qzX3bg8JKnom03eYVxLiQcwt2I27bOB3as++FszqysxLVpnN1QEkQksARpOraToXjtrF
         +aOxU55U68znhUk+FAhz4uc+L4/Pg3iQneWbbUNusLl0TzlKxbdwp6mAZlVyAq7z5FEG
         NgqmEzjvHGWUXFg4g6tpL90UqSDQ5InZaYCHKhsa9txuPduVOw+kKWsrcRg8qUTuqXAB
         GbbQRP38axqTRKGd7Sb2uP9+G2Qo+317c7FqYbzvMPniHhXzYxdGFbcFkkRo54CJtuPD
         b1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXs4frHkVp6VUNeQ5gGQhfiB6xxjh3OuHCvn6ipEVTI=;
        b=gaMEbO1cR6YLKHO7zz7+XLORHUN3XkzPl5Zy2ClKI/bj7yRnweaCSZ1bPXDdZpCj39
         D2onmQfmmmnYPDCIiBCX3xJilu7Hfx6TXg4l8g4V6SEH35mCNenhrlZW/0PQA0cy+ANy
         h6FPQr0UC6ibp54b+AWP+wWvf9d5sT0u+4MCsvBHYq82sLN29uMM/VK+AAhCsw7ItIyu
         dCJEgPz9Qk5zI1No2NePN3Jpe3KpQ+WzUUYq205a6RfGemMFAVziB7BvV0MO0wDnxJop
         DPaq8eELyaXydP9tsoxnXknlMFzHgU4IW5om7bQadNGa/H68ok3geryDdGdpLDu8P5Qa
         bSrA==
X-Gm-Message-State: APjAAAXlB7aK7y/cRAM37EDoTfEnELo93cl41RemxaJBLdtEnXmU5Y20
        Uz4EWi9T/gYV5jv0cYA23863+nAybwQjICAJj4U=
X-Google-Smtp-Source: APXvYqyzNZZfvmhyelUp9YYRUnoAg2o3dqNGQ0oWU8oA3Qyjx/+bSAP+ERzAWyY3PG0ywynql83843+jgQ1bwEo5ohM=
X-Received: by 2002:a5d:9942:: with SMTP id v2mr2933633ios.177.1565913821841;
 Thu, 15 Aug 2019 17:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190812123933.24814-1-jusual@redhat.com> <592fe38c-1fa2-9ba5-cd6c-da69c95edb33@acm.org>
 <75c89da5-2ec1-9725-62c8-f6abd3a24202@kernel.dk> <CAMDeoFXJ3r_axyrDWwHkbz-9o42WyT-rcTfXZjrmmp7GK82brA@mail.gmail.com>
In-Reply-To: <CAMDeoFXJ3r_axyrDWwHkbz-9o42WyT-rcTfXZjrmmp7GK82brA@mail.gmail.com>
From:   Hrvoje Zeba <zeba.hrvoje@gmail.com>
Date:   Thu, 15 Aug 2019 20:03:30 -0400
Message-ID: <CAEsUgYiAXkjSFHpUOfqd9rwSMhmG4OnK7fa-f=uHddZNGVuRzg@mail.gmail.com>
Subject: Re: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
To:     Julia Suvorova <jusual@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 14, 2019 at 11:24 AM Julia Suvorova <jusual@redhat.com> wrote:
>
> On Mon, Aug 12, 2019 at 6:03 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 8/12/19 7:55 AM, Bart Van Assche wrote:
> > > On 8/12/19 5:39 AM, Julia Suvorova wrote:
> > >> -#define mb()        asm volatile("mfence" ::: "memory")
> > >> -#define rmb()       asm volatile("lfence" ::: "memory")
> > >> -#define wmb()       asm volatile("sfence" ::: "memory")
> > >> -#define smp_rmb() barrier()
> > >> -#define smp_wmb() barrier()
> > >> +#define io_uring_mb()               asm volatile("mfence" ::: "memory")
> > >> +#define io_uring_rmb()              asm volatile("lfence" ::: "memory")
> > >> +#define io_uring_wmb()              asm volatile("sfence" ::: "memory")
> > >> +#define io_uring_smp_rmb()  io_uring_barrier()
> > >> +#define io_uring_smp_wmb()  io_uring_barrier()
> > >
> > > Do users of liburing need these macros? If not, have you considered to
> > > move these macros to a new header file that is only used inside liburing
> > > and such that these macros are no longer visible to liburing users?
> >
> > The exposed API should not need any explicit barriers from the user,
> > so this suggestion makes a lot of sense to me.
>
> How about moving the definition of io_uring_cqe_seen() with whole
> io_uring_cq_advance() and io_uring_for_each_cqe() from liburing.h to
> queue.c? This way we can cover all barriers, and leave barrier.h local.
>
> Do you need io_uring_cq_advance and io_uring_for_each_cqe in the
> library?
>

This is one of the usage patterns:

io_uring_cqe* cqe;
int head;
int count = 0;

io_uring_for_each_cqe(&m_io_uring, head, cqe)
{
    /* ... */
    count++;
}

io_uring_cq_advance(&m_io_uring, count);


A little bit more performance is squeezed out this way.


Hrvoje Zeba

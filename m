Return-Path: <SRS0=vQdV=2N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63BC2D0D0
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 10:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24094206CB
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 10:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ZJDHLQVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLWKbk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:31:40 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33825 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfLWKbk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Dec 2019 05:31:40 -0500
Received: by mail-il1-f195.google.com with SMTP id s15so13687252iln.1
        for <linux-block@vger.kernel.org>; Mon, 23 Dec 2019 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2KG3qxeHruibpXGsVIa4Wl/ThA0sLV8fQC/MJrjy0s=;
        b=ZJDHLQVmWJg9pubaWSGVw5+bzHZEsCdrO8rLoMCYF5cD2/uIjAhCvjh/B0MzplTmY+
         gtYzoWO8Z3eIjCu0cHNk9EAVPcLtQFGo7fHT1e+KoySOm2KJKZ5VEfqOEa33YGiasb1j
         K5TZb9CnawjfJDnE9su1egPT1920OGfeqEId3x0Jm5nv+rEo5F/nVnWGqWiaH9ePM+Ju
         4Y68emC8fzscXHq4v9YeQb9wCJ87GOHzhJVFu3j5T8UAHjzNRloZBMAe66I0lcVxCu3l
         7QQMSP5YEKJsFftAR5etS/D3AjqVOxUhtuI6u3+bsyNGGIMb5CteVoNWaJibSTo13nmU
         ETzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2KG3qxeHruibpXGsVIa4Wl/ThA0sLV8fQC/MJrjy0s=;
        b=teViqGwt7RVUqEb+7HwYnF4cHheisJ1UJbIJuxmBmzM4Tv83bWOTp/z9z1NrMg9UwX
         0y0/37CHzfY1ijrpreWLBd6k9rO/BAHWXiUxfRDAIm5W5nD4wSWuET9EACpm+hR9rqzD
         ZCdu39JsAeUtDvFSGYkUYRkCswn+IM9nN5+2n0dVyeZo4Iy4ULjcY+PeyUvsK+piViFH
         Kx8JpN2z2fnT8lur7R1wiL+1zcB4YtrTWp9lRT5xuxeDXnWkvCU5IeFDxx23cvKD1aOy
         jP0RMG9Bpnm4vbnDMNh0kPdMBbmFLj+UGsF/mQszOokSa/bfC13B/+snc0I3aq0cw92/
         ktNA==
X-Gm-Message-State: APjAAAVEdSpXVeFNvgL6oykRNIQoG8faTGy3mTJWosKi9hsVdcvg3M3U
        uULAF3imd2vAn1RGm2p7qdSTEPRsLCDtwNeAiK9HaQ==
X-Google-Smtp-Source: APXvYqx8puoUeQ/1rOf+Mmdibf48OOGKRlBiWxu0EI9nTQSX7vkl6dvMqzS+1T4ybMe+KUcJ7VJoPM0eqZwQ/TUzLtM=
X-Received: by 2002:a92:d2:: with SMTP id 201mr25608188ila.22.1577097099298;
 Mon, 23 Dec 2019 02:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-3-jinpuwang@gmail.com>
 <20191221101530.GC13335@unreal> <CAHg0HuxC9b+E9CRKuw4qDeEfz7=rwUceG+fFGfNHK5=H2aQMGw@mail.gmail.com>
 <20191222073629.GE13335@unreal> <CAMGffEn9xcBO0661AXCfv0KDnZBX6meCaT07ZutHykSxM4aGaQ@mail.gmail.com>
 <20191223080438.GL13335@unreal>
In-Reply-To: <20191223080438.GL13335@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 23 Dec 2019 11:31:28 +0100
Message-ID: <CAMGffEk_3QYzj6MoSh_06fmvJzvv5qLKJXJ3d-m4oQRhH5ZyGg@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] rtrs: public interface header to establish RDMA connections
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 23, 2019 at 9:04 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Dec 23, 2019 at 08:38:54AM +0100, Jinpu Wang wrote:
> > On Sun, Dec 22, 2019 at 8:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Sat, Dec 21, 2019 at 03:27:55PM +0100, Danil Kipnis wrote:
> > > > Hi Leon,
> > > >
> > > > On Sat, Dec 21, 2019 at 11:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > Perhaps it is normal practice to write half a company as authors,
> > > > > and I'm wrong in the following, but code authorship is determined by
> > > > > multiple tags in the commit messages.
> > > >
> > > > Different developers contributed to the driver over the last several
> > > > years. Currently they are not working any more on this code. What tags
> > > > in the commit message do you think would be appropriate to give those
> > > > people credit for their work?
> > >
> > > Signed-of-by/Co-developed-../e.t.c
> > >
> > > But honestly without looking in your company contract, I'm pretty sure
> > > that those people are not eligible for special authorship rights and
> > > credits beyond already payed by the employer.
> > >
> > Hi, Leon,
> >
> > Thanks for the suggestion, how about only remove the authors for the
> > new entry, only keep the company copyright?
> > > +/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
> > > + * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > + *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > > + *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> > > + */
> >
> > The older entries were there, I think it's not polite to remove them.
>
> From our point of view, this is brand new code and it doesn't matter how
> many internal iterations you had prior submission. If you want to be
> polite, your company shall issue official press release and mention
> all those names there as main contributors for RTRS success.
>
> You can find a lot of examples of "Authors:" in the kernel code, but
> they one of two: code from pre-git era or copy/paste multiplied by
> cargo cult.
>
> Thanks
>
Ok, will only keep the copyright lines, and remove Authors.

Thanks

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37706 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdA3NaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 08:30:19 -0500
Received: by mail-it0-f48.google.com with SMTP id r185so101037534ita.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2017 05:30:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkdaL0qNXKOp9J-yLAN3njPoViE7iGtCr=mhmPGHdY+9LBQ@mail.gmail.com>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
 <CAPDyKFrB9UfkfGD08fTKegSB2W65pdWuDU=10mGukQmB=yhaqQ@mail.gmail.com>
 <CAPDyKFq6wzw=_6oc=hyW3B_tBAGfqzrixoy-gr=ki=M2wyhiNg@mail.gmail.com> <CACRpkdaL0qNXKOp9J-yLAN3njPoViE7iGtCr=mhmPGHdY+9LBQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Jan 2017 14:30:12 +0100
Message-ID: <CACRpkdbafkc-XSM+Ef4txKvWmYLThM1ptx1HJuD8prdM2fxXvw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: block: command issue cleanups
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 30, 2017 at 2:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jan 27, 2017 at 8:58 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> And now it is crashing at mmc_blk_rw_rq_prep() + 0x20 so I suspect it is one of
> these:
>
> struct mmc_blk_request *brq = &mqrq->brq;
> struct request *req = mqrq->req;
> struct mmc_blk_data *md = mq->blkdata;
>
> I guess the first: mqrq is NULL.
>
> So I suspect the oneliner in commit 0ebd6e72b5ee2592625d5ae567a729345dfe07b6
> "mmc: block: do not assign mq_rq when aborting command"

Bah looking closer at that it just doesn't make any logical sense at all.

I now suspect the NULL check removed in mmc_blk_rw_start_new()
to be behind this, so sent a patch to restore it.

No idea how to test it or if it's the real problem.

I had to rebase my further patches on top too, so if you merge this
I need to resend the next series.

Yours,
Linus Walleij

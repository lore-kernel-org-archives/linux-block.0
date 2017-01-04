Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35425 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbdADKSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2017 05:18:16 -0500
Received: by mail-qk0-f170.google.com with SMTP id u25so390893474qki.2
        for <linux-block@vger.kernel.org>; Wed, 04 Jan 2017 02:18:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170103173113epcas5p3bcc48e614ca71c27917a966640321138@epcas5p3.samsung.com>
 <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Jan 2017 11:18:14 +0100
Message-ID: <CACRpkdYEqbpU0sc+-CvJh32hnrM0G=SYQBhb5r34ofmYyBoD3g@mail.gmail.com>
Subject: Re: [PATCH PoCv2 0/2] mmc: add blk-mq support
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 3, 2017 at 6:30 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

Interesting patch!

> The differences between these patches and Linus' RFD patch:
> - request completion is handled from the IRQ handler
>   (or tasklet context as happens in dw_mmc host driver)

I think we need to make a patch like this separately to the
current (only old blk) code, to stop the kthread from forcing
in NULL requests to clean the pipeline.

We should also avoid sending any completion at
all: if we know we only get one request at a time as your
patch does, there is no reason to wait for a completion: we
will always be complete when a new request arrives.

Same with two requests in parallel, we can trust the block
layer to not send more than 2 (the queue depth) so there is
no reason to wait for a completion.

I'm trying to work in this direction at least, your patch is great
inspiration!

Yours,
Linus Walleij

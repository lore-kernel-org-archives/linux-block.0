Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38265 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759923AbdAJJz0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2017 04:55:26 -0500
Received: by mail-wm0-f41.google.com with SMTP id k184so153797239wme.1
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2017 01:55:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483431417.2911.1.camel@sandisk.com>
References: <771BC555-46A4-4AE1-BDD5-BFB4E3F065F0@linaro.org> <1483431417.2911.1.camel@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Jan 2017 10:55:23 +0100
Message-ID: <CAPDyKFqZrgspJcyaPiwqpsds2NogKMoLt2_5sWPRM6ydSo4oYg@mail.gmail.com>
Subject: Re: [LSF/MM ATTEND AND AGENDA TOPIC] request to attend the summit
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "broonie@linaro.org" <broonie@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[...]

>
> I agree that it would be useful to discuss blk-mq I/O scheduling during
> LSF/MM. However, blk-mq I/O scheduling involves more than what has been
> described above. The topics I would like to see being discussed are:
> * How to add an I/O scheduling API to the blk-mq core. This is what Jens
>   is working on (http://git.kernel.dk/cgit/linux-block/log/?h=blk-mq-sched).
> * The BFQ for blk-mq patch series once this patch series has been posted.
>   If the rules for this edition of LSF/MM are similar to those of previous
>   editions then I expect that the LSF/MM program committee will want to
>   see a BFQ for blk-mq implementation posted as patches on a Linux kernel
>   mailing list before adding a session about BFQ for blk-mq to the LSF/MM
>   agenda.
> * Since BFQ has been designed for hard disks and since the approach in BFQ
>   for handling deceptive idleness reduces bandwidth, what scheduling
>   algorithm to use for storage media that do not have any moving parts
>   (SSDs and MMC).
> * How to port the MMC driver to blk-mq. See also Linus Walleij, "[PATCH
>   v2] RFD: switch MMC/SD to use blk-mq multiqueueing"
>   (https://www.spinics.net/lists/linux-block/msg07360.html).

Hi Bart,

As the MMC maintainer I am also interested in participating in all the
above BFQ/MMC related discussions.

Regarding the blk-mq port for MMC, I would also like to add a detail,
which perhaps may influence the generic blkmq interface.

The MMC block device driver implements a asynchronous request
mechanism, which increases performance for architectures where DMA
mapping operations are slow (cache flushes/bounce buffering when using
non-coherent DMAs). Ideally I would like to remove this hack from the
MMC subsystem, if it makes sense to extend blkmq to support this. And
if not, perhaps we can discuss on the best method to implement it for
MMC.

Kind regards
Uffe

Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDF8C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 14:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8092E20844
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 14:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yv0u9ylQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfBFOIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:08:40 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41541 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfBFOIk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 09:08:40 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so4426857vsc.8
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 06:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YBjFiMLRTQ7DSf7AbeupSlp9C/FWJH3ulyojuoZqqw=;
        b=Yv0u9ylQIM66vfFo2XLM9Z03NOQVK43CQZ7hUfAQwVIwd0WKJWo/KrQQR1mzPxT6t0
         Ogz4qQ99Er7hMMUf/hsAuJoEJOlYwuXw/1GRgh8XKFSlFpNgDizgJ4HO5FW7ZpEnDq2a
         i3cMIjJ6pv38Z3c6arDDty4lHEA5yqDZVbBtuRCYbdyFVe3JLUSnEZh1UbvLwx7nJ10q
         08nlQZU8Id4B6z1VbKSmgx2mrI8+UOufI4IacPF94ZPgJxn3HaEMhmKRbzra1V3ERaNt
         uxs6INC+8EddbEBPnq04HkcJonxOrWkct3382N0RIJEm6M00L+tb2n7mQHJGIogCGuu1
         mW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YBjFiMLRTQ7DSf7AbeupSlp9C/FWJH3ulyojuoZqqw=;
        b=eaOaQuonodARh2lXrx3UEwcLI/sRK6uv1Yw19uu2pa1rz0Iuenp5YihFLlm88Qze10
         0yDrLngzEMQc0iH134z6HwAbsvJshUHWg5Oty03ZvLuHYc8nqAKhNdD9C5Ucz8lqdQO/
         QMEr4BZR5330CFuq7p7+k6/wLR4Q8px2ybF+n+Yuf8mQ9kwUv+9QLOqfovTmgUHZ4Wkx
         D1tAnbxJYBJ8d+49dzZsYR1VrpbWYJl5OZt6GAUahZf3u2eZbcmQKmtfcwJ/YKhYNfLu
         WZ70TDydU7Z8qqx7JKb3Kf1dGp/L7SxhjIiiuzI9AZEh1bhs88eXlZfeoF0EPzHTMKzG
         sHXA==
X-Gm-Message-State: AHQUAuYgvm6o3zN0zhiQd1PzDUSTLm28XhwExH5JguzFJqmVcGsmn7t1
        +11A+0vtCrZl3LL8Anso7nO0DA/sJ4KTvs05vMTwBg==
X-Google-Smtp-Source: AHgI3IbwUJbuedJmf0eg7inBRNsXpg+2LtPQx+h0x81vCU92EUThEHfBcmF2cw27/FCUO6S41dRN4xidyUAlewQ0uBM=
X-Received: by 2002:a67:b245:: with SMTP id s5mr4225927vsh.200.1549462119679;
 Wed, 06 Feb 2019 06:08:39 -0800 (PST)
MIME-Version: 1.0
References: <1549385523-20521-1-git-send-email-zhays@lexmark.com>
 <CAPDyKFofTMGXfp1sKgv1Z6OSEyM9e78B-+3qZ=a6s3s2aNWybg@mail.gmail.com> <6956f0d7-0dea-b100-06ec-54148f043710@intel.com>
In-Reply-To: <6956f0d7-0dea-b100-06ec-54148f043710@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 15:08:02 +0100
Message-ID: <CAPDyKFrC4QjfrarvjRYCKYqoi7A1QOz_fQLnrOFocXARTP1kWA@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: handle complete_work on separate workqueue
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Zachary Hays <zhays@lexmark.com>, Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 6 Feb 2019 at 13:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/02/19 2:00 PM, Ulf Hansson wrote:
> > + Adrian, Linus
> >
> > On Tue, 5 Feb 2019 at 17:53, Zachary Hays <zhays@lexmark.com> wrote:
> >>
> >> The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
> >> This generates a rescuer thread for that queue that will trigger when
> >> the CPU is under heavy load and collect the uncompleted work.
> >>
> >> In the case of mmc, this creates the possibility of a deadlock as
> >> other blk-mq work is also run on the same queue. For example:
> >>
> >> - worker 0 claims the mmc host
> >> - worker 1 attempts to claim the host
> >> - worker 0 schedules complete_work to release the host
> >> - rescuer thread is triggered after time-out and collects the dangling
> >>   work
> >> - rescuer thread attempts to complete the work in order starting with
> >>   claim host
> >> - the task to release host is now blocked by a task to claim it and
> >>   will never be called
> >>
> >
> > Adrian, I need your help to understand more of this. The above
> > description doesn't add up to me.
> >
> > In principle, already when "worker 1 attempts to claim the host" as
> > described above, it should succeed and should *not* need to wait for
> > the host to be released. Right?
>
> If it is the same queue, then yes.  Although in that case there is only 1
> work for the hw queue so there cannot be another worker.  There could be
> another attempt to send a request directly, but that will not block - if the
> host controller is busy, BLK_STS_RESOURCE will be returned from ->queue_rq().
>

Right.

> >
> > The hole point with the commit 6c0cedd1ef95 ("mmc: core: Introduce
> > host claiming by context"), was to allow the mmc host to be
> > re-claimable for blk I/O requests, no matter from what worker/thread
> > the claim/release is done from.
> >
> > Is it not working as expected you think? What am I missing here?
>
> I assumed we were talking about a situation where there are multiple
> internal eMMC partitions each with their own disk and queue.  In that case,
> a queue waits if there is another queue that is using the eMMC.

Of course! I totally forgot about this case, that is most certainly
what must be happening!

>
> We should clarify whether that is the scenario we are looking at.  Zachary?

Yes, please.

Assuming this is the case, I would also prefer an updated changelog
that describe this scenario.

Adrian, thanks a lot for you help!

[...]

Kind regards
Uffe

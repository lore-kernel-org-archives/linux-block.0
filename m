Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB157C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FB020734
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKJ0Ua8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgFBGqn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBGqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 02:46:43 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613BC061A0E
        for <linux-block@vger.kernel.org>; Mon,  1 Jun 2020 23:46:43 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n22so629592vkm.7
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2020 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=po5KhSQTeo32/YVK41COchciTQ5Axh4/cuzyzfj7k8Y=;
        b=cKJ0Ua8VUyJPxTXav2T7v9Iap1uoLnK2FAfVwkXDm6QLkxuY2sRpJQ8/gjoSeD9I5F
         GtO1vc4iUY2sO/v2w6oGyi5KRwIXLd1/+tDtPljWs4g3XWjZx5uh9Q+dlz0A91L5eCCd
         gm+FvNbqO9Lrbd39hqeFozWz1NVGptqVi4kJuPAq9ysg+mFnC+b8I1ySRNQI21vhUCE9
         Bk5QLuGj6X6NurT6EzvGQb09ELdfs6SRHqOoL1GK7A1WT89qM8fRz0JA9VYMYmiTNg16
         7Tn2UsWhITskp/GIcxh/YPUkgspoIh+IZ6MDzyvf7gtl3KGdfCShIH84jeLf+yCTRYUa
         6VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=po5KhSQTeo32/YVK41COchciTQ5Axh4/cuzyzfj7k8Y=;
        b=K0YZmxHIywRQ/7guAsMeTUOh774T7BLCimlHplA34DrW5bugrscrJCILZHJz5lDZ0p
         V+y+Emf8MChKsO3iHH4BJB2YpVfD4HO6DwdiqgpDeyVBn+PW4JcZFKNVr/nnhvjMhUoJ
         RDQbBSaLRA+WZCjSB13KmQMJsvRFPulDQ41vQy00z8vhYZIqKChDNpfsb0ukJ9qshahl
         SwrT9/W7CoCw4RH6ZDTJCsvBtnVeLjD0ASSNCuvWhT/WLR6HFKyIgvoZ/ZZZi9xVEahA
         hCzM97uM3r+wZ/kt3pBdO4rmr9bq5FZBJfDpNp+tM8ab4KdTw8oiO6QXGokdZPG1XS93
         rFEw==
X-Gm-Message-State: AOAM533sgIlJFyscPwbmYQIXYHgwZuSdqZXPgs2+NdLkbnNQ7PJ2dWj5
        J39psd3Tj/WGngIU3xHtFNGh3hAvw8Z8w/T9JI0wuA==
X-Google-Smtp-Source: ABdhPJwk2Bn3ClGMFwno2UudGxk3fxDlJ6UnRjdygaD9Zp+7Cb47KxvzLjYfdTNTDbz6LB5+4cgoo5UQLmemmh+F/HQ=
X-Received: by 2002:ac5:cc44:: with SMTP id l4mr8633992vkm.43.1591080402504;
 Mon, 01 Jun 2020 23:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200528081003.238804-1-linus.walleij@linaro.org>
 <20200601074957.GE1181806@T590> <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
 <20200601115818.GB1190838@T590> <CAPDyKFq2paDu9ogEFh6VXWq8___FLeEaNyBWhkMSdpZYpEytQQ@mail.gmail.com>
 <7f9aaf69b24b794ca4c9c126eb2394862e276c73.camel@wdc.com> <6bda7563-fc47-e049-ed55-265f58ae522c@kernel.dk>
In-Reply-To: <6bda7563-fc47-e049-ed55-265f58ae522c@kernel.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Jun 2020 08:46:06 +0200
Message-ID: <CAPDyKFoNQwmtrw1Ka=M6SKbnKbD_aapkmLBZ-Ji-YgSFEhT5ow@mail.gmail.com>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2 Jun 2020 at 01:45, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 6/1/20 5:37 PM, Damien Le Moal wrote:
> > On Mon, 2020-06-01 at 14:53 +0200, Ulf Hansson wrote:
> >> On Mon, 1 Jun 2020 at 13:58, Ming Lei <ming.lei@redhat.com> wrote:
> >>> On Mon, Jun 01, 2020 at 01:36:54PM +0200, Linus Walleij wrote:
> >>>> On Mon, Jun 1, 2020 at 9:50 AM Ming Lei <ming.lei@redhat.com> wrote:
> >>>>> On Thu, May 28, 2020 at 10:10:03AM +0200, Linus Walleij wrote:
> >>>>>> The Kyber block scheduler is not suitable for single hardware
> >>>>>> queue devices, so add a new flag for single hardware queue
> >>>>>> devices and add that to the deadline and BFQ schedulers
> >>>>>> so the Kyber scheduler will not be selected for single queue
> >>>>>> devices.
> >>>>>
> >>>>> The above may not be true for some single hw queue high performance HBA(
> >>>>> such as megasas), which can get better performance from none, so it is
> >>>>> reasonable to get better performance from kyber, see 6ce3dd6eec11 ("blk-mq:
> >>>>> issue directly if hw queue isn't busy in case of 'none'"), and the
> >>>>> following link:
> >>>>>
> >>>>> https://lore.kernel.org/linux-block/20180710010331.27479-1-ming.lei@redhat.com/
> >>>>
> >>>> I see, but isn't the case rather that none is preferred and kyber gives
> >>>> the same characteristics because it's not standing in the way
> >>>> as much?
> >>>
> >>> Kyber has its own characteristic, such as fair read & write, better
> >>> IO merge. And the decision on scheduler isn't only related with device,
> >>> but also with workloads.
> >>>
> >>>> It looks like if we should add a special flag for these devices with
> >>>> very fast single queues so they can say "I prefer none", do you
> >>>> agree?
> >>>
> >>> I am not sure if it is easy to add such flag, because it isn't only
> >>> related with HBA, but also with the attached disks.
> >>>
> >>
> >> In general I don't mind the idea of giving hints from lower layer
> >> block devices, about what kind of scheduling algorithm that could make
> >> sense (as long it's on a reasonable granularity).
> >>
> >> If I understand your point correctly, what you are saying is that it
> >> isn't easy or even possible for some block devices HWs. However, that
> >> should be fine, as it wouldn't be mandatory to set this kind of flags,
> >> but
> >> instead could help where we see it fit, right?
> >
> > The elevator features flag was implemented not as a hint, but as hard
> > requirements for elevators that are needed (mandatory) for a particular
> > device type for correct operation. By correct operation, I mean "no IO
> > errors or weird behavior resulting in errors such as timeouts". Until
> > now, the only hard requirement we have is for zoned block devices which
> > need mq-deadline to guarantee in-order dispatch of write commands (for
> > sequential zones writing).
> >
> > We definitely could add hint flags to better help the block layer
> > decide on the default optimal elevator for a particular device type,
> > but as is, the elevator features will completely prevent the use of any
> > other elevator that does not have the feature set. Those elevators will
> > not be seen in /sys/block/<dev>/queue/scheduler. This may be a little
> > too much for hint level rather than hard requirement.
> >
> > Furthermore, as Ming said, this depends on the HBA too rather than just
> > the device itself. E.g. the smartpqi driver (Microsemi SAS HBAs)
> > exposes single hard-disks as well as fast RAID arrays as multi-queue
> > devices. While kyber may make sense for the latter, it probably does
> > not make much sense for the former.
> >
> > In kernel vs udev rules for setting the optimal elevator for a
> > particular device type should also be considered.
>
> Agree, the elevator flags are hard requirements, which doesn't match
> what this patch is trying to do. There's absolutely nothing wrong with
> using none or kyber on single queue devices, hence it should be possible
> to configure it as such.

I agree, the elevator flags as is, currently don't work for giving
hints from lower block layers. However, I still think it would be
worth exploring the idea that is brought up here.

The point is, even if it's perfectly fine to use kyber for MMC/SD, for
example, it would make little sense as BFQ performs better on this
type of single queue storage device. So, why solely rely on userspace
udev rules, when we can, in-kernel, help to decide what is the best
configuration?

Kind regards
Uffe

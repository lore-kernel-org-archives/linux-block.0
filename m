Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C9C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6091F20679
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bq93oX3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAMyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFAMyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 08:54:17 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40133C061A0E
        for <linux-block@vger.kernel.org>; Mon,  1 Jun 2020 05:54:17 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u7so5517811vsp.7
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2020 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxOGOTlnKggSgjQN9iuwo59FH5ZZhrFmRgyUJCajkQk=;
        b=Bq93oX3H0MjyO4jQyEkH9OcwjHBLYZnL9ZkdIUgGiD2zEtJ1qK0jZfP3DG0e8CJQlO
         bgfbm+qCqMxOirDVLMp1k4BBVElUNv9JiPkiek0ywTFBJvEIBah7KJ7xDd99B2kUBKTZ
         hFfKQKaVKU7tJtXSjB8K9jBr7SS+heDWhxm51cnPJNMVbqtZhmwoBeunp+3HCADKUblv
         RNP/O2BXpIkljeEhQU+5kOzrrlVmMtmAsBEuowHJbg1/ITGbH4826WnStPnVlwGlYprb
         lL9xn7KDoDFQc5SBHPURx2QEPsnWWhun/D4ziej3vzv1wN8OmlBoh05lGP7hGtbQwiNG
         aDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxOGOTlnKggSgjQN9iuwo59FH5ZZhrFmRgyUJCajkQk=;
        b=g85VwrkXly6amDLpfBj7zpDaP7f5Lyd8NDuEtGqwtSkXlTmBG0sTl6auVgctJL0sMr
         EivE/fYssP6mw+hYcf6acRN1pEW5/L5nAULy/sDn05Xdi9xDUTGVYy9SQQCSbFZl5PQD
         4RLCzsont2zf9WRjCTy+nDpIdfVRzQO1m0EPNL0WVjkp5Gu/kI/libU0EhisSDl4P+QD
         mf417a0p2tyqLxJuWzb0VbDPxxgAuOOBuQB9xG7OliztGIVd58x4dd20sjTJEHd8VmSo
         0UoJ/O8qiZiw93J75XU1p552H5uLo3eHHt+wme0rfMM4qwszKIiFbt//NtjZgHx+toIc
         makQ==
X-Gm-Message-State: AOAM533Ub84AYpREVJw0YN5kwMFef7RtnW/Vzi5PeRa8MxjcMOG6J7EB
        0ynlQCfy7CmwwtUHZsybCzcyfA6m5eroG6VOJPlj1w==
X-Google-Smtp-Source: ABdhPJwensK4OmZ1cWNU2F/cG9IQgr3JCJdS9trt1igpOZBMncCUR0zvXSmGHNQzDqH6kP5RIwzLOU86cbFcsM1ehlc=
X-Received: by 2002:a67:be05:: with SMTP id x5mr13037457vsq.35.1591016056212;
 Mon, 01 Jun 2020 05:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200528081003.238804-1-linus.walleij@linaro.org>
 <20200601074957.GE1181806@T590> <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
 <20200601115818.GB1190838@T590>
In-Reply-To: <20200601115818.GB1190838@T590>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Jun 2020 14:53:39 +0200
Message-ID: <CAPDyKFq2paDu9ogEFh6VXWq8___FLeEaNyBWhkMSdpZYpEytQQ@mail.gmail.com>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 1 Jun 2020 at 13:58, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jun 01, 2020 at 01:36:54PM +0200, Linus Walleij wrote:
> > On Mon, Jun 1, 2020 at 9:50 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > On Thu, May 28, 2020 at 10:10:03AM +0200, Linus Walleij wrote:
> > > > The Kyber block scheduler is not suitable for single hardware
> > > > queue devices, so add a new flag for single hardware queue
> > > > devices and add that to the deadline and BFQ schedulers
> > > > so the Kyber scheduler will not be selected for single queue
> > > > devices.
> > >
> > > The above may not be true for some single hw queue high performance HBA(
> > > such as megasas), which can get better performance from none, so it is
> > > reasonable to get better performance from kyber, see 6ce3dd6eec11 ("blk-mq:
> > > issue directly if hw queue isn't busy in case of 'none'"), and the
> > > following link:
> > >
> > > https://lore.kernel.org/linux-block/20180710010331.27479-1-ming.lei@redhat.com/
> >
> > I see, but isn't the case rather that none is preferred and kyber gives
> > the same characteristics because it's not standing in the way
> > as much?
>
> Kyber has its own characteristic, such as fair read & write, better
> IO merge. And the decision on scheduler isn't only related with device,
> but also with workloads.
>
> >
> > It looks like if we should add a special flag for these devices with
> > very fast single queues so they can say "I prefer none", do you
> > agree?
>
> I am not sure if it is easy to add such flag, because it isn't only
> related with HBA, but also with the attached disks.
>

In general I don't mind the idea of giving hints from lower layer
block devices, about what kind of scheduling algorithm that could make
sense (as long it's on a reasonable granularity).

If I understand your point correctly, what you are saying is that it
isn't easy or even possible for some block devices HWs. However, that
should be fine, as it wouldn't be mandatory to set this kind of flags,
but
instead could help where we see it fit, right?

Kind regards
Uffe

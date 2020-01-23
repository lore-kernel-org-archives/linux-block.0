Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5046CC2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A5D21D7E
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="gW3y/RVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAWT0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:26:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41944 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWT0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 14:26:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so4505775eds.8
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 11:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqIW6P3nd0U6+Dsb/HPJR6jYzvPosfZF53uQ6BthKN4=;
        b=gW3y/RVj2biVs5qjZRGGCVdyKyYY5PkgEb4/NzAl2uLh5e5wBRP2O/SVVaH2DzteAs
         QGluUfOAUEKlrymgGFQgmLZH3RPKauzPaxKKz6mgDyIWqG8c63VnJgBPMmYcPZQFti+3
         lH/P4AQhTWU3tEZbuNDs/vGZNtzVd/ySMEEjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqIW6P3nd0U6+Dsb/HPJR6jYzvPosfZF53uQ6BthKN4=;
        b=fstKV9gHQNbl/k8K/LoxIehjLOd+iU8RC2hgKP2czV22acwYG6UARpxta0RQqVcfCn
         01h/kVVpvlu5gDDuC7L/mcIBQau1TT1q5QEKFBmbbkhOWEmjlJQkawMqXUiCKgWi8iXP
         DJdwpxuuq6FqcahIW1tVhANXnoYyBil++Mcuv9ZApak6oafHJDPwXnXkmXag+gWaELHV
         sEBgfGh9x9YnD9ZFEQYAIVfJwAtgr8W5fkrd2GricgCT1e3mXHdroCXU46N3wvKu6N6g
         Tee88kjVs5+s1i1iTJGm+Iv8ZjGeAHoOfij2UCdmvEZkV96ezSkKYJ4StZ7sFseER4ZN
         MSSw==
X-Gm-Message-State: APjAAAX5vYWKsq8v5MxGnId4di9Qllcjer+ry/fw3uOIXpBxRHoFm/kj
        H29Jl5S2sWmgIMjkI1jo1Jf3DYHjx40ObLeSUE6x
X-Google-Smtp-Source: APXvYqy+5EK2XIUhq5ABCc8/NNvWj4YsDl2Uf+JrOq/5DntqE4eTNmBm/zoLhcikAJl04M2I98zGqF09GRSNg/PNHf4=
X-Received: by 2002:a50:bae1:: with SMTP id x88mr8266708ede.10.1579807568083;
 Thu, 23 Jan 2020 11:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com> <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
In-Reply-To: <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
From:   Muraliraja Muniraju <muraliraja.muniraju@rubrik.com>
Date:   Thu, 23 Jan 2020 11:25:57 -0800
Message-ID: <CAByjrT9=pZGOwDFnJQ60aG-EznV2QK+DQT3a1NEDJr3RU0K_Gw@mail.gmail.com>
Subject: Re: [PATCH] Adding multiple workers to the loop device.
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I see that the kernel is already is using the multi queues with the
number of hardware queues is 1. But the problem IMO is that the worker
seems to be processing 1 request at a time, to parallelize requests
and have more concurrency more workers needs to be added. I also tried
increasing the nr_hw_queues without increasing the number of workers,
I did not see any difference in performance and it stayed the same. It
allows to queue more requests but it is processed one at a time. I
have not tried with enabling BLK_MQ_F_BLOCKING though. I see that it
can schedule requests early.

On Thu, Jan 23, 2020 at 10:59 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/21/20 12:25 PM, muraliraja.muniraju wrote:
> > Current loop device implementation has a single kthread worker and
> > drains one request at a time to completion. If the underneath device is
> > slow then this reduces the concurrency significantly. To help in these
> > cases, adding multiple loop workers increases the concurrency. Also to
> > retain the old behaviour the default number of loop workers is 1 and can
> > be tuned via the ioctl.
>
> Have you considered using blk-mq for this? Right now loop just does
> some basic checks and then queues for a thread. If you bump nr_hw_queues
> up (provide a parameter for that) and set BLK_MQ_F_BLOCKING in the
> tag flags, then that might be a more viable approach for handling this.
>
> --
> Jens Axboe
>

Return-Path: <SRS0=CX+6=YG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D8C4360C
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4862067B
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POxsotDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJMPmr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Oct 2019 11:42:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40523 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfJMPmr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 11:42:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so14196346ljw.7
        for <linux-block@vger.kernel.org>; Sun, 13 Oct 2019 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9ZS3jllfWlgyi4J9EIgyoW+JFF4XGXxz5jEe+fdZO34=;
        b=POxsotDIOZllUGTASySuhF3PHBB9Eq69WWvnt52cHruHP2qJpa9R3W5avOpMhRgj8u
         HTpih8ffcqMoSWTF8NFGSjonkcJx7NPuTVcIDv8Zr6RF4kzqyn0mcmx4qNPTzdxbIuX8
         aLhWShza+KxA+AIYtgONyyjd3ytOdFLCBZ/W+Uh04QagDNka9enEe0Esus5K2ssw3Wkd
         mRWJvWcYQrjF/q4x2vmb81P7uLPKR4sgUSbgpNY+6bvC4bX19hloL4bCywBbc6umaZGy
         QmUXLJ+sO7A7jAxPSTI9T5m2k9u+1W9zUdYfod6BwzMSLXrGdXMqn0N6OifgsEIX7Lf/
         FWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9ZS3jllfWlgyi4J9EIgyoW+JFF4XGXxz5jEe+fdZO34=;
        b=YbrzyqF6uMfPanSx3ygQen5hscxUTbywY20dTJHOsvy8lFZkq6m48N5XJ7QTackHxu
         4zSy01zUdrWKO49iKbyKxYlV5IpVTvs64YOlp7P3EJTratIv04kR9PnReh40l6Z/Rh/u
         SPBmEhmcRWdNXn7KMb6qY4BhKCiiOpy/zvFvkz55y8pdrsGBugXgXgbcpux5blRCSiMw
         eVL3wODoYbWNQlQCNr10MTb1sdkz1Y9LVFnbhoVGNI5nY2ZOS+BqWALCG5Q62frGjQfD
         Uve34F3/VrBLzbd4I81bb13YChUGz+g/1a/jbBzEQdoz7bnaZ1zxqphEo3xieeZznxAE
         PVNg==
X-Gm-Message-State: APjAAAU/EQ14pBVE3jTozis/nrkLPwUvWmvzPnVZAOjX71rDgQL93cJB
        ZMGO2ifAyCZ/c7iTvNFkvXcWegfbx73dWAfWAodEGa+i
X-Google-Smtp-Source: APXvYqwAt94u/JbqTmKSbCpq/d3G5oL7KYMvNQZLAuc7rPU/44JTXiYqJ+kqPgCaRaUgg+wJqZHJdfBBfzNvEb5SGbE=
X-Received: by 2002:a2e:9119:: with SMTP id m25mr15911580ljg.106.1570981365014;
 Sun, 13 Oct 2019 08:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191013154245.23538-1-9erthalion6@gmail.com>
In-Reply-To: <20191013154245.23538-1-9erthalion6@gmail.com>
From:   Dmitry Dolgov <9erthalion6@gmail.com>
Date:   Sun, 13 Oct 2019 17:43:49 +0200
Message-ID: <CA+q6zcULf3QG0j5b0Q5wLpYLfUNumHpwX1n-RD6WK61oADqw_Q@mail.gmail.com>
Subject: Re: [RFC v2] io_uring: add set of tracing events
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Sun, Oct 13, 2019 at 5:41 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> To trace io_uring activity one can get an information from workqueue and
> io trace events, but looks like some parts could be hard to identify via
> this approach. Making what happens inside io_uring more transparent is
> important to be able to reason about many aspects of it, hence introduce
> the set of tracing events.
>
> All such events could be roughly divided into two categories:
>
> * those, that are helping to understand correctness (from both kernel
>   and an application point of view). E.g. a ring creation, file
>   registration, or waiting for available CQE. Proposed approach is to
>   get a pointer to an original structure of interest (ring context, or
>   request), and then find relevant events. io_uring_queue_async_work
>   also exposes a pointer to work_struct, to be able to track down
>   corresponding workqueue events.
>
> * those, that provide performance related information. Mostly it's about
>   events that change the flow of requests, e.g. whether an async work
>   was queued, or delayed due to some dependencies. Another important
>   case is how io_uring optimizations (e.g. registered files) are
>   utilized.
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> v1: add io_uring_link trace event
> v2: Extend io_uring events, to include not only io_uring_link, but other
>     events to cover important parts of the functionality

To clarify, I refer to this one [1] as v1. Would be glad to get any feedback.

[1]: https://lore.kernel.org/linux-block/CA+q6zcWqWAWG7UqzOekEH71XGUb24WpmJqe9juK94C4wq=1xsw@mail.gmail.com/T/

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC1AC7EE21
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 20:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjEDUtD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEDUsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 16:48:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DBE1A5
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 13:48:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4efe8991bafso1171343e87.0
        for <linux-block@vger.kernel.org>; Thu, 04 May 2023 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683233220; x=1685825220;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4BDNA8x26D+gc/g54BXpX2Nts8JzomtqMRTsoUmvOM=;
        b=dK+cb6qFoS8f8aSmVvVAt5PvFkbfebo96ikBzM42EXW4mpWiwa1Xzr6hqInDJkJllV
         LkzodpaC5RmaLoC/KSCVi2iREl/0gnHLU2KW/W/yKQ9Z4htTtjFr3tc9cObZvMR5xs0Q
         erUQOsXHbfsAo+ceTs5y1EaycVxues5onIkZQxrkCA+8s6UaZMg+zpP791U/faRXPMQC
         ekCzoKEM7TuJ32S6FsoJLM0rYSkoPuu5Moy3mE+SqK+2eaj99mO+JaOLDX8I7hEDYhO8
         UTcNBlirIIA3+GZNyjh+PNdvgfAOE/dtbwpdITnsG4ToDBwfzRXRyKXum7S3mxC1X3Zr
         wbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233220; x=1685825220;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4BDNA8x26D+gc/g54BXpX2Nts8JzomtqMRTsoUmvOM=;
        b=bwZbC70qivdRmvuF20fveHvcB46d7mz0Msm8tymumZ85koCJcqLq2asmzA2X1fDn3S
         wOPomVBMcKtsq1Lo1sgOMkXRIP6x0vAtIa+DaD+oSTh9Kx0WSre1gtNjXGeP3pLpc1NF
         +0+A0sEYt7TK0BkORvPbkvqUGDh9KsbxEKQiCWuG4fppyu0IJ4/H3nvm5CXUIfpQkL1Q
         vNtgSGRTw5V24jgjOvTpBmJ830mtdKZA74/LXwOUPT9mDF+nzMXyVw3z2RN6FxEwlXEA
         /TW5aM2ibdp2T10VUw9k4B3+F2oqOD94i1fvYTDpNqrpchKQ+pLI4VGc9bGHc4OQensT
         2fQg==
X-Gm-Message-State: AC+VfDwOYdtrp2m0t39o9xVTxrmt3V+Vn5PUSWMQTv5koWEqfnfKgsIy
        zf/nN/lQryMiDSsrb3meh167g8l9HHeXovxsmLo=
X-Google-Smtp-Source: ACHHUZ7LMxRdUgv7ihKLYjHLVFijm/GoKWSZk2d5fk7YgzP3ozFOa7A5lw2KFJwtJFmO5XoiGrGuqw==
X-Received: by 2002:a17:906:4794:b0:94a:937a:58f1 with SMTP id cw20-20020a170906479400b0094a937a58f1mr235860ejc.1.1683232645162;
        Thu, 04 May 2023 13:37:25 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id rl12-20020a170907216c00b009599c3a019fsm7809ejb.60.2023.05.04.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:37:24 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Thu, 04 May 2023 21:59:53 +0200
In-reply-to: <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
Message-ID: <875y97u92z.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens Axboe <axboe@kernel.dk> writes:

> On 5/4/23 12:52?PM, Keith Busch wrote:
>> On Thu, May 04, 2023 at 11:36:01AM -0700, Bart Van Assche wrote:
>>> On 5/4/23 11:15, Andreas Hindborg wrote:
>>>> If it is still unclear to you why this effort was started, please do let
>>>> me know and I shall try to clarify further :)
>>>
>>> It seems like I was too polite in my previous email. What I meant is that
>>> rewriting code is useful if it provides a clear advantage to the users of
>>> a driver. For null_blk, the users are kernel developers. The code that has
>>> been posted is the start of a rewrite of the null_blk driver. The benefits
>>> of this rewrite (making low-level memory errors less likely) do not outweigh
>>> the risks that this effort will introduce functional or performance regressions.
>> 
>> Instead of replacing, would co-existing be okay? Of course as long as
>> there's no requirement to maintain feature parity between the two.
>> Actually, just call it "rust_blk" and declare it has no relationship to
>> null_blk, despite their functional similarities: it's a developer
>> reference implementation for a rust block driver.
>
> To me, the big discussion point isn't really whether we're doing
> null_blk or not, it's more if we want to go down this path of
> maintaining rust bindings for the block code in general. If the answer
> to that is yes, then doing null_blk seems like a great choice as it's
> not a critical piece of infrastructure. It might even be a good idea to
> be able to run both, for performance purposes, as the bindings or core
> changes.
>
> But back to the real question... This is obviously extra burden on
> maintainers, and that needs to be sorted out first. Block drivers in
> general are not super security sensitive, as it's mostly privileged code
> and there's not a whole lot of user visibile API. And the stuff we do
> have is reasonably basic. So what's the long term win of having rust
> bindings? This is a legitimate question. I can see a lot of other more
> user exposed subsystems being of higher interest here.

Even though the block layer is not usually exposed in the same way that
something like the USB stack is, absence of memory safety bugs is a very
useful property. If this is attainable without sacrificing performance,
it seems like a nice option to offer future block device driver
developers. Some would argue that it is worth offering even in the face
of performance regression.

While memory safety is the primary feature that Rust brings to the
table, it does come with other nice features as well. The type system,
language support stackless coroutines and error handling language
support are all very useful.

Regarding maintenance of the bindings, it _is_ an amount extra work. But
there is more than one way to structure that work. If Rust is accepted
into the block layer at some point, maintenance could be structured in
such a way that it does not get in the way of existing C maintenance
work. A "rust keeps up or it breaks" model. That could work for a while.

Best regards
Andreas

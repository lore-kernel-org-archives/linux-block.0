Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C39BC433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 23:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C3760E9C
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 23:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhKAXxl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhKAXxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 19:53:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47CC061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 16:51:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k22so10365377ljk.5
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzV7K8wfEn1u0q7SJBtFTB4z48oxUhXRtNS/oDaEJ0Y=;
        b=MYMOaSZ89diox646KLhP3f/90t0Utb/n67qq0RwjIh8qUHkMVGhuBwXEQ7deCpK0bg
         sohjpP520/sbSQz4cgyBRNZQLxd/is4CvxCteCaNAQ5kd/3GKsw0E0oZh/lBcximVAal
         pTAwEeUMjtVJ92P0uX3DHJyvCuj2E82USIywY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzV7K8wfEn1u0q7SJBtFTB4z48oxUhXRtNS/oDaEJ0Y=;
        b=zcQ5FDQ7hG0s45bpfnS4uAg93dgaWBDQRg4NbBawM0H8a/rgLa1lRR7JmGDCEFfau8
         p0pYduyfS7iRxts1KscXokq2R0ARQ3pAHRKpPcEtmuS1HuonsXzaE91wrRg6EsALpq6e
         sjRnwIkDBMlKsM0tmiKSvCIOq2al2OlYRfNQTb27/6mSNtrtLwokaA65JsmNEVPyIDzn
         y8dKgalthxJIejBl4HQ8B0qtUUjquA61aw77KGUjVzcjMxMSqQRR9eFMEN+P5vnXjbnV
         56sS9AAWxuohhQCkjdyBiMV/JR3+uVpuof3wfe+zMq3sKvmo+BrrNl9RZ5jJ7lehx7OL
         Fvxg==
X-Gm-Message-State: AOAM5324DnaVjWhxAjAPMIouq+b5znRJTN1jopSU16VELO7Zrxrzdqtb
        3epnyfzwpqIivY+ddNvDMdb7Pz95is73rBm4
X-Google-Smtp-Source: ABdhPJzM8GC8QwOhTfh4gxzzX7dwPnHnwaBbegcFi8nF+rgRiYQOyQKoNz+ys0Jlv+yhbC0PnSFNJA==
X-Received: by 2002:a2e:bc24:: with SMTP id b36mr35595455ljf.54.1635810665330;
        Mon, 01 Nov 2021 16:51:05 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o5sm508533lfo.85.2021.11.01.16.51.04
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 16:51:04 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id l13so39412898lfg.6
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 16:51:04 -0700 (PDT)
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr31657503lfg.150.1635810664533;
 Mon, 01 Nov 2021 16:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
 <CAHk-=wii3c_VebHJxEyqU5P6FKjOLirYHQm+0=oaL59DNi-t1A@mail.gmail.com> <71c40f9b-7f83-be81-18cf-297077db005c@kernel.dk>
In-Reply-To: <71c40f9b-7f83-be81-18cf-297077db005c@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 16:50:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6dwyg9XMxiBB9or2oofXea7VY_hMjm4-0_9YU8o+LZQ@mail.gmail.com>
Message-ID: <CAHk-=wh6dwyg9XMxiBB9or2oofXea7VY_hMjm4-0_9YU8o+LZQ@mail.gmail.com>
Subject: Re: [GIT PULL] bdev size cleanups
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 1, 2021 at 4:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Yes, probably safer just to make bdev_nr_bytes() return sector_t as
> well, even if loff_t isn't strictly wrong.

Well, that would actually change the sign of some of the existing
comparisons. Possibly changing their meaning entirely..

So having 'loff_t' being signed may be an odd choice for a byte size,
but it is what it is. At least the current set of cleanups seemed to
keep the type logic the same when it changed i_size_read() to be
bdev_nr_bytes() instead.

Changing it to 'sector_t' not only doesn't make conceptual sense when
it's a byte count, it might also be dangerous.

So my reaction was really that it wasn't obvious that bdev_nr_bytes()
did the shift in the right type.. It does happen to do that, but
historically sector_t was the smaller type.

            Linus

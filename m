Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1817C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AE26103D
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJRXhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhJRXhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 19:37:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123EC06161C;
        Mon, 18 Oct 2021 16:35:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kk10so13337572pjb.1;
        Mon, 18 Oct 2021 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MTzc7Vauq6hE6XDUUmLoP37oT0cI2JXT4LSk6BMdNU0=;
        b=UV+YFz7fAV1/s9y4lSl/x69KQJHNW8l87QrzKVtLi6X74DioX72VAXBz/2a2UHGVIF
         hiqnJF8UZDQzQnT9h2Bjlv+1Eld8v0e+FYiaZ18W6YGUtCn6WLVDz1o0FYqKArtuLygg
         7nJGlTkL5/O5clIYVpHbI5Gpd5oF0LRAQbAR2OxGqxQ4Aa6p257RZv9sca0jUa1szGVX
         0DKSYelRkptcpNK/26llJEdbPUsjXGKZMyqfA58JmNyxeKcacMkjtJ1/JjYDWiVjlEvz
         9hPe1DljVTC318j7UbMI9TvoahCUxe+ZLXLjcg0w3i/Cc7Zqd7DtTg69+JGCJDcU0LkA
         FNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MTzc7Vauq6hE6XDUUmLoP37oT0cI2JXT4LSk6BMdNU0=;
        b=wE0UuCPosmEOuq65Mfm21WVKXcwpluDsI/bckW4/rxV2+MXkiqpTHFsBFLL5ISXmDF
         4QuNrHkOtijKosaK4V9v9ebL1fns5q5h29U9QghgzNeQDSNn07GudxuqXGNQQaWb62vs
         7EgbnS6Pmkvmdv1yKy+LMavEOhhQcQlJ0jwRX7bps9j1MYIb0/Q2HS8gnapWw0AEkX+t
         JqWISSxXBOw0Vqrc5dthKWvWMug2u6W9wbuake/lmk0kixBGMaicFli41Z+nDR3LUOPK
         AwU9GhZPO4iLs7YndACgU7rVluzQfRWD3PAmhDbU1YZ1pY/TkMF/SjBq0exVptiiqwl7
         VIvw==
X-Gm-Message-State: AOAM531ZD1YOivqcNYmZdDVnyVhEGu56Ub9ulIWZXt6ScPKTHnbdr2Wa
        l2RwJNTIaOkVZyVJXMze5wquWpOGi5s=
X-Google-Smtp-Source: ABdhPJymgO0UmDLGH8GGymRk5M0V/VVSqF6VdrVXMHvNgg+SLfS3hGHO71H4CrP+ZxNv+6B4Z50hmQ==
X-Received: by 2002:a17:90a:9297:: with SMTP id n23mr2242072pjo.199.1634600134656;
        Mon, 18 Oct 2021 16:35:34 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id t3sm14285478pgo.51.2021.10.18.16.35.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 16:35:34 -0700 (PDT)
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
To:     Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org
References: <20211018222157.12238-1-schmitzmic@gmail.com>
 <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <791e1173-4794-a547-2c84-112cc6627a1f@gmail.com>
Date:   Tue, 19 Oct 2021 12:35:27 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 19/10/21 11:30, Jens Axboe wrote:
> Was going to ask if this driver was used by anyone, since it's taken 3

Can't honestly say - I'm not following any other user forum than 
linux-m68k (and that's not really a user forum either).

> years for the breakage to be spotted... In all fairness, it was pretty
> horribly broken before the change too (like waiting in request_fn, under
> a lock).

In all fairness, it was a pretty broken design, but it did at least 
work. I concede that it was unmaintainable in its old form, and still 
largely is, just surprised that I didn't see a call for testing on 
linux-m68k, considering the committer realized it probably wouldn't work.

> So I'm curious, are you actively using it, or was it just an exercise in
> curiosity?

I've used it quite a bit in the past, but not for many years. For legacy 
hardware, floppies are often the only way to get data on or off the 
device, and I consider this driver an important fallback option should 
my network adapter (which is a pretty horrible kludge to use an old ISA 
NE2000 card on the ROM cartridge port) fail.

But then, any use of this legacy hardware is an exercise in curiosity 
mostly.

>
>> Testing this change, I've only ever seen single sector requests with the
>> 'last' flag set. If there is a way to send requests to the driver
>> without that flag set, I'd appreciate a hint. As it now stands,
>> the driver won't release the ST-DMA lock on requests that don't have
>> this flag set, but won't accept further requests because the attempt
>> to acquire the already-held lock once more will fail.
>
> 'last' is set if it's the last of a sequence of ->queue_rq() calls. If
> you just do sync IO, then last is always set, as there is no sequence.
> It's not hard to generate sequences, but on a floppy with basically no
> queue depth the most you'd ever get is 2. You could try and set:
>
> /sys/block/<dev>/queue/max_sectors_kb
>
> to 4 for example, and then do something that generates a larger than 4k
> write or read. Ideally that should give you more than 1.

Thanks, tried that - that does indeed cause multiple requests queued to 
the driver (which rejects them promptly).

Now fails because ataflop_commit_rqs() unconditionally calls 
finish_fdc() right after the first request started processing- and 
promptly wipes it again.

What is the purpose of .commit_rqs? The PC legacy floppy driver doesn't 
use it ...

Cheers,

	Michael

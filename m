Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F74C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1526103B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhJSAqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 20:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJSAqq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 20:46:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B7C061745
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 17:44:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id g2so16783443ild.1
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 17:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oiv/6je/Gai3gdb7sqtU2Dbs8TnGdildTjxNh1eS73w=;
        b=X3tEdNNKtPUI/8RkyNLed8FGLNWmL04VDx3QHRAI5N6tDkcluutb+sCzJow9TrZJxs
         Bb+JuX1peqRrJ85BsSNhHDqRcWoaE7BoBRPRYpTbug0b5jOyBQGwgGAF7r7hhHzSopMV
         mFJ7L89T8wnNo3h53otp7A0h/dPrGLnBAicSk/n5v4pjn3MlkjRw4b3J4Zjx/FZXdxv1
         WkeCjKKxFmULMOcCkXeLZlk+K8Coush+cYApRyhNHiLduSIVQEhYxuOqnvqXlwfCZ5VC
         ZwGMJy59CmeqJsJpr5z3PleYQ/EQ8R187T3plLh4ayhIU6kwUN4QWAlXZSwmgF+3eNiA
         Zg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oiv/6je/Gai3gdb7sqtU2Dbs8TnGdildTjxNh1eS73w=;
        b=DyvVhpAGAsjh6+u/hUZTok3NxEX3hkkF9JBogMHarAYOZLqom2Ivn3u7czGMmEywFK
         UlfHt8oKYl10n8fnJyMH+xsRSKsL0XXbPMFu4PKKxgq9eScolcnNNO+mHYhMxiPG70Pd
         HPBzM62oMhjle4boetVed+iQnCnk49DJLfMIQUULKIb8qpYAi0/Cz4ZsIyypHLnvlCuD
         NAdCWe2bq8tOU9A9QbywcqzY1gYKbpNIc27RkCPwM7U/U+Eb5ZZT6OGcIKi+vFphqvzX
         r4k2vDjreQ8G+EJLC3iS3JijtUT/MXmG3RXjcM2sCAeTFW2wwbVAfKlseuaYnWuiKgvR
         vs5A==
X-Gm-Message-State: AOAM531SY5hcQoHlFVYGyuSvhKDaylfaaAZ4ijyVIBko23VEcqXLHv6K
        cB4pCCIlkBI/+Emm2omHiSD2Iw==
X-Google-Smtp-Source: ABdhPJz5LAwUjAg3hHG6GOEBEXixQHSeCQrEH5YqUj6fnxLpCVCyM4z+bXQUZHll89uzllqh6CHN9w==
X-Received: by 2002:a05:6e02:12c1:: with SMTP id i1mr8361918ilm.297.1634604273610;
        Mon, 18 Oct 2021 17:44:33 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y5sm7514531ilg.58.2021.10.18.17.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 17:44:33 -0700 (PDT)
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20211018222157.12238-1-schmitzmic@gmail.com>
 <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
 <791e1173-4794-a547-2c84-112cc6627a1f@gmail.com>
 <859908de-0ca0-0425-1220-a3192c1e9110@kernel.dk>
 <CAOmrzkJZAAGEQFamfSb-jZNr5r0hr6jM+YoMSTCS08TtDWxcZg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1855e2ed-90d2-e99d-5df6-26766019bb3a@kernel.dk>
Date:   Mon, 18 Oct 2021 18:44:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOmrzkJZAAGEQFamfSb-jZNr5r0hr6jM+YoMSTCS08TtDWxcZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 6:42 PM, Michael Schmitz wrote:
> Hi Jens,
> 
> On Tue, Oct 19, 2021 at 12:40 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> 'last' is set if it's the last of a sequence of ->queue_rq() calls. If
>>>> you just do sync IO, then last is always set, as there is no sequence.
>>>> It's not hard to generate sequences, but on a floppy with basically no
>>>> queue depth the most you'd ever get is 2. You could try and set:
>>>>
>>>> /sys/block/<dev>/queue/max_sectors_kb
>>>>
>>>> to 4 for example, and then do something that generates a larger than 4k
>>>> write or read. Ideally that should give you more than 1.
>>>
>>> Thanks, tried that - that does indeed cause multiple requests queued to
>>> the driver (which rejects them promptly).
>>>
>>> Now fails because ataflop_commit_rqs() unconditionally calls
>>> finish_fdc() right after the first request started processing- and
>>> promptly wipes it again.
>>>
>>> What is the purpose of .commit_rqs? The PC legacy floppy driver doesn't
>>> use it ...
>>
>> You only need to care about bd->last if you have something in the driver
>> that can make it cheaper to commit more than one request. An example is
>> a driver that fills in requests, and then has an operation to ring the
>> submission doorbell to flush them out. The latter is what ->commit_rqs
>> is for.
> 
> OK, that's indeed a no-op for our floppy driver, which can queue
> exactly one request.

Right, and the only reason the depth is set to 2 is to allow one for
merging purposes.

>> For a floppy driver, just ignore bd->last and don't implement
>> commit_rqs, I don't think we're squeezing a lot of extra efficiency out
>> of it through that! Think many hundreds of thousands of IOPS or millions
>> of IOPS, not a handful of IOPS or less.
> 
> I'm not averse to using bd->last to close down only after the last
> request in a sequence if it can be done safely (i.e. the requests that
> had been rejected are then promptly requeued). But complexity is the
> enemy of maintainability, so the nice and easy fix should be enough.

With just 2 requests, any sequence is going to be pretty limited :-).
My recommendation would be to just ignore bd->last and treat any
request as a standalone unit. Should make for easier code too, and
you won't have two different cases to handle.

> I'll respin and send another version shortly.

Great, thanks.

-- 
Jens Axboe


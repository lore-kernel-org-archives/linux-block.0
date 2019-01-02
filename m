Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E67AC43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17367218E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Epx8omwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfABS71 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:59:27 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:51648 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfABS71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 13:59:27 -0500
Received: by mail-it1-f182.google.com with SMTP id w18so42278735ite.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TJTV9S1AbNtRuWW8slI8NrZGiVJQreRPQYp1US2zbgg=;
        b=Epx8omwL5LzsnDW+r6U6/atM2+mastBP8r0g9SHe1Bq/3GM5kw4Vb+KW0xuyAzR7nS
         eU+++iFF5f4LtdGe+M0Kn02ZoJ8rk65pF0zH70b/FSl2Gc6X9uRY7K5H6tdjGTRafJsc
         CgANBld8dhWTjy7h3fuLvI4qa6/EVJ/yyAN7UlYeLOf3AGeuIAI1T6wepj9+Rj9JmWqy
         ix79aookx/A+pnCKzBOOg25QCavavrd7g/UyAmYQHQMpLNC1rk7sQpgb93NwMulFk9P3
         e0abcNzYW9vNKg/xaeYy8RwQY+0iKriae47H5exTufDNYoWrIcLIGEdlHEhmq8OjgObq
         ZL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TJTV9S1AbNtRuWW8slI8NrZGiVJQreRPQYp1US2zbgg=;
        b=Lpq4JOISe8YyaJG3wfWBmHy6YPMs+Xz7nK7y3Pf4glKZPjkph2jmVAu03LyLksQ8iV
         hPeqvaUGgdWDbGEpEhmzxPq0I32PATQAxEaumCOlI1g1J2PBnPlGNKsKu4MV0/ry/Yq9
         EMeBrfhgDEZTMMQI1przRSk/f1ASsEhS9GfnoA55mnz4/3nGVhdsbFigpNmGY9S0OGEV
         ikzgeiTVRStRSIh3AMV1RkT+cqggAVj5gjt5DPXY65dMTVpErb7Cl+iF55x+6hnEhH2R
         Ut5chcEe2wSCPeDbUyPUth1RgTTsgLpTrjOsG3xfvt53VkENVcLEr+epalFsynq2kJRD
         1Fsg==
X-Gm-Message-State: AA+aEWZ1upgOGkkMMuL58NPmAB1btX6pabxGU+FdqETMAjjNpxN2dal5
        Zgxn0s2n0uTrZjDmG3e0u/AiUg==
X-Google-Smtp-Source: AFSGD/U6b6LdJg93gsC22YwVj6Argd1gnTA9XYt6S2ie51pLEttAn/H/ND9k5ePcAOd3Oey6Kt4KoQ==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr32342964itb.93.1546455566271;
        Wed, 02 Jan 2019 10:59:26 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v19sm21881512itb.0.2019.01.02.10.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:59:24 -0800 (PST)
Subject: Re: block: only use __set_current_state() for polled IO
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk>
 <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
 <CAHk-=whcmNjH+3pP_tgKbxe3iNu20eVVxfDyVXrKsNf7HiR0WA@mail.gmail.com>
 <9d2da835-fe54-947a-85da-cedb4423bca0@kernel.dk>
 <CAHk-=whz9-ren=HOTcofA0hCROWnVijTDGUgKaEVwkVjf2_CZg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eebec8c9-af48-6b9f-b1ba-2b10ea9a5a96@kernel.dk>
Date:   Wed, 2 Jan 2019 11:59:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whz9-ren=HOTcofA0hCROWnVijTDGUgKaEVwkVjf2_CZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/2/19 11:55 AM, Linus Torvalds wrote:
> On Wed, Jan 2, 2019 at 10:14 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Note that the blk-mq hunk is fine, since that's ONLY used for polling.
> 
> Actually, it's fine for another reason too: using
> "__set_current_state()" is always safe when the state you're setting
> things to is TASK_RUNNING. Even if there's a concurrent wakeup, that's
> only going to set things running anyway, so there's no race.

Right, that is of course correct, guess I glanced too quickly at that
one for the revert.

> But yes, if something is truly just polling, then it shouldn't touch
> the task state at all.

Exactly, and I agree this was going down the wrong path. I'll work
on getting rid of the state setting for polled IO, that makes a lot
more sense than trying to fiddle with __set_current_state() when
we aren't going to be sleeping at all.

> That said, some of the "polling" code looks mis-named. For example,
> the blk_poll() call in mm/page_io.c looks like it's polling, but it
> can actually sleep (ie blk_mq_poll_hybrid() gets called even when
> "spin" is true).

That's another case that needs a bit of cleanup, the hybrid polling
only really makes sense for sync polling. FWIW, the 'spin == true'
doesn't control if we're going to be sleeping or not, it's the
caller saying "keep going until you find a completion we care about".

> But the sleeping case looks like it handles the task state thing on
> its own, so all those polling codepaths should probably be inspected.
> 
> In the meantime, the attached is what I committed.

Looks good to me, matches my manual revert.


-- 
Jens Axboe


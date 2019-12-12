Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A37C2D0C6
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBED208C3
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S/7cyjie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLLBa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:30:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45097 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLLBaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 20:30:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so247621pgk.12
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJPEtyzhZidGS2TDF5UHDm6IlR5MghzdNBnmbPSNEo4=;
        b=S/7cyjie54XBy/hArCv6T4A7Bor9inO/ZNcOMf6/OTQe+W/dVAOqvxDFMVsL2TPJ1M
         BxUwDY2olMgNOND1g42vdqbyHt2rQOu4MGlAQ1rkNaadzL2uaQpoGw+JqTKAE1fKXmUl
         xjPW507Y+GgufzxHyTA7FzzGfiH0yTDGpe0F+wqIBT/ViUNbyvyXjhKn3AT3dAzlvnZX
         GlVBEPAbfWbpEo8fUQioDdBob4Bsx16jhup9qtnto0Ge3Un65iQN4lMxgoAFPfviMPYN
         DC68f9XuVS3ADsICBn7gGgO+PG4BXwwzpOs+Miz7n4GrZHJu9ChoiwpWmW6KWddXgem4
         zFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJPEtyzhZidGS2TDF5UHDm6IlR5MghzdNBnmbPSNEo4=;
        b=QjPkNAlLSVCuK1ftXOz5hDqShNLz6bx3UcIGeDOhhNoT+by9IZhpiCI6qBUWj0uEya
         ADaaLzO+1EFsRElGtjJoc6X4AVXfpudO45bXRnbT8/GWo6MwE0umUiEHQDMgHFOGyqOI
         9K2BDNC9Atj5CTt0HdcZurb0RI9dzjJQ8UFZVT2FbbCG3HBox8QZOKL1vWBIi43SAJKE
         vljv9klPv+0MTa7VNKFncJRRZ33veZ3FbVJBzT0o5kRUGl8253F+F5EE3vc5yc8sSgQ5
         JzBN57U+nhSRbDMeRsWl/EgTaStm5cZuLqDfpsPh3dKm+7fTT8o68G7Cc0LQnae60Q0g
         a7bg==
X-Gm-Message-State: APjAAAUTMnPo6f7HfLrZiJSBNjaFa7BEfu/42+WUJvsJ0hnpbM0cwEdy
        5qe3PUtptepuzZTztOpeYoTklA==
X-Google-Smtp-Source: APXvYqzksgTVuqBLGRiL2fpMnw1dJBEdBT87utGfQubHJUD1xblSlpC07LEp4C+G/oheM+P4WOiuWA==
X-Received: by 2002:a62:243:: with SMTP id 64mr7284697pfc.49.1576114255171;
        Wed, 11 Dec 2019 17:30:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id k3sm4131707pgc.3.2019.12.11.17.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:30:54 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <20191211210401.GA158617@cmpxchg.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <052a73a4-353a-05fc-8c21-41efbe234ece@kernel.dk>
Date:   Wed, 11 Dec 2019 18:30:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211210401.GA158617@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/19 2:04 PM, Johannes Weiner wrote:
> On Wed, Dec 11, 2019 at 12:18:38PM -0800, Linus Torvalds wrote:
>> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> $ cat /proc/meminfo | grep -i active
>>> Active:           134136 kB
>>> Inactive:       28683916 kB
>>> Active(anon):      97064 kB
>>> Inactive(anon):        4 kB
>>> Active(file):      37072 kB
>>> Inactive(file): 28683912 kB
>>
>> Yeah, that should not put pressure on some swap activity. We have 28
>> GB of basically free inactive file data, and the VM is doing something
>> very very bad if it then doesn't just quickly free it with no real
>> drama.
> 
> I was looking at this with Jens offline last week. One thing to note
> is the rate of IO that Jens is working with: combined with the low
> cache hit rate, it was pushing upwards of half a million pages through
> the page cache each second.
> 
> There isn't anything obvious sticking out in the kswapd profile: it's
> dominated by cache tree deletions (or rather replacing pages with
> shadow entries, hence the misleading xas_store()), tree lock
> contention, etc. - all work that a direct reclaimer would have to do
> as well, with one exceptions: RWC_UNCACHED doesn't need to go through
> the LRU list, and 8-9% of kswapd cycles alone are going into
> physically getting pages off the list. (And I suspect part of that is
> also contention over the LRU lock as kswapd gets overwhelmed and
> direct reclaim kicks in).
> 
> Jens, how much throughput difference does kswapd vs RWC_UNCACHED make?

It's not huge, like 5-10%. The CPU usage is the most noticable,
particularly at the higher IO rates.

-- 
Jens Axboe


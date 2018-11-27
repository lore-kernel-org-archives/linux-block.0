Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB6FC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 15:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9FF208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 15:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EjuBGJ5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9FF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeK1CSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:18:24 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42596 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbeK1CSX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 21:18:23 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so17247735ioa.9
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=POh+IpSj5aInNunC/JT3A2D5g2jxhXy8a/L5Lu2wvPA=;
        b=EjuBGJ5elEsjloaOoUsYFPqAOUh89QUdYv29vITjWKAluMKvmRHzowHHEnHCrmLmvI
         1JhKGGAi7oRNgfUCy48bi1WKfktnGIGirVbO5D8Co6MSSqAgaPBDB4bLUOOV8ypCax1R
         8zwUMs4I3Pf3m8oQei96KfrphkHUP+Y3i4IzTT5OJHdtTWeF6WimujXedJjzYggY0M8m
         3VIafA2Xulu6eA4swsaviWjquhWqZ22auoYw1g1lPuydKwRbjryjIzlXcwdUFvgGqPL9
         aYcv4qxkRQqMvj1Sf0ojUF/rCnype5S0LtTC+gF0QabDDm+kN3WF/Vdu5wqX0QBjPkr+
         sekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POh+IpSj5aInNunC/JT3A2D5g2jxhXy8a/L5Lu2wvPA=;
        b=o7rgZB6yi5YT8KwSMDDnv0KHFe9emeLvLvBTYZfwPdzsgRF8kbO4P8xH9R5XbJC/Y5
         piKramLMWQSyED5Yy+9UizKat2T5Z9mT+C+bjBT6DR/Bb97L7SgCZXO87w8qRE9EEEgC
         vyxxuYxc5H2dv4BbBkA1JRUwjqelxK66urYIcotKdUeW19NmwaUoiVeHM0/GholXbHTI
         oWH96JGt1atW9UDTeXW82VIc/oTzOcZufie3/CjBOQQmzRqjktv33G+H2Lf3c2D2/7Lx
         RsvFYEDcfqbQHBc1AU2ij3T+/V5yuCJfnYscbt0XF/i+CIQ+AupPac/dH/c6PiI9zBK/
         qAew==
X-Gm-Message-State: AA+aEWYjrPxGDJ73PKfd4Vu+C6yC9y1Ubh7Fk22qOXCGW14l5s/WF1FA
        Yryt61x9gz9VrSwRK7zyYyKIzYWyoT4=
X-Google-Smtp-Source: AFSGD/XWycQ4APTAzc5vXAjwCYBFxU6BS27U+1kGXYfGaWEHWfKbf5dteRce/LdQaQ7/83M5SJxVWg==
X-Received: by 2002:a6b:c9ce:: with SMTP id z197mr24914112iof.287.1543332008854;
        Tue, 27 Nov 2018 07:20:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j8sm1871104itb.30.2018.11.27.07.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 07:20:07 -0800 (PST)
Subject: Re: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
 <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>
 <ba2d191c-cf9d-07f1-5875-6a07ef043949@kernel.dk>
 <eee2f768-5ca2-aaa1-7d04-4fd7c9623312@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <470ea9e2-9546-8001-bed9-ed4753f061cb@kernel.dk>
Date:   Tue, 27 Nov 2018 08:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <eee2f768-5ca2-aaa1-7d04-4fd7c9623312@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 3:10 AM, Sagi Grimberg wrote:
>> No, it'll be exactly the same, and believe me, I've done plenty of
>> performance testing to ensure that it works well.  In fact, with the
>> changes queued up and this on top, polling is both faster and more
>> efficient than it ever has been before, for both the classic
>> preadv2/pwritev2 and the async polled IO.
> 
> I don't argue that this has not been tested, I was referring to the
> following use-case: app queues say 16 I/Os with io_submit and then
> issues preadv2 for an "important" 512B sector.
> 
> With this proposed change, is poll_fn more likely to return with the
> first completion it sees rather than continue poll until it sees that
> specific I/O it polled for?

Any IO completion will make it return, that was the case before and that
is still the case. If it isn't your specific IO, then you get to go
around the loop again.

>> I think that would be useless. For SYNC type polling with one thread, it
>> doesn't matter if we're looking for a particular IO, or just any IO.
>> Once your into two threads, you're already wasting huge amounts of CPU,
>> just to get to QD=2. The poll loop handles finding each others IOs just
>> fine, so there's no worry on that side.
>>
>> Polling was originally designed for the strictly SYNC interfaces, and
>> since we had the cookie anyway, it was tempting to look for a specific
>> IO. I think that was a mistake, as it assumed that we'd never do async
>> polling.
> 
> Not arguing. Just now that we already have the selective interface in
> place I'm asking is it OK to change that (IFF the above question is
> indeed real) esoteric as this use-case may be...

It won't cause any real change for the sync use case. There's no
difference between multiple sync users of polling and a mixed async/sync
polled use case in that regard.

-- 
Jens Axboe


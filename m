Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D3C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DBF214C1
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dl2p+swp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DBF214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeLERym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:54:42 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52281 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLERym (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:54:42 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so2771722itg.2
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tQC/xzepMyUehYfiFdFNXROFp4lhABrYSSKT2iLJXNg=;
        b=Dl2p+swpQ+kSC96RZt1z7NkCyPvcj9ThdLG5KGyWO1tXBa9U039h15IPqdqvSbGcqf
         OHpcpTP6q+z024vKsnQnJ4h12fHXFZVMUI3m/4L+rt9REYySz/geeovkxa0/8UBopFeX
         M/qw18BzDu1oRRvurcHAA4AUrpps2srhRrTSgbucT8H9niSeiQVRtxMymg27eSdXHr0c
         uSqhlSMoCemw98A1LW9gFRlifT90/x3EAg6p5Ds9qNQcIUkc4+tIjrX11ps8+Vuvic3a
         M10tLewXm1Bx+ht4CbhEdW/jdt0QwbFH5eamsCiNQhL3/5WD0P7akL3Bg+dxnCGDTXsD
         DGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQC/xzepMyUehYfiFdFNXROFp4lhABrYSSKT2iLJXNg=;
        b=n4DTr83EgvilHVixPxFXcQUSmYsgooIrNuldfBl08rMVQsv2ttNc+h0zQi4eUjtJux
         H4OUB0tblf4pfhpdy6mIk9TqYlwRQ+SgRyNqjOI4igA1+QOlEcxoBbo62qIwg8klggKE
         2IsShcqxcTokqaQ9sBrzqfyssfhTV8Rco/pC0m9na+TVI7HDy2E+c8SCn3GYhmbRuoBe
         9BjkHhPBIiCgld8j25b5356sgj8cniasz8d+56cBAK6gNCbneKc56qW9sh9xgs/oUlVp
         jAV/KUBvEW8dCPTomoWzhqNrZn0lFGDyLT8e9Ei8aZhryjz/oxVUxrIbU9bbFdTQ9qd3
         TwLA==
X-Gm-Message-State: AA+aEWbFe6rM8xC5HbobX8PfnIuXLXPEmvBWOgPODUK4UdddyfSd24M5
        CwsgdBTpduKxgEJR8z39kqLOXREra1M=
X-Google-Smtp-Source: AFSGD/UbrSUPivzYEZAjb4QSmiZo/Hk1beCgp1eGIWxZl2A4bHHPxEfcU5cO+FXs7tKbzUgWS4Npsg==
X-Received: by 2002:a24:a64f:: with SMTP id r15mr16101370iti.101.1544032481245;
        Wed, 05 Dec 2018 09:54:41 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i135sm7518602iti.34.2018.12.05.09.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:54:40 -0800 (PST)
Subject: Re: [PATCH v2 4/6] block: switch to per-cpu in-flight counters
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20181130222226.77216-1-snitzer@redhat.com>
 <20181130222226.77216-5-snitzer@redhat.com>
 <d6a741cd-ea75-19d0-13e3-eb1321e617b4@kernel.dk>
 <20181205174942.GA9838@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb184c39-9d60-0fa3-0d27-7af2f78d601e@kernel.dk>
Date:   Wed, 5 Dec 2018 10:54:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205174942.GA9838@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 10:49 AM, Mike Snitzer wrote:
> On Wed, Dec 05 2018 at 12:30pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 11/30/18 3:22 PM, Mike Snitzer wrote:
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index cdf174d7d329..d4c9dd65def6 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -45,53 +45,76 @@ static void disk_add_events(struct gendisk *disk);
>>>  static void disk_del_events(struct gendisk *disk);
>>>  static void disk_release_events(struct gendisk *disk);
>>>  
>>> -void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
>>> +void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
>>>  {
>>>  	if (queue_is_mq(q))
>>>  		return;
>>>  
>>> -	atomic_inc(&part->in_flight[rw]);
>>> +	local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
>>
>> I mentioned this in a previous email, but why isn't this just using
>> this_cpu_inc?
> 
> I responded to your earlier question on this point but, Mikulas just
> extended the existing percpu struct disk_stats and he is using local_t
> for reasons detailed in this patch's header:
> 
>     We use the local-atomic type local_t, so that if part_inc_in_flight or
>     part_dec_in_flight is reentrantly called from an interrupt, the value will
>     be correct.
> 
>     The other counters could be corrupted due to reentrant interrupt, but the
>     corruption only results in slight counter skew - the in_flight counter
>     must be exact, so it needs local_t.

Gotcha, make sense.

>> There's also no need to pass in the cpu, if we're not running with
>> preempt disabled already we have a problem. 
> 
> Why should this be any different than the part_stat_* interfaces?
> __part_stat_add(), part_stat_read(), etc also use
> per_cpu_ptr((part)->dkstats, (cpu) accessors.

Maybe audit which ones actually need it? To answer the specific question,
it's silly to pass in the cpu, if we're pinned already. That's true
both programatically, but also for someone reading the code.


-- 
Jens Axboe


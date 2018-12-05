Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B241CC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 18:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F579208E7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 18:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UsMnbveO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F579208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeLESf4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:35:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36385 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLESf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 13:35:56 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so17523594ioh.3
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v8EbNLobN+T6GLESbWwAKRZd/9IjJELZLYk/ilnlwiQ=;
        b=UsMnbveO9swihrQNFj7b1JhexeanCCq35dJmyJn7HuVGHXnRONw2Vr4umy5a+xUUO2
         L+F7Ne7Yt0HOMIa8c4z4F4Ud+X/+O6Wucx0yidIwtQo4FmXOTVdaFWuIx6kXzCho+YsU
         aqtDiVnaDF0KY+jm08x1y6/jPnk/CvaE+Gf/uShcsR1tZjbr7wGT7hCiDNFRUoJ/yvsv
         pZDrAEQTi5tNpCyTTX8nwdNZT5IfJURpZp62+DQiQuIRmwzNIFY9CgB95X2251AmY8Xb
         q65lfDVTO2KRulpKlg6r186pgzfyYHOGMrkEQwG03Is6LWqrnknvSHox3P2E8sPcW6HH
         wdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v8EbNLobN+T6GLESbWwAKRZd/9IjJELZLYk/ilnlwiQ=;
        b=I76MmncACAe9nLvYpJ6013zZrYn4xWluopHToVxs0YnRQwspMIQqCWNUFsAyuYV6Z2
         VRreutf1RmdguU8Nr4dQ9iwVZmHq04KvF6rn/QPOFR4xK/YoXAjh8zGLkzd9ApY4KoKj
         nuNyf1DtWCw47bo05IeRQ4c2l5VM1+ZV27HQ+p7d4S1A4jHFduE5hfUgf+67qsu6UOsx
         0tue6hgbtieLwjSASB6NVZ6oRUeY4T0v9qP96eONrCz8M4LdwyU5zRiNgBlU4KRboYM3
         iWC5DbmKGLt1sdSvugDW/FMIQzCHcBMxxy8ro3LI56dE4X7XboJYYkynzRI876nf/RtD
         w+zQ==
X-Gm-Message-State: AA+aEWaPr9lLotb8Zyef/OjadNrpc99eaRgbgbp+845V3EZ4ltR9cnAd
        MncW+yXXmUajI/uF2vrYUBvQ2cQDnv4=
X-Google-Smtp-Source: AFSGD/XEUcf6rWAxWesHoW1rkC1rcSlEA6pw5sKExrtqqXjtwbrcORlhtfvz3Rk2zgeXlftOcQh1mw==
X-Received: by 2002:a6b:5804:: with SMTP id m4mr20764264iob.47.1544034954880;
        Wed, 05 Dec 2018 10:35:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r21sm7433615ita.27.2018.12.05.10.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:35:54 -0800 (PST)
Subject: Re: [PATCH v2 4/6] block: switch to per-cpu in-flight counters
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20181130222226.77216-1-snitzer@redhat.com>
 <20181130222226.77216-5-snitzer@redhat.com>
 <d6a741cd-ea75-19d0-13e3-eb1321e617b4@kernel.dk>
 <20181205174942.GA9838@redhat.com>
 <eb184c39-9d60-0fa3-0d27-7af2f78d601e@kernel.dk>
 <20181205180347.GA9966@redhat.com>
 <779ca97e-3353-5fd0-9899-73de8a0b2cad@kernel.dk>
 <20181205181832.GA10058@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff67e752-2e3c-1e4d-245a-0ad4765ea38b@kernel.dk>
Date:   Wed, 5 Dec 2018 11:35:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205181832.GA10058@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 11:18 AM, Mike Snitzer wrote:
> On Wed, Dec 05 2018 at  1:04pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 12/5/18 11:03 AM, Mike Snitzer wrote:
>>> On Wed, Dec 05 2018 at 12:54pm -0500,
>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> On 12/5/18 10:49 AM, Mike Snitzer wrote:
>>>>> On Wed, Dec 05 2018 at 12:30pm -0500,
>>>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>>> There's also no need to pass in the cpu, if we're not running with
>>>>>> preempt disabled already we have a problem. 
>>>>>
>>>>> Why should this be any different than the part_stat_* interfaces?
>>>>> __part_stat_add(), part_stat_read(), etc also use
>>>>> per_cpu_ptr((part)->dkstats, (cpu) accessors.
>>>>
>>>> Maybe audit which ones actually need it? To answer the specific question,
>>>> it's silly to pass in the cpu, if we're pinned already. That's true
>>>> both programatically, but also for someone reading the code.
>>>
>>> I understand you'd like to avoid excess interface baggage.  But seems to
>>> me we'd be better off being consistent, when extending the percpu
>>> portion of block core stats, and then do an incremental to clean it all
>>> up.
>>
>> The incremental should be done first in that case, it'd be silly to
>> introduce something only to do a cleanup right after.
> 
> OK, all existing code for these percpu stats should follow the pattern:
> 
>   int cpu = part_stat_lock();
> 
>   <do percpu diskstats stuff>
> 
>   part_stat_unlock();
> 
> part_stat_lock() calls get_cpu() which does preempt_disable().  So to
> your point: yes we have preempt disabled.  And yes we _could_ just use
> smp_processor_id() in callers rather than pass 'cpu' to them.
> 
> Is that what you want to see?

Something like that, yes.

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6163C433F5
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 12:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354955AbiE1MXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 08:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348350AbiE1MXN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 08:23:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60401CB3B
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:23:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q92-20020a17090a17e500b001e0817e77f6so9302781pja.5
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KNkWWZNJaBDWQjmUzXidwr3D2Eiw+JFCKCjudoaWngc=;
        b=myqCNYR10XR1hxiqrht4DQ5X15wGTgdOmdOo7WaQ6WL+jOVAqXF7e++wPnqP4e8Ubv
         5lOBFTK0/cPUhQzzip73ZrydoafgOuMXy7X4leuiUtq3XXJM7Qs4un+2L/+mnx/evWd3
         8Lyn148ukNfnczHByHrQF0ptghAdwqt6WrCUvJczQ5CtPOizoJz2i/aIWwt20edZYD04
         yAS6S++r6ub2rfsgXHxSJ7MirSacvGKQ6RJjmVqAnQCM7D+pmGTn02WUKQj41nuyLjy6
         pzbAtWJs+6twSlCU1G193YPH8kI+T4vqeAhZhF2VBQFTgCxAPXaUqDNKO9C7r1XGL70v
         Zmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KNkWWZNJaBDWQjmUzXidwr3D2Eiw+JFCKCjudoaWngc=;
        b=x5tMD8Qv8h7iRpHqQ97lSrIFdu1P9CE+vAINsWioLAPydLcqj76yUHjlLFQss30EXU
         RQMZ3CZXLQ/I/t1GJUT0kVDahyPgwrh4ncpmAqNslrBQ4DMjaon2GkeyfUfj1j0BgS51
         udS6/u21Pj+8j3O+6X13wRxnE9TvDuIyt9u4REkIX/0RCfh+VtvKvYswot5SSru4o0xv
         S7Eaq05PJnK1Hn16ajxgQmp6So3KoHcDkPLEJhgrjNz69qN+KaK9eupfZgbbnRLH7akI
         kMZdFMpLT140R4zJgf/skXQ6yIqojPGwJ/9HVH7NaDzeH1wKyabaNnwULbOWW/hnzZYR
         iq8g==
X-Gm-Message-State: AOAM533iNWpFfN1SsKSXfAyB06y1mp13OQSUnNxC9cos5HhKkVnqn6JS
        3iHbhJCY6V3t3mDWzOGHISBqTg==
X-Google-Smtp-Source: ABdhPJwE5O3+BxKfPfqEibyUCA0oDuQ8uj9gkkdNlEBVT3YJy8eCIeYiKQTAUdhEQR7I8mDuHm5hjQ==
X-Received: by 2002:a17:902:c412:b0:161:af8b:f478 with SMTP id k18-20020a170902c41200b00161af8bf478mr47578359plk.67.1653740590281;
        Sat, 28 May 2022 05:23:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b0016170bb6528sm5563203plf.113.2022.05.28.05.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 05:23:09 -0700 (PDT)
Message-ID: <e0002f36-fb39-5d27-ce10-2278fd4a77bb@kernel.dk>
Date:   Sat, 28 May 2022 06:23:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/1] bcache: avoid unnecessary soft lockup in kworker
 update_writeback_rate()
Content-Language: en-US
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
References: <20220528061949.28519-1-colyli@suse.de>
 <20220528061949.28519-2-colyli@suse.de>
 <8a45c9fa-4cd8-e0e0-63f3-03adb761f9ca@kernel.dk>
 <1BD307CE-9390-4A4B-B917-676104DA77F1@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1BD307CE-9390-4A4B-B917-676104DA77F1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/28/22 6:22 AM, Coly Li wrote:
> 
> 
>> 2022?5?28? 20:20?Jens Axboe <axboe@kernel.dk> ???
>>
>> On 5/28/22 12:19 AM, Coly Li wrote:
>>> The kworker routine update_writeback_rate() is schedued to update the
>>> writeback rate in every 5 seconds by default. Before calling
>>> __update_writeback_rate() to do real job, semaphore dc->writeback_lock
>>> should be held by the kworker routine.
>>>
>>> At the same time, bcache writeback thread routine bch_writeback_thread()
>>> also needs to hold dc->writeback_lock before flushing dirty data back
>>> into the backing device. If the dirty data set is large, it might be
>>> very long time for bch_writeback_thread() to scan all dirty buckets and
>>> releases dc->writeback_lock. In such case update_writeback_rate() can be
>>> starved for long enough time so that kernel reports a soft lockup warn-
>>> ing started like:
>>>  watchdog: BUG: soft lockup - CPU#246 stuck for 23s! [kworker/246:31:179713]
>>>
>>> Such soft lockup condition is unnecessary, because after the writeback
>>> thread finishes its job and releases dc->writeback_lock, the kworker
>>> update_writeback_rate() may continue to work and everything is fine
>>> indeed.
>>>
>>> This patch avoids the unnecessary soft lockup by the following method,
>>> - Add new member to struct cached_dev
>>>  - dc->rate_update_retry (0 by default)
>>> - In update_writeback_rate() call down_read_trylock(&dc->writeback_lock)
>>>  firstly, if it fails then lock contention happens.
>>> - If dc->rate_update_retry <= BCH_WBRATE_UPDATE_RETRY_MAX (15), doesn't
>>>  acquire the lock and reschedules the kworker for next try.
>>> - If dc->rate_update_retry > BCH_WBRATE_UPDATE_RETRY_MAX, no retry
>>>  anymore and call down_read(&dc->writeback_lock) to wait for the lock.
>>>
>>> By the above method, at worst case update_writeback_rate() may retry for
>>> 1+ minutes before blocking on dc->writeback_lock by calling down_read().
>>> For a 4TB cache device with 1TB dirty data, 90%+ of the unnecessary soft
>>> lockup warning message can be avoided.
>>>
>>> When retrying to acquire dc->writeback_lock in update_writeback_rate(),
>>> of course the writeback rate cannot be updated. It is fair, because when
>>> the kworker is blocked on the lock contention of dc->writeback_lock, the
>>> writeback rate cannot be updated neither.
>>>
>>> This change follows Jens Axboe's suggestion to a more clear and simple
>>> version.
>>
>> This looks fine, but it doesn't apply to my current for-5.19/drivers
>> branch which the previous ones did. Did you spin this one without the
>> other patches, perhaps?
>>
>> One minor thing we might want to change if you're respinning it -
>> BCH_WBRATE_UPDATE_RETRY_MAX isn't really named for what it does, since
>> it doesn't retry anything, it simply allows updates to be skipped. Why
>> not call it BCH_WBRATE_UPDATE_MAX_SKIPS instead? I think that'd be
>> better convey what it does.
> 
> Naming is often challenge for me. Sure, _MAX_SKIPS is better. I will
> post another modified version.

It's hard for everyone :-)

Sounds good, I'll get it applied when it shows up.

-- 
Jens Axboe


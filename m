Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C91C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1039522464
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e0eAkopM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAWSw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:52:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38568 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWSw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 13:52:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so1954077pfc.5
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 10:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HIgWTybk6CC3JVz4nmT3PGzBcRGE/1gMLzKZ2iu2jY=;
        b=e0eAkopMT/lWXA2we6hDwxa3kgFS/1T2VaefkmGUvPHOkyB45OFh8csM4c9XBF7xxD
         xJ4sbwuFb0MoTDt3p+0b2KMrsnFRTtSRpgh7CJZlR2d9xr+WmgPJOOqY245XeJQtY0Dl
         PunG5hZeVpZd8CjRRwXKwEDju6gU0xZvDFk1XfhK5zpKScZKzLIqLAXTtYLryco4vhK5
         vPSfPpULdU+LBcDKqmGfGTQhQGkrSovm4H03SQA5DnNnUf6fAjAhPY/fiCPysINq2Gs9
         yX4zTN6GgeaSRmbpN3MV2heoPOwgg288JgwR+DBFG8L6oKit2kQgL2NhpG5dZEgaJ0m/
         lINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HIgWTybk6CC3JVz4nmT3PGzBcRGE/1gMLzKZ2iu2jY=;
        b=TEN12+sfm1AtLRuRHe+spxweC9LX33djSiA0maPY2fe9g6TAYPPZ9WBEeoddHEQ2wt
         W+1SeLa1svRA8NqH6QGow4o0oauleYjmujukLDbYgQf0aEOGrjTizst0tDU0Bn5OV7g/
         5xFmAUCwR8sjVDbbuU6HIGoG0tKFpY5xNHbGLes+HhqQG5J2ohugTJJaVMip4EwExBNs
         B1OnEwPbOD9OHkrI2p3rV28jzJS3UyPRQRAWGyf9dGcMFhRC3gEBIivKV/Vm6V1KAQED
         UkTo+uQUXBUGNqbW223sGldua5qF9pTqqBX/Ndl+lEWQzXBUb+r/Ug2JX+u180XEEf27
         VAEg==
X-Gm-Message-State: APjAAAVnZEdFTXr1Pksj4KPNTVFsP7CW+YVGgaASkzgxEwzUZrR6xeid
        WBE8/PkwX06OD5WUIlHObKQU7w==
X-Google-Smtp-Source: APXvYqwb0Dm759onHzJsHI0qaChii+UBFR/+cfwTXWHY+akNML1O7gnTFlmahTk/bilyqtYvVscuCQ==
X-Received: by 2002:aa7:9729:: with SMTP id k9mr8705251pfg.72.1579805548644;
        Thu, 23 Jan 2020 10:52:28 -0800 (PST)
Received: from ?IPv6:2600:380:4562:fb25:b980:6664:b71f:35b5? ([2600:380:4562:fb25:b980:6664:b71f:35b5])
        by smtp.gmail.com with ESMTPSA id q25sm3396820pfg.41.2020.01.23.10.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:52:28 -0800 (PST)
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
To:     Mike Snitzer <snitzer@redhat.com>,
        Stefan Bader <stefan.bader@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Tyler Hicks <tyler.hicks@canonical.com>,
        Alasdair Kergon <agk@redhat.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
 <20200123103541.GA28102@redhat.com> <20200123172816.GA31063@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81055166-37fb-ad65-6a53-11c22c626ab1@kernel.dk>
Date:   Thu, 23 Jan 2020 11:52:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123172816.GA31063@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/20 10:28 AM, Mike Snitzer wrote:
> On Thu, Jan 23 2020 at  5:35am -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
>> On Thu, Jan 23 2020 at  4:17am -0500,
>> Stefan Bader <stefan.bader@canonical.com> wrote:
>>
>>> When device-mapper adapted for multi-queue functionality, they
>>> also re-organized the way the make-request function was set.
>>> Before, this happened when the device-mapper logical device was
>>> created. Now it is done once the mapping table gets loaded the
>>> first time (this also decides whether the block device is request
>>> or bio based).
>>>
>>> However in generic_make_request(), the request function gets used
>>> without further checks and this happens if one tries to mount such
>>> a partially set up device.
>>>
>>> This can easily be reproduced with the following steps:
>>>  - dmsetup create -n test
>>>  - mount /dev/dm-<#> /mnt
>>>
>>> This maybe is something which also should be fixed up in device-
>>> mapper.
>>
>> I'll look closer at other options.
>>
>>> But given there is already a check for an unset queue
>>> pointer and potentially there could be other drivers which do or
>>> might do the same, it sounds like a good move to add another check
>>> to generic_make_request_checks() and to bail out if the request
>>> function has not been set, yet.
>>>
>>> BugLink: https://bugs.launchpad.net/bugs/1860231
>>
>> >From that bug;
>> "The currently proposed fix introduces no chance of stability
>> regressions. There is a chance of a very small performance regression
>> since an additional pointer comparison is performed on each block layer
>> request but this is unlikely to be noticeable."
>>
>> This captures my immediate concern: slowing down everyone for this DM
>> edge-case isn't desirable.
> 
> SO I had a look and there isn't anything easier than adding the proposed
> NULL check in generic_make_request_checks().  Given the many
> conditionals in that  function.. what's one more? ;)
> 
> I looked at marking the queue frozen to prevent IO via
> blk_queue_enter()'s existing cheeck -- but that quickly felt like an
> abuse, especially in that there isn't a queue unfreeze for bio-based.
> 
> Jens, I'll defer to you to judge this patch further.  If you're OK with
> it: cool.  If not, I'm open to suggestions for how to proceed.  
> 

It does kinda suck... The generic_make_request_checks() is a mess, and
this doesn't make it any better. Any reason why we can't solve this
two step setup in a clean fashion instead of patching around it like
this? Feels like a pretty bad hack, tbh.

-- 
Jens Axboe


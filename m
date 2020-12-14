Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5AC2BB40
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 17:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6317122522
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 17:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408493AbgLNRXA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408460AbgLNRWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 12:22:55 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D09C06179C
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 09:22:01 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p187so17627055iod.4
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eWhgExMN4zCprjhcDtgmjw9YARch/pKzDiQ2LLbaT/E=;
        b=ntS0H9izzEOozE6++3J6RmbFanpPP/2BS164kd/cUdKNpxehdndHtiol5OcrBrr/W/
         VyrGQKZApqsVmIpC4HgoWyOQFYpBU4aMAKrtHGu3pGPi7UHDWfx+1OJ5VOXwS1fnqr7z
         uYjvo7F9GIcAMQ6BSaIybuK5IjEYs37EHmWB0jXABDW3lAgFQlN6kxwrkQo9KH8KHmgm
         05snhCr74SjXv2O1n1hxKt8tE/XsBeFVjOXOcxdm18CqUm1xV7Q86BkkmriiLlns0cFq
         u8f2yfHdyrzEBpdY07+I7jSgJ4P1YYzk0bC2nMtnCU9Ee3za5ptQROdrmYb39ueT+hU5
         KENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eWhgExMN4zCprjhcDtgmjw9YARch/pKzDiQ2LLbaT/E=;
        b=S2qKNsMR1uWSvAMXEXPZt4Mte8VRjVw1ZLwPZ9NvfqnKMUH4pAs/p2guXilqgryHMN
         lsvlQlZ7W3Y17d35vhzVeq/0gGNewJpFVM+GCsdS+fsTS/aubNG/EOBuDjK0Lt/BNhwM
         fE3LZ981cLwFazNG2E/MmqYIh6DWaCNbrEtavgxOXaBysykyeS0mYbbIVJXzxLxT8D3w
         0uMOb3zEJn69osvEo0WlCJuCvAKMETK525hTdHzTv9Vr4FXoZy56tOTGewg4PV0jxola
         LFKjnNaD28fx/M0VlifBkK9Aqjl38/zAWH0ao5OHoqNV/xd+gk5JcjnJDd5Bp0W//aUh
         yzWQ==
X-Gm-Message-State: AOAM530DbSK2b+JWKzH7kJJm0GBeGRRkbL7IMKaUCJBPrBRGbj5m89Ic
        y2k9wKG1sYFEe8kDwCc+3iTkrw==
X-Google-Smtp-Source: ABdhPJzv0nDdErB58l03RvBxS0IlU1/1JVfgOa2qPsxmwVJr9H+ZQuTiasKMVqbH+kw5ob7E0FEkkA==
X-Received: by 2002:a5e:820d:: with SMTP id l13mr32942668iom.102.1607966520897;
        Mon, 14 Dec 2020 09:22:00 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j9sm11475152ile.59.2020.12.14.09.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 09:22:00 -0800 (PST)
Subject: Re: Linux 5.10
To:     Mike Snitzer <snitzer@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
 <20201214053147.GA24093@codemonkey.org.uk> <X9b9ujh5T6U5+aBY@kroah.com>
 <20201214160247.GA2090@redhat.com> <20201214162631.GA2290@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6522caad-bfe8-2554-2ba9-dff5856233d1@kernel.dk>
Date:   Mon, 14 Dec 2020 10:21:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214162631.GA2290@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/20 9:26 AM, Mike Snitzer wrote:
> On Mon, Dec 14 2020 at 11:02am -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
>> On Mon, Dec 14 2020 at 12:52am -0500,
>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>>> On Mon, Dec 14, 2020 at 12:31:47AM -0500, Dave Jones wrote:
>>>> On Sun, Dec 13, 2020 at 03:03:29PM -0800, Linus Torvalds wrote:
>>>>  > Ok, here it is - 5.10 is tagged and pushed out.
>>>>  > 
>>>>  > I pretty much always wish that the last week was even calmer than it
>>>>  > was, and that's true here too. There's a fair amount of fixes in here,
>>>>  > including a few last-minute reverts for things that didn't get fixed,
>>>>  > but nothing makes me go "we need another week".
>>>>
>>>> ...
>>>>
>>>>  > Mike Snitzer (1):
>>>>  >       md: change mddev 'chunk_sectors' from int to unsigned
>>>>
>>>> Seems to be broken.  This breaks mounting my raid6 partition:
>>>>
>>>> [   87.290698] attempt to access beyond end of device
>>>>                md0: rw=4096, want=13996467328, limit=6261202944
>>>> [   87.293371] attempt to access beyond end of device
>>>>                md0: rw=4096, want=13998564480, limit=6261202944
>>>> [   87.296045] BTRFS warning (device md0): couldn't read tree root
>>>> [   87.300056] BTRFS error (device md0): open_ctree failed
>>>>
>>>> Reverting it goes back to the -rc7 behaviour where it mounts fine.
>>>
>>> If the developer/maintainer(s) agree, I can revert this and push out a
>>> 5.10.1, just let me know.
>>
>> Yes, these should be reverted from 5.10 via 5.10.1:
>>
>> e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10
>> f075cfb1dc59 md: change mddev 'chunk_sectors' from int to unsigned
> 
> Sorry, f075cfb1dc59 was my local commit id, the corresponding upstream
> commit as staged by Jens is:
> 
> 6ffeb1c3f82 md: change mddev 'chunk_sectors' from int to unsigned
> 
> So please revert:
> 6ffeb1c3f822 md: change mddev 'chunk_sectors' from int to unsigned
> and then revert:
> e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10

Working with Song on understanding the failure case here. raid6 was
tested prior to this being shipped. We'll be back with more soon...

-- 
Jens Axboe


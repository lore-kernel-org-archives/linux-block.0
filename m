Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB43C67871
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 17:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjAPRsJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjAPRrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 12:47:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B06360A8
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 09:27:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k12so8885078plk.0
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 09:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pbFqvRalBstKcD7x1Jm78X3aEvFaX7kUH8j1+PZIDk=;
        b=PqzH0AvgIFkYY3HvOaWOWn0hVhfluvbwmW4/nGppH6kEd7iw86GjLRx/8KKtIPlHyv
         8W4N4v6FySnxBTgBtCtMNCye+lg+cRa26wsmrrdLy0wkAYnDl+ImRMKier5ECfbC1s2N
         y6+nM/FDxr2++fzEVHkIaWx+/bVXJc85lLXXTEB+kl0GYnkduophTrUijdmJZpJeprNP
         g/rI4pQgFocfQZI/vGKiAQX7iHPfLwGRm+toJWAtkZgygnRtkDa2nDE0rMJwc7Bw/ATf
         i0GJTkzCB5KomLmaCNdjyYwqDsqPiq+adlRKjPvWPSi/YqHh2wCePcgt5S74mQs0tWuX
         li1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pbFqvRalBstKcD7x1Jm78X3aEvFaX7kUH8j1+PZIDk=;
        b=mzKKBAFpni2W20T/lPhOpiXBBzOV3pQabY8+0IOlz9eXe+dx374o64TLuaBjDO7m8q
         dnu6vzywlv4Ke7p134LiX4+ydSS8eNEpeyOsq4IFOVNv/QnzRQuI6w9mEo9FcygV95Nk
         01+YyvaCTxOF9IIstuVRx0o63/bpRNNbMmuZCiNw4aHGftzB4RdBVYDZqTuHPlMArCLz
         4+Fl0Kl/JK9/kd443yNcE6Vvuh4sp1pTFHjii/gyGTj9zSsJWnt5N7QwOlYMiJNFy2Vc
         mhIsJeeU9l1UWaqvjFi4LsCxvG6N57awaz1Q/tq9BXdk5EC9V93cEDbISRLiOUG94L2V
         fGVg==
X-Gm-Message-State: AFqh2kqn5s8quJFEzEU0f68GtMQdT0PI+rE1Q/hxg6YzmOKLQEF5r2+S
        PlRTMSDZ9DcaIJVYCYpn5OTpvJ2v/90yU+Fg
X-Google-Smtp-Source: AMrXdXvGJIfa2RE3Um74mOGpIMMhkXgTZdRC3TPL/QIruI5gmwuuwf5le1FuiwjKC6PClkC7G8B27Q==
X-Received: by 2002:a05:6a21:9011:b0:b5:f664:b4bc with SMTP id tq17-20020a056a21901100b000b5f664b4bcmr7787085pzb.2.1673890062653;
        Mon, 16 Jan 2023 09:27:42 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090322d100b00186f0f59c85sm19597934plg.235.2023.01.16.09.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 09:27:42 -0800 (PST)
Message-ID: <98a4b012-341d-aa44-bbfa-eb045784a4ee@kernel.dk>
Date:   Mon, 16 Jan 2023 10:27:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
 <BYAPR21MB1688FCAE25367032B13BD9F2D7C19@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <BYAPR21MB1688FCAE25367032B13BD9F2D7C19@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 10:11 AM, Michael Kelley (LINUX) wrote:
> From: Jens Axboe <axboe@kernel.dk> Sent: Monday, January 16, 2023 8:02 AM
>>
>> If we're doing a large IO request which needs to be split into multiple
>> bios for issue, then we can run into the same situation as the below
>> marked commit fixes - parts will complete just fine, one or more parts
>> will fail to allocate a request. This will result in a partially
>> completed read or write request, where the caller gets EAGAIN even though
>> parts of the IO completed just fine.
>>
>> Do the same for large bios as we do for splits - fail a NOWAIT request
>> with EAGAIN. This isn't technically fixing an issue in the below marked
>> patch, but for stable purposes, we should have either none of them or
>> both.
>>
>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
>>
>> Cc: stable@vger.kernel.org # 5.15+
>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
>> Link: https://github.com/axboe/liburing/issues/766
>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index 50d245e8c913..a03cb732c2a7 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -368,6 +368,14 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct
>> iov_iter *iter)
>>  			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>>  		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
>>  	}
>> +	/*
>> +	 * We're doing more than a bio worth of IO (> 256 pages), and we
>> +	 * cannot guarantee that one of the sub bios will not fail getting
>> +	 * issued FOR NOWAIT as error results are coalesced across all of
>> +	 * them. Be safe and ask for a retry of this from blocking context.
>> +	 */
>> +	if (iocb->ki_flags & IOCB_NOWAIT)
>> +		return -EAGAIN;
>>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>>  }
> 
> A code observation:  __blkdev_direct_IO() has a test for IOCB_NOWAIT
> that now can't happen, as this is the only place it is called.  But maybe it's
> safer to leave the check in case of future code shuffling.

I think we should just keep it, or it will get missed later on. I am
pondering how we could make this better, but it's a bit more involved.

-- 
Jens Axboe



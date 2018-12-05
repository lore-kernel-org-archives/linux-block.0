Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7DBC04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 03:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9CF20661
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 03:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EwZunKD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9CF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLEDF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:05:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41561 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEDF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 22:05:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so8312117pgh.8
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0wzXdEd/l8To/h1BDnQ8vGW3xdWa8543A8JdjbalIU=;
        b=EwZunKD/n7HURiAK0pFkL5cHXrEbkudYaQ8NuiEBAFNJdZP3qBy5qYBWtWoTRcGy3v
         LslzMhealu4CcqpETi7Xu/VxoH70S6ZEoiWHgxpZ4D3828+sVs03U3gSMpbXsH7lCT3v
         STQ9XK2sDdx+NKDZXbptzaY4ICA7+Ey52R/E6YOWj8BXleSpG8HOViPqtGh1/ukuxNhA
         gxBGy9MCAH7eDpUsggYCiSeg1g/KndqwVB8ikajPfH4fieNkireIwtOiRKrH09sQErT0
         bGyhuT9yv5ENEfPmMyKc3ygKtgUigHmCL2/XqbWkNVAV2MErjiphM850gRa+N1QtC/KK
         O/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0wzXdEd/l8To/h1BDnQ8vGW3xdWa8543A8JdjbalIU=;
        b=YwR+I8FbpX2wfM9oPQmziSoYU0BWT+zjbIfPuG3ZiRl8tIBH59lTrNPuotSYWYfbH4
         7ATP4sVNG+XbasZ+3kTdMpBFIU6kSMygBl86sCSAwmldfVdt6xi5w2LjVtAOWdU0oX3n
         2TB6BJJoy96Rl+CDVdK8l+UcZu0c0Q2y+vt9vVoLRIebJNq9ki9FtapfEnW+ZSdixEi1
         7oUk5DP9/KfUJsvDVm9SqcxVBswele21EPrBhF3LaVkyVbJEzN/Vdi5v16gRWhkW483U
         TQPTBMoVRlUGIJTJi+55dfzoh+41sea/RILgZwVoLnHWr++zIZ89PsqtTF1i3Nj1PouE
         HoSA==
X-Gm-Message-State: AA+aEWYpGtBozBj6Z54lgoCECMwCmdXddflg4wWVGePDHOwMnzqu8yl4
        nZuEe8bWDCHZVIqyVks3+tU79M9AMxo=
X-Google-Smtp-Source: AFSGD/V7bfixWrOAexNKjYpmeaOU2dqswOPUUmRRG3bwNn/PrLqobNOJx1H4zfp8emAyDDA+bvauZw==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr22456012pfa.186.1543979157712;
        Tue, 04 Dec 2018 19:05:57 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v70sm32700103pfa.152.2018.12.04.19.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 19:05:56 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013736.GD17845@ming.t460p>
 <37bf8821-c205-717a-df0d-96ecfb0f75aa@kernel.dk>
 <20181205022716.GE17845@ming.t460p>
 <227a40a3-6599-9fc0-ab58-674f063e9c3a@kernel.dk>
 <20181205025801.GF17845@ming.t460p> <20181205030300.GG17845@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c49e301b-343c-17e8-5799-c80c5a6cac3e@kernel.dk>
Date:   Tue, 4 Dec 2018 20:05:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205030300.GG17845@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 8:03 PM, Ming Lei wrote:
> On Wed, Dec 05, 2018 at 10:58:02AM +0800, Ming Lei wrote:
>> On Tue, Dec 04, 2018 at 07:30:24PM -0700, Jens Axboe wrote:
>>> On 12/4/18 7:27 PM, Ming Lei wrote:
>>>> On Tue, Dec 04, 2018 at 07:16:11PM -0700, Jens Axboe wrote:
>>>>> On 12/4/18 6:37 PM, Ming Lei wrote:
>>>>>> On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
>>>>>>> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
>>>>>>> we queue the request up normally. However, the SCSI layer may have
>>>>>>> already setup SG tables etc for this particular command. If we later
>>>>>>> merge with this request, then the old tables are no longer valid. Once
>>>>>>> we issue the IO, we only read/write the original part of the request,
>>>>>>> not the new state of it.
>>>>>>>
>>>>>>> This causes data corruption, and is most often noticed with the file
>>>>>>> system complaining about the just read data being invalid:
>>>>>>>
>>>>>>> [  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)
>>>>>>>
>>>>>>> because most of it is garbage...
>>>>>>>
>>>>>>> This doesn't happen from the normal issue path, as we will simply defer
>>>>>>> the request to the hardware queue dispatch list if we fail. Once it's on
>>>>>>> the dispatch list, we never merge with it.
>>>>>>>
>>>>>>> Fix this from the direct issue path by flagging the request as
>>>>>>> REQ_NOMERGE so we don't change the size of it before issue.
>>>>>>>
>>>>>>> See also:
>>>>>>>   https://bugzilla.kernel.org/show_bug.cgi?id=201685
>>>>>>>
>>>>>>> Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>>>
>>>>>>> ---
>>>>>>>
>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>>>> index 3f91c6e5b17a..d8f518c6ea38 100644
>>>>>>> --- a/block/blk-mq.c
>>>>>>> +++ b/block/blk-mq.c
>>>>>>> @@ -1715,6 +1715,15 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>>>>>>>  		break;
>>>>>>>  	case BLK_STS_RESOURCE:
>>>>>>>  	case BLK_STS_DEV_RESOURCE:
>>>>>>> +		/*
>>>>>>> +		 * If direct dispatch fails, we cannot allow any merging on
>>>>>>> +		 * this IO. Drivers (like SCSI) may have set up permanent state
>>>>>>> +		 * for this request, like SG tables and mappings, and if we
>>>>>>> +		 * merge to it later on then we'll still only do IO to the
>>>>>>> +		 * original part.
>>>>>>> +		 */
>>>>>>> +		rq->cmd_flags |= REQ_NOMERGE;
>>>>>>> +
>>>>>>>  		blk_mq_update_dispatch_busy(hctx, true);
>>>>>>>  		__blk_mq_requeue_request(rq);
>>>>>>>  		break;
>>>>>>>
>>>>>>
>>>>>> Not sure it is enough to just mark it as NOMERGE, for example, driver
>>>>>> may have setup the .special_vec for discard, and NOMERGE may not prevent
>>>>>> request from entering elevator queue completely. Cause 'rq.rb_node' and
>>>>>> 'rq.special_vec' share same space.
>>>>>
>>>>> We should rather limit the scope of the direct dispatch instead. It
>>>>> doesn't make sense to do for anything but read/write anyway.
>>>>
>>>> discard is kind of write, and it isn't treated very specially in make
>>>> request path, except for multi-range discard.
>>>
>>> The point of direct dispatch is to reduce latencies for requests,
>>> discards are so damn slow on ALL devices anyway that it doesn't make any
>>> sense to try direct dispatch to begin with, regardless of whether it
>>> possible or not.
>>
>> SCSI MQ device may benefit from direct dispatch from reduced lock contention.
>>
>>>
>>>>>> So how about inserting this request via blk_mq_request_bypass_insert()
>>>>>> in case that direct issue returns BUSY? Then it is invariant that
>>>>>> any request queued via .queue_rq() won't enter scheduler queue.
>>>>>
>>>>> I did consider this, but I didn't want to experiment with exercising
>>>>> a new path for an important bug fix. You do realize that your original
>>>>> patch has been corrupting data for months? I think a little caution
>>>>> is in order here.
>>>>
>>>> But marking NOMERGE still may have a hole on re-insert discard request as
>>>> mentioned above.
>>>
>>> What I said was further limit the scope of direct dispatch, which means
>>> not allowing anything that isn't a read/write.
>>
>> IMO, the conservative approach is to take the one used in legacy io
>> path, in which it is never allowed to re-insert queued request to
>> scheduler queue except for requeue, however RQF_DONTPREP is cleared
>> before requeuing request to scheduler.
>>
>>>
>>>> Given we never allow to re-insert queued request to scheduler queue
>>>> except for 6ce3dd6eec1, I think it is the correct thing to do, and the
>>>> fix is simple too.
>>>
>>> As I said, it's not the time to experiment. This issue has been there
>>> since 4.19-rc1. The alternative is yanking both those patches, and then
>>> looking at it later when the direct issue path has been cleaned up
>>> first.
>>
>> The issue should have been there from v4.1, especially after commit
>> f984df1f0f7 ("blk-mq: do limited block plug for multiple queue case"),
>> which is the 1st one to re-insert the queued request into scheduler
>> queue.
> 
> But at that time, there isn't io scheduler for MQ, so in theory the
> issue should be there since v4.11, especially 945ffb60c11d ("mq-deadline:
> add blk-mq adaptation of the deadline IO scheduler").

Ming, I'm getting really tired of this. As mentioned in the other email,
we're not having a theoretical or hypothetical debate here. The facts
are on the table, there's no point in trying to shift blame. We need
to deal with the current situation.

-- 
Jens Axboe


Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE38C282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145782073D
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wkcz3TOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfBKP2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:28:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56266 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389927AbfBKP2t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 10:28:49 -0500
Received: by mail-it1-f196.google.com with SMTP id f18so16180253itb.5
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KjMR8soKTss3sa7GeNZH82KYT/+U70YI2CqoGZ+zpFo=;
        b=wkcz3TOwWFgXj1RwA8vh7YtdFZCXr/uROsJsOXMfhMIQbYjNgl1lzmNZOEqNzNrdqC
         2zIlrthA8tQvkpcza1lbC0e+oN63YsSJ+0ZqnzeVaLWLfvcxyHpSBvRneH9txXnt5gn4
         KK+FKdO+5gxUEjvnkrsQB7aglmSECbe/g2VM3oherXZFTUtZXpLn2YWv9KhXT4X8/J7A
         sB/sCXg4khjM8qSft7lIxJTtnaHh55A+OyqS6wbxxwz7IDv8qqQFbZKyeJBhmreRUSMC
         QK2B0WFDbDTjo2WPC4hBKpcxobkV9l3OHFw/EneTnWSWXLi50mVUgfu7VlrQeLUSNhmC
         2Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KjMR8soKTss3sa7GeNZH82KYT/+U70YI2CqoGZ+zpFo=;
        b=JG2HWX0XFmSAfdjSaDl4zqa74ljLEi4FaOa+CVL/vHNHd9WHew0WD5UwPuEH+f8f7Z
         QE1DBQu6S0kH/vJQuLrTC/X/6iJW8wtoSjcWkx9sSSwgEdSCdjXoycnJlUEYk0364yjA
         0rcsuE/m4pmtmCT5u9M+SMoXO8lHLnhFXQDaKEXoWgsz5mrS6syUrhOiT74ED47E27/C
         qhpiJ6aw0YZ9U9XjptyFaR9e6yOg8pl5+gz3u2t2gwrcColR74J/upLRK3BvPTp2BAw+
         efrdfkZyLCinrahui00UOu7/V9l6UpKePVHma9VWxLXv2DwkOcovDzWUePdKbxMCLYtN
         sKGQ==
X-Gm-Message-State: AHQUAubmJxBQcsiJ45JgwS3R59hGLTPBdv1bLrK1YLJ72f5sHwNFWpmH
        yzXLAHdeKmzTFRTFTb1MiRSvjw==
X-Google-Smtp-Source: AHgI3IZA+CLO+vQQPlmwPRdPeN4IsLQdh9EGvXSB+j55qm7K90P2wzQRsi1pJeFUCVK/mVZK9mYc6A==
X-Received: by 2002:a24:2f08:: with SMTP id j8mr48657itj.42.1549898928526;
        Mon, 11 Feb 2019 07:28:48 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f204sm1244830itf.3.2019.02.11.07.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:28:47 -0800 (PST)
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
 <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com>
 <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
 <1549815924.4142.8.camel@HansenPartnership.com>
 <0e6e5d67-d305-dd00-2e42-e2299166c8b2@kernel.dk>
 <1549898730.2831.6.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
Date:   Mon, 11 Feb 2019 08:28:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549898730.2831.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 8:25 AM, James Bottomley wrote:
> On Sun, 2019-02-10 at 09:35 -0700, Jens Axboe wrote:
>> On 2/10/19 9:25 AM, James Bottomley wrote:
>>> On Sun, 2019-02-10 at 09:05 -0700, Jens Axboe wrote:
>>>> On 2/10/19 8:44 AM, James Bottomley wrote:
>>>>> On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
>>>>>> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
>>>>>> <James.Bottomley@hansenpartnership.com> wrote:
>>>>>
>>>>> [...]
>>>>>>> I think the reason for this is that the block mq path
>>>>>>> doesn't feed the kernel entropy pool correctly, hence the
>>>>>>> need to install an entropy gatherer for systems that don't
>>>>>>> have other good random number sources.
>>>>>>
>>>>>> That does sound plausible, I admit I didn't even consider the
>>>>>> possibility that the old block I/O path also was an entropy
>>>>>> source.
>>>>>
>>>>> In theory, the new one should be as well since the rotational
>>>>> entropy collector is on the SCSI completion path.   I'd seen
>>>>> the same problem but had assumed it was something someone had
>>>>> done to our internal entropy pool and thus hadn't bisected it.
>>>>
>>>> The difference is that the old stack included ADD_RANDOM by
>>>> default, so this check:
>>>>
>>>> 	if (blk_queue_add_random(q))
>>>> 		add_disk_randomness(req->rq_disk);
>>>>
>>>> in scsi_end_request() would be true, and we'd add the randomness.
>>>> For sd, it seems to set it just fine for non-rotational drives.
>>>> Could this be because other devices don't? Maybe the below makes
>>>> a difference.
>>>
>>> No, in both we set it per the rotational parameters of the disk in 
>>>
>>> sd.c:sd_read_block_characteristics()
>>>
>>> 	rot = get_unaligned_be16(&buffer[4]);
>>>
>>> 	if (rot == 1) {
>>> 	
>>> 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>>> 	
>>> 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
>>> 	} else {
>>> 	
>>> 	blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
>>> 	
>>> 	blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
>>> 	}
>>>
>>>
>>> That check wasn't changed by the code removal.
>>
>> As I said above, for sd. This isn't true for non-disks.
> 
> Yes, but the behaviour above doesn't change across a switch to MQ, so I
> don't quite understand how it bisects back to that change.  If we're
> not gathering entropy for the device now, we wouldn't have been before
> the switch, so the entropy characteristics shouldn't have changed.

But it does, as I also wrote in that first email. The legacy queue
flags had QUEUE_FLAG_ADD_RANDOM set by default, the MQ ones do not.
Hence any non-sd device would previously ALWAYS have ADD_RANDOM
set, now none of them do. Also see the patch I sent.

>>> Although I suspect it should be unconditional: even SSDs have what
>>> would appear as seek latencies at least during writes depending on
>>> the time taken to find an erased block or even trigger garbage
>>> collection.  The entropy collector is good at taking something
>>> completely regular and spotting the inconsistencies, so it won't
>>> matter that loads of "seeks" are deterministic.
>>
>> The reason it isn't is that it's of limited use for SSDs where it's a
>> lot more predictable. And they are also a lot faster, which means the
>> adding randomness is more problematic from an efficiency pov.
> 
> But that's my point: our entropy extractor is good at weeding out
> predictable signals.  Fine, it won't extract any entropy if the disk
> seek time is entirely regular, but it won't contaminate the entropy
> pool.  The computational delay, I grant ... it takes a while to
> determine if any entropy is present in the signal.

But you are missing my point - if we're mostly weeding out predictable
signals, then it's pointless to take the overhead of the randomness.
This is why the MQ flag don't include it by default.

> What about feeding it with something like discard timings, which should
> be much less predictable.

That's not true, lots of devices have VERY predictable discard timings.
Most of them will have a fixed discards-per-second rate, even.

-- 
Jens Axboe


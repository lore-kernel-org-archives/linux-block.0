Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB6C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D22520863
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rbubk3Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfBLCud (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:50:33 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:34627 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLCud (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 21:50:33 -0500
Received: by mail-pg1-f178.google.com with SMTP id i130so267685pgd.1
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 18:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4hktLvRrYNBAIK5RvKt0ooP5Z2boEovdPPoa2tGx3BY=;
        b=rbubk3KdIMO91/3BKlq9NkDgoIMTno7c+Chy0O1pwH6lNKMhbw1YId7jl7YDYAUtXE
         eCdf+umqUFQsboiMY4S0CZY1rKvtYFPeL/NpfBuCyXr87/8rqTOZjFQTBsMFT7fDoeav
         lbBbSJrKG/vLeGHIdG+8LVPz4J9BESBo5CG7A3E9oirZGQ3ACD1ookWK0h+mvEHlMEs1
         r+mGBkPxUP8xDY95Of5VO1KMRlHRYbQ+qSwEv28PtSqdSBy70WFwbJGE89DotS7REFkO
         muhsNKYZFUBO1G379KO5DAS4WgXHAGjob8y7lth4FF+yg4zg1QorawRiEgQZkfuPOnTf
         0fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4hktLvRrYNBAIK5RvKt0ooP5Z2boEovdPPoa2tGx3BY=;
        b=qE0mjM3yvVKPXAasZ3QzLap1Jy0ufJ6fn9ybES/BuPktjPFeFIZKj5m74zM72kRUNm
         NVBAM9xl+DchSSM/HrDroNGPltJiuLDZizP8z0wWzHBjtNkBDLR8AKUnuT4VvriiKQh7
         5uTh+jS7ICniQM6ziTEomMMwT3vQ8sRnZystvohIFGc4q+2krE9E3EATjUiEOqOeqDm3
         rNc2gHhGeYFqpux1k4JJTIODh3/1upEwSUMp5RANEdhSmho48pOCxLNg04oh5V79u0uQ
         W8fuiDD69LvI3sOiPLdGu3N67E9/Bmnyh7zeNjLNn5ZqBPYLorfKRJgFP6BawcrbRZEs
         Mt8Q==
X-Gm-Message-State: AHQUAua7bN5iCklvqn9LnxwUcYjmlOUaZLe0Pf8U2DrhX01yNlU5Sz2D
        FFytwugmaCNrqckSKc2wh6Re6Q==
X-Google-Smtp-Source: AHgI3IYkf/JlCJ3EKvo6KziICHXbVFoyt0+4gJq+eCit6N8r9yvm99STMDKCo8hnlfMn2k+g5NBi5g==
X-Received: by 2002:a63:535c:: with SMTP id t28mr1546084pgl.128.1549939832350;
        Mon, 11 Feb 2019 18:50:32 -0800 (PST)
Received: from ?IPv6:2600:380:4a5b:8858:a8b3:edff:f3de:ccc1? ([2600:380:4a5b:8858:a8b3:edff:f3de:ccc1])
        by smtp.gmail.com with ESMTPSA id r12sm12995051pgv.83.2019.02.11.18.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 18:50:31 -0800 (PST)
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
 <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com>
 <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
 <1549815924.4142.8.camel@HansenPartnership.com>
 <0e6e5d67-d305-dd00-2e42-e2299166c8b2@kernel.dk>
 <1549898730.2831.6.camel@HansenPartnership.com>
 <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
 <1549899773.2831.12.camel@HansenPartnership.com>
 <1a00da0e-cb8e-30ea-8d17-120f97242b2f@kernel.dk>
 <1549902521.2831.23.camel@HansenPartnership.com>
 <fce66227-ff41-3a4e-4c6a-f4c2ca492b95@kernel.dk>
 <1549937598.2857.8.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fc547d40-9a42-a823-b62f-460c3244fe7d@kernel.dk>
Date:   Mon, 11 Feb 2019 19:50:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549937598.2857.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 7:13 PM, James Bottomley wrote:
> On Mon, 2019-02-11 at 09:31 -0700, Jens Axboe wrote:
>> On 2/11/19 9:28 AM, James Bottomley wrote:
>>> On Mon, 2019-02-11 at 08:46 -0700, Jens Axboe wrote:
>>>> On 2/11/19 8:42 AM, James Bottomley wrote:
>>>>> On Mon, 2019-02-11 at 08:28 -0700, Jens Axboe wrote:
>>>>>> On 2/11/19 8:25 AM, James Bottomley wrote:
>>>>>>> On Sun, 2019-02-10 at 09:35 -0700, Jens Axboe wrote:
>>>>>>>> On 2/10/19 9:25 AM, James Bottomley wrote:
>>>
>>> [...]
>>>>>>>>> That check wasn't changed by the code removal.
>>>>>>>>
>>>>>>>> As I said above, for sd. This isn't true for non-disks.
>>>>>>>
>>>>>>> Yes, but the behaviour above doesn't change across a switch
>>>>>>> to MQ, so I don't quite understand how it bisects back to
>>>>>>> that change.  If we're not gathering entropy for the device
>>>>>>> now, we wouldn't have been before the switch, so the
>>>>>>> entropy characteristics shouldn't have changed.
>>>>>>
>>>>>> But it does, as I also wrote in that first email. The legacy
>>>>>> queue flags had QUEUE_FLAG_ADD_RANDOM set by default, the MQ
>>>>>> ones do not. Hence any non-sd device would previously ALWAYS
>>>>>> have ADD_RANDOM set, now none of them do. Also see the patch
>>>>>> I sent.
>>>>>
>>>>> So your theory is that the disk in question never gets to the
>>>>> rotational check?  because the check will clear the flag if
>>>>> it's non-rotational and set it if it's not, so the default
>>>>> state of the flag shouldn't matter.
>>>>
>>>> No, my point is about non-disks, devices that aren't driven by
>>>> sd. The behavior for sd hasn't changed, as it sets/clears it
>>>> unconditionally. 
>>>
>>> I agree, but I don't think any of them were significant entropy
>>> contributors before: things like nvme have always been outside of
>>> this and sr and st don't really contribute much to the seek load
>>> during boot because they're probed but not used by the boot
>>> sequence, so I can't see how they would cause this behaviour.  I
>>> suppose it could be target probing, but even that seems unlikely
>>> because it should be dwarfed by the number of root disk reads
>>> during boot.
>>>
>>> For the rng to take an additional 5 minutes to initialize, we must
>>> have lost a significant entropy source somewhere.
>>
>> I agree it's not a significant amount of entropy, but even just one
>> bit could mean a long stall if that put us over the edge of just not
>> having enough for whatever is blocking on /dev/random. Mikael's boot
>> did have a CDROM, it's not impossible that the handful of commands we
>> end up doing to that device would have contributed enough entropy to
>> get the boot done without stalling for minutes.
>>
>> One way to know for sure, and that's if Mikael tests the patch.
> 
> I think I've got the root cause.  I have one system in my test bed
> exhibiting this behaviour.  It turns out the disk in it has no
> characteristics VPD page.  The 0xB1 VPD was a SBC-3 addition, so that's
> not surprising.  However, the characteristics check bails before
> setting the flags, so it takes the default flag which has flipped.
> 
> We can either fix this by setting the QUEUE_FLAG_ADD_RANDOM if there's
> no 0xB1 page or by setting the default as Jens proposed.

I'd recommend just doing my patch, since that'll be the same behavior
that SCSI had before.

-- 
Jens Axboe


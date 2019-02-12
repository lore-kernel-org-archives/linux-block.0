Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C4EC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF43220836
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p82WIHKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfBLP1X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:27:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36174 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbfBLP1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 10:27:17 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so8469772itj.1
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 07:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tYslnKNsUDD5Oft6/8e3KxuwAAhtlSneejSnOF3//LE=;
        b=p82WIHKzdicReH7Q9m3Vw6PG1y+7laTHYPT/dsFLqO5ilzqcbPgJ1WqYiY5EVEmxDR
         f3DNZLl/SS/ZQhFKPp3vvVoC8zdO5YBsmRF2YsmlWipeXjp1iLC1V9V0MXyiI3MIvrwQ
         4b9pce8F9Rx9DL6dLGyK5ZZ8sBKPaUV/pP4hqs8I6uxSi7Kfhn3gOotf23+KzG7AJoC1
         t9CI9rULLHpGG8F4RNZG2y6nCmWrS8PP2QnLqM2ae96pEgSd6ysJrbv7k3SQ0tLSoWhq
         /s+Q86tLQ77b11l0pLBQd6gmuVY7+xiD27fxLCnF6oydRo7t1aLzdI2vIeRf/ao8Ce4Z
         RDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tYslnKNsUDD5Oft6/8e3KxuwAAhtlSneejSnOF3//LE=;
        b=iixPjV2nif0axY1HCVsBRISVoVVb4WFxXi65xsx/lO5i3M4VVMU8C9Ydq/coTOueRp
         X9DnfBnwVh4N/Ii9ewNUMIVPvASC3or+w0DKxpZJCbxLUBNaAswdLJJUBwtVlemN9aX1
         PlL1p9EVcLT2o6W3pFcgFLb8+9S2dwbjF8Y/OWlBusN2UsXnVlTbKJ5sLc6KXbaykUCZ
         SLlAWGiRK87JipT4Evmvc2ux3SaBpeBxo4nxU3dwR5L9Mz0FkdRLERVe8gxW8hlih4SQ
         nIhRHrkFDpJjNiUCRzjy7+6Gv1st9bAkoQsJCeeFufutqJXrFuAjiBnSQiuZ9nIKrdjP
         LqmQ==
X-Gm-Message-State: AHQUAuYcKY4U5Mivs/kekDb7o4sAcjPql6ss+IlhO+e3HNNQipyStfs7
        9eThoI7FH5tzbkBEcK/cwtSKdkhCGFA1Fg==
X-Google-Smtp-Source: AHgI3IaffUZdt3s56vNZPmKeQJvgKTtkT3onrBUn8L7EE+iey1PMFUXc2u8O8I4WuCFshN+aKumg7A==
X-Received: by 2002:a5d:85cd:: with SMTP id e13mr2501634ios.46.1549985235823;
        Tue, 12 Feb 2019 07:27:15 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q3sm1489560itb.34.2019.02.12.07.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 07:27:14 -0800 (PST)
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Xuewei Zhang <xueweiz@google.com>
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
 <fc547d40-9a42-a823-b62f-460c3244fe7d@kernel.dk>
 <1549985049.3173.3.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02383850-f55c-ad14-ffb4-e9f987ebe986@kernel.dk>
Date:   Tue, 12 Feb 2019 08:27:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549985049.3173.3.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/19 8:24 AM, James Bottomley wrote:
> On Mon, 2019-02-11 at 19:50 -0700, Jens Axboe wrote:
>> On 2/11/19 7:13 PM, James Bottomley wrote:
>>> On Mon, 2019-02-11 at 09:31 -0700, Jens Axboe wrote:
>>>> On 2/11/19 9:28 AM, James Bottomley wrote:
>>>>> On Mon, 2019-02-11 at 08:46 -0700, Jens Axboe wrote:
>>>>>> On 2/11/19 8:42 AM, James Bottomley wrote:
>>>>>>> On Mon, 2019-02-11 at 08:28 -0700, Jens Axboe wrote:
>>>>>>>> On 2/11/19 8:25 AM, James Bottomley wrote:
>>>>>>>>> On Sun, 2019-02-10 at 09:35 -0700, Jens Axboe wrote:
>>>>>>>>>> On 2/10/19 9:25 AM, James Bottomley wrote:
>>>>>
>>>>> [...]
>>>>>>>>>>> That check wasn't changed by the code removal.
>>>>>>>>>>
>>>>>>>>>> As I said above, for sd. This isn't true for non-
>>>>>>>>>> disks.
>>>>>>>>>
>>>>>>>>> Yes, but the behaviour above doesn't change across a
>>>>>>>>> switch
>>>>>>>>> to MQ, so I don't quite understand how it bisects back
>>>>>>>>> to
>>>>>>>>> that change.  If we're not gathering entropy for the
>>>>>>>>> device
>>>>>>>>> now, we wouldn't have been before the switch, so the
>>>>>>>>> entropy characteristics shouldn't have changed.
>>>>>>>>
>>>>>>>> But it does, as I also wrote in that first email. The
>>>>>>>> legacy
>>>>>>>> queue flags had QUEUE_FLAG_ADD_RANDOM set by default, the
>>>>>>>> MQ
>>>>>>>> ones do not. Hence any non-sd device would previously
>>>>>>>> ALWAYS
>>>>>>>> have ADD_RANDOM set, now none of them do. Also see the
>>>>>>>> patch
>>>>>>>> I sent.
>>>>>>>
>>>>>>> So your theory is that the disk in question never gets to
>>>>>>> the
>>>>>>> rotational check?  because the check will clear the flag if
>>>>>>> it's non-rotational and set it if it's not, so the default
>>>>>>> state of the flag shouldn't matter.
>>>>>>
>>>>>> No, my point is about non-disks, devices that aren't driven
>>>>>> by
>>>>>> sd. The behavior for sd hasn't changed, as it sets/clears it
>>>>>> unconditionally. 
>>>>>
>>>>> I agree, but I don't think any of them were significant entropy
>>>>> contributors before: things like nvme have always been outside
>>>>> of
>>>>> this and sr and st don't really contribute much to the seek
>>>>> load
>>>>> during boot because they're probed but not used by the boot
>>>>> sequence, so I can't see how they would cause this
>>>>> behaviour.  I
>>>>> suppose it could be target probing, but even that seems
>>>>> unlikely
>>>>> because it should be dwarfed by the number of root disk reads
>>>>> during boot.
>>>>>
>>>>> For the rng to take an additional 5 minutes to initialize, we
>>>>> must
>>>>> have lost a significant entropy source somewhere.
>>>>
>>>> I agree it's not a significant amount of entropy, but even just
>>>> one
>>>> bit could mean a long stall if that put us over the edge of just
>>>> not
>>>> having enough for whatever is blocking on /dev/random. Mikael's
>>>> boot
>>>> did have a CDROM, it's not impossible that the handful of
>>>> commands we
>>>> end up doing to that device would have contributed enough entropy
>>>> to
>>>> get the boot done without stalling for minutes.
>>>>
>>>> One way to know for sure, and that's if Mikael tests the patch.
>>>
>>> I think I've got the root cause.  I have one system in my test bed
>>> exhibiting this behaviour.  It turns out the disk in it has no
>>> characteristics VPD page.  The 0xB1 VPD was a SBC-3 addition, so
>>> that's
>>> not surprising.  However, the characteristics check bails before
>>> setting the flags, so it takes the default flag which has flipped.
>>>
>>> We can either fix this by setting the QUEUE_FLAG_ADD_RANDOM if
>>> there's
>>> no 0xB1 page or by setting the default as Jens proposed.
>>
>> I'd recommend just doing my patch, since that'll be the same behavior
>> that SCSI had before.
> 
> I've got the history now, it's this patch
> 
> Author: Xuewei Zhang <xueweiz@google.com>
> Date:   Thu Sep 6 13:37:19 2018 -0700
> 
>     scsi: sd: Contribute to randomness when running rotational device
> 
> It added the else branch to the if (rot == 1).  It's the position of
> that else branch which is wrong because not all disks have a SBC-3
> characteristics VPD page, so they're the ones under MQ which stop
> contributing entropy.  Whichever patch we go with will need a fixes:
> for this.

Ah, makes sense. I'd say we're _probably_ fine just fixing that then,
or at least it should be two separate patches.

-- 
Jens Axboe


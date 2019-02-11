Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBAC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962C221773
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 16:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o9ktg4Gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfBKQbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:31:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51910 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBKQbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 11:31:10 -0500
Received: by mail-it1-f195.google.com with SMTP id y184so21513730itc.1
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NB6mV9B8vcQ152ozOfFKlg62KKBFeup4CBAijLKW/ok=;
        b=o9ktg4Gs1pR2ot43fRr2uBAEWLSaH4mM7rwVLUvhTgPBdDb1CHqP9VJ3P9KjCWBNgQ
         0GYpdrwdSWoMMpooa1FTJbJz0RtlldwhXVwHCGGLIYxc3dmJSIvfMf7T7ol3d3ipwLl9
         J8hNW1dsE6yE3fIF8/kDVwYZl1h+PAIzkvYpH0NXz482bSM5X6C0ymDPBfLgDeE4zNSb
         1MW/EP5ggq+3baJo0YesVXofqgIVOwJvkiVX2vvKHGpcmXmRHawRY39zcquvz29cpX5U
         gToU55rh+jDx4r2aZyIDHASI04rooWIt6ncbifS+BbHh2KUq9R90B1Fj8l7OEyjMtEvf
         ckYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NB6mV9B8vcQ152ozOfFKlg62KKBFeup4CBAijLKW/ok=;
        b=KZ7Z+hb4HbbFx2V92P9ylD4oWibaIpKDOtdnNUUmUM5p2LO2xkfIoc37zsmEwORu3S
         ZAtZf2fuGmRe3qasTS4OvW3CYaRdXpzNqnen/YW4bbL+ugYvJj5fmAa+hpT7ksKBT+Jp
         xfGc/UVbzq/DQBK3uomEHxoGYpZ6wVLmd5GjIZwMkHMQYSvqmwAXoaAOYTEaf0kZp8Fp
         CyapW+sXArFLkvSVSBuUDhxVV3rkpbcIBy2ihdwnPcEdzKsE0GCbMze9OZpgg4L55MvH
         FGZeR2KKp8Jj95ePRK+wKNqyVZV2DF4vs6h1VcwFlt5kfRrTfop+4HPTwfdCnn/cdRLB
         Yj/Q==
X-Gm-Message-State: AHQUAuZkFfR1zpznZdogZrhOT8TRBzyk/HubT3mQvZ5I2ZLZZExC53+Q
        v3dw4GcTUPo/XLU847yjo0fT1Q==
X-Google-Smtp-Source: AHgI3IadP15Qd5ZG8A352PrfgFG/NRP+ZvGkasnxxN2HSL9LI06kWkOHzDR0uN2/wqPO6qA3KWrnNg==
X-Received: by 2002:a5e:8517:: with SMTP id i23mr19001527ioj.28.1549902670078;
        Mon, 11 Feb 2019 08:31:10 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 196sm5507266itu.33.2019.02.11.08.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 08:31:08 -0800 (PST)
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
 <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
 <1549899773.2831.12.camel@HansenPartnership.com>
 <1a00da0e-cb8e-30ea-8d17-120f97242b2f@kernel.dk>
 <1549902521.2831.23.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fce66227-ff41-3a4e-4c6a-f4c2ca492b95@kernel.dk>
Date:   Mon, 11 Feb 2019 09:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549902521.2831.23.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 9:28 AM, James Bottomley wrote:
> On Mon, 2019-02-11 at 08:46 -0700, Jens Axboe wrote:
>> On 2/11/19 8:42 AM, James Bottomley wrote:
>>> On Mon, 2019-02-11 at 08:28 -0700, Jens Axboe wrote:
>>>> On 2/11/19 8:25 AM, James Bottomley wrote:
>>>>> On Sun, 2019-02-10 at 09:35 -0700, Jens Axboe wrote:
>>>>>> On 2/10/19 9:25 AM, James Bottomley wrote:
> [...]
>>>>>>> That check wasn't changed by the code removal.
>>>>>>
>>>>>> As I said above, for sd. This isn't true for non-disks.
>>>>>
>>>>> Yes, but the behaviour above doesn't change across a switch to
>>>>> MQ, so I don't quite understand how it bisects back to that
>>>>> change.  If we're not gathering entropy for the device now, we
>>>>> wouldn't have been before the switch, so the entropy
>>>>> characteristics shouldn't have changed.
>>>>
>>>> But it does, as I also wrote in that first email. The legacy
>>>> queue flags had QUEUE_FLAG_ADD_RANDOM set by default, the MQ ones
>>>> do not. Hence any non-sd device would previously ALWAYS have
>>>> ADD_RANDOM set, now none of them do. Also see the patch I sent.
>>>
>>> So your theory is that the disk in question never gets to the
>>> rotational check?  because the check will clear the flag if it's
>>> non-rotational and set it if it's not, so the default state of the
>>> flag shouldn't matter.
>>
>> No, my point is about non-disks, devices that aren't driven by sd.
>> The behavior for sd hasn't changed, as it sets/clears it
>> unconditionally.
> 
> I agree, but I don't think any of them were significant entropy
> contributors before: things like nvme have always been outside of this
> and sr and st don't really contribute much to the seek load during boot
> because they're probed but not used by the boot sequence, so I can't
> see how they would cause this behaviour.  I suppose it could be target
> probing, but even that seems unlikely because it should be dwarfed by
> the number of root disk reads during boot.
> 
> For the rng to take an additional 5 minutes to initialize, we must have
> lost a significant entropy source somewhere.

I agree it's not a significant amount of entropy, but even just one bit
could mean a long stall if that put us over the edge of just not having
enough for whatever is blocking on /dev/random. Mikael's boot did have a
CDROM, it's not impossible that the handful of commands we end up doing
to that device would have contributed enough entropy to get the boot
done without stalling for minutes.

One way to know for sure, and that's if Mikael tests the patch.

-- 
Jens Axboe


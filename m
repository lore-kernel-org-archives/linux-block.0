Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B2CC433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 13:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiBCNrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 08:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBCNrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Feb 2022 08:47:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF3C061714
        for <linux-block@vger.kernel.org>; Thu,  3 Feb 2022 05:47:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p12-20020a17090a2d8c00b001b833dec394so3086449pjd.0
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4lH2VgPBXYRbIhRugnUOELNcQmdFJ96oasF65A9Co/Q=;
        b=4PvRoUTgpElxfl/Go44GA2aaNrScwzjhcWR99CInOd7e1l5EZj2NAPZZIURjbYZWzq
         JtR4InT15njGIPaeLn+76hBlX6Oj7FO5myCTILI5SEAI3/gIokoEiWOHaoJT6RNGDm96
         s2bh9qgnzvypbzsa9RP63SfDS1nnQubTIGSEnGf1vodzaMwigBHzudA4gjkp3N9XWzvy
         P8UQ5jLKH/idWYjzg8PayenbtEK3naZXT1nDMuqUMFNg5U1/LOK+E3dXKDGio2da+mkF
         INbaGB56lah1TXPk3PpUQB2mts4P/srDseppvn0Ndo9Y024IUTCmG2/xlEabHKBXz4ou
         fF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4lH2VgPBXYRbIhRugnUOELNcQmdFJ96oasF65A9Co/Q=;
        b=FRTLVqKEmdzaI3eGDwoi+ODD+bI2J86+IP0OTunOuPGSmCClYYNPJvviSnBfpSysX5
         vxaniOlnTJ3UiFq4NIfq9tEGbWbwlHnqEV4VrplVuj07NcgLoyYXdE5zvCLS9VK2YQt6
         VC5R+ZRgEBKlyPHuXVKI6MB4xHdpSCPzlG2kw3cjZ5vDYqKoVOiWnBEORqIUGO/3CTSV
         JVRAqVE7yiPiY+i/KSDwOy1qOI1MJiXKvr7Y3g+YjxevXYuByn29hBPP+JTCUanA4T3j
         wBLFN1wGCVulEWptI2n4DbsZRERsiQsh6ZtVAtf5qHVadWofYo/SCfcxEkb2gHdtLD7e
         F1RA==
X-Gm-Message-State: AOAM533LUi7nyOdfTK/WcwjkuRxq8An7y6Ri9kdvDGmUyLymyLyTOeYf
        XBLUxw6UDEwJTNyM8CnGamm1BLueRSHfeg==
X-Google-Smtp-Source: ABdhPJy4n/BftDa7LWNvKG9wfAOMBEYieimwvOR+N8ucNn6mXZkLOo/h1yGZrveoUe6eZYLz9PpZEQ==
X-Received: by 2002:a17:902:d50f:: with SMTP id b15mr1634677plg.54.1643896026771;
        Thu, 03 Feb 2022 05:47:06 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e3sm22669698pgc.41.2022.02.03.05.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 05:47:06 -0800 (PST)
Subject: Re: [PATCH 1/2] block: introduce BLK_STS_OFFLINE
To:     Hannes Reinecke <hare@suse.de>, Song Liu <song@kernel.org>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Kernel Team <kernel-team@fb.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20220203064009.1795344-1-song@kernel.org>
 <20220203064009.1795344-2-song@kernel.org>
 <CAPhsuW6PNaYUb5xDxPX_gX=2fZdiRURRos5sT_Tsbngon1+eKw@mail.gmail.com>
 <f7489746-b8fb-bc9a-a706-e5926fa9e325@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <27583256-dc7d-74bd-115c-b0c835cd5c1b@kernel.dk>
Date:   Thu, 3 Feb 2022 06:47:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f7489746-b8fb-bc9a-a706-e5926fa9e325@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/22 12:24 AM, Hannes Reinecke wrote:
> On 2/3/22 07:52, Song Liu wrote:
>> CC linux-block (it was a typo in the original email)
>>
>> On Wed, Feb 2, 2022 at 10:40 PM Song Liu <song@kernel.org> wrote:
>>>
>>> Currently, drivers reports BLK_STS_IOERR for devices that are not full
>>> online or being removed. This behavior could cause confusion for users,
>>> as they are not really I/O errors from the device.
>>>
>>> Solve this issue with a new state BLK_STS_OFFLINE, which reports "device
>>> offline error" in dmesg instead of "I/O error".
>>>
>>> Signed-off-by: Song Liu <song@kernel.org>
>>> ---
>>>   block/blk-core.c          | 1 +
>>>   include/linux/blk_types.h | 7 +++++++
>>>   2 files changed, 8 insertions(+)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 61f6a0dc4511..24035dd2eef1 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -164,6 +164,7 @@ static const struct {
>>>          [BLK_STS_RESOURCE]      = { -ENOMEM,    "kernel resource" },
>>>          [BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },
>>>          [BLK_STS_AGAIN]         = { -EAGAIN,    "nonblocking retry" },
>>> +       [BLK_STS_OFFLINE]       = { -EIO,       "device offline" },
>>>
>>>          /* device mapper special case, should not leak out: */
>>>          [BLK_STS_DM_REQUEUE]    = { -EREMCHG, "dm internal retry" },
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index fe065c394fff..5561e58d158a 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -153,6 +153,13 @@ typedef u8 __bitwise blk_status_t;
>>>    */
>>>   #define BLK_STS_ZONE_ACTIVE_RESOURCE   ((__force blk_status_t)16)
>>>
>>> +/*
>>> + * BLK_STS_OFFLINE is returned from the driver when the target device is offline
>>> + * or is being taken offline. This could help differentiate the case where a
>>> + * device is intentionally being shut down from a real I/O error.
>>> + */
>>> +#define BLK_STS_OFFLINE                ((__force blk_status_t)17)
>>> +
>>>   /**
>>>    * blk_path_error - returns true if error may be path related
>>>    * @error: status the request was completed with
>>> --
>>> 2.30.2
>>>
> Please do not overload EIO here.
> EIO already is a catch-all error if we don't know any better, but for 
> the 'device offline' case we do (or rather should).
> Please map it onto 'ENODEV' or 'ENXIO'.

It's deliberately EIO as not to force a change in behavior. I don't mind
using something else, but that should be a separate change then.

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0599DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 22:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiDRW1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRW1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 18:27:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0E2A24B
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:24:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k29so21352479pgm.12
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kojsscREKZDQxHv37eCuMkjqmEqNwB31BGScw3+Do8A=;
        b=W4nypCG5fmelFoWvZbIMxIoh7TG7bZdnnZFI9Wb8SFX3CrLfExSFe7W/gUmPfoWns9
         Whjk8Rf7RQWr3WAVQ8M8HK9K/dslbACFs6MNPyr7LapzYHIQ7yeAaP5AAg3x7IA4ks+I
         4IufxZkFZOtrpYP+Vre0YbFAbPCyU9i8IjPBeM24y98+iSu40HPV0HKJzNTKk4GsrYkt
         sZY6h4UBAIMUi9VP9pztnUjhC1ZAdfZRUA9xNsmPrsbfufQdD8/tXFxRFy8MT8tvD9KJ
         uUxBwUMoxD548JzvjNGPHSR9ECIjZ/PhyKMLofC5CL5Z/UF+9Rysz7ysT4hhFp7AyC02
         BA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kojsscREKZDQxHv37eCuMkjqmEqNwB31BGScw3+Do8A=;
        b=nqwj9DDheeMB3477BS0yWha1xOR35XCwNcwspm0+cwbjNZXeQ71n7lx4C57JPHkP3t
         J0aFNmX8BtW8jFr7+oFoclmzzP7tc/ZYNm+I7EYudWBH2M6+8shrW/Yd1THrGtZxKI8c
         F+O1R517Lw69oer5P0TV31zVHUHctjGGNpInPWQj7Qd6l0V0bod+aBPbEm0zZHRhFvsM
         8ukna5efH4h5u4qBJPXKeFaY8S0vVBTybQmIe3UR0bB/trP94bVvC0qnu4ecanOrE0W1
         fnzfqX96vf+gDj1iiKhLXC4/WI9aL1aK2Vg4ws4OSCOcIH6rD+NibNCaeHdVXxrT6VD/
         DHwQ==
X-Gm-Message-State: AOAM532Nap6iaFs1bHlfMuEAEmdaqcP44YajWZgxS6XGBOEdEMHTOjxD
        c04j90ktiWk1a2/8fgM89B25qA==
X-Google-Smtp-Source: ABdhPJykEs30sWt69Y6S3R0QTzBOVA+EOzgRvl8E8p5s3L77LjYIPKTCXYRgMsPxGIo4U0Vxcm61hQ==
X-Received: by 2002:a63:8f45:0:b0:398:d78:142f with SMTP id r5-20020a638f45000000b003980d78142fmr12138598pgn.162.1650320676180;
        Mon, 18 Apr 2022 15:24:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id md4-20020a17090b23c400b001cb66e3e1f8sm13985908pjb.0.2022.04.18.15.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:24:35 -0700 (PDT)
Message-ID: <bc93d84b-3c10-07ed-5203-9eba485fb108@kernel.dk>
Date:   Mon, 18 Apr 2022 16:24:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Nullblk configfs oddities
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
 <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
 <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk>
 <827699fb-e21b-2cad-6a6d-0a21c49f444e@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <827699fb-e21b-2cad-6a6d-0a21c49f444e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/22 4:21 PM, Chaitanya Kulkarni wrote:
> On 4/18/22 15:14, Jens Axboe wrote:
>> On 4/18/22 3:54 PM, Chaitanya Kulkarni wrote:
>>> On 4/18/22 14:38, Josef Bacik wrote:
>>>> Hello,
>>>>
>>>> I'm trying to add a test to fsperf and it requires the use of nullblk.  I'm
>>>> trying to use the configfs thing, and it's doing some odd things.  My basic
>>>> reproducer is
>>>>
>>>> modprobe null_blk
>>>> mkdir /sys/kernel/config/nullb/nullb0
>>>> echo some shit into the config
>>>> echo 1 > /sys/kernel/config/nullb/nullb0/power
>>>>
>>>> Now null_blk apparently defaults to nr_devices == 1, so it creates nullb0 on
>>>> modprobe.  But this doesn't show up in the configfs directory.  There's no way
>>>> to find this out until when I try to mkfs my nullb0 and it doesn't work.  The
>>>> above steps gets my device created at /dev/nullb1, but there's no actual way to
>>>> figure out that's what happened.  If I do something like
>>>> /sys/kernel/config/nullb/nullbfsperf I still just get nullb<number>, I don't get
>>>> my fancy name.
>>>>
>>>
>>> when you load module with default module parameter it will create a
>>> default device with no memory backed mode, that will not be visible in
>>> the configfs.
>>
>> Right, the problem is really that pre-configured devices (via nr_devices
>> being bigger than 0, which is the default) don't show up in configfs.
>> That, to me, is the real issue here, because it means you need to know
>> which ones are already setup before doing mkdir for a new one.
>>
>> On top of that, it's also odd that they don't show up there to begin
>> with.
>>
> 
> it is indeed confusing, maybe we need to find a way to populate the
> configfs when loading the module? but I'm not sure if that is
> the right approach since configs ideally should be populated by
> user.
> 
> OTOH we can make the memory_backed module param [1] so user can
> tentatively not use configfs and only rely on default configuration ?

Arguably configfs should just be disabled if loading with nr_devices
larger than 0, as it's a mess of an API as it stands. But probably too
late for that. The fact that we also have an option that's specific to
configfs just makes it even worse.

I don't know much about configfs, but pre-populating with the configured
devices and options would be ideal and completely solve this. I think
that would be the best solution given the current situation. Not that
it's THAT important, null_blk is a developer tool and as such can have
some sharper and rouger edges. Still would be nice to make it saner,
though.

-- 
Jens Axboe


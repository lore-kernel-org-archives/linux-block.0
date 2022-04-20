Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667FAC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 00:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiDTAUX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 20:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiDTAUV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 20:20:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7537F252A6
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:17:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j8so232241pll.11
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WDpj3ae9m2zaOqvU2jk+M6Cs2z1bbkNqfQNvgj+UK/8=;
        b=lsvPJoyVFY8bJ5zYnCFh22LBjxpdr3q83O9KrOlWUEzYYnyknAj60IXMM0pXTejA1y
         ZRCIfRRPSHndosX9uP7u4ZQx7G8Jc+Nwie1QQKX/HbBaSNAbTgWiGgVM5B1NHMd9CY6v
         6PUGhsBaz9LUf+KGuaFlzPUUoPE259v5/sOZ4PSUVUsB/90xHa6MpVN0op0nmBW76WCB
         pIRdOgz2YZBa0i0zJrdXw0PY0Y7A9Ur6LHjYgAlIM0g0Xx8fjJXsExi8SNYqOkHjvfKo
         YG4vyGlU+EqyTqeL4e6ISxv0RIA9S8Hvsoi40KWc4SWjY2UtdSajqgKZkm4qW4fGM2EB
         mFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WDpj3ae9m2zaOqvU2jk+M6Cs2z1bbkNqfQNvgj+UK/8=;
        b=IM6iJ2yh5JpgbuW3Y6LoPVwlGXVs0vki3hBXV0wt8U4PXHHF0s3l6YkN3JcdYyzUKr
         bvJRyzdAWWImXVAEMMipA+8p/g0PWF8lVKAN5CbADz/xBpwSZTDlY/OAJX/oTR/UWlj9
         qkeVWPKZE2qx8BofPfeYGcy1SnioJ/9QQXGLGe4gMVKTQoqW6Ipn1rAh6ZTUjoa6URR+
         tnvayY7jiZ2G7SIta41J/A7TT15MG+uOeysuiSo50lIMz4GhSiwyN4aZlscIzL+gqFWD
         iQLBstgY8MOhg+edJoIIIvhWehb6vXB7HMyZ2mYMv7HqlS/gZQhG7TkwPCmdgfyHNHc3
         hO0g==
X-Gm-Message-State: AOAM530gidPocveSEIVoT8VP65ZTKRuxNiwAXu6OyLBJQ3v4ZLJJykh3
        KzdeCf1wvnyiETllRBk6airZNw==
X-Google-Smtp-Source: ABdhPJy9R1sRY2L5ceEfryJOmVp9UvR4LWVNjdAENAWVaVfIvAtJW29O8HC2f6bmC62Xodv7rUcVdQ==
X-Received: by 2002:a17:902:ea08:b0:158:f881:8f9a with SMTP id s8-20020a170902ea0800b00158f8818f9amr12926767plg.79.1650413856862;
        Tue, 19 Apr 2022 17:17:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm18922930pfc.111.2022.04.19.17.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 17:17:36 -0700 (PDT)
Message-ID: <82e7beea-1ce9-7bec-5d75-577614564bca@kernel.dk>
Date:   Tue, 19 Apr 2022 18:17:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] block: null_blk: Improve device creation with
 configfs
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
 <20220419110038.3728406-5-damien.lemoal@opensource.wdc.com>
 <03583c5a-00fb-a6a0-9021-592f61c17d91@kernel.dk>
 <c25455bf-a929-95cb-41f8-c8ee4f6b0d62@opensource.wdc.com>
 <b752fcdd-9be4-549c-39b2-9c1034a97a39@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b752fcdd-9be4-549c-39b2-9c1034a97a39@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/22 5:13 PM, Damien Le Moal wrote:
> On 4/20/22 05:58, Damien Le Moal wrote:
>> On 4/19/22 20:55, Jens Axboe wrote:
>>> On 4/19/22 5:00 AM, Damien Le Moal wrote:
>>>> Currently, the directory name used to create a nullb device through
>>>> sysfs is not used as the device name, potentially causing headaches for
>>>> users if devices are already created through the modprobe operation
>>>> withe the nr_device module parameter not set to 0. E.g. a user can do
>>>> "mkdir /sys/kernel/config/nullb/nullb0" to create a nullb device while
>>>> /dev/nullb0 wasalready created from modprobe. In this case, the configfs
>>>                 ^^^
>>>
>>> space
>>
>> Re-sending to fix this. Also realized that using "#define pr_fmt" would
>> simplify patch 3. Updating that.
>>
>>>
>>>> nullb device will be named nullb1, causing confusion for the user.
>>>>
>>>> Simplify this by using the configfs directory name as the nullb device
>>>> name, always, unless another nullb device is already using the same
>>>> name. E.g. if modprobe created nullb0, then:
>>>>
>>>> $ mkdir /sys/kernel/config/nullb/nullb0
>>>> mkdir: cannot create directory '/sys/kernel/config/nullb/nullb0': File
>>>> exists
>>>>
>>>> will be reported to th user.
>>>>
>>>> To implement this, the function null_find_dev_by_name() is added to
>>>> check for the existence of a nullb device with the name used for a new
>>>> configfs device directory. nullb_group_make_item() uses this new
>>>> function to check if the directory name can be used as the disk name.
>>>> Finally, null_add_dev() is modified to use the device config item name
>>>> as the disk name for new nullb device, for devices created using
>>>> configfs. The naming of devices created though modprobe remains
>>>> unchanged.
>>>>
>>>> Of note is that it is possible for a user to create through configfs a
>>>> nullb device with the same name as an existing device. E.g.
>>>
>>> This is nice, and solves both the confusing part of having
>>> pre-configured devices, but also using the actual directory name as the
>>> device name even if they are not ordered.
>>>
>>> Only odd bit is you can create a device name where a special file of
>>> that name already exists, but I don't think that's solvable in a clean
>>> way and we just need to ignore that. That's arguably a user error, don't
>>> pick names that already exist.
>>
>> Yes. add_disk() will fail if the device name already exist within the
>> "block" device class, but will not complain about anything if the existing
>> device belongs to another class.
>>
>> I could add a "block" class wide check for device name existence in
>> null_find_dev_by_name() instead of only checking the nullb list ?
> 
> Looked into this, but I do not see any easy ready-to-use way to do it
> since "struct class block_class" is not exported. And I would not wnat
> to export this block/dev internal symbol.
> 
> We could play with vfs_stat() to test for device existence, but that
> is a little ugly...

Eek no, let's not go that far!

> What about simply enforcing a name pattern like "nullb*" for the
> configfs directory/device names ? That is simple and the current
> nullb_find_dev_by_name() will keep working as is.

That might break existing use cases. I say just leave it alone. If you
pick a name that already exists in /dev, then too bad for you.

What I cared most about fixing here was situation of having an empty
directory and being able to mkdir nullb0 when that was already assigned.
And that's fixed with your patches.

-- 
Jens Axboe


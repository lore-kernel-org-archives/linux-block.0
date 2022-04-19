Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76016C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 11:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiDSL6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351967AbiDSL6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 07:58:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09B513D15
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:55:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id u2so23266694pgq.10
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2kBWKFYHtFn2qqqc/JEGIt21uQwlSXyfvn4fX90vPBE=;
        b=FbKUPdyKRBBRYLl95007pxP1QH4ZutWyTQM0Ejc/8XeNN2uWBF9aFBKh6OUzW2U78a
         Dj1uGOhDodnjlt7BWxK/3fa5gsS+HKV95+Nn0FbvArwVTgwzGMR+ddghONW6U7vp3wbl
         XHwHmcNk3cT+kxcOLCcpbUjm3KifW327ytU8FBGtXCztyQ1jtnGUVGm9186OMASNdNX6
         4mkhZu+8rsGCvSJqW7uMiWWRB3MZwrGH8ywoesX/laRp8AeCwyqgZaSkFDrflGxcIY3d
         5nk8YY9hmjNUPoCxUAfLSsBnazFjtFFKv5cMI8Wq3l7Rj7JtAGCRXFmCTOgM4gzmCpse
         diVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2kBWKFYHtFn2qqqc/JEGIt21uQwlSXyfvn4fX90vPBE=;
        b=shnG8xTkVb7+H4/ehVeHjpwc5BZVduhwSvDfnlHk1TBIRi75zf19SlwiSO3akIJdPg
         CSvtGB3kER7kDiZuKNaygELNQmIiApj2f1wzuGWfsMFmMKaY1CTmzVLRbSWyoJT/0lGv
         Tzfv80qX9oFTpa9yGkU889g1YUVv1bYJ6xNY70ut3gAL5sAlcnA53fa5oSxxlHlKjKYc
         E3ktGQ3z2LxShYEuiM17yGngS9XGwowRkPK1iMTOrheelE4dIYb7zYZCB3UdrWL6s0eG
         18vRtsgXh76TvEn1U1Qy8JQNZCMfF5AxBQuiTYbAUgO8hKMWHnt6X+BHQ39E9nUPaOvP
         TNaA==
X-Gm-Message-State: AOAM533q7zl7+60LjZx3WPU3s0IejmZB444kUB9tcns7v3uSYkTmBWcW
        GYdHw201NUWWg5dptqxLrKaFP6QNKPdfubpQ
X-Google-Smtp-Source: ABdhPJymfHmCDcnj6Qd99yRaIuyCXiFUC0WT9DGE42LFWTonE/ehcJlJhkvmVSwIZEzrGbdsNFnTEQ==
X-Received: by 2002:a63:f04b:0:b0:3aa:354b:6e3e with SMTP id s11-20020a63f04b000000b003aa354b6e3emr2885303pgj.396.1650369328042;
        Tue, 19 Apr 2022 04:55:28 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w21-20020a17090a461500b001d28f5ee454sm6855206pjg.47.2022.04.19.04.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:55:27 -0700 (PDT)
Message-ID: <03583c5a-00fb-a6a0-9021-592f61c17d91@kernel.dk>
Date:   Tue, 19 Apr 2022 05:55:26 -0600
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220419110038.3728406-5-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/22 5:00 AM, Damien Le Moal wrote:
> Currently, the directory name used to create a nullb device through
> sysfs is not used as the device name, potentially causing headaches for
> users if devices are already created through the modprobe operation
> withe the nr_device module parameter not set to 0. E.g. a user can do
> "mkdir /sys/kernel/config/nullb/nullb0" to create a nullb device while
> /dev/nullb0 wasalready created from modprobe. In this case, the configfs
                ^^^

space

> nullb device will be named nullb1, causing confusion for the user.
> 
> Simplify this by using the configfs directory name as the nullb device
> name, always, unless another nullb device is already using the same
> name. E.g. if modprobe created nullb0, then:
> 
> $ mkdir /sys/kernel/config/nullb/nullb0
> mkdir: cannot create directory '/sys/kernel/config/nullb/nullb0': File
> exists
> 
> will be reported to th user.
> 
> To implement this, the function null_find_dev_by_name() is added to
> check for the existence of a nullb device with the name used for a new
> configfs device directory. nullb_group_make_item() uses this new
> function to check if the directory name can be used as the disk name.
> Finally, null_add_dev() is modified to use the device config item name
> as the disk name for new nullb device, for devices created using
> configfs. The naming of devices created though modprobe remains
> unchanged.
> 
> Of note is that it is possible for a user to create through configfs a
> nullb device with the same name as an existing device. E.g.

This is nice, and solves both the confusing part of having
pre-configured devices, but also using the actual directory name as the
device name even if they are not ordered.

Only odd bit is you can create a device name where a special file of
that name already exists, but I don't think that's solvable in a clean
way and we just need to ignore that. That's arguably a user error, don't
pick names that already exist.

-- 
Jens Axboe


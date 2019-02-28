Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A17C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E2220C01
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EahzLf8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfB1VAV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:00:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55702 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1VAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:00:20 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so16865306itf.5
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iA75yPyGHneWtrfS9/5Hco2AMpHTGV0NxTli2PDo8RI=;
        b=EahzLf8gR8E3iOm7SZcvNroGad4BcWYltPktvo/8A1c343w+RrxM0p07q5WNhIbz+3
         Kt0FmqAUsF+deASZDXAANDu375Aa1dgF7swfstiu7ZZbDgw5zZc5XzNBNLgSeisfg+AX
         SRBDzbiKi+0LRcKFX9YSZCLxQ/oR0frQjsaPb/qPsN4lm6GC4x/ivlboR9vz9F4bqWhE
         P/8YNt1htCfOhMCVFhuCRwbvvkV5lrBu1cN6pVIXcHQlUN0jsuHw9NFtFv76S5sBzHN6
         jVSwnDh7chYaPTUQ6FUmoMqX3qoqm1MoWIWEWYQ4aIu8zmJQO99EZ+W+UOzox5UmFlUN
         qQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iA75yPyGHneWtrfS9/5Hco2AMpHTGV0NxTli2PDo8RI=;
        b=lm5fbKEtAjxVMHmc8IBVTJTG0PgB4gC6jIqANXLfIh6pSUgH1JgxF8crC/Jc83xoIE
         TYxe8csLY1Qz5rFxmVZiRjTx9K5c1vEjHHxEla++yM3QFC2BYJM1ontIOKy1dSIbSifj
         6jHslhmT9JMw1z+xBvhrOJE6f0VeLzuRV/YzAU7hNVT/pGqPmSGKEr55LQsG4fJgHVn4
         d23e5iz5lK7tse/p17wkpIUv0GXPdtKpYz6rc/UAbhn6H3ZyaTxNa+b8//d+76JxKaji
         BJPk3sZClJIfXSbFnIsLMJ1EvR1nnpFlxj5wf5hEbyL08Kz8PlgE4LURlPl/a5pC4NPu
         sqlA==
X-Gm-Message-State: APjAAAUL6TMJ23AJvqJ3vmT3f7EzZNEBS5aV+hQJSt6K+dQpysbn4rfK
        J+klr7JABOFVFsDsJaB/YHhjIg==
X-Google-Smtp-Source: AHgI3IbojRyeHH2ZDOXf5rHsPFZizWeOrtNh7Y2oj7ETM47eVS+mwdaK3ynTJK6vUk4PQ8qfjS+HUg==
X-Received: by 2002:a24:97d7:: with SMTP id k206mr1216903ite.167.1551387619626;
        Thu, 28 Feb 2019 13:00:19 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 127sm3371357itl.25.2019.02.28.13.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:00:18 -0800 (PST)
Subject: Re: [PATCH V2] fs: fix guard_bio_eod to check for real EOD errors
To:     Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, tom.leiming@gmail.com
References: <20190226105150.10717-1-cmaiolino@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <961fc518-616e-f13d-2acf-c78807109a6e@kernel.dk>
Date:   Thu, 28 Feb 2019 14:00:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226105150.10717-1-cmaiolino@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/19 3:51 AM, Carlos Maiolino wrote:
> guard_bio_eod() can truncate a segment in bio to allow it to do IO on
> odd last sectors of a device.
> 
> It already checks if the IO starts past EOD, but it does not consider
> the possibility of an IO request starting within device boundaries can
> contain more than one segment past EOD.
> 
> In such cases, truncated_bytes can be bigger than PAGE_SIZE, and will
> underflow bvec->bv_len.
> 
> Fix this by checking if truncated_bytes is lower than PAGE_SIZE.
> 
> This situation has been found on filesystems such as isofs and vfat,
> which doesn't check the device size before mount, if the device is
> smaller than the filesystem itself, a readahead on such filesystem,
> which spans EOD, can trigger this situation, leading a call to
> zero_user() with a wrong size possibly corrupting memory.
> 
> I didn't see any crash, or didn't let the system run long enough to
> check if memory corruption will be hit somewhere, but adding
> instrumentation to guard_bio_end() to check truncated_bytes size, was
> enough to see the error.
> 
> The following script can trigger the error.
> 
> MNT=/mnt
> IMG=./DISK.img
> DEV=/dev/loop0
> 
> mkfs.vfat $IMG
> mount $IMG $MNT
> cp -R /etc $MNT &> /dev/null
> umount $MNT
> 
> losetup -D
> 
> losetup --find --show --sizelimit 16247280 $IMG
> mount $DEV $MNT
> 
> find $MNT -type f -exec cat {} + >/dev/null
> 
> Kudos to Eric Sandeen for coming up with the reproducer above
> 
> Changelog:
> 
> 	V2: Compare truncated_bytes agains bvec->bv_len instead of
> 	    PAGE_SIZE

Applied - note I snipped your changelog, that should go below the ---
lines to not end up in the commit message.

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F0C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698E4619A5
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 22:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVWV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 18:21:27 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:45880 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCVWVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 18:21:23 -0400
Received: by mail-pf1-f170.google.com with SMTP id h3so12168842pfr.12;
        Mon, 22 Mar 2021 15:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t6icTyai4O67Q+rTLOoampNNY5W8EYDWVT5g1rlVasw=;
        b=HIE7oKWv0UAzxPnhG2h2ouuoIvtsZ1nwlmZV34ZJGNY6u7MWeOwMRy8AcjjDG2K/aE
         grL2j8MaoLkmflWiQ1yJ8g3K4QZmwjWjzR7KoMS3ZgwX7H59yRxWP/v+RleIVH8l17y1
         87lB04IFgMsnjvAEUoi+p0c3p2MT4WRtvqf4qOJJC6ontQB9aOinVZ27PsuiAcYPf1KU
         0neaxtohBq4ucxoHVASu23Xe2wjM7pQyL3S+ceZzOowHoDDkL7MZ/kDWZv8gc5tksA0K
         dMEBaVwGzlGdEBw/BcexbMxyl8llRKqc3hgnsA0wHShxTgsv1xCDi/8JEsFJav3zmDoE
         GUXA==
X-Gm-Message-State: AOAM530Ec5aX9wha6kBSzrowXzWjbNCw5UtJ1Z6mtxUy5JZEfZl/IK1Y
        isLEgsjMqR5nghKyRaVGQi8Lu/r5c6k=
X-Google-Smtp-Source: ABdhPJwH4UmE956iKYThpolfsApuUHW/kGu09EX48llOe7hxGnBtc+em5PjpZ30r7QCVoD2t1sa2CQ==
X-Received: by 2002:aa7:9532:0:b029:1f8:838e:7773 with SMTP id c18-20020aa795320000b02901f8838e7773mr1899876pfp.15.1616451682329;
        Mon, 22 Mar 2021 15:21:22 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b64sm14440369pfa.191.2021.03.22.15.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 15:21:21 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
References: <00000000000053da9405bd7d2644@google.com>
 <000000000000a17fb305be0b3f38@google.com> <20210322071801.GE3440@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <94abea02-0c6f-cd0b-5aa4-fef08f9b2ab8@acm.org>
Date:   Mon, 22 Mar 2021 15:21:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322071801.GE3440@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/21 12:18 AM, Christoph Hellwig wrote:
> I've been running the reproducer on a KASAN enable VM for about
> 15 minutes now, but haven't been able to reproduce it.
> 
> Is there a way to inject this proposed fix into the syzbot queue?
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a7558917c47d6..f5d5872b89d57e 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -288,15 +288,12 @@ struct device_type part_type = {
>   void delete_partition(struct block_device *part)
>   {
>   	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
> -	kobject_put(part->bd_holder_dir);
> -	device_del(&part->bd_device);
> -
> -	/*
> -	 * Remove the block device from the inode hash, so that it cannot be
> -	 * looked up any more even when openers still hold references.
> -	 */
>   	remove_inode_hash(part->bd_inode);
>   
> +	synchronize_rcu();
> +
> +	kobject_put(part->bd_holder_dir);
> +	device_del(&part->bd_device);
>   	put_device(&part->bd_device);
>   }

Hi Christoph,

disk_part_iter_next() calls bdgrab() before returning a pointer to a 
certain partition. 'part' is only freed if its reference count drops to 
zero. The function that frees the partition information, 
bdev_free_inode(), is invoked via call_rcu(). bdgrab() fails if the 
refcount of a partition is zero. Does that mean that it is not necessary 
to call synchronize_rcu() between xa_erase() and put_device()?

Thanks,

Bart.


Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75901C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC982070B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDTNWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:22:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34944 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDTNWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 09:22:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id r14so4935852pfg.2;
        Mon, 20 Apr 2020 06:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/fj0h2mvNbIHyUZqMnIDvXRJPwVGn8bQL5X9tlS0mAQ=;
        b=IqGy//5bTtxci2XD/6Dx7/Azk8EeeLPeM5Xeu3Ij6NONSpeZWR+bDhxWbW00M6Dfyn
         JswNDUlaGeTrumQ/KBM1CHSCZeOwEj8m/E+MNFPZwv4guutWSg35FcRe43K6P8tM9QZM
         tNgFqx4Fa0uDJ9Ic8ZAFs40dTMX5GYoSQrIKBHeX5NQlEo8uzzeHBHNtcigU+4xBenlo
         sTI3qX+FQ7ic26Ec4l77IPEJV9IItgGO76qHSoncViBNrz3Q8L5Z46xjrSYLt/6QsfaX
         MiSYLi50mShf8cYN0VewLiQCA/cJNKogbc4FsW932GlBOWPjeKDvQH18VGiVfKP6gLy7
         DgvQ==
X-Gm-Message-State: AGi0PuajACcyW1nz54cnt2vaBn9beVTO8Fwwpdsg47EItNygF5rtW2Yz
        4yS/jSzSiR1G/UqtvrfE91Q=
X-Google-Smtp-Source: APiQypKc8DZ+iGhnJz49xipKnTbgAUEKLEIk5iShNar5T6096pSGHpVeLspz/QgDTCgvwoagnRVdWw==
X-Received: by 2002:aa7:850f:: with SMTP id v15mr16282159pfn.204.1587388935780;
        Mon, 20 Apr 2020 06:22:15 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.10])
        by smtp.gmail.com with ESMTPSA id j7sm1231550pjy.9.2020.04.20.06.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 06:22:14 -0700 (PDT)
Subject: Re: [PATCH 1/4] loop: Refactor size calculation.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, Chaitanya.Kulkarni@wdc.com,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200420080409.111693-1-maco@android.com>
 <20200420080409.111693-2-maco@android.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b546eff4-616a-8488-fc11-9b7e23d44bcf@acm.org>
Date:   Mon, 20 Apr 2020 06:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420080409.111693-2-maco@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/20 1:04 AM, Martijn Coenen wrote:
> +/**
> + * loop_set_size - sets device size and notifies userspace
> + * @lo: struct loop_device to set the size for
> + * @size: new size of the loop device
> + *
> + * Callers must validate that the size passed into this function fits into
> + * a sector_t.
> + */
> +static void loop_set_size(struct loop_device *lo, loff_t size)
> +{
> +	struct block_device *bdev = lo->lo_device;
> +
> +	set_capacity(lo->lo_disk, size);
> +	bd_set_size(bdev, size << 9);
> +	/* let user-space know about the new size */
> +	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
> +}

How about using the SECTOR_SHIFT constant instead of "9"? I think the 
following has been added recently in include/linux/blkdev.h:

#define SECTOR_SHIFT 9

> @@ -1295,6 +1321,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>   	/* I/O need to be drained during transfer transition */
>   	blk_mq_freeze_queue(lo->lo_queue);
>   
> +	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
> +		/* kill_bdev should have truncated all the pages */
> +		err = -EAGAIN;
> +		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
> +			__func__, lo->lo_number, lo->lo_file_name,
> +			lo->lo_device->bd_inode->i_mapping->nrpages);
> +		goto out_unfreeze;
> +	}
> +
>   	err = loop_release_xfer(lo);
>   	if (err)
>   		goto out_unfreeze;

Please Cc Jaegeuk for any changes in this code (see also 
https://lore.kernel.org/linux-block/20190518005304.GA19446@jaegeuk-macbookpro.roam.corp.google.com/).

Please also change the "kill_bdev should have truncated all the pages" 
comment into something like "return -EAGAIN if any pages have been 
dirtied after kill_bdev() returned".

Thanks,

Bart.

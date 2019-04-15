Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634DC10F12
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C2A2070D
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 21:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YciWsYOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfDOVgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:36:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34355 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfDOVgm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 17:36:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so9233941pgq.1
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4qKTodmcdfLx4hSSwpki61mlxSH1Iz4ZVv16WFnNrE=;
        b=YciWsYOFZe/GiIi7S2IZP0DTK7yeFNpN50riFKaeU91vOUa/jdBooOzE09rz4VO95g
         k5MbU3bdyQzzKU6w+VSu0dM/a1Pw0p9RyFNjz3M+k5WFkiKkUm9CsMo3GZiQIrMl23O6
         /ZicI07hegeArAmCxsmAMPW8NNSMt7UWOytaxoC639Q8MT0YzBMfXiuabNU54u17U9IO
         PIAybo3mYsPyqKYPGturvyO6MCrcM4GGAZlk/jtrC1Ll/M4dVKKq+xSpVlopsgGmq0hq
         ka1DmDtWXKSWZbKf4DJj2aQFok+Sd/ajSsTvg78KSuPhQo04LqB/c6/KvWVfQhN04fFF
         Mmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4qKTodmcdfLx4hSSwpki61mlxSH1Iz4ZVv16WFnNrE=;
        b=oSZ+6ASQRGwWSune37u/0okLEywbju7ltONMnkCox2AYoG/lR4X2r+1BieeFg+w5MF
         EuC2utXiP/AXUXtsYnc59Ilcvagi1A5RLUBk6Ks7t5UKkQ6LuoqTDp4sXtl+KI+CIwKe
         B6Ff4x08NYv2Q0J2ZpD/7U9A7y5FhympuOzNUjvkR9GjpOynEum3Wwg8bDt4yemI5Kq3
         R29aIFFoqh+A6FT/IWjb1OiSGPPh3LDZw/NmhgDl324gbMfnvVfF1iPlW0B9I6KPmobj
         33xvrZASNHILwyhxn4pMRn37Heg/gjGUCYdyZFNOwcgN9hKpvnvuYXyHNyP8P9BgM8dn
         XqGw==
X-Gm-Message-State: APjAAAWUwu2+ZGVrWc82/TmwV0GMF+9KPm3yAt9z67nweX4sRqG8LLaP
        XIJruBjPO1ntNVWXuTLso/+fiNeX9Rc7YQ==
X-Google-Smtp-Source: APXvYqymuWgbE7yJm1DgdtOKH+ybQVV51AniESwnK7V4tCp37qXc9nkGsVChFDV+WAiJ8l+zcIBo6Q==
X-Received: by 2002:a65:4341:: with SMTP id k1mr73399029pgq.88.1555364201783;
        Mon, 15 Apr 2019 14:36:41 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w3sm98219007pfn.179.2019.04.15.14.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 14:36:40 -0700 (PDT)
Subject: Re: [PATCH v3] block: fix use-after-free on gendisk
To:     Yufen Yu <yuyufen@huawei.com>, jack@suse.cz
Cc:     viro@zeniv.linux.org.uk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org
References: <20190402120634.51040-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5e3ace1-6388-cb23-1ea2-d2fbc1b9cca8@kernel.dk>
Date:   Mon, 15 Apr 2019 15:36:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402120634.51040-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/19 6:06 AM, Yufen Yu wrote:
> commit 2da78092dda "block: Fix dev_t minor allocation lifetime"
> specifically moved blk_free_devt(dev->devt) call to part_release()
> to avoid reallocating device number before the device is fully
> shutdown.
> 
> However, it can cause use-after-free on gendisk in get_gendisk().
> We use md device as example to show the race scenes:
> 
> Process1		Worker			Process2
> md_free
> 						blkdev_open
> del_gendisk
>   add delete_partition_work_fn() to wq
>   						__blkdev_get
> 						get_gendisk
> put_disk
>   disk_release
>     kfree(disk)
>     						find part from ext_devt_idr
> 						get_disk_and_module(disk)
>     					  	cause use after free
> 
>     			delete_partition_work_fn
> 			put_device(part)
>     		  	part_release
> 		    	remove part from ext_devt_idr
> 
> Before <devt, hd_struct pointer> is removed from ext_devt_idr by
> delete_partition_work_fn(), we can find the devt and then access
> gendisk by hd_struct pointer. But, if we access the gendisk after
> it have been freed, it can cause in use-after-freeon gendisk in
> get_gendisk().
> 
> We fix this by adding a new helper blk_invalidate_devt() in
> delete_partition() and del_gendisk(). It replaces hd_struct
> pointer in idr with value 'NULL', and deletes the entry from
> idr in part_release() as we do now.
> 
> Thanks to Jan Kara for providing the solution and more clear comments
> for the code.

Applied, thanks.

-- 
Jens Axboe


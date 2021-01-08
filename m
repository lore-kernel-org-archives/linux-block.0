Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470BEC433DB
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 03:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C7A23601
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 03:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbhAHDzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 22:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbhAHDzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 22:55:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A9C0612F4
        for <linux-block@vger.kernel.org>; Thu,  7 Jan 2021 19:54:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q4so4982637plr.7
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 19:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXF7Wxl+2xm0K9jZ2JXhR8PSiyP4I0s+lgrMreIKtdg=;
        b=0U6XM7KzjrmqKvAlOozXhtMIlw7pANOTUCGr9KM+dGM28ftxWipaUgFVgFyHipWuP9
         kuJzULVtCeY1tiZJ14we8W7v8niJ4v7PCgAQFqrpaJunVoJNR8JvKUOYYZXW+3Wjupxi
         O1rxDaKKYpdyb+lNz+nxF6ruuymw7urf+7+7FX25bxwzARMGlFnRIDxlS8fYTuVS1Iud
         kWqf0IRQNPAOIrV8mamM7l3d2NDoddP9RbuPGWi90Z4Vj4qP4M79IL/4lKuiQDcBInRm
         YB7AyymBKdD4uX5BtwgtT0DIeZn/9mEZkOtqSOJPiwmoXSTd5CDYJvPWFxOUT5apSIKv
         z+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXF7Wxl+2xm0K9jZ2JXhR8PSiyP4I0s+lgrMreIKtdg=;
        b=CWK8w4v5GRSxY8yHK6VYlOu0pQ/vnuh7LDVexuo55SXw/OfgcQfFXnPgNPnLjQadSL
         rJRpaZ1zmMD0DJ9tqZ8UMeuM/XNNCMDuQpRT9+179sGFj/OSGZeuPi9PYq1H3qFVqdDN
         lOcVlVsn/t7thllMTcOE6v0Nsk1VIMTTdqIouC1GZxsr9aiih53SPBJZRUQklY6T/eRf
         q8yINjap3pvsu1K8VvCaaF1grTChPHxZwpH/s+ezq4v8tpnLGGlmAsF09EMy4B9Mp5wY
         8luKwksQURdbrCpFwXWymGqyhaCOsZubN0kwst0JkvphQdSE14HWN5mTpA+U+MX4i85n
         OHVQ==
X-Gm-Message-State: AOAM533rqTMzEasRCA6sOYnqPL/tWM0aDBtI1xPxpI2pMzdfFdeiONdM
        d1RHQ9GiJG4LLZgRtytCSzqatg==
X-Google-Smtp-Source: ABdhPJw5SYsdDX/CfNUypZ0j8X3Fv50Lzmcbqsfp6yToErbaCxFx4FybEL6PUf2Qh9Ohi+Czice94A==
X-Received: by 2002:a17:90b:298:: with SMTP id az24mr1714016pjb.128.1610078072820;
        Thu, 07 Jan 2021 19:54:32 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id z3sm7666327pgs.61.2021.01.07.19.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 19:54:32 -0800 (PST)
Subject: Re: [PATCH] block: pre-initialize struct block_device in
 bdev_alloc_inode
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jack@suse.cz
References: <20210107183640.849336-1-hch@lst.de>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <10544287-baf9-bb2b-9f90-87b2defe49d8@ozlabs.ru>
Date:   Fri, 8 Jan 2021 14:54:27 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210107183640.849336-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 08/01/2021 05:36, Christoph Hellwig wrote:
> bdev_evict_inode and bdev_free_inode are also called for the root inode
> of bdevfs, for which bdev_alloc is never called.  Move the zeroing o

nice wrapping :)

> f struct block_device and the initialization of the bd_bdi field into
> bdev_alloc_inode to make sure they are initialized for the root inode
> as well.
> 
> Fixes: e6cb53827ed6 ("block: initialize struct block_device in bdev_alloc")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   fs/block_dev.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 3e5b02f6606c42..b79ddda11ee317 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -774,8 +774,11 @@ static struct kmem_cache * bdev_cachep __read_mostly;
>   static struct inode *bdev_alloc_inode(struct super_block *sb)
>   {
>   	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
> +
>   	if (!ei)
>   		return NULL;
> +	memset(&ei->bdev, 0, sizeof(ei->bdev));
> +	ei->bdev.bd_bdi = &noop_backing_dev_info;
>   	return &ei->vfs_inode;
>   }
>   
> @@ -869,14 +872,12 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>   	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
>   
>   	bdev = I_BDEV(inode);
> -	memset(bdev, 0, sizeof(*bdev));
>   	mutex_init(&bdev->bd_mutex);
>   	mutex_init(&bdev->bd_fsfreeze_mutex);
>   	spin_lock_init(&bdev->bd_size_lock);
>   	bdev->bd_disk = disk;
>   	bdev->bd_partno = partno;
>   	bdev->bd_inode = inode;
> -	bdev->bd_bdi = &noop_backing_dev_info;
>   #ifdef CONFIG_SYSFS
>   	INIT_LIST_HEAD(&bdev->bd_holder_disks);
>   #endif
> 

-- 
Alexey

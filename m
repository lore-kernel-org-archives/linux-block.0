Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CE2C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiKPVu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiKPVuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB68063B8D
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gb7j/bSfwmKBgntX+bLM9T0km8Jf8pYUeq23+M2C16M=;
        b=jTtGB3J4RJW/lYLjqg8Mxb7g45I3fEuakDbLCd9JJxQWI0uTcCqRjzrUG7Zj3uJp56qZhP
        n6QJEQgq1gEja3CnTkCpQXE7xPlX4gBx07VjIuC9Kvd3ThoSuuIPZYXs4wFgjM9LSibBwF
        PqCq30FxxqwYP/TgKg2gPgKjbwoDUNI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-602-PhqvTaVPMzue-YbyM9PTRA-1; Wed, 16 Nov 2022 16:48:44 -0500
X-MC-Unique: PhqvTaVPMzue-YbyM9PTRA-1
Received: by mail-qt1-f198.google.com with SMTP id c19-20020a05622a059300b003a51d69906eso18411qtb.1
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb7j/bSfwmKBgntX+bLM9T0km8Jf8pYUeq23+M2C16M=;
        b=fWD6KoVFJ7Ckdw1+TsJ0TU8TA1ABdeYrianVvWWsS3b0i1kMBnaIZz/wlvnJWjHlaW
         8uuytCXxc76x+StJbwUXRHAE6f4iMquGkCqf+zaIYpuCzCBc/eYIZdTy16f2JMXWQ52b
         si2rYZ+jwuW21KLKuv82OntWaBI81v9UMYiCK6jH/HeMH6lfSzYqpq4j3dabdvEUtzUH
         nPkJJYoy+oB3jPlUzjevwsE0oQ7WoRMv/s2Na72sp8VJ2OrwCEthCjmClyyiO2Jsdlwm
         q4hdqsmnx9N1gJvArTGOKQ+k3FA4RncQ+Krcl2TGTdCLW3a/3Okw+ftd5hgMqldAFyHw
         8cZQ==
X-Gm-Message-State: ANoB5plUgvY6W3xmTq7hqg73eWI/L7b29B6J1o4Xnj8M9tbkmxScK8l6
        OS0FXLGcIbrskEA9I9LCpmLPb2PWcKF1rY7r6CdjvCSOuLLjDDVIpNCb780LENIa8OvnEdU5uuM
        MtFRdyr3JQD7Z7wqZmHesfQ==
X-Received: by 2002:ae9:ef0c:0:b0:6ea:8eb4:3898 with SMTP id d12-20020ae9ef0c000000b006ea8eb43898mr21421447qkg.588.1668635324215;
        Wed, 16 Nov 2022 13:48:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7qRR7lyPfh1G9FP29Lbv7v+knDVgTkc535wRE4ZJ7VapZ3sEbuHbJgrTLOn4ZuOtuRz4HoJw==
X-Received: by 2002:ae9:ef0c:0:b0:6ea:8eb4:3898 with SMTP id d12-20020ae9ef0c000000b006ea8eb43898mr21421434qkg.588.1668635323996;
        Wed, 16 Nov 2022 13:48:43 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id e7-20020a05622a110700b0038b684a1642sm9385264qty.32.2022.11.16.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:43 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:48:42 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RFC v3 05/10] dm: make sure create and remove dm device
 won't race with open and close table
Message-ID: <Y3VaunS49xJvHflm@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-6-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> open_table_device() and close_table_device() is protected by
> table_devices_lock, hence use it to protect add_disk() and
> del_gendisk().
> 
> Prepare to track per-add_disk holder relations in dm.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/dm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2917700b1e15..3728b56b364b 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1952,7 +1952,14 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  		spin_unlock(&_minor_lock);
>  		if (dm_get_md_type(md) != DM_TYPE_NONE) {
>  			dm_sysfs_exit(md);
> +
> +			/*
> +			 * Hold lock to make sure del_gendisk() won't concurrent
> +			 * with open/close_table_device().
> +			 */
> +			mutex_lock(&md->table_devices_lock);
>  			del_gendisk(md->disk);
> +			mutex_unlock(&md->table_devices_lock);
>  		}
>  		dm_queue_destroy_crypto_profile(md->queue);
>  		put_disk(md->disk);
> @@ -2312,15 +2319,24 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>  	if (r)
>  		return r;
>  
> +	/*
> +	 * Hold lock to make sure add_disk() and del_gendisk() won't concurrent
> +	 * with open_table_device() and close_table_device().
> +	 */
> +	mutex_lock(&md->table_devices_lock);
>  	r = add_disk(md->disk);
> +	mutex_unlock(&md->table_devices_lock);
>  	if (r)
>  		return r;
>  
>  	r = dm_sysfs_init(md);
>  	if (r) {
> +		mutex_lock(&md->table_devices_lock);
>  		del_gendisk(md->disk);
> +		mutex_unlock(&md->table_devices_lock);
>  		return r;
>  	}
> +
>  	md->type = type;
>  	return 0;
>  }
> -- 
> 2.31.1
> 

In the new comments added: s/concurrent/race/ ?

But otherwise:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


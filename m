Return-Path: <SRS0=BT6h=UB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2912C28CC3
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 02:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80C62780A
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 02:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2sM5KI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFBCDF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jun 2019 22:03:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34227 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfFBCDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jun 2019 22:03:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id c14so6100572pfi.1;
        Sat, 01 Jun 2019 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/D6JpUiet993VqUwy3BOSTDwyFn2AJ+XDrJt4fKxlo=;
        b=K2sM5KI2NzjQL1wp9wPJW8B+XU67VtMZLNhPF62wNPqWGqWPLgV34wFE3yJNe837/m
         h8I+1JdoXFkT9kTD36JaKnNQGeORMC4JNkt4Dz7retUqBCNUo5livLypWJ5EZ82RpIDJ
         IkKX42XnBOV4xoN/533879rKzFc7aCR86MmMqHp7n/VgQEiUxUCtInaWPYwiJ2av378M
         dn7xNhr47L3DZ7NPyEgoApM0JI31DqiqxnjJ1Sq55/W7vEMC6JoljVO1+rADEBW19BXN
         QFtMahIe9VM8l6jn5l+Kw2S+6uRUT3FMjp/5xOHYOktM17I1dmI3hNYc27S9Jas0L9im
         +V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/D6JpUiet993VqUwy3BOSTDwyFn2AJ+XDrJt4fKxlo=;
        b=Vv9y7BLKR5IWs+0i5DojUySfzjNw6g8hI2l+Nv/WuZnjGnPEB7qG9dS+W1z/i7jUDY
         K5CQ+D+xojJM5S/zlZJ7RwFKBpO7z1EBleUrrYcalsbwnXPueaeim1G8zdaY3HT0DoZC
         cXnNPZydp3WKP690UDgjKwhvBMnWN3JVClw0eK2J4mVF7OLw2pd4mT8HuAKPTFH+um2Q
         jvrLHXJRxZKp+p7/DKH7ebdsHKKIrwXvSqccVORHN2PQu1/JNb3xiUENK7/OMA01E/L3
         T8020VllZj3wfbRPCTDhuZkbX0EDYrKA7Lth72d/IFCtjvdK1pbSZuRAWlicn6D5HNju
         Qm1w==
X-Gm-Message-State: APjAAAUA/WLRO/Veqh3rDME9n2F57VorD/9ByHjIjE3MEp0XL9VnOis+
        isbQny6bxFr9jhFV7MnCdHA=
X-Google-Smtp-Source: APXvYqysKoBMw1bgsrXByX3jBBQwrvvwNL+0Gs9k66RU0l8OWB2zKv8SZSMZEB/X2aMKjOJkGC7GkQ==
X-Received: by 2002:a63:4754:: with SMTP id w20mr19271592pgk.31.1559440984193;
        Sat, 01 Jun 2019 19:03:04 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id i16sm10153339pfd.100.2019.06.01.19.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 19:03:03 -0700 (PDT)
Date:   Sun, 2 Jun 2019 11:03:01 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/9] scsi_debug: support host tagset
Message-ID: <20190602020259.GC28933@minwooim-desktop>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190531022801.10003-5-ming.lei@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-05-31 10:27:56, Ming Lei wrote:
> The 'host_tagset' can be set on scsi_debug device for testing
> shared hostwide tags on multiple blk-mq hw queue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/scsi_debug.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index d323523f5f9d..8cf3f6c3f4f9 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -665,6 +665,7 @@ static bool have_dif_prot;
>  static bool write_since_sync;
>  static bool sdebug_statistics = DEF_STATISTICS;
>  static bool sdebug_wp;
> +static bool sdebug_host_tagset = false;

Hi Ming, 

I think we can leave it without an initialisation just like the others above.

>  
>  static unsigned int sdebug_store_sectors;
>  static sector_t sdebug_capacity;	/* in sectors */
> @@ -4468,6 +4469,7 @@ module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
>  module_param_named(wp, sdebug_wp, bool, S_IRUGO | S_IWUSR);
>  module_param_named(write_same_length, sdebug_write_same_length, int,
>  		   S_IRUGO | S_IWUSR);
> +module_param_named(host_tagset, sdebug_host_tagset, bool, S_IRUGO | S_IWUSR);
>  
>  MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
>  MODULE_DESCRIPTION("SCSI debug adapter driver");
> @@ -5779,6 +5781,7 @@ static int sdebug_driver_probe(struct device *dev)
>  	sdbg_host = to_sdebug_host(dev);
>  
>  	sdebug_driver_template.can_queue = sdebug_max_queue;
> +	sdebug_driver_template.host_tagset = sdebug_host_tagset;
>  	if (!sdebug_clustering)
>  		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;

Otherwise: It looks good to me in host tagset point of view.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

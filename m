Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9ABC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7146A610C7
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 08:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbhJ0I6j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241092AbhJ0I6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 04:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635324968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bg2jmWugrAP5drzBc7AtpQfP7KTLK8hNbD3CI7qc7g=;
        b=T2/B1hW08RJjQEEB65XouIjCwdvDrYXp0k19YNMXqGZvP07mfggRELZEETOuz4dr48sPDp
        n5aSYOpY8YO/FgX2oATjKm49exCSjL5TFMdSfLK5Y13xdANXqpf+33TDCaxqr67+oLzIP6
        5CYQ1Huxssxvp9zCLTwXqdAG6Lks3Pg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-xrnLM9-WN2SQXlae1Y-mog-1; Wed, 27 Oct 2021 04:56:07 -0400
X-MC-Unique: xrnLM9-WN2SQXlae1Y-mog-1
Received: by mail-wm1-f69.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so915273wmh.6
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 01:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7bg2jmWugrAP5drzBc7AtpQfP7KTLK8hNbD3CI7qc7g=;
        b=D9v37DDI/AKJwwUfMV7sZe8hLBbUxneUHz8vLKOc+UlnQTvDiotQgQHluX/mxeJrNZ
         oTNpRRUKjZBDwpsGn910fRb/Nd2YzSWXTCDILy5b2AqgP6o9c/CK4PvFHwLSj6tLVIkD
         drgyhREWS6ej2g9KdiBJcDE299kzvH1H1k/pnGWH2H4aLauiqsTf4s/PAnAcextLJa1G
         I/dOAh4smhSuCPGLwiF+sArqzdc9jtrHHvGObiOtAYVBBlEfbc7DXBHYR6YxuOLmMMBS
         keebR+RNBesECxPoX8/4bgIn26SWwA/1HY6jAPcUemODVxhPCF4EUwvhUf095CsqoWmx
         Zd7A==
X-Gm-Message-State: AOAM530y4ZDLvvGJAa3pvP5V5eIkTRkY+MvN2bUlN3gy2C1xwYQkzA5i
        LVnPhi7fFBynMTRtgLCAR9O8ct11gzg6U/amcVeQ7xNxp7+jjr6PP222Zy0CyB5yZSlSpt3r/2o
        EkySTx2ZAd0hGRaIBo3a0Gtw=
X-Received: by 2002:a5d:5191:: with SMTP id k17mr28697925wrv.166.1635324966165;
        Wed, 27 Oct 2021 01:56:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdvrKPLGWce0zKxktjiX4WZxnekcKuLnVTB4v3+lf2dmRnC6Bb5uHHKMtXNijIGyJvWy3P0A==
X-Received: by 2002:a5d:5191:: with SMTP id k17mr28697903wrv.166.1635324965997;
        Wed, 27 Oct 2021 01:56:05 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
        by smtp.gmail.com with ESMTPSA id t3sm3296837wrq.66.2021.10.27.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:56:05 -0700 (PDT)
Date:   Wed, 27 Oct 2021 04:56:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Feng Li <lifeng1519@gmail.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: select CONFIG_SG_POOL
Message-ID: <20211027045533-mutt-send-email-mst@kernel.org>
References: <20211027082433.52616-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027082433.52616-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 27, 2021 at 10:24:13AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Switching virtio-blk to the sg_pool interfaces causes a build
> failures when they are not part of the kernel:
> 
> drivers/block/virtio_blk.c:182:3: error: implicit declaration of function 'sg_free_table_chained' [-Werror,-Wimplicit-function-declaration]
>                 sg_free_table_chained(&vbr->sg_table,
>                 ^
> drivers/block/virtio_blk.c:195:8: error: implicit declaration of function 'sg_alloc_table_chained' [-Werror,-Wimplicit-function-declaration]
>         err = sg_alloc_table_chained(&vbr->sg_table,
>               ^
> 
> Select this symbol through Kconfig, as is done for all other
> users.
> 
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'll squash this to avoid bisect failures, ok?

> ---
>  drivers/block/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index d97eaf6adb6d..2a51dfb09c8f 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -371,6 +371,7 @@ config XEN_BLKDEV_BACKEND
>  config VIRTIO_BLK
>  	tristate "Virtio block driver"
>  	depends on VIRTIO
> +	select SG_POOL
>  	help
>  	  This is the virtual block driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
> -- 
> 2.29.2


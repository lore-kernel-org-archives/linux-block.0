Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 09:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668EE61040
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbhJ0JMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241167AbhJ0JMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635325826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KlLWjdMEKosubEUbhbKYe/h5vQ0MkvY9AMnhHvQo6Zc=;
        b=jIQTTs/y+mBZ6twGXk0JC/9K0WPh919/j8eD8B6Dm1nmC0EJtep/xn7GQmWMqOjLMIkZMC
        cN4Yja2069qJ0NIrGt+dO3cO1g7+kjNl6HNuNjHjpuDuaebCnoQcd03y0g7oipURpy5w7I
        7fXoA00OfLsBu32QjPEJdQ3OlyTPmyk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-kpyCFJ_EP_Sc7gzTh6YlzA-1; Wed, 27 Oct 2021 05:10:25 -0400
X-MC-Unique: kpyCFJ_EP_Sc7gzTh6YlzA-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso420853wrc.2
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 02:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KlLWjdMEKosubEUbhbKYe/h5vQ0MkvY9AMnhHvQo6Zc=;
        b=Jhw0bgId5zKwTVXidqamZ9CTRQrU/ciz4FmwLKhQigFumWVRkaahfLGZXvZVM8WFw9
         j9OP2zSiXpswAg+VCPtVodHt9omqCVPcOlYtLBLHXiT/UGAkHjzKc9I/pjRZUpVottpV
         CAaly6MdlEo99icB5cFaj7cdFpP1+r3wiOEVkG68LmI+zGfXpPC9ht9e/vR1kj39XjIl
         meduWRpppE1AQnv3ni8b0nkMPoxIdk23Wsb+tR061JFDtv3XI3wxJP/P4UJmqo4AyQbv
         rH9Sy75vznKtp7dulLHr04NRqfD5HjlJrKz2fPMqHD5jHSpVU4SWFCxyf7yqgDEsy+UW
         Va4Q==
X-Gm-Message-State: AOAM531+qvpl/DOnqU3h6aHUUCm2h+dd0ljvkKQ7FpAeg7lnU7LRme4E
        v4l/axhflPT/B1+zbEt/cuPCms43cGcbP8u5Jg7IVYujDcjrcxeyKNaCVEgmEMG3d7lGS70ieU8
        mRsBfC7AEoFBjj0TUHuTgJcs=
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr4398563wmj.83.1635325823889;
        Wed, 27 Oct 2021 02:10:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKr6hWccKZ4DikZQtjdLBb3+ZLg/Ww0gd7xpXig2puZOSUH1NwZhUKNUb1ULbuc6mIfHdn7Q==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr4398541wmj.83.1635325823672;
        Wed, 27 Oct 2021 02:10:23 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
        by smtp.gmail.com with ESMTPSA id g2sm21736134wrb.20.2021.10.27.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 02:10:23 -0700 (PDT)
Date:   Wed, 27 Oct 2021 05:10:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: select CONFIG_SG_POOL
Message-ID: <20211027050920-mutt-send-email-mst@kernel.org>
References: <20211027082433.52616-1-arnd@kernel.org>
 <29dbebdd-185d-a3be-6131-c9a471dc8d39@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29dbebdd-185d-a3be-6131-c9a471dc8d39@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

https://lore.kernel.org/r/20210901131434.31158-1-mgurtovoy@nvidia.com

yes - it was there. I think I dropped it while resolving
conflicts.
Thanks!


On Wed, Oct 27, 2021 at 11:56:20AM +0300, Max Gurtovoy wrote:
> This is strange, I've sent V3 with this code included.
> 
> MST,
> 
> which version did you take to your tree ?
> 
> 
> On 10/27/2021 11:24 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Switching virtio-blk to the sg_pool interfaces causes a build
> > failures when they are not part of the kernel:
> > 
> > drivers/block/virtio_blk.c:182:3: error: implicit declaration of function 'sg_free_table_chained' [-Werror,-Wimplicit-function-declaration]
> >                  sg_free_table_chained(&vbr->sg_table,
> >                  ^
> > drivers/block/virtio_blk.c:195:8: error: implicit declaration of function 'sg_alloc_table_chained' [-Werror,-Wimplicit-function-declaration]
> >          err = sg_alloc_table_chained(&vbr->sg_table,
> >                ^
> > 
> > Select this symbol through Kconfig, as is done for all other
> > users.
> > 
> > Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   drivers/block/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> > index d97eaf6adb6d..2a51dfb09c8f 100644
> > --- a/drivers/block/Kconfig
> > +++ b/drivers/block/Kconfig
> > @@ -371,6 +371,7 @@ config XEN_BLKDEV_BACKEND
> >   config VIRTIO_BLK
> >   	tristate "Virtio block driver"
> >   	depends on VIRTIO
> > +	select SG_POOL
> >   	help
> >   	  This is the virtual block driver for virtio.  It can be used with
> >             QEMU based VMMs (like KVM or Xen).  Say Y or M.


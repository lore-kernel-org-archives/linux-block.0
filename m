Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664BDC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 23:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B484222C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 23:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duFgFGxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLKXFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:05:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48134 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726487AbfLKXFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 18:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576105515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sx72Zu8R4y3Ns6A0Elwe6ONN3kNLN0tIVRBIzDH4IQA=;
        b=duFgFGxP82/1Nf8+LS2tVOujuD6RevdPYNPrbuY8FVuyBrUra9pZAEI/JABoQmybR3XQJV
        uQNrzgaz+5zIfuiViU+qWNdHGmlEEvDTe3UOVBwhihHgMeCNTmwdRLJC0Fqkn7T2jCx2Vh
        weEmQar/C2qbLBFX/nXnxCI/3ZL2U/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-Y6CvdMBIOo2xme8Uv8otXw-1; Wed, 11 Dec 2019 18:05:12 -0500
X-MC-Unique: Y6CvdMBIOo2xme8Uv8otXw-1
Received: by mail-wr1-f69.google.com with SMTP id f17so214477wrt.19
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 15:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sx72Zu8R4y3Ns6A0Elwe6ONN3kNLN0tIVRBIzDH4IQA=;
        b=mSBqAShw/SZ83ZY6KTcIRS1IsGdhpInwevwg4DIEw2HIYgfeG/Ko2iGHBhqPs/dYGp
         Rg0llnod9pcdHsWZtHQY8Spd9Yv7DW/CqHHPkBOzZjDzFBY0vMjqPbDG5EelswXSw42w
         Uxgj8zXyu77VhE6Qcs2abty/M6uexsKRM5l03VMIeSSGPZcmvo8S7j10ncCrnTQXkCz8
         xUIlCcG0d6bVrLhKnwbMBJYIAPU8JF5xQpS626b7Z5hUOKB+gB5SIiVJ7INdss+Hihtu
         5WGNCvvSFmMIszefBwn8s5f6iSEQT+M/u9vh7mEmKeeWvCRrFFM4vbP6SgYF3ddbWYzQ
         tqKg==
X-Gm-Message-State: APjAAAXbT3EmOEqeoDAuZ+UBHKv1RrM60kQqYKJW25f5u7Romb2Z7eYU
        iogYlFikw8/28U7YZGGAdmHw6aGqyBKNamRiifCuNHa6QKTO4O1Bn0veqE2qXH3nvk3Tu8b4arG
        Wd7pfGOsfH33FO5Gk5htsBAs=
X-Received: by 2002:a1c:4008:: with SMTP id n8mr2404656wma.121.1576105511592;
        Wed, 11 Dec 2019 15:05:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpe9p8ejWiVLiuArWlu3PcE1o950G4BmpoXFY8faxUGRQT/Ci+xtr4RXgpMlISlS8MvrxukA==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr2404621wma.121.1576105511390;
        Wed, 11 Dec 2019 15:05:11 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id g18sm3736144wmh.48.2019.12.11.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:05:10 -0800 (PST)
Date:   Wed, 11 Dec 2019 18:05:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20191211180155-mutt-send-email-mst@kernel.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211204306.1207817-16-arnd@arndb.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 09:42:49PM +0100, Arnd Bergmann wrote:
> Each driver calling scsi_ioctl() gets an equivalent compat_ioctl()
> handler that implements the same commands by calling scsi_compat_ioctl().
> 
> The scsi_cmd_ioctl() and scsi_cmd_blk_ioctl() functions are compatible
> at this point, so any driver that calls those can do so for both native
> and compat mode, with the argument passed through compat_ptr().
> 
> With this, we can remove the entries from fs/compat_ioctl.c.  The new
> code is larger, but should be easier to maintain and keep updated with
> newly added commands.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/virtio_blk.c |   3 +
>  drivers/scsi/ch.c          |   9 ++-
>  drivers/scsi/sd.c          |  50 ++++++--------
>  drivers/scsi/sg.c          |  44 ++++++++-----
>  drivers/scsi/sr.c          |  57 ++++++++++++++--
>  drivers/scsi/st.c          |  51 ++++++++------
>  fs/compat_ioctl.c          | 132 +------------------------------------
>  7 files changed, 142 insertions(+), 204 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7ffd719d89de..fbbf18ac1d5d 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  
>  static const struct block_device_operations virtblk_fops = {
>  	.ioctl  = virtblk_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
> +#endif
>  	.owner  = THIS_MODULE,
>  	.getgeo = virtblk_getgeo,
>  };

Hmm - is virtio blk lumped in with scsi things intentionally?

-- 
MST


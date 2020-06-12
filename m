Return-Path: <SRS0=gmaS=7Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8701C433DF
	for <linux-block@archiver.kernel.org>; Fri, 12 Jun 2020 14:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEC42074B
	for <linux-block@archiver.kernel.org>; Fri, 12 Jun 2020 14:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BO41d+Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgFLO1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:27:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55282 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgFLO1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jun 2020 10:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591972040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+olewpNOq4Mhtigyte1j6a5drL4wqqmBJ3lT4ECK4c=;
        b=BO41d+PrVB+Cr1yznVWCCGtYIoZtuAfEt1CzbZTXQzEw/SEy+vduTh6hRigdVI45YtWaBv
        gwPYZlPkZ1CeV9jGUBUhoXGwp2spdswp/odSiqEX5F96o0I5aAQvALHgicmuo2cYg4HBXc
        iCoMS3eUOrgS5++DH4Mk3F07CMSBSaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-bP41vhZ6Pjq2css5taBa4A-1; Fri, 12 Jun 2020 10:27:19 -0400
X-MC-Unique: bP41vhZ6Pjq2css5taBa4A-1
Received: by mail-wr1-f71.google.com with SMTP id j16so3930267wre.22
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2020 07:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6+olewpNOq4Mhtigyte1j6a5drL4wqqmBJ3lT4ECK4c=;
        b=hOZ3S4x+SdL90e5t1qguFDXv07fZQOZ7TFgYkusuFaeTixRqw/eNbArNfN47BXC+pW
         B2tktj9lGOPJgxx3xW2YCQ3NqYsc5EqUmjjVDD+EAFy2+qDSdTMEHKEfYEWILrAfdpeF
         KP++2kCqamV+Xwa21wabKIf5sPP1l6fyr3RejBnWqB9BbsZ8aZszPjZdSnn1cpsx9L9S
         4p6bqTjMQ5Hd5buE1TZvO2PowhFQZE1sUL5wEaMOTu3BJPnRns5yJtx9wBJid5HabC2j
         rUWL2A1QwVWaGrRSzrEXwa1mMUa7ZCLEUUoyZ0+2osnpAd+1mHap+ToekMO5vmNlPAP8
         RGUA==
X-Gm-Message-State: AOAM532ryBH1X4a43btFon0PmMYUu9WfuOlbv3P20ps+lG1cnJk1MOq8
        RYVpEL5LQHPMNzaDuqd7i0uDI0jQi+pwzB7C8CN2wskx1lDSfDfoPW9Mn35kSslsoFs45aVdmQO
        KwiwwFNuo93jnq2FQVwA5/hA=
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr15422402wrt.341.1591972037871;
        Fri, 12 Jun 2020 07:27:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0rXM6T8tsdAIVG7Puy2koE7wNaJ6yQ2Cnd9iEfviiNtynmFOaRLpvuGD2gfkKEGv2EVuLpQ==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr15422380wrt.341.1591972037717;
        Fri, 12 Jun 2020 07:27:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
        by smtp.gmail.com with ESMTPSA id t189sm9043363wma.4.2020.06.12.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 07:27:17 -0700 (PDT)
Date:   Fri, 12 Jun 2020 10:27:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers\block: Use kobj_to_dev() API
Message-ID: <20200612102651-mutt-send-email-mst@kernel.org>
References: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 12, 2020 at 03:10:56PM +0800, Wang Qing wrote:
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 drivers/block/virtio_blk.c


Subject should probably use "/". Besides that - trivial tree?

> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9d21bf0..c808405
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -630,7 +630,7 @@ static struct attribute *virtblk_attrs[] = {
>  static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
>  		struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct gendisk *disk = dev_to_disk(dev);
>  	struct virtio_blk *vblk = disk->private_data;
>  	struct virtio_device *vdev = vblk->vdev;
> -- 
> 2.7.4


Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232EBC433E0
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 07:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BE220707
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 07:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crOBL503"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFOHc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:32:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728368AbgFOHc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 03:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592206345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVmSa8Yxs683+Ekeg5nVJQwj3FLB/0nHqVNedIYMZKA=;
        b=crOBL503O3AGgsu9FGpdn2F5jAbpZ6d2DBxpo9y6QLU5OAWDpcy9Yx0pov1pYQyaANaAwB
        v3bp/pOyjA72iUQ3bz6MRaQH1G/U0oU/vkDNJE3UHaH7MM5RK7PogGGKzM+cW+z1V6kWYE
        GuKXmkbrHzZjYnsSQvzpNNkDQuaXSKw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-ywQts1fXOD2REQZKZAvlug-1; Mon, 15 Jun 2020 03:32:23 -0400
X-MC-Unique: ywQts1fXOD2REQZKZAvlug-1
Received: by mail-wr1-f69.google.com with SMTP id o1so6635305wrm.17
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 00:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MVmSa8Yxs683+Ekeg5nVJQwj3FLB/0nHqVNedIYMZKA=;
        b=a4kkDzf98+piN0HGM01yOhloPiumEz5NTMjV+k2cjl9ld3gZ+rFfROuX5oQITNp4p5
         tsCyvjuiZUpgvBt0Z0a2HFuNIRBLzKnJWbbRoDhukgPF0IozeK2kFbidsg2fVBvnNHiE
         iwl8XO2VRWimVvcBLl0KwxO/gcpXT+4MVyyWnBhiU/sf7jlLvcNhdeZalqbDAgRuj3+H
         H+avU281idH8V6H0Oh3XWpMHoOLn44ICWC8OuLAH5Ot8tYULd7Oy8wH02xRAMFIibo65
         85aMzGlAMkEtp0O/vaJDiGu0Q4VWyYRO1+W5FUi4sFT92T/8GNxwZH7+RisLpu6xumVF
         oMHw==
X-Gm-Message-State: AOAM531ZeckEHQdelDEy732j4hVFhOCIOCAv4+p6J8eis9IoduAMAYT0
        uFfrIUC819Hqv9VTq8dwsNPW8Y6oaJEgSA2m5K1SS8iITG6uJqrt0wBEhxU0m59nEnro0XrZk2Q
        SoAGHHq8WIRgfAICjde1kLxY=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr28119139wrr.96.1592206342592;
        Mon, 15 Jun 2020 00:32:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9sW2KxmB2iYo5NWUyXKW9j1fjFzmv455gF6I9xB5C663EM4s8qGhGf3DzxGkOXJyGtHB+ew==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr28119120wrr.96.1592206342383;
        Mon, 15 Jun 2020 00:32:22 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id v19sm21164940wml.26.2020.06.15.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 00:32:21 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:32:19 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] virtio-blk: free vblk-vqs in error path of
 virtblk_probe()
Message-ID: <20200615073219.eeydysnn3d3xkwzg@steredhat>
References: <20200615041459.22477-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615041459.22477-1-houtao1@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 15, 2020 at 12:14:59PM +0800, Hou Tao wrote:
> Else there will be memory leak if alloc_disk() fails.
> 
> Fixes: 6a27b656fc02 ("block: virtio-blk: support multi virt queues per virtio-blk device")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9d21bf0f155e..980df853ee49 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -878,6 +878,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	put_disk(vblk->disk);
>  out_free_vq:
>  	vdev->config->del_vqs(vdev);
> +	kfree(vblk->vqs);
>  out_free_vblk:
>  	kfree(vblk);
>  out_free_index:
> -- 
> 2.25.0.4.g0ad7144999
> 

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


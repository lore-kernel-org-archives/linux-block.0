Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED8C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 22:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A91206CB
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 22:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwoiYjlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgF3Wad (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:30:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45913 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbgF3Wab (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 18:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593556230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfviXLg7XzaMbM+hNuQYcNab3PT4KOfUFzlReRkI2dI=;
        b=WwoiYjlKg8hf+yq1XALyPTF82lTs5V8hoqzZK1sMZA/w7ID1PXVRbwdhemKfoGRA2WPxj1
        UNtVQp36JmLUuJN0HLzWVFi5uLaoCLJC3mFo1ht8jhxN6N0HwLYjjDOsm4AG3rmDUr2J2f
        M04xKYnUKJ98jDharyyBOaQ4FcIc320=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-j3z0j1TmORy0Vb8F9Vvvwg-1; Tue, 30 Jun 2020 18:30:27 -0400
X-MC-Unique: j3z0j1TmORy0Vb8F9Vvvwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A52B7800597;
        Tue, 30 Jun 2020 22:30:25 +0000 (UTC)
Received: from T590 (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3C36106222A;
        Tue, 30 Jun 2020 22:30:16 +0000 (UTC)
Date:   Wed, 1 Jul 2020 06:30:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] virtio-blk: free vblk-vqs in error path of
 virtblk_probe()
Message-ID: <20200630223012.GA2251557@T590>
References: <20200615041459.22477-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615041459.22477-1-houtao1@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


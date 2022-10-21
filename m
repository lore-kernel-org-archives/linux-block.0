Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3239DC433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 01:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJUBJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJUBJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 21:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A89D2F1
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666314563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKA52vvbdJ19DM1uaw2+qmDoOCSKKzKeEBsIYnSVXIM=;
        b=EZftmHfGR16oBH4HP4TXtFA+nXwq9OQH8ojSfj3vlQEhiP92ioX4MF0jrmkUIaaYSon+ZU
        sxMIBI2fB3SsEbt2NvPnKEdXypWCZW5j/+D1t23Qfwrk6pgg+SD8CIn32lxP840dhPUvNJ
        yhdGxyl5Mgfawuzlh4xBslpv2jl81+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-2wXbEbqaO-SUV26G1WUbdQ-1; Thu, 20 Oct 2022 21:09:20 -0400
X-MC-Unique: 2wXbEbqaO-SUV26G1WUbdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B47C6811E81;
        Fri, 21 Oct 2022 01:09:19 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE16240CA41E;
        Fri, 21 Oct 2022 01:09:13 +0000 (UTC)
Date:   Fri, 21 Oct 2022 09:09:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Message-ID: <Y1HxM+3bXNpsZvzk@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 12:56:01PM +0200, Christoph Hellwig wrote:
> nvme and xen-blkfront are already doing this to stop buffered writes from
> creating dirty pages that can't be written out later.  Move it to the
> common code.  Note that this follows the xen-blkfront version that does
> not send and uevent as the uevent is a bit confusing when the device is
> about to go away a little later, and the the size change is just to stop
> buffered writes faster.
> 
> This also removes the comment about the ordering from nvme, as bd_mutex
> not only is gone entirely, but also hasn't been used for locking updates
> to the disk size long before that, and thus the ordering requirement
> documented there doesn't apply any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c                | 3 +++
>  drivers/block/xen-blkfront.c | 1 -
>  drivers/nvme/host/core.c     | 7 +------
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 17b33c62423df..2877b5f905579 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -555,6 +555,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
>  {
>  	set_bit(GD_DEAD, &disk->state);
>  	blk_queue_start_drain(disk->queue);
> +
> +	/* stop buffered writers from dirtying pages that can't written out */
> +	set_capacity(disk, 0);

The idea makes sense:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Just one small issue on mtip32xx, which may call blk_mark_disk_dead() in
irq context, and ->bd_size_lock is actually not irq safe.

But mtip32xx is already broken since blk_queue_start_drain() need mutex,
maybe mtip32xx isn't actively used at all.

Thanks,
Ming


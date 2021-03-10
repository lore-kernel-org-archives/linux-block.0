Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB476C433E6
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 21:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2BD64FD5
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 21:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhCJV5x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbhCJV5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 16:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615413455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbP0fY/AimR+3m1w1TVNpTvBeGaBYaBvKVfRdOhqRpY=;
        b=gjv28exD0ZTCFAmI+WwkT9CwIOzzX/ASmhzEivpOW8G1nEsR6PWiqk1YarYpdVx/FLXdXg
        puwRplFina/OLXy5AUtLU6h58m1hbnUGu0Bu4qM8AtUQDLzAXEFsS+m1XYPpnG308nA/SW
        AlNckqaiCaT6mSSqkcr1CXHHQy1HcKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-Dpl0IHafPMacUKJLY_O3rw-1; Wed, 10 Mar 2021 16:57:33 -0500
X-MC-Unique: Dpl0IHafPMacUKJLY_O3rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43AB719067E0;
        Wed, 10 Mar 2021 21:57:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 864A15C22A;
        Wed, 10 Mar 2021 21:57:28 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:57:27 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, mpatocka@redhat.com,
        caspar@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 09/12] nvme/pci: don't wait for locked polling queue
Message-ID: <20210310215727.GA23410@redhat.com>
References: <20210303115740.127001-1-jefflexu@linux.alibaba.com>
 <20210303115740.127001-10-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303115740.127001-10-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 03 2021 at  6:57am -0500,
Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> There's no sense waiting for the hw queue when it currently has been
> locked by another polling instance. The polling instance currently
> occupying the hw queue will help reap the completion events.
> 
> It shall be safe to surrender the hw queue, as long as we could reapply
> for polling later. For Synchronous polling, blk_poll() will reapply for
> polling, since @spin is always True in this case. While For asynchronous
> polling, i.e. io_uring itself will reapply for polling when the previous
> polling returns 0.
> 
> Besides, it shall do no harm to the polling performance of mq devices.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

You should probably just send this to the linux-nvme list independent of
this patchset.

Mike


> ---
>  drivers/nvme/host/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 38b0d694dfc9..150e56ed6d15 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1106,7 +1106,9 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
>  	if (!nvme_cqe_pending(nvmeq))
>  		return 0;
>  
> -	spin_lock(&nvmeq->cq_poll_lock);
> +	if (!spin_trylock(&nvmeq->cq_poll_lock))
> +		return 0;
> +
>  	found = nvme_process_cq(nvmeq);
>  	spin_unlock(&nvmeq->cq_poll_lock);
>  
> -- 
> 2.27.0
> 


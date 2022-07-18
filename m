Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08694C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 12:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiGRMY4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiGRMYl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 08:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E68D31145
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658147069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JaN8Md9qX08DyikgPic0MhdnqduPbYVgd0e7WGFGJB4=;
        b=QHD2/JND/OQA5eACpAUQSlDGvTTPYBSgwTThSma65fKa/vS41dwrAW+lL6/RKG+6sVp6as
        Yz3H+uW44B8pbKfJNSfyRxXgneUqHLW/5DEsljvpY3sIB/OL7NTnEejVjkpuMCCsE/p9Xo
        mVaFogKtW4wdlWDKrI3VyYd1eYNXHUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-Z51wG6CsPO2t0CPE9CF8Lw-1; Mon, 18 Jul 2022 08:24:25 -0400
X-MC-Unique: Z51wG6CsPO2t0CPE9CF8Lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F90085A581;
        Mon, 18 Jul 2022 12:24:25 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18D1590A00;
        Mon, 18 Jul 2022 12:24:21 +0000 (UTC)
Date:   Mon, 18 Jul 2022 20:24:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] ublk_drv: missing error code in ublk_add_dev()
Message-ID: <YtVQ8OComr1XD4SM@T590>
References: <YtVAlDAfLLRolN/X@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVAlDAfLLRolN/X@kili>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 02:14:28PM +0300, Dan Carpenter wrote:
> This error path accidentally returns success instead of a negative
> error code.
> 
> Fixes: cebbe577cb17 ("ublk_drv: fix request queue leak")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/block/ublk_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c0f9a5b4ed58..332472901ff8 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1169,8 +1169,10 @@ static int ublk_add_dev(struct ublk_device *ub)
>  		goto out_deinit_queues;
>  
>  	ub->ub_queue = blk_mq_init_queue(&ub->tag_set);
> -	if (IS_ERR(ub->ub_queue))
> +	if (IS_ERR(ub->ub_queue)) {
> +		err = PTR_ERR(ub->ub_queue);
>  		goto out_cleanup_tags;
> +	}

Yang Yingliang has posted one same patch:

https://lore.kernel.org/linux-block/YtUOhUXBKG28bew4@T590/T/#t


Thanks,
Ming


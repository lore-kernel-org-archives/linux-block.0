Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496CBC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 07:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGRHTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 03:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiGRHTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 03:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2150313CF6
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 00:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658128744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFJk3gzuLpr6lCwqwORMEAnIZDpoMcspB88v8uFxVPA=;
        b=WoDx/WRz0knKzlNpgNacI+kqIlKf3G0L9Ae0fFUd8bQyprnPfCCoKP4vVxANO5LT981GI6
        wc2c2Oy/bCbkKU34c9V0Z5FwhwUq0G1ZsO/zWAQwsl+/73GHa+sWCrkOX5TFVxaU8xAVtD
        3Irt9NMflUt1s+a2PPGevam6wsHb37A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-QJ00F83qNA-ypv9DDgQytw-1; Mon, 18 Jul 2022 03:19:00 -0400
X-MC-Unique: QJ00F83qNA-ypv9DDgQytw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A5B2101AA69;
        Mon, 18 Jul 2022 07:19:00 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46B54404C6C0;
        Mon, 18 Jul 2022 07:18:56 +0000 (UTC)
Date:   Mon, 18 Jul 2022 15:18:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] block: call blk_mq_exit_queue from disk_release for
 never added disks
Message-ID: <YtUJXGhFBw5yrf7N@T590>
References: <20220718062928.335399-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718062928.335399-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 08:29:27AM +0200, Christoph Hellwig wrote:
> To undo the all initialization from blk_mq_init_allocated_queue in case
> of a probe failure where add_disk is never called we have to call
> blk_mq_exit_queue from put_disk.
> 
> We should be doing this in general, but can't do it for the normal
> teardown case (yet) as the tagset can be gone by the time the disk is
> released once it was added.  I hope to sort this out properly eventual
> but for now this isolated hack will do it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 44dfcf67ed96a..ad8a3678d4480 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1138,6 +1138,18 @@ static void disk_release(struct device *dev)
>  	might_sleep();
>  	WARN_ON_ONCE(disk_live(disk));
>  
> +	/*
> +	 * To undo the all initialization from blk_mq_init_allocated_queue in
> +	 * case of a probe failure where add_disk is never called we have to
> +	 * call blk_mq_exit_queue here. We can't do this for the more common
> +	 * teardown case (yet) as the tagset can be gone by the time the disk
> +	 * is released once it was added.
> +	 */
> +	if (queue_is_mq(disk->queue) &&
> +	    test_bit(GD_OWNS_QUEUE, &disk->state) &&
> +	    !test_bit(GD_ADDED, &disk->state))
> +		blk_mq_exit_queue(disk->queue);
> +

Request queue is allocated successfully, but disk allocation may fail,
so blk_mq_exit_queue still may be missed in this case.


thanks,
Ming


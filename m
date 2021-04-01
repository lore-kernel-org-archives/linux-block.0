Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB3C433ED
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 00:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF50610CB
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 00:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhDAAzV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 20:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232782AbhDAAzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 20:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617238506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WpC/+2DCWYSR48tBQKKUf11MkuPyQvJ3mEtYtH3+QPo=;
        b=HOYFR1nmxTY0N1PnAcv30rLT2W5Ap9r0g/VaZMGfWB6meueb+IH+YBC7tdFUKj+bcVNSUY
        AtOKasBHwWokexNfxBED5pwVxsZvwIA9g1STkP1+tXAapW4dOd+7Lxjpm8dcoMvGGPgu9d
        rtjNy2NLnnhPf42m8qrY428hOoHjMGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-KyIrvTB8PAytMXAafZPTrg-1; Wed, 31 Mar 2021 20:55:03 -0400
X-MC-Unique: KyIrvTB8PAytMXAafZPTrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73AF7107ACCA;
        Thu,  1 Apr 2021 00:55:02 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFCC45C1BB;
        Thu,  1 Apr 2021 00:54:54 +0000 (UTC)
Date:   Thu, 1 Apr 2021 08:54:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        bvanassche@acm.org, kbusch@kernel.org
Subject: Re: [PATCH] block: only update parent bi_status when bio fail
Message-ID: <YGUZ2SYCi1EkNcvh@T590>
References: <20210331115359.1125679-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331115359.1125679-1-yuyufen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 31, 2021 at 07:53:59AM -0400, Yufen Yu wrote:
> For multiple split bios, if one of the bio is fail, the whole
> should return error to application. But we found there is a race
> between bio_integrity_verify_fn and bio complete, which return
> io success to application after one of the bio fail. The race as
> following:
> 
> split bio(READ)          kworker
> 
> nvme_complete_rq
> blk_update_request //split error=0
>   bio_endio
>     bio_integrity_endio
>       queue_work(kintegrityd_wq, &bip->bip_work);
> 
>                          bio_integrity_verify_fn
>                          bio_endio //split bio
>                           __bio_chain_endio
>                              if (!parent->bi_status)
> 
>                                <interrupt entry>
>                                nvme_irq
>                                  blk_update_request //parent error=7
>                                  req_bio_endio
>                                     bio->bi_status = 7 //parent bio
>                                <interrupt exit>
> 
>                                parent->bi_status = 0
>                         parent->bi_end_io() // return bi_status=0
> 
> The bio has been split as two: split and parent. When split
> bio completed, it depends on kworker to do endio, while
> bio_integrity_verify_fn have been interrupted by parent bio
> complete irq handler. Then, parent bio->bi_status which have
> been set in irq handler will overwrite by kworker.
> 
> In fact, even without the above race, we also need to conside
> the concurrency beteen mulitple split bio complete and update
> the same parent bi_status. Normally, multiple split bios will
> be issued to the same hctx and complete from the same irq
> vector. But if we have updated queue map between multiple split
> bios, these bios may complete on different hw queue and different
> irq vector. Then the concurrency update parent bi_status may
> cause the final status error.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 26b7f721cda8..f49713ff8ad3 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -277,7 +277,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>  	struct bio *parent = bio->bi_private;
>  
> -	if (!parent->bi_status)
> +	if (bio->bi_status && !parent->bi_status)
>  		parent->bi_status = bio->bi_status;
>  	bio_put(bio);
>  	return parent;
> -- 
> 2.25.4
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


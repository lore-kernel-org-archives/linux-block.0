Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD9C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 06:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6582D61052
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 06:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhHIG24 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 02:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233136AbhHIG24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 02:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628490515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSB+qsiXiDt/LtGYRnCraHlctWmbZ6sfAQg7VcuKR9M=;
        b=O+0IoCJxikctsnMIl/681rfh4xxFRgC2oeTZAVPNIh6nGOy04mObUVyAqLqyyh3usy4PeP
        ctyqdZsO8PX0GGXdq5eJchlyS55kDOSYP0lEu1VpG6La768aAKyD03NucJOVUiCDyaZA5W
        DqkaejWSUiaaTx9JVccJgnT6GVbNMPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-PUrK1CkgPYeY80-D0WG0jA-1; Mon, 09 Aug 2021 02:28:33 -0400
X-MC-Unique: PUrK1CkgPYeY80-D0WG0jA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79C48B5DC4;
        Mon,  9 Aug 2021 06:28:15 +0000 (UTC)
Received: from T590 (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE60F10013C1;
        Mon,  9 Aug 2021 06:28:10 +0000 (UTC)
Date:   Mon, 9 Aug 2021 14:28:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2 2/2] nbd: convert to use blk_mq_get_rq_by_tag()
Message-ID: <YRDK9tBFscK5ScK8@T590>
References: <20210809030927.1946162-1-yukuai3@huawei.com>
 <20210809030927.1946162-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809030927.1946162-3-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 09, 2021 at 11:09:27AM +0800, Yu Kuai wrote:
> blk_mq_tag_to_rq() might return freed request, use
> blk_mq_get_rq_by_tag() instead.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c38317979f74..9e56975a8eee 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -713,11 +713,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  	tag = nbd_handle_to_tag(handle);
>  	hwq = blk_mq_unique_tag_to_hwq(tag);
>  	if (hwq < nbd->tag_set.nr_hw_queues)
> -		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
> -				       blk_mq_unique_tag_to_tag(tag));
> -	if (!req || !blk_mq_request_started(req)) {
> -		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
> -			tag, req);
> +		req = blk_mq_get_rq_by_tag(nbd->tag_set.tags[hwq],
> +					   blk_mq_unique_tag_to_tag(tag));
> +	if (!req) {
> +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d\n", tag);
>  		return ERR_PTR(-ENOENT);
>  	}
>  	trace_nbd_header_received(req, handle);
> @@ -779,6 +778,8 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  	}
>  out:
>  	trace_nbd_payload_received(req, handle);
> +	if (req)
> +		blk_mq_put_rq_ref(req);
>  	mutex_unlock(&cmd->lock);
>  	return ret ? ERR_PTR(ret) : cmd;

After blk_mq_put_rq_ref() returns, this request may have been freed,
so the returned 'cmd' may have been freed too.

As I replied in your another thread, it is driver's responsibility to
cover race between normal completion and timeout/error handling, that
means the caller of blk_mq_tag_to_rq need to make sure that the request
represented by the passed 'tag' can't be freed.

I'd suggest to understand why nbd_read_stat()/blk_mq_tag_to_rq() may return
one freed request first, who frees the request and how when calling
blk_mq_tag_to_rq() before figuring out solutions.



Thanks,
Ming


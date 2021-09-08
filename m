Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF0C433FE
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 07:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4362361051
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 07:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350523AbhIHHbi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350428AbhIHHbe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Sep 2021 03:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631086226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkqGjkxzxSPrvDa6nFo8JJGNfAA6j1Mj5Wob9D9BFCs=;
        b=B8BjKUmMaKL/sOi+fjOw2qDh60U8apZxHuQs1GdZ2MtzbdMaXTXK7nwg2pI371Q/NMMpGV
        0IR2WbF562xBjUs9kaKmiBx4gKC7qZLdCs6AH7aSvlvGFzbo63Ze14JgR+cGNygT3cY7Sd
        t4hiRA7XkwzPTWeSNIOBMH5iK7EBziM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-e8Mtu1L4NlapVx1NWYf7Pg-1; Wed, 08 Sep 2021 03:30:23 -0400
X-MC-Unique: e8Mtu1L4NlapVx1NWYf7Pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A66E6801A92;
        Wed,  8 Sep 2021 07:30:21 +0000 (UTC)
Received: from T590 (ovpn-12-207.pek2.redhat.com [10.72.12.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7842D5D9F4;
        Wed,  8 Sep 2021 07:30:12 +0000 (UTC)
Date:   Wed, 8 Sep 2021 15:30:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v4 2/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YThmhhI1/fZd29b1@T590>
References: <20210907140154.2134091-1-yukuai3@huawei.com>
 <20210907140154.2134091-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907140154.2134091-3-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 10:01:50PM +0800, Yu Kuai wrote:
> blk_mq_tag_to_rq() can only ensure to return valid request in
> following situation:
> 
> 1) client send request message to server first
> submit_bio
> ...
>  blk_mq_get_tag
>  ...
>  blk_mq_get_driver_tag
>  ...
>  nbd_queue_rq
>   nbd_handle_cmd
>    nbd_send_cmd
> 
> 2) client receive respond message from server
> recv_work
>  nbd_read_stat
>   blk_mq_tag_to_rq
> 
> If step 1) is missing, blk_mq_tag_to_rq() will return a stale
> request, which might be freed. Thus convert to use
> blk_mq_find_and_get_req() to make sure the returned request is not
> freed. However, there are still some problems if the request is
> started, and this will be fixed in next patch.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5170a630778d..920da390635c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -718,12 +718,13 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  	tag = nbd_handle_to_tag(handle);
>  	hwq = blk_mq_unique_tag_to_hwq(tag);
>  	if (hwq < nbd->tag_set.nr_hw_queues)
> -		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
> -				       blk_mq_unique_tag_to_tag(tag));
> +		req = blk_mq_find_and_get_req(nbd->tag_set.tags[hwq],
> +					      blk_mq_unique_tag_to_tag(tag));
>  	if (!req || !blk_mq_request_started(req)) {
>  		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
>  			tag, req);
> -		return ERR_PTR(-ENOENT);
> +		ret = -ENOENT;
> +		goto put_req;
>  	}
>  	trace_nbd_header_received(req, handle);
>  	cmd = blk_mq_rq_to_pdu(req);
> @@ -785,6 +786,9 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  out:
>  	trace_nbd_payload_received(req, handle);
>  	mutex_unlock(&cmd->lock);
> +put_req:
> +	if (req)
> +		blk_mq_put_rq_ref(req);
>  	return ret ? ERR_PTR(ret) : cmd;

After the request's refcnt is dropped, it can be freed immediately, then
one stale command is returned to caller.

Thanks,
Ming


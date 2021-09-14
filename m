Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 00:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7527761108
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 00:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhINA7R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 20:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233514AbhINA7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 20:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631581073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SS7/FhncPXhi3voNRWPd1aP8SGBMDiJ0bi0FjQH7ipo=;
        b=fKxnGdXHNfJuHPQ7DlAKZ7hhUjw0mU9gr82T+eUrYwHnmdz9yBZHdI4tE7aq0QmR7MF7Az
        TZwycgBqoO/fmITk+L20MG/yWTLrKFCPLKDvZO+EvH1qGgt2DlVWLK7jKIVijKqn4YahwP
        RpKkmbaupvy3+IxtZMrgcNcTrmWeHFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-ZKbsjLAUP9aqnZaVL-D-Pg-1; Mon, 13 Sep 2021 20:57:52 -0400
X-MC-Unique: ZKbsjLAUP9aqnZaVL-D-Pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54E99802929;
        Tue, 14 Sep 2021 00:57:51 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FDDF5C23A;
        Tue, 14 Sep 2021 00:57:44 +0000 (UTC)
Date:   Tue, 14 Sep 2021 08:57:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 2/6] nbd: make sure request completion won't concurrent
Message-ID: <YT/zkdoXG+awaVbm@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909141256.2606682-3-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 10:12:52PM +0800, Yu Kuai wrote:
> commit cddce0116058 ("nbd: Aovid double completion of a request")
> try to fix that nbd_clear_que() and recv_work() can complete a
> request concurrently. However, the problem still exists:
> 
> t1                    t2                     t3
> 
> nbd_disconnect_and_put
>  flush_workqueue
>                       recv_work
>                        blk_mq_complete_request
>                         blk_mq_complete_request_remote -> this is true
>                          WRITE_ONCE(rq->state, MQ_RQ_COMPLETE)
>                           blk_mq_raise_softirq
>                                              blk_done_softirq
>                                               blk_complete_reqs
>                                                nbd_complete_rq
>                                                 blk_mq_end_request
>                                                  blk_mq_free_request
>                                                   WRITE_ONCE(rq->state, MQ_RQ_IDLE)
>   nbd_clear_que
>    blk_mq_tagset_busy_iter
>     nbd_clear_req
>                                                    __blk_mq_free_request
>                                                     blk_mq_put_tag
>      blk_mq_complete_request -> complete again
> 
> There are three places where request can be completed in nbd:
> recv_work(), nbd_clear_que() and nbd_xmit_timeout(). Since they
> all hold cmd->lock before completing the request, it's easy to
> avoid the problem by setting and checking a cmd flag.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 04861b585b62..550c8dc438ac 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -406,7 +406,11 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>  	if (!mutex_trylock(&cmd->lock))
>  		return BLK_EH_RESET_TIMER;
>  
> -	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
> +	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
> +		mutex_unlock(&cmd->lock);
> +		return BLK_EH_DONE;
> +	}
> +
>  	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>  		cmd->status = BLK_STS_TIMEOUT;
>  		mutex_unlock(&cmd->lock);
> @@ -842,7 +846,10 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
>  
>  	mutex_lock(&cmd->lock);
>  	cmd->status = BLK_STS_IOERR;
> -	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
> +	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
> +		mutex_unlock(&cmd->lock);
> +		return true;
> +	}
>  	mutex_unlock(&cmd->lock);

If this request has completed from other code paths, ->status shouldn't be
updated here, maybe it is done successfully.

-- 
Ming


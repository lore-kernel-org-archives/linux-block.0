Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410A3C2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 16:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE832080A
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 16:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS8qShYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI1QDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgI1QDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 12:03:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601309016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+oblG/qOGXlNUQJxqjOijPeYpNJDV13ZGeW1mxzWDpk=;
        b=IS8qShYgGVIopJumCJjTAdTES2GhQS8yIjBr1PygiM7mh8XgGmVqC+szyzoRQVp+8j5PJs
        rTMGA8UazCHCemTywJO+kqTH6DJSoPmI2IlbQ6iIyRxSru4etIoiJDp3RGZW/FRsoE3Yev
        nOpFycIFN1kaFUtBoEBisDuvlnZ2P7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-Zgsi6zW-NYeQdn5MAlcA9w-1; Mon, 28 Sep 2020 12:03:32 -0400
X-MC-Unique: Zgsi6zW-NYeQdn5MAlcA9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31725801AC4;
        Mon, 28 Sep 2020 16:03:31 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86EA51A8AC;
        Mon, 28 Sep 2020 16:03:23 +0000 (UTC)
Date:   Mon, 28 Sep 2020 12:03:22 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: dm: fix imposition of queue_limits in dm_wq_work() thread
Message-ID: <20200928160322.GA23320@redhat.com>
References: <20200927120435.44118-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927120435.44118-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 27 2020 at  8:04am -0400,
Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Hi Mike, would you mind further expalin why bio processed by dm_wq_work()
> always gets a previous ->submit_bio. Considering the following call graph:
> 
> ->submit_bio, that is, dm_submit_bio
>   DMF_BLOCK_IO_FOR_SUSPEND set, thus queue_io()
> 
> then worker thread dm_wq_work()
>   dm_process_bio  // at this point. the input bio is the original bio
>                      submitted to dm device
> 
> Please let me know if I missed something.
> 
> Thanks.
> Jeffle

In general you have a valid point, that blk_queue_split() won't have
been done for the suspended device case, but blk_queue_split() cannot be
used if not in ->submit_bio -- IIUC you cannot just do it from a worker
thread and hope to have proper submission order (depth first) as
provided by __submit_bio_noacct().  Because this IO will be submitted
from worker you could have multiple threads allocating from the
q->bio_split mempool at the same time.

All said, I'm not quite sure how to address this report.  But I'll keep
at it and see what I can come up with.

Thanks,
Mike

> Original commit log:
> dm_process_bio() can be called by dm_wq_work(), and if the currently
> processing bio is the very beginning bio submitted to the dm device,
> that is it has not been handled by previous ->submit_bio, then we also
> need to impose the queue_limits when it's in thread (dm_wq_work()).
> 
> Fixes: cf9c37865557 ("dm: fix comment in dm_process_bio()")
> Fixes: 568c73a355e0 ("dm: update dm_process_bio() to split bio if in ->make_request_fn()")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  drivers/md/dm.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 6ed05ca65a0f..54471c75ddef 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1744,17 +1744,13 @@ static blk_qc_t dm_process_bio(struct mapped_device *md,
>  	}
>  
>  	/*
> -	 * If in ->submit_bio we need to use blk_queue_split(), otherwise
> -	 * queue_limits for abnormal requests (e.g. discard, writesame, etc)
> -	 * won't be imposed.
> -	 * If called from dm_wq_work() for deferred bio processing, bio
> -	 * was already handled by following code with previous ->submit_bio.
> +	 * Call blk_queue_split() so that queue_limits for abnormal requests
> +	 * (e.g. discard, writesame, etc) are ensured to be imposed, while
> +	 * it's not needed for regular IO, since regular IO will be split by
> +	 * following __split_and_process_bio.
>  	 */
> -	if (current->bio_list) {
> -		if (is_abnormal_io(bio))
> -			blk_queue_split(&bio);
> -		/* regular IO is split by __split_and_process_bio */
> -	}
> +	if (is_abnormal_io(bio))
> +		blk_queue_split(&bio);
>  
>  	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
>  		return __process_bio(md, map, bio, ti);
> -- 
> 2.27.0
> 


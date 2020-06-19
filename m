Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C5CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 09:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D7C2080C
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 09:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByT/jP+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgFSJnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:43:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731861AbgFSJnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 05:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592559783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Usgy37+XpMwpp9KaBSHE3Q3qWZPdIgsfjefYq+Scx1E=;
        b=ByT/jP+wdEdg86hUKpnlRwGur3LMhXRcvIH1lwRGgBL96lHTUl+nnpDTTwNqU9dvHrDBHB
        xfk3glNw3jNIxFTHzRi2/iw5kDTQliL9ArS2HiSsONGPMkY6pQBJZXwBkpVhM4BA7buFQ1
        1YggYDBLYWVxjZD3UjQJebP2/j/rsEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-WIFaDxcFNmaQ_WrGwIpwSw-1; Fri, 19 Jun 2020 05:43:01 -0400
X-MC-Unique: WIFaDxcFNmaQ_WrGwIpwSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 655D684B842
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 09:43:00 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA9D5C1D6;
        Fri, 19 Jun 2020 09:42:51 +0000 (UTC)
Date:   Fri, 19 Jun 2020 05:42:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: dm-rq: don't call blk_mq_queue_stopped in dm_stop_queue()
Message-ID: <20200619094250.GA18410@redhat.com>
References: <20200619084214.337449-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619084214.337449-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thanks for the patch!  But I'm having a hard time understanding what
you've written in the patch header,

On Fri, Jun 19 2020 at  4:42am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> dm-rq won't stop queue, meantime blk-mq won't stop one queue too, so
> remove the check.

It'd be helpful if you could unpack this with more detail before going on
to explain why using blk_queue_quiesced, despite dm-rq using
blk_mq_queue_stopped, would also be ineffective.

SO:

> dm-rq won't stop queue

1) why won't dm-rq stop the queue?  Do you mean it won't reliably
   _always_ stop the queue because of the blk_mq_queue_stopped() check?

> meantime blk-mq won't stop one queue too, so remove the check.

2) Meaning?: blk_mq_queue_stopped() will return true even if only one hw
queue is stopped, given blk-mq must stop all hw queues a positive return
from this blk_mq_queue_stopped() check is incorrectly assuming it meanss
all hw queues are stopped.

> dm_stop_queue() actually tries to quiesce hw queues via blk_mq_quiesce_queue(),
> we can't check via blk_queue_quiesced for avoiding unnecessary queue
> quiesce because the flag is set before synchronize_rcu() and dm_stop_queue
> may be called when synchronize_rcu from another blk_mq_quiesce_queue is
> in-progress.

But I'm left with questions/confusion on this too:

1) you mention blk_queue_quiesced instead of blk_mq_queue_stopped, so I
   assume you mean that: not only is blk_mq_queue_stopped()
   ineffective, blk_queue_quiesced() would be too?

2) the race you detail (with competing blk_mq_quiesce_queue) relative to
   synchronize_rcu() and testing "the flag" is very detailed yet vague.

Anyway, once we get this heaader cleaned up a bit more I'll be happy to
get this staged as a stable@ fix for 5.8 inclusion ASAP.

Thanks!
Mike

> 
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/md/dm-rq.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index f60c02512121..ed4d5ea66ccc 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -70,9 +70,6 @@ void dm_start_queue(struct request_queue *q)
>  
>  void dm_stop_queue(struct request_queue *q)
>  {
> -	if (blk_mq_queue_stopped(q))
> -		return;
> -
>  	blk_mq_quiesce_queue(q);
>  }
>  
> -- 
> 2.25.2
> 


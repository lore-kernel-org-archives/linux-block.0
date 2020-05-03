Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F85C28CBC
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 03:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FE520748
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 03:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSktYG/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgECDgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 23:36:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55631 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726752AbgECDgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 May 2020 23:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588477001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAZNlkY3TK1OkjCPuzoX3OFB5DxIPZ1jQKGdergyj34=;
        b=dSktYG/WXWJ6cidOwJRTXzjNteV82wo/e59mMz0LhcfN0+juPOU2EBCorgWBPHHYTTtF9n
        5uz1zNBDmfN3ibCW2L/oB7J8upJygOqWsF/KCheHYSmvw0tlKn+LK+RsmEi7ozi0nkYBa2
        rPhWqLrA4m1mp8EeO2R+zDl+spbwJWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-mTnz8LojMQOI5LBUkkTMRw-1; Sat, 02 May 2020 23:36:39 -0400
X-MC-Unique: mTnz8LojMQOI5LBUkkTMRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C68E80B702;
        Sun,  3 May 2020 03:36:38 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA7E1000322;
        Sun,  3 May 2020 03:36:32 +0000 (UTC)
Date:   Sun, 3 May 2020 11:36:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [RESEND v4 5/6] block: rename __blk_mq_alloc_rq_map
Message-ID: <20200503033627.GB1128091@T590>
References: <cover.1588080449.git.zhangweiping@didiglobal.com>
 <f39d442afa7e37bf144954f3f65a1c46a6b6fa91.1588080449.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39d442afa7e37bf144954f3f65a1c46a6b6fa91.1588080449.git.zhangweiping@didiglobal.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 09:30:13PM +0800, Weiping Zhang wrote:
> rename __blk_mq_alloc_rq_map to __blk_mq_alloc_map_and_request,
> actually it alloc both map and request, make function name
> align with function.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  block/blk-mq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1c360b69155c..b6c907dbbb30 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2473,7 +2473,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>  	}
>  }
>  
> -static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
> +static bool __blk_mq_alloc_map_and_request(struct blk_mq_tag_set *set, int hctx_idx)
>  {
>  	int ret = 0;
>  
> @@ -2527,7 +2527,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  		hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
>  		/* unmapped hw queue can be remapped after CPU topo changed */
>  		if (!set->tags[hctx_idx] &&
> -		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
> +		    !__blk_mq_alloc_map_and_request(set, hctx_idx)) {
>  			/*
>  			 * If tags initialization fail for some hctx,
>  			 * that hctx won't be brought online.  In this
> @@ -3000,7 +3000,7 @@ static int blk_mq_realloc_map_and_requests(struct blk_mq_tag_set *set, int new)
>  		return 0;
>  
>  	for (i = now; i < new; i++)
> -		if (!__blk_mq_alloc_rq_map(set, i))
> +		if (!__blk_mq_alloc_map_and_request(set, i))
>  			goto out_unwind;
>  
>  	return 0;
> -- 
> 2.18.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


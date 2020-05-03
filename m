Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B076C28CBC
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 03:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9A920767
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 03:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPldElCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgECDhv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 23:37:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32630 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726805AbgECDhv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 May 2020 23:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588477069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih5sJSXDiDITENARHkGGCjTEa7Fn57RFFrfG4x14fLw=;
        b=cPldElCpJCHcYZS1+DYGKeJN9J/Ul4KgKRCkyOKIkdkAjT0JGHTEOM3QyEf0dI/mqeiGb/
        Z73UUKK6oZhm9fER/jPXT5lOkvJtC1VEBFkLntv2eOXUVVK/SXodTZWIh2Umkz2N2L9e0N
        lNpWEtTTOCtt6WOYNRex8K7OXWprdak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Neb2c5G8No6g9jD31yZtCQ-1; Sat, 02 May 2020 23:37:42 -0400
X-MC-Unique: Neb2c5G8No6g9jD31yZtCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 298EA80B70A;
        Sun,  3 May 2020 03:37:41 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15CEA60612;
        Sun,  3 May 2020 03:37:32 +0000 (UTC)
Date:   Sun, 3 May 2020 11:37:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [RESEND v4 6/6] block: rename blk_mq_alloc_rq_maps
Message-ID: <20200503033727.GC1128091@T590>
References: <cover.1588080449.git.zhangweiping@didiglobal.com>
 <35b2fc8a9648ed16c9a465fd43c928d4393d1c4a.1588080449.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b2fc8a9648ed16c9a465fd43c928d4393d1c4a.1588080449.git.zhangweiping@didiglobal.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 09:30:28PM +0800, Weiping Zhang wrote:
> rename blk_mq_alloc_rq_maps to blk_mq_alloc_map_and_requests,
> this function allocs both map and request, make function name align
> with funtion.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  block/blk-mq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b6c907dbbb30..8ae9e375fe53 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3017,7 +3017,7 @@ static int blk_mq_realloc_map_and_requests(struct blk_mq_tag_set *set, int new)
>   * may reduce the depth asked for, if memory is tight. set->queue_depth
>   * will be updated to reflect the allocated depth.
>   */
> -static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> +static int blk_mq_alloc_map_and_requests(struct blk_mq_tag_set *set)
>  {
>  	unsigned int depth;
>  	int err;
> @@ -3177,7 +3177,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>  	if (ret)
>  		goto out_free_mq_map;
>  
> -	ret = blk_mq_alloc_rq_maps(set);
> +	ret = blk_mq_alloc_map_and_requests(set);
>  	if (ret)
>  		goto out_free_mq_map;
>  
> -- 
> 2.18.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


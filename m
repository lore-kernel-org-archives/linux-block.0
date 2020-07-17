Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7BAC433E1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 10:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792BF20684
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 10:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P17TcJ4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgGQKDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:03:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42328 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgGQKDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 06:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594980219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjQh2w716v6C6bPanaPTOORT3Ug+azqFIs2iBG77r+8=;
        b=P17TcJ4MOwdHjKvyHCNaXXPzgEjyL7TwVQHbnXy5PqpfRtOYMGLLzJYGV3wrIuAZ/Z8WPE
        SuLLjbVr7EicBC/knunrra7Mb2mQC/d145yiPuJJt6jI5/2OKlV+D7bPTlMnEHnXk+0YiI
        Zl4ZcXtbzEzaJicPWPeold4RbDn3v9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-9IBdv7pwMR6KCpGENt1Ajg-1; Fri, 17 Jul 2020 06:03:35 -0400
X-MC-Unique: 9IBdv7pwMR6KCpGENt1Ajg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1C1580183C;
        Fri, 17 Jul 2020 10:03:34 +0000 (UTC)
Received: from T590 (ovpn-13-1.pek2.redhat.com [10.72.13.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 611A35C57D;
        Fri, 17 Jul 2020 10:03:28 +0000 (UTC)
Date:   Fri, 17 Jul 2020 18:03:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: remove unused code exist in
 blk_mq_dispatch_rq_list
Message-ID: <20200717100324.GE670561@T590>
References: <20200717092348.36303-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717092348.36303-1-yangerkun@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 17, 2020 at 05:23:48PM +0800, yangerkun wrote:
> Once .queue_rq return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, we will
> insert the rq back to list, and will return false since '(!list_empty)'
> always be true. The latter check seems unused.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  block/blk-mq.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4e0d173beaa3..5e561283580f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1361,13 +1361,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  	} else
>  		blk_mq_update_dispatch_busy(hctx, false);
>  
> -	/*
> -	 * If the host/device is unable to accept more work, inform the
> -	 * caller of that.
> -	 */
> -	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
> -		return false;
> -
>  	return (queued + errors) != 0;
>  }
>  
> -- 
> 2.25.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


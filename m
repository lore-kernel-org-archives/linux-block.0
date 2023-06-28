Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29163EB64D9
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 02:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjF1CV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 22:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjF1CVt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 22:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E335B0
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687918820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AkgvUXqtTvYcSPYv6MmS9pMR3d196457Ms+2JlK9wRQ=;
        b=CsmI65fognHqJNwn4J4jVPsbGYrafSw3i69P86BxlCNf/W+9woeWuD4B1FAEKbdgIueMos
        opyITb+51GFrLoULyGF4EfUG8uIEUAkda3KAlYGXwlk/ASpzDbawe12NsE3lTv5TGWmAuz
        qKJH007DFJikP9CEa4pqQ3EaZbGV2h8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-5jJP3DmINOGmlihgUe0a4A-1; Tue, 27 Jun 2023 22:20:12 -0400
X-MC-Unique: 5jJP3DmINOGmlihgUe0a4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58782185A7A5;
        Wed, 28 Jun 2023 02:20:11 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86C08111F3B0;
        Wed, 28 Jun 2023 02:20:06 +0000 (UTC)
Date:   Wed, 28 Jun 2023 10:20:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, ming.lei@redhat.com
Subject: Re: [PATCH 1/4] blk-mq: use percpu csd to remote complete instead of
 per-rq csd
Message-ID: <ZJuY0OZu42H0oBa7@ovpn-8-21.pek2.redhat.com>
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627120854.971475-2-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 27, 2023 at 08:08:51PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> If request need to be completed remotely, we insert it into percpu llist,
> and smp_call_function_single_async() if llist is empty previously.
> 
> We don't need to use per-rq csd, percpu csd is enough. And the size of
> struct request is decreased by 24 bytes.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  block/blk-mq.c         | 12 ++++++++----
>  include/linux/blk-mq.h |  5 +----
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index decb6ab2d508..a36822479b94 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -43,6 +43,7 @@
>  #include "blk-ioprio.h"
>  
>  static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
> +static DEFINE_PER_CPU(struct __call_single_data, blk_cpu_csd);

It might be better to use call_single_data, given:

/* Use __aligned() to avoid to use 2 cache lines for 1 csd */
  typedef struct __call_single_data call_single_data_t
  	__aligned(sizeof(struct __call_single_data));

>  
>  static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
>  static void blk_mq_request_bypass_insert(struct request *rq,
> @@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
>  {
>  	struct llist_head *list;
>  	unsigned int cpu;
> +	struct __call_single_data *csd;
>  
>  	cpu = rq->mq_ctx->cpu;
>  	list = &per_cpu(blk_cpu_done, cpu);
> -	if (llist_add(&rq->ipi_list, list)) {
> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> -		smp_call_function_single_async(cpu, &rq->csd);
> -	}
> +	csd = &per_cpu(blk_cpu_csd, cpu);
> +	if (llist_add(&rq->ipi_list, list))
> +		smp_call_function_single_async(cpu, csd);
>  }

This way is cleaner, and looks correct, given block softirq is guaranteed to be
scheduled to consume the list if one new request is added to this percpu list,
either smp_call_function_single_async() returns -EBUSY or 0.

thanks
Ming


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48BC05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 03:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBBD0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 22:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjBBDZ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 22:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA26402F6
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 19:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675308314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFxU24xTK9LyWGkT3MMlpGhbfHeFlgoFYwwTA3mimJI=;
        b=hko6B6xBkr4ZUIg57Mq7XGopc+XEK7aq3XKlrLnHm5ObVLW+x+cZM82eaR2zRrbg4Zs4E7
        +NQbKAHYNmcryPdJ7Jj9wHdhGvPknvUDtlRxTXz1+LgjGN3hqTSAp0SOWTZR3gaaEMua1f
        d7aK92ac8ueD/mYXFPWadS5ANrifCRs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-qoYBlXyOMsSd7cswTTKjyg-1; Wed, 01 Feb 2023 22:25:10 -0500
X-MC-Unique: qoYBlXyOMsSd7cswTTKjyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 644D3833948;
        Thu,  2 Feb 2023 03:25:10 +0000 (UTC)
Received: from [10.22.32.115] (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28441140EBF4;
        Thu,  2 Feb 2023 03:25:10 +0000 (UTC)
Message-ID: <2083465c-6732-c631-ccd3-fbd4fc19f0f9@redhat.com>
Date:   Wed, 1 Feb 2023 22:25:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] blk-cgroup: don't update io stat for root cgroup
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>
References: <20230202021804.278582-1-ming.lei@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230202021804.278582-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/23 21:18, Ming Lei wrote:
> We source root cgroup stats from the system-wide stats, see blkcg_print_stat
> and blkcg_rstat_flush, so don't update io state for root cgroup.
>
> Fixes blkg leak issue introduced in commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> which starts to grab blkg's reference when adding iostat_cpu into percpu
> blkcg list, but this state won't be consumed by blkcg_rstat_flush() where
> the blkg reference is dropped.
>
> Tested-by: Bart van Assche <bvanassche@acm.org>
> Reported-by: Bart van Assche <bvanassche@acm.org>
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-cgroup.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index cb110fc51940..78f855c34746 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -2034,6 +2034,10 @@ void blk_cgroup_bio_start(struct bio *bio)
>   	struct blkg_iostat_set *bis;
>   	unsigned long flags;
>   
> +	/* Root-level stats are sourced from system-wide IO stats */
> +	if (!cgroup_parent(blkcg->css.cgroup))
> +		return;
> +
>   	cpu = get_cpu();
>   	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
>   	flags = u64_stats_update_begin_irqsave(&bis->sync);

Thanks for fixing this issue.

Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman


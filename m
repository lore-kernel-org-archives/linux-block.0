Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BACEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjFVNBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjFVNBe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 09:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A719AB
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687438846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anc3kC3R/ibThGofmp0Z4waKrYa9MHhOjRQqx6Elcuk=;
        b=ME9eDHvUUUMr1ZX7bSGfseBKCpKMJSeYedikiDMbjpewrO0CEORNGMxDAIyyBOwmA5L9p/
        EkxsROr+hKM7eCCy3QFlZhVhqHCkzHDEHy6BECAWxGXwfeRBCuh+QGfGcT4MIo+08ByoQg
        WHA6hfTPmtKbe87/MynOZHoQH5xt+o8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-UuE5YYRNNJWAyu5VJDa3MQ-1; Thu, 22 Jun 2023 09:00:42 -0400
X-MC-Unique: UuE5YYRNNJWAyu5VJDa3MQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63B8129AA383;
        Thu, 22 Jun 2023 13:00:35 +0000 (UTC)
Received: from [10.22.17.29] (unknown [10.22.17.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01052112132C;
        Thu, 22 Jun 2023 13:00:34 +0000 (UTC)
Message-ID: <d46a3ba6-e0d3-686b-063c-9c6ba01a96f3@redhat.com>
Date:   Thu, 22 Jun 2023 09:00:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] block: make sure local irq is disabled when calling
 __blkcg_rstat_flush
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Tejun Heo <tj@kernel.org>
References: <20230622084249.1208005-1-ming.lei@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230622084249.1208005-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 04:42, Ming Lei wrote:
> When __blkcg_rstat_flush() is called from cgroup_rstat_flush*() code
> path, interrupt is always disabled.
>
> When we start to flush blkcg per-cpu stats list in __blkg_release()
> for avoiding to leak blkcg_gq's reference in commit 20cb1c2fb756
> ("blk-cgroup: Flush stats before releasing blkcg_gq"), local irq
> isn't disabled yet, then lockdep warning may be triggered because
> the dependent cgroup locks may be acquired from irq(soft irq) handler.
>
> Fix the issue by disabling local irq always.
>
> Fixes: 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/pz2wzwnmn5tk3pwpskmjhli6g3qly7eoknilb26of376c7kwxy@qydzpvt6zpis/T/#u
> Cc: stable@vger.kernel.org
> Cc: Jay Shin <jaeshin@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-cgroup.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index f0b5c9c41cde..dce1548a7a0c 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -970,6 +970,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>   	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>   	struct llist_node *lnode;
>   	struct blkg_iostat_set *bisc, *next_bisc;
> +	unsigned long flags;
>   
>   	rcu_read_lock();
>   
> @@ -983,7 +984,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>   	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
>   	 * this lock won't cause contention most of time.
>   	 */
> -	raw_spin_lock(&blkg_stat_lock);
> +	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
>   
>   	/*
>   	 * Iterate only the iostat_cpu's queued in the lockless list.
> @@ -1009,7 +1010,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>   			blkcg_iostat_update(parent, &blkg->iostat.cur,
>   					    &blkg->iostat.last);
>   	}
> -	raw_spin_unlock(&blkg_stat_lock);
> +	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
>   out:
>   	rcu_read_unlock();
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


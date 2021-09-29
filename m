Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CA9613A7
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 11:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhI2LvX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:51:23 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33548 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbhI2LvX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 07:51:23 -0400
Received: by mail-wr1-f53.google.com with SMTP id t18so3860073wrb.0
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 04:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kHpUmrPsKhrLx7UYZQumswVnpo8AVuQi6znyFKxVTeY=;
        b=0GuU0mtkpQ3aDVxuYI1L6rJEduZnL2XSEzxVUpEahX7Xf7bVve9e3+Jd2HkJRIrAUW
         FgT6fW9e10axjLXTsyvRiXzfyS+CvjWaZOGp4e1vqu+cJXrQwVpgGtTyzkOL68TUNbgf
         fDBAegrBzvCIgsmExlH9E4+v+1pwiFRhfOIAHt4gGgnEAIw5wGP8DXQ0PugEfN+gEZJf
         flsy+gk7cib7jnJycu9aJLzXp70GDx5BL/hQ+tPiK6sVo3Dw9quQLZkC8wvqWENMcSQd
         GKt107b6xe8sCKIwzhzayMzoHtbnvUAZeWmgItquX6DUNC6bPy4HGeAVKDyLDi6K54B0
         qhrQ==
X-Gm-Message-State: AOAM533z6fgWJW7aUXSVui65xJkrEi4v2ySMO6kUfEp9znz9XkYReeK+
        P9OhUFlA6oDKNIlObKrfzOQ=
X-Google-Smtp-Source: ABdhPJycJ2fUmnINyNlIcVFOzUgkS95yA8gAqePHal7+2fu522CVLQLPMpUBX5uMomd10e9BaXxBrw==
X-Received: by 2002:adf:ab5e:: with SMTP id r30mr1010897wrc.124.1632916181530;
        Wed, 29 Sep 2021 04:49:41 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t126sm1398862wma.4.2021.09.29.04.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 04:49:41 -0700 (PDT)
Subject: Re: [PATCH 4/5] nvme: paring quiesce/unquiesce
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-5-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dc9152dd-afb3-5902-004f-84fa27cee9ca@grimberg.me>
Date:   Wed, 29 Sep 2021 14:49:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929041559.701102-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/29/21 7:15 AM, Ming Lei wrote:
> The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> stops and starts the queue unconditionally. And there can be concurrent
> quiesce/unquiesce coming from different unrelated code paths, so
> unquiesce may come unexpectedly and start queue too early.
> 
> Prepare for supporting nested / concurrent quiesce/unquiesce, so that we
> can address the above issue.
> 
> NVMe has very complicated quiesce/unquiesce use pattern, add one mutex
> and queue stopped state in nvme_ctrl, so that we can make sure that
> quiece/unquiesce is called in pair.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h |  4 ++++
>   2 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 23fb746a8970..5d0b2eb38e43 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4375,6 +4375,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
> +	mutex_init(&ctrl->queues_stop_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
>   	xa_init(&ctrl->cels);
>   	init_rwsem(&ctrl->namespaces_rwsem);
> @@ -4450,14 +4451,44 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>   
> +static void __nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	lockdep_assert_held(&ctrl->queues_stop_lock);
> +
> +	if (!ctrl->admin_queue_stopped) {
> +		blk_mq_quiesce_queue(ctrl->admin_q);
> +		ctrl->admin_queue_stopped = true;
> +	}
> +}
> +
> +static void __nvme_start_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	lockdep_assert_held(&ctrl->queues_stop_lock);
> +
> +	if (ctrl->admin_queue_stopped) {
> +		blk_mq_unquiesce_queue(ctrl->admin_q);
> +		ctrl->admin_queue_stopped = false;
> +	}
> +}

I'd make this a bit we can flip atomically.

> +
>   static void nvme_start_ns_queue(struct nvme_ns *ns)
>   {
> -	blk_mq_unquiesce_queue(ns->queue);
> +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> +
> +	if (test_bit(NVME_NS_STOPPED, &ns->flags)) {
> +		blk_mq_unquiesce_queue(ns->queue);
> +		clear_bit(NVME_NS_STOPPED, &ns->flags);
> +	}
>   }
>   
>   static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   {
> -	blk_mq_quiesce_queue(ns->queue);
> +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> +
> +	if (!test_bit(NVME_NS_STOPPED, &ns->flags)) {
> +		blk_mq_quiesce_queue(ns->queue);
> +		set_bit(NVME_NS_STOPPED, &ns->flags);
> +	}
>   }

Why not use test_and_set_bit/test_and_clear_bit for serialization?

>   
>   /*
> @@ -4490,16 +4521,18 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
>   
> +	mutex_lock(&ctrl->queues_stop_lock);
>   	down_read(&ctrl->namespaces_rwsem);
>   
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
> -		nvme_start_admin_queue(ctrl);
> +		__nvme_start_admin_queue(ctrl);
>   
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		nvme_set_queue_dying(ns);
>   
>   	up_read(&ctrl->namespaces_rwsem);
> +	mutex_unlock(&ctrl->queues_stop_lock);

This extra lock wrapping the namespaces_rwsem is scary. The
ordering rules are not clear to me.

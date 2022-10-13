Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC9C4332F
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 10:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJMKWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMKWV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 06:22:21 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349D10452F
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 03:22:19 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id bu30so2073748wrb.8
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 03:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAFpSuhE/g245plQMmYFcjOwS/J2mWdqesS431eNBu0=;
        b=PWuVkHmjohxDbfvJrs4MeOrCXHEREVH++L6zMD9EPAU79an7zzd3l1QwtzRve1ucxF
         py3MxJttZXNAQbOf2N8rR+27uAqWFS9/NgVfPfY7dlvSIwd4tsHVNrVkF0e2E6j0UsHy
         WZdrbF2xuzj/msZGvmb9ZVAvbazWK5OJFXjsKO/BRr0wJz4gLuw2yEDVgEZK4zCEc9C9
         SLdu/MPXeePenEWer3qmz5zPbtAlxKeeNMaouaqn74tN3wxMBhYLjSZH0bvcGbG6sFR3
         mfEEITm28i1qHJEPWql7p4zSUc6UVZ6GL0IazipJSxrvNoc1dPJksv3q3cDoEVJP07qr
         34qQ==
X-Gm-Message-State: ACrzQf3HQI9sa6Fsb932dhWOIrUTc0APAKtsuSy8OAVWas4XuuNwi3s1
        wNHryA3LLG3Jo87WEUK1Tjc=
X-Google-Smtp-Source: AMsMyM7EfaYNqJToij1GvgOfjzZDuLhFqSCkJv00XeteuZgZh5Q91WNfLJ+64cMWrkoky5RfML6bmQ==
X-Received: by 2002:a5d:5950:0:b0:22d:d0b5:a9b2 with SMTP id e16-20020a5d5950000000b0022dd0b5a9b2mr21165934wri.452.1665656537723;
        Thu, 13 Oct 2022 03:22:17 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003a2f2bb72d5sm5940326wmp.45.2022.10.13.03.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 03:22:16 -0700 (PDT)
Message-ID: <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
Date:   Thu, 13 Oct 2022 13:22:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-3-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221013094450.5947-3-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/13/22 12:44, Chao Leng wrote:
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> Now use NVME_NS_STOPPED to ensure pairing quiescing and unquiescing.
> If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be invalided,
> so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> 
> nvme connect_q should be never quiesced, so set QUEUE_FLAG_NOQUIESCED
> when init connect_q.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/core.c | 42 +++++++++++++-----------------------------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c1..0d07a07e02ff 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> +		blk_queue_flag_set(QUEUE_FLAG_NOQUIESCED, ctrl->connect_q);
>   	}
>   
>   	ctrl->tagset = set;
> @@ -5089,20 +5090,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>   
> -static void nvme_start_ns_queue(struct nvme_ns *ns)
> -{
> -	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_unquiesce_queue(ns->queue);
> -}
> -
> -static void nvme_stop_ns_queue(struct nvme_ns *ns)
> -{
> -	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_quiesce_queue(ns->queue);
> -	else
> -		blk_mq_wait_quiesce_done(ns->queue);
> -}
> -
>   /*
>    * Prepare a queue for teardown.
>    *
> @@ -5111,13 +5098,14 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>    * holding bd_butex.  This will end buffered writers dirtying pages that can't
>    * be synced.
>    */
> -static void nvme_set_queue_dying(struct nvme_ns *ns)
> +static void nvme_set_queue_dying(struct nvme_ns *ns, bool start_queue)
>   {
>   	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>   		return;
>   
>   	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> +	if (start_queue)
> +		blk_mq_unquiesce_queue(ns->queue);
>   
>   	set_capacity_and_notify(ns->disk, 0);
>   }
> @@ -5132,6 +5120,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>   void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
> +	bool start_queue = false;
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   
> @@ -5139,8 +5128,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
>   
> +	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> +		start_queue = true;

Why can't we just start the queues here? just call nvme_start_queues()?
Why does it need to happen only after we mark the disk dead?
The documentation only says that we need to set the capacity to 0
after we unquiesce, but it doesn't say that we can't unquiesce erliear.

Something like this:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7e840549a940..27dc393eed97 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5127,8 +5127,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
                 return;

         blk_mark_disk_dead(ns->disk);
-       nvme_start_ns_queue(ns);
-
         set_capacity_and_notify(ns->disk, 0);
  }

@@ -5149,6 +5147,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
         if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
                 nvme_start_admin_queue(ctrl);

+       if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+               nvme_start_queues(ctrl);
+
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 nvme_set_queue_dying(ns);
--

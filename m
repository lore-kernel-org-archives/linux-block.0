Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BAC636D4
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 20:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBAUVK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBAUVK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 15:21:10 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102821955
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 12:21:09 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id m13so7737389plx.13
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2023 12:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhXnlDjbNDYCV+jzLFLYnKg9FibPBUbCn8wmHAI34RE=;
        b=FdkO0IshbORqkxsCDtKoH4wzOlH4EphVjjfIN8x5KuIyPHYejrmGA5Nm4e3qVGB0br
         jZaOOD9bQakOAbHsenLNyml4BPPPvDSjruaLVvmqOKG1xJ3NHneNeAjCeeUOHd1yurak
         stspZnTWqEwu5RUVwgGsl30VKCtW80iFYMnNPTcEFpRB2MQXejWWoQ447dRctKIEqnrO
         eo90bg8r9AAq4pwZL8D+UsZ1fZFjRLUQ3SNH5A1aReMPMV6s4yMcX3Pu9zOSfvJyuAmN
         BkORSQJxo1CAI3bsutIlY36tAlEdoZP/mU3EQbD0BWxs7dZl6dgObet3yj0Aa0LImYCr
         YmJw==
X-Gm-Message-State: AO0yUKVAvwM2URzbEmiXxldzXI6wLLB2kadKGznNgTctSXP3lJ6TLoXA
        OTP9j2ZZSrDcDmNZ6AEQen7ju07XHx8=
X-Google-Smtp-Source: AK7set/XZgN7FAnI2wVMBsmNZnPXqrUSfq/axrjod8G2086/Zm4U/+xrgInw7jIu3cEVKw9Tl5Rqmg==
X-Received: by 2002:a05:6a20:9b9b:b0:9f:3197:bfa1 with SMTP id mr27-20020a056a209b9b00b0009f3197bfa1mr3879133pzb.7.1675282869053;
        Wed, 01 Feb 2023 12:21:09 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f3cf:17ca:687:af15? ([2620:15c:211:201:f3cf:17ca:687:af15])
        by smtp.gmail.com with ESMTPSA id t6-20020a637806000000b004d2f344430bsm6134261pgc.75.2023.02.01.12.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 12:21:07 -0800 (PST)
Message-ID: <a1bb78dd-a793-197b-c8e6-31cf2d113466@acm.org>
Date:   Wed, 1 Feb 2023 12:21:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: Revert "let blkcg_gq grab request queue's refcnt"
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Waiman Long <longman@redhat.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230130232257.972224-1-bvanassche@acm.org>
 <Y9h0WMOqNau4s0c0@T590> <102b71d2-ee00-c317-fd63-3f3d006505d4@acm.org>
 <Y9nGsMEiecgnQDfE@T590> <Y9nqtcbKYAyE/lB7@T590> <Y9qLe6tZikQbps29@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y9qLe6tZikQbps29@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/23 07:55, Ming Lei wrote:
> The following patch can address the blkg leak issue:
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

The above patch passes my tests. Feel free to add:

Tested-by: Bart van Assche <bvanassche@acm.org>

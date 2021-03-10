Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0063C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764DC64FBC
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhCJP5Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:57:25 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43043 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhCJP5R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 10:57:17 -0500
Received: by mail-pl1-f176.google.com with SMTP id d8so8668844plg.10;
        Wed, 10 Mar 2021 07:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ed1eF4vTxVn8+UDZHdqJb6uBIYF4gHr46zP4BQvVtmY=;
        b=qGIq3PR7gEeg6C6sgDiinFktQmBKh1yNsx632p8Uv433QmzFoSStkFCS8BjQs4j8YK
         jRn+I9vz8XK8tu2Xvx0b3B63o8EEirAbtRGpQVLLyXK4Nrw/19513yAAMKTq83J5bCzY
         s6sfi/2TPzTOrqUAc4/SqzaJZ8KlLIuIWdfT9FI2DX7rdfLbsa7LYrz0uNHwttCBk5mC
         Age1fSCWCjtFYpyUYBuRBPhLwLZszCX41UF5jn+F5Xf2QGLko4AGtDV5273iPJZHK77L
         OhswOlt73QPzrfXtGyX7Gw99WHXaPrjk/43/JrH6+apaMxRsZ1+LVmUl1EtVzTxDiVLk
         Rvjg==
X-Gm-Message-State: AOAM531mfPixlhxHTUzarX53tGq2K8F5Uzqcm5k/Gj2kDQLutsGlYGDD
        ebJFmVg2LJQFBypqNA15Epg=
X-Google-Smtp-Source: ABdhPJwpwv5OjS4z0+0udZcuR+v+CLo25h/hf/MdXEdzrdeIubGVjS/jiXlnTYehVzQbyFNGClpVdQ==
X-Received: by 2002:a17:90a:bf0a:: with SMTP id c10mr4126242pjs.195.1615391836481;
        Wed, 10 Mar 2021 07:57:16 -0800 (PST)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id x1sm6959115pje.40.2021.03.10.07.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:57:15 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e6ce148d-213c-6588-33dc-9d6ed51d3595@acm.org>
Date:   Wed, 10 Mar 2021 07:57:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614957294-188540-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/21 7:14 AM, John Garry wrote:
> diff --git a/block/blk.h b/block/blk.h
> index 3b53e44b967e..1a948bfd91e4 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -201,10 +201,29 @@ void elv_unregister_queue(struct request_queue *q);
>   static inline void elevator_exit(struct request_queue *q,
>   		struct elevator_queue *e)
>   {
> +	struct blk_mq_tag_set *set = q->tag_set;
> +	struct request_queue *tmp;
> +
>   	lockdep_assert_held(&q->sysfs_lock);
>   
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
> +		if (tmp == q)
> +			continue;
> +		blk_mq_freeze_queue(tmp);
> +		blk_mq_quiesce_queue(tmp);
> +	}
> +
>   	blk_mq_sched_free_requests(q);
>   	__elevator_exit(q, e);
> +
> +	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
> +		if (tmp == q)
> +			continue;
> +		blk_mq_unquiesce_queue(tmp);
> +		blk_mq_unfreeze_queue(tmp);
> +	}
> +	mutex_unlock(&set->tag_list_lock);
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

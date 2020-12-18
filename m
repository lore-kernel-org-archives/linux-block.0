Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8008AC2BBCF
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 01:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D3523A5A
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 01:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgLRB4g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 20:56:36 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:39872 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgLRB4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 20:56:35 -0500
Received: by mail-pj1-f42.google.com with SMTP id hk16so465210pjb.4;
        Thu, 17 Dec 2020 17:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ejzs/9wDH46rXiWxjSID2tbI9cGlj6Llr1w/JV/Xgbk=;
        b=XPOVBZ/tuZ4/T2MxJLiOJqdtozhmupo/o6bAnmj8UboQcVp7uKqdz8Oc5wyfaFmA6X
         M4FuodNNkii4bg+GLpy29ZS+dx0dpyeP8c7L9pghO9dNyqHhrqVVqKdmzL9yQX+hcp+W
         cNGZ4Ur7b4d2MJ4c1iuq+x5eu6O4h8yVBQTnODxcgmXU70Pyx4/gNe6yqEcqMdeh0ZxK
         MAsD+YMNeVv31DSPbtYo24XFUe4y7Mfyd0jNPMKJiFY8qfcrRb9SiYCBlqEBrH3IEeRV
         AhTkTYrz9f6eia02knRLEht18+lFb2nk0cB++zXIHJ7XTkhNHeIhXjxSGXo4x37BE9RF
         LNsg==
X-Gm-Message-State: AOAM530T1f4mdS7kKG7sPQfB4HnunwAaolRb7nexW6I4pDqhn99tB22c
        GUd3brJ5Ns9+mZBbE+uUjQ8=
X-Google-Smtp-Source: ABdhPJxZdRa6PwldpktbLodeG4FvGJXUzNaRkbOGXiXuPSuPbxUzhH+RR58PO70WUnIcdha4h5Ccgg==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr1991435pjb.220.1608256554580;
        Thu, 17 Dec 2020 17:55:54 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m3sm6873983pfa.134.2020.12.17.17.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 17:55:53 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, ppvk@codeaurora.org,
        kashyap.desai@broadcom.com, linuxarm@huawei.com
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <30c16455-6d7d-39ac-b3fc-4ee38199e683@acm.org>
Date:   Thu, 17 Dec 2020 17:55:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1608203273-170555-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 3:07 AM, John Garry wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index a6df2d5df88a..853ed5b889aa 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -358,10 +358,19 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>  {
>  	int i;
>  
>  	for (i = 0; i < tagset->nr_hw_queues; i++) {
> -		if (tagset->tags && tagset->tags[i])
> -			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> +		if (tagset->tags && tagset->tags[i]) {
> +			struct blk_mq_tags *tags = tagset->tags[i];
> +
> +			if (!atomic_inc_not_zero(&tags->iter_usage_counter))
> +				continue;
> +
> +			__blk_mq_all_tag_iter(tags, fn, priv,
>  					      BT_TAG_ITER_STARTED);
> +
> +			atomic_dec(&tags->iter_usage_counter);
> +		}
>  	}
>  }

Atomic operations are (a) more expensive than rcu_read_lock() /
rcu_read_lock() and (b) do not provide the same guarantees.
rcu_read_lock() has acquire semantics and rcu_read_unlock() has
release semantics. Regular atomic operations do not have these
semantics which means that the CPU is allowed to reorder certain
regular loads and stores against atomic operations. Additionally,
atomic operations are more expensive than the corresponding RCU
primitives. In other words, I would be much happier if this patch
series would use RCU instead of atomics.

Thanks,

Bart.

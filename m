Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB5AC433DB
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 04:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0BA65011
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 04:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCFEnX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 23:43:23 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33294 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFEnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 23:43:07 -0500
Received: by mail-pl1-f177.google.com with SMTP id c16so2439356ply.0;
        Fri, 05 Mar 2021 20:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WpuX4jtViXGHBqpqCDoI3IPp3tBlZBEZA1GBacd28cw=;
        b=i7hLxZOUDceuapM0M9f8/X0dUPqxFtYHHTSdTgCvRngpWIykp+cmczq80G9csK4iy8
         02nmCHqH729P0QSMPc6YVfchJ6rPV0kr3kdSeDlI1EjUjtIPhCebQxEQz479XO/tAjUL
         EfQVZFVp6pwISKLWWpNO/wxP4sjJt2NHT60XAaXUjeNh6SiDSHV8m3dcvjNxnXLKSJFI
         C2IFacmyteNdw46aYW2Mc4xrt5dXIlsapaBmJiGZF2TXOyog51rgun04bNgT2v8aZ9lE
         /XW1f05IuApaMqYUFJSxcvmOAGoN8gIyMrFh0xxkbBFj1RWeCC+eW8F7M5dy/LjkK1Z0
         Rtmg==
X-Gm-Message-State: AOAM5316jnn4L6z5UqI6esmDvVvdu6x0DJ2vQJoZ7t9CFSN8JpLpg28i
        UEoKufePQVOd59meq4sns+8=
X-Google-Smtp-Source: ABdhPJyjpLfbzjfzX2gwl18nucxUcIfibp3ZYmX+nqFjK7BU4AymfgOUJJxNmUDOgCa/oeamnYyd2Q==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr13643790pjh.141.1615005786526;
        Fri, 05 Mar 2021 20:43:06 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:508e:d398:f4d5:3d44? ([2601:647:4000:d7:508e:d398:f4d5:3d44])
        by smtp.gmail.com with ESMTPSA id k9sm3437410pji.8.2021.03.05.20.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 20:43:05 -0800 (PST)
Subject: Re: [RFC PATCH v3 3/3] blk-mq: Lockout tagset iterator when exiting
 elevator
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-4-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <48a3cf78-3f6d-c13c-bca2-1f8277817b45@acm.org>
Date:   Fri, 5 Mar 2021 20:43:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614957294-188540-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/21 7:14 AM, John Garry wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 7ff1b20d58e7..5950fee490e8 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -358,11 +358,16 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>  {
>  	int i;
>  
> +	if (!atomic_inc_not_zero(&tagset->iter_usage_counter))
> +		return;
> +
>  	for (i = 0; i < tagset->nr_hw_queues; i++) {
>  		if (tagset->tags && tagset->tags[i])
>  			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>  					      BT_TAG_ITER_STARTED);
>  	}
> +
> +	atomic_dec(&tagset->iter_usage_counter);
>  }
>  EXPORT_SYMBOL(blk_mq_tagset_busy_iter);

This changes the behavior of blk_mq_tagset_busy_iter(). What will e.g.
happen if the mtip driver calls blk_mq_tagset_busy_iter(&dd->tags,
mtip_abort_cmd, dd) concurrently with another blk_mq_tagset_busy_iter()
call and if that causes all mtip_abort_cmd() calls to be skipped?

> +	while (atomic_cmpxchg(&set->iter_usage_counter, 1, 0) != 1);

Isn't it recommended to call cpu_relax() inside busy-waiting loops?

>  	blk_mq_sched_free_requests(q);
>  	__elevator_exit(q, e);
>  
> +	atomic_set(&set->iter_usage_counter, 1);

Can it happen that the above atomic_set() call happens while a
blk_mq_tagset_busy_iter() call is in progress? Should that atomic_set()
call perhaps be changed into an atomic_inc() call?

Thanks,

Bart.

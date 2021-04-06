Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA34C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4B4613CD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbhDFVFn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:05:43 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:44847 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbhDFVFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 17:05:39 -0400
Received: by mail-pl1-f174.google.com with SMTP id d8so8201961plh.11;
        Tue, 06 Apr 2021 14:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQtbHZh9mMJ8Gbu9gM4FnKVSS66GRXJs/SnLTdKoo7M=;
        b=QFvBIDGWHLrDx94EDIcl2IqrnxO6i85u5ptglGN3/dzrIXD8/ulkeNBHXAUNBav+Zg
         TwuEBx/lvEhHtV8AxvJpMlm4Bn+K1c5hmPJzYauMGeBcIqEwr4lL5BkSBRXzPoVZ6YTb
         gWGhtYtW+qxlTyliO0pbfN3vbN1wElzy0Nvo673Pijh2xzdHDtAIGoHufe6p+LEdXNDI
         1vQGEr46hguYdeje0aZh4DGAppUUh8W7AAanysmD+QnjG8pc4c3xIAuEET1yiV+Fvhck
         Vih7PT8iPeRjbwHGu8e/Ev8voLGhSVLHkb0S2BiL6b2Zsl5hWVwpGBOC6MuLUZ8EwRLz
         3oYA==
X-Gm-Message-State: AOAM531Hibdxyw0m3X/69T4i5Qy7fv+ceyXK9/OgukXMq7S+vs1UKCGp
        otPEAs2Xv1VrE/nlcoCUpwk=
X-Google-Smtp-Source: ABdhPJwbAsNf7r8WrcbSmbRWJfBxaCqUr/jYwMNpWXvVtteJfOmZaO/tlRKiJyOsNZJHdBxgjFirUg==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr93448pjb.120.1617743130086;
        Tue, 06 Apr 2021 14:05:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:277d:764e:de23:a2e8? ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id f2sm19720728pfq.129.2021.04.06.14.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 14:05:29 -0700 (PDT)
Subject: Re: [RESEND PATCH v5 2/2] bio: add limit_bio_size sysfs
To:     Changheun Lee <nanich.lee@samsung.com>, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <20210316074401.4594-1-nanich.lee@samsung.com>
 <CGME20210316080106epcas1p3522dda95e9c97fc39b40b008bbf87c04@epcas1p3.samsung.com>
 <20210316074401.4594-2-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7c8d9787-f0eb-9ef1-6ebf-f383c27b599a@acm.org>
Date:   Tue, 6 Apr 2021 14:05:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316074401.4594-2-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/21 12:44 AM, Changheun Lee wrote:
> Add limit_bio_size block sysfs node to limit bio size.
> Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
> And bio max size will be limited by queue max sectors via
> QUEUE_FLAG_LIMIT_BIO_SIZE set.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
>  Documentation/block/queue-sysfs.rst   |  7 +++++++
>  block/blk-sysfs.c                     |  3 +++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> index e34cdeeeb9d4..86a7b15410cf 100644
> --- a/Documentation/ABI/testing/sysfs-block
> +++ b/Documentation/ABI/testing/sysfs-block
> @@ -316,3 +316,13 @@ Description:
>  		does not complete in this time then the block driver timeout
>  		handler is invoked. That timeout handler can decide to retry
>  		the request, to fail it or to start a device recovery strategy.
> +
> +What:		/sys/block/<disk>/queue/limit_bio_size
> +Date:		Feb, 2021
> +Contact:	Changheun Lee <nanich.lee@samsung.com>
> +Description:
> +		(RW) Toggle for set/clear QUEUE_FLAG_LIMIT_BIO_SIZE queue flag.
> +		Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size
> +		is set. And bio max size will be limited by queue max sectors.
> +		QUEUE_FLAG_LIMIT_BIO_SIZE will be cleared if limit_bio_size is
> +		cleard. And limit of bio max size will be cleard.
> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> index 2638d3446b79..cd371a821855 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst
> @@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
>  do not support zone commands, they will be treated as regular block devices
>  and zoned will report "none".
>  
> +limit_bio_size (RW)
> +-------------------
> +This indicates QUEUE_FLAG_LIMIT_BIO_SIZE queue flag value. And
> +QUEUE_FLAG_LIMIT_BIO_SIZE can be changed via set(1)/clear(0) this node.
> +bio max size will be limited by queue max sectors via set this node. And
> +limit of bio max size will be cleard via clear this node.
> +
>  Jens Axboe <jens.axboe@oracle.com>, February 2009
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index b513f1683af0..840d97f427e6 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -288,6 +288,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
>  QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
>  QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
>  QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
> +QUEUE_SYSFS_BIT_FNS(limit_bio_size, LIMIT_BIO_SIZE, 0);
>  #undef QUEUE_SYSFS_BIT_FNS
>  
>  static ssize_t queue_zoned_show(struct request_queue *q, char *page)
> @@ -615,6 +616,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
>  QUEUE_RW_ENTRY(queue_iostats, "iostats");
>  QUEUE_RW_ENTRY(queue_random, "add_random");
>  QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
> +QUEUE_RW_ENTRY(queue_limit_bio_size, "limit_bio_size");
>  
>  static struct attribute *queue_attrs[] = {
>  	&queue_requests_entry.attr,
> @@ -648,6 +650,7 @@ static struct attribute *queue_attrs[] = {
>  	&queue_rq_affinity_entry.attr,
>  	&queue_iostats_entry.attr,
>  	&queue_stable_writes_entry.attr,
> +	&queue_limit_bio_size_entry.attr,
>  	&queue_random_entry.attr,
>  	&queue_poll_entry.attr,
>  	&queue_wc_entry.attr,

Has it been considered to introduce a function to set the BIO size limit
instead of introducing a new sysfs attribute? See also
blk_queue_max_hw_sectors().

Thanks,

Bart.

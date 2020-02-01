Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E533C33C9E
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 04:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EB8206D3
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 04:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d87Scoi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgBAEoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 23:44:24 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37556 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgBAEoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 23:44:24 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so3936627pjb.2
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 20:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aiy4PmBJE71vUKt1kw5awgcy3bfWPjaQVfm2udlJN4A=;
        b=d87Scoi3N4PkN7raMGoGCBJ+MoDiaVpy+Qv2m1nAV9Xqv/bBOmszLEhZu6rqoUYTm1
         EV8vPFRo1IvMPgSab/E69v1UhfST9BZPLCdeZBTfAeRv6SWqBc4Akb42seRpwhGYvfCN
         wn89zCKtXmUQQeFJyrKEfHDxXinHTELF793iWMF+2U3QOWmLR3UEKGS0e7l/uXIOdvKP
         6PrNY6KC4Lbw0DYNucB/d15rZBqVFcrQPsJ1Lr81fX1JVM3/f60zuXgEjZnogSX3/voT
         i/tbjd0s/kVenITWebefN1mbVztYPX7HyhR9ytZ4iaV4UNRu5Y5mA0K09A8FGrTJIgyb
         imzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aiy4PmBJE71vUKt1kw5awgcy3bfWPjaQVfm2udlJN4A=;
        b=kHyIrSUHOtknhdmWBcXDIqqraDCsHEGgzy9i8GoevBCeRRJ7Ihuz+3K6yFAinqQy3K
         RtgwA/z5jT/NZ2aRt9NbwzGym1gfNR4gB3o4pkfwKkkyJa61rfLY47pVjQbPVciaDr2H
         cxDxpsG4dcmn00XaLiyrFgTJEJcLF60Il44/jLZChX/PUZ6AFWEm4smsQps5Hg/jHBia
         oWpN17bAioNCqxe9EK+qT+2EcP44M1BBl+sdVB408CUuD5GHmjk6VR/5jibb463lBwH1
         SbGkM9nPYAr0EW0tEiFU0/DDE4eyz2yI6idLsntLDOXDMc0ofaQo3e+evU0OuBrGVTz4
         MEAw==
X-Gm-Message-State: APjAAAUKDlDY/hrM8lsTtI/2nAh6zeIEFbH0IPLQNQ5tT3908kEQhynC
        dBIbieZ+kr86aHZm476gRjvh6w==
X-Google-Smtp-Source: APXvYqyVTSwqHq3VC8V93VCsXo/84I4PvVMaVGJ3N6Lx/nkRC+o1gzjGXrrSECgeun1AhFtrnhkPUg==
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr13906231plb.123.1580532263482;
        Fri, 31 Jan 2020 20:44:23 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y190sm12325751pfb.82.2020.01.31.20.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 20:44:22 -0800 (PST)
Subject: Re: [PATCH BUGFIX 5/6] block, bfq: get a ref to a group when adding
 it to a service tree
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com
References: <20200131092409.10867-1-paolo.valente@linaro.org>
 <20200131092409.10867-6-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0572f01d-ab0a-b89e-a5d4-6ddf2d3db18e@kernel.dk>
Date:   Fri, 31 Jan 2020 21:44:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131092409.10867-6-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/20 2:24 AM, Paolo Valente wrote:
> BFQ schedules generic entities, which may represent either bfq_queues
> or groups of bfq_queues. When an entity is inserted into a service
> tree, a reference must be taken, to make sure that the entity does not
> disappear while still referred in the tree. Unfortunately, such a
> reference is mistakenly taken only if the entity represents a
> bfq_queue. This commit takes a reference also in case the entity
> represents a group.
> 
> Tested-by: Chris Evich <cevich@redhat.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-cgroup.c  |  2 +-
>  block/bfq-iosched.h |  1 +
>  block/bfq-wf2q.c    | 16 +++++++++++++++-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index c818c64766e5..f85b25fd06f2 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
>  		kfree(bfqg);
>  }
>  
> -static void bfqg_and_blkg_get(struct bfq_group *bfqg)
> +void bfqg_and_blkg_get(struct bfq_group *bfqg)
>  {
>  	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
>  	bfqg_get(bfqg);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index f1cb89def7f8..b9627ec7007b 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -984,6 +984,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
>  struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
>  struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>  struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
> +void bfqg_and_blkg_get(struct bfq_group *bfqg);
>  void bfqg_and_blkg_put(struct bfq_group *bfqg);
>  
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 26776bdbdf36..ef06e0d34b5b 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -533,7 +533,13 @@ static void bfq_get_entity(struct bfq_entity *entity)
>  		bfqq->ref++;
>  		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
>  			     bfqq, bfqq->ref);
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	} else
> +		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
> +					       entity));
> +#else
>  	}
> +#endif

These are really an eyesore and needs improving. Surely that can be done
in a cleaner way?

-- 
Jens Axboe


Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2EAC43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4149720714
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 21:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QTIi2XlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgC1VcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:32:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42309 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1VcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 17:32:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so16189182wrx.9
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4NtauribHFasrWNUQmgLR2FCAHn2NDAqemG54NUCPYM=;
        b=QTIi2XlV9y966P+ta3KnqKslWIo+VfiDpa3w/ThbhOvGJ2iNdDfAzbqu8JvAwvbDF3
         2D92v0dPqNQcYWTUxJvTg1ShCYpzhePKCLCr+ogisAfF8jsXh+zkyh5aF5VtQbmmIKXi
         GWJZYOH72FJ13OCO1zWLWJ5VRP/NYZeRB2rQZtMNyH73qHi1uD0x/mtkRR8sLixMhz3U
         MzVEQD+xOU5r4Dyfm/tSTW4DdRvkeKu6d49GlxFwaG/7fJxndKs4IanTLnMWl7PFnkzQ
         3WwARIyLAxoXKFQkAUO3lpea2sIjjlQx7IDqmfwvRcRB1VYKsg0tIGqItyh3yCVh1ESP
         P/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4NtauribHFasrWNUQmgLR2FCAHn2NDAqemG54NUCPYM=;
        b=RcBbd5rw7as8wpkb2pEYvQiQ8wK6Wp5g+AzwLDdvERMgRzdIHaCZAJAOBuqW9/37Fy
         0I+MsjSPrUa6tu+ynD4JJycMKsEP1KUBQJszeewwdk+OwzNOFMugWaWbaxuytBihfO36
         xP3e40VIuW5Huw9BZY9p4WeyA4sM/j3mGzUhulbp0qf3jQg59LvSrlwMzkU8RSLyGQDJ
         eD8fVYBWJDDErDzt7O9VP58DfGxnjUk9LmmLkP+D1MWDvHxabvalLIqjHo94KtBTTSt3
         u3efp9hY8PuR9ynRj5894oEh59VKqZQUgGlJq37fcvleKKM2DXJwnGWXn/BFFNa/ZJQL
         dzVg==
X-Gm-Message-State: ANhLgQ00pbfUhoMu3iOZDRiUMMQFhNNAoBIsabsrOhaUlI1njTmckpCb
        qlfnUDZLgEIaYcxdWsv0I/rDjXw0i0M=
X-Google-Smtp-Source: ADFU+vuuc4L9uqI6I4ec4Qwo23cdRwQ6qfWeTnuQuwCF8VXerxNpZZ2VakF66/dE0z8GUocvxVfFfw==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr6553406wrx.395.1585431132295;
        Sat, 28 Mar 2020 14:32:12 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4809:f600:1d90:b47c:300d:f695? ([2001:16b8:4809:f600:1d90:b47c:300d:f695])
        by smtp.gmail.com with ESMTPSA id k3sm15086689wrw.61.2020.03.28.14.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 14:32:11 -0700 (PDT)
Subject: Re: [PATCH] block: return NULL in blk_alloc_queue() on error
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hch@lst.de
References: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <22e5e0bf-49db-03a8-d81f-00733f117765@cloud.ionos.com>
Date:   Sat, 28 Mar 2020 22:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/28/20 7:27 PM, Chaitanya Kulkarni wrote:
> This patch fixes follwoing warning:
> 
> block/blk-core.c: In function ‘blk_alloc_queue’:
> block/blk-core.c:558:10: warning: returning ‘int’ from a function with return type ‘struct request_queue *’ makes pointer from integer without a cast [-Wint-conversion]
>     return -EINVAL;
> 
> Fixes: 3d745ea5b095a ("block: simplify queue allocation")
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   block/blk-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 18b8c09d093e..7e4a1da0715e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -555,7 +555,7 @@ struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id)
>   	struct request_queue *q;
>   
>   	if (WARN_ON_ONCE(!make_request))
> -		return -EINVAL;
> +		return NULL;

Maybe return ERR_PTR(-EINVAL) is better.

Thanks,
Guoqing

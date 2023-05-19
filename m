Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFFEC7EE26
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjESTzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjESTzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 15:55:49 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797271B4
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:55:48 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ae851f2a7dso7026905ad.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684526148; x=1687118148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGgKoOi4Si5fLfKgXosQHnkYGaOCBF30A3pvVN3HNDI=;
        b=FtUnQci4bnmyzElIblPJ+WsVWoYLaGdiyr4ZW2B1Kc6EZrxuWK4zS9HnnEoEXNaRjH
         hZGFn2N5YssUia3GRQ8evAqPnggZuLMcGi3h2Y3n6UhyzrRkj1rtzKnL+tAAo8MpSSCw
         Xg45pz6/fx3Fis+5geDw2rxmL9f6PLAyxzu0ELT2kPjY+NQYNhVa66JF21xj+ZaQabUQ
         Xj7qStTMxB0GFQQ0T0vcnp3gw1n+EY9W8xNsfKxoEsIX4vl+Xfeh77uti4dR5X9jB6DL
         cp2CNUmgQx5Ld97gLZZ+T/3dGnKN7Khn8t/0HcoQkbxTldAAOrq4hVk8S15uiLjWXGpS
         gXug==
X-Gm-Message-State: AC+VfDxZtGVfIDY1D+xNrBivBYWRAxHdljtbLhZQ52GkhsVugKt65g1W
        oghuaSKbWzZdPuksnL2RM/A1GmOVqiY=
X-Google-Smtp-Source: ACHHUZ7StGNbdD2SSxb3eSs/WVtBcOkhlsy1RVUUL9asvlmjW/aMJounPK1mnKz1H/OY6H1nj/qarw==
X-Received: by 2002:a17:903:191:b0:1a6:7ea8:9f4f with SMTP id z17-20020a170903019100b001a67ea89f4fmr4487168plg.26.1684526147809;
        Fri, 19 May 2023 12:55:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902724900b001acae093442sm25714pll.82.2023.05.19.12.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:55:47 -0700 (PDT)
Message-ID: <36dbbde0-e7f4-c1bd-8015-6265ac812786@acm.org>
Date:   Fri, 19 May 2023 12:55:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-8-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230519044050.107790-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 21:40, Christoph Hellwig wrote:
> Currently both requeues of commands that were already sent to the
> driver and flush commands submitted from the flush state machine
> share the same requeue_list struct request_queue, despite requeues
> doing head insertations and flushes not.  Switch to using two
> separate lists instead.

insertations -> insertions. See also https://www.google.com/search?q=insertation.

> @@ -1434,13 +1437,16 @@ static void blk_mq_requeue_work(struct work_struct *work)
>   	struct request_queue *q =
>   		container_of(work, struct request_queue, requeue_work.work);
>   	LIST_HEAD(rq_list);
> -	struct request *rq, *next;
> +	LIST_HEAD(flush_list);
> +	struct request *rq;
>   
>   	spin_lock_irq(&q->requeue_lock);
>   	list_splice_init(&q->requeue_list, &rq_list);
> +	list_splice_init(&q->flush_list, &flush_list);
>   	spin_unlock_irq(&q->requeue_lock);

"rq_list" stands for "request_list". That name is now confusing since this patch
add a second request list (flush_list).

Otherwise this patch looks good to me.

Thanks,

Bart.

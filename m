Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C50C0032E
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 19:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjJTTLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJTTLn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 15:11:43 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C991A8
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 12:11:41 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6be840283ceso1088889b3a.3
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 12:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697829101; x=1698433901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJW3rQiiJt4btFGA1pDGRb0HUq2Iev54eL4TgstZGUs=;
        b=bXM74s0HLhzCj9EPnKYr0ekJPCXjKb3kLiej7J1wQsJARXFtNSGx2gNp7HWx/83q0P
         z5hgJRecvp0aBGIPnPp1G9lsBJz3ebdVSkqfHpEev1kWL1V/jp7QIn6kQJMuiGDGqQp3
         QmIAeC5WAPb9C6umLAOIk19IpBrzrdC1CiTQ0wHmlhAsNdY0rNPjSj4T4j7QI1/Y+QXW
         3+v3bO4a4I058OTQRaSd81BHtJfXSSO4wXuHddDk1vbu4RChO/zGLYBOVad5Yxec6q+M
         zNb514JPs/kH7IODye6O19w8U0lob29dtBE/wYDt43uaYLtzepu7PdGdeqQEPfkYuxgZ
         A6Ig==
X-Gm-Message-State: AOJu0YxOEdwoWb8UQ268qYVYf6qPtIWCT2YZLudFwFfifHdY97W3fwby
        pvc2hunTb5gZxdEZt4ig3Kc=
X-Google-Smtp-Source: AGHT+IFaoiNXnICAzr2PRQgnA187iqaiAEkV9yKeBvzZoTQXWyMb8MEQUg/DN6YkgTrLIZ+slF7eKQ==
X-Received: by 2002:a05:6a21:7182:b0:174:af85:91fc with SMTP id wq2-20020a056a21718200b00174af8591fcmr2960137pzb.48.1697829101084;
        Fri, 20 Oct 2023 12:11:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:72ba:c99b:d191:901c? ([2620:15c:211:201:72ba:c99b:d191:901c])
        by smtp.gmail.com with ESMTPSA id q12-20020aa7982c000000b0068fbaea118esm1887844pfl.45.2023.10.20.12.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 12:11:40 -0700 (PDT)
Message-ID: <a7c940d0-a769-46e6-8ade-39d1e8f019c5@acm.org>
Date:   Fri, 20 Oct 2023 12:11:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve shared tag set performance
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231018180056.2151711-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/23 11:00, Bart Van Assche wrote:
> -/*
> - * For shared tag users, we track the number of currently active users
> - * and attempt to provide a fair share of the tag depth for each of them.
> - */
> -static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
> -				  struct sbitmap_queue *bt)
> -{
> -	unsigned int depth, users;
> -
> -	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
> -		return true;
> -
> -	/*
> -	 * Don't try dividing an ant
> -	 */
> -	if (bt->sb.depth == 1)
> -		return true;
> -
> -	if (blk_mq_is_shared_tags(hctx->flags)) {
> -		struct request_queue *q = hctx->queue;
> -
> -		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> -			return true;
> -	} else {
> -		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> -			return true;
> -	}
> -
> -	users = READ_ONCE(hctx->tags->active_queues);
> -	if (!users)
> -		return true;
> -
> -	/*
> -	 * Allow at least some tags
> -	 */
> -	depth = max((bt->sb.depth + users - 1) / users, 4U);
> -	return __blk_mq_active_requests(hctx) < depth;
> -}

(replying to my own email)

Hi Jens,

Do you perhaps remember why the above code was introduced by commit
0d2602ca30e4 ("blk-mq: improve support for shared tags maps") in 2014
(nine years ago)?

Thanks,

Bart.

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81705C77B76
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 19:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDQTve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDQTva (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 15:51:30 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E87ED5
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 12:51:18 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id q2so31909608pll.7
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 12:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761078; x=1684353078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrD8gqPJTfavNmbCiiSALjRgsxjHdIeKireDyGxX30M=;
        b=WypA1MHG6lMyCxX8pZLv4vVV7FORVdn/o73M1x7jNVIa8ALLO1po3N34DuiugjRju8
         d55Yqd1hbD0gtwC1TbCk5NDGl+cI+fPO/2TM1+X2T5hyXwXn7m6YUW2N+Z/6Zht9hw7b
         DQiKKGJBZ/PrT5W+vX6UkvF5/jEhBT/60KDgcEBVeD++om/YMcRfHS3+iAUgZpuuWwBf
         dw1S2NYugmQYruQ0Osf1lW6lh6O4j6+tFoQTlGeGx2ep2MQZADZP/uetoevUB6KkdT47
         8Ra5H9ZlcVqOlQEeElBkawujMTdVCIH6dgxYlG0zrGgZC10p1vjWTvSOhi4gXQSJAKPd
         vOBA==
X-Gm-Message-State: AAQBX9fihdGq/juIuTc4MWkQKiKfmWQUOiotQkrv7sAqaXUu5YOr+HTH
        Icr7zTdmhmo8nPLIxBG/gZo=
X-Google-Smtp-Source: AKy350YgJ99/uOcUQAcOEZW54ezd2C26a7UF2vG6NxAXe1rmvx4sjQMtrmgkZ5i0BCOrFipzWhPZMg==
X-Received: by 2002:a17:902:fb4f:b0:1a6:387a:6572 with SMTP id lf15-20020a170902fb4f00b001a6387a6572mr97165plb.13.1681761078270;
        Mon, 17 Apr 2023 12:51:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2cdd:e77:b589:1518? ([2620:15c:211:201:2cdd:e77:b589:1518])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b001a221d1417csm8042949pls.298.2023.04.17.12.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 12:51:17 -0700 (PDT)
Message-ID: <c707e29d-08e7-b5b6-9277-06d7934d41fc@acm.org>
Date:   Mon, 17 Apr 2023 12:51:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 6/7] blk-mq: do not do head insertations post-pre-flush
 commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-7-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230416200930.29542-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/23 13:09, Christoph Hellwig wrote:
> blk_flush_complete_seq currently queues requests that write data after
> a pre-flush from the flush state machine at the head of the queue.
> This doesn't really make sense, as the original request bypassed all
> queue lists by directly diverting to blk_insert_flush from
> blk_mq_submit_bio.
insertations -> insertions

Otherwise:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

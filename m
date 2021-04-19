Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C36C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF1161369
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhDSTsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbhDSTsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 15:48:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E2C06174A
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 12:48:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id c4so3580796ilq.9
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wgtxZSflAiWmJVLCzDmdLgAcLUJmwymHsDoF35ncDkc=;
        b=qeRSc7+N1olXx5kZ8Uo/rOwAHJQiLP5/DzqsBbxcVuOS+WkkQPzZltJQriDu90FbR/
         qMDvu22Hr0S9XxPiL8DoIt9a2FM/plXTWsvoSbT4+B83IEu4Wh2eM90fJkFd5+zziXMp
         wWFWi4bwm95PgJA1F0TrphaiR1QgJJeYvu1wXWgYnXQLkuKKliQgfGRNSG81MIWUFnWA
         QrQqxdDWnnLSsyjx/+EMk9ywCb6Mk6aRbRgRsJkOshm711HYgOWWrYBdYG0g/OODhNyM
         Usgz5gKU5ACszgSWy3gdJLsmfkoq+iKA9bs0dlrBnBGQv5oONbKGfKw7RkjAM3PeR4Kn
         /vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgtxZSflAiWmJVLCzDmdLgAcLUJmwymHsDoF35ncDkc=;
        b=FV0AayFdhL98I6UNUBV4A1tbt8JJdYyCB/VBVe4vzHhG/IEKdTyWUD2yJUD4j80maL
         zM59/oEKLCQQ8WBDO9fXQ5JZpyp0b5njMuIwTQ5jFUA4ybONlZ6uLLjRGRfs3RlJGUri
         zR3nbgMhftT4LL+GcUNAc+pua84OP7jvi4bP2WmRjNgeRSDHVX2X3Q17tKEj5xCjWnLF
         aoTLySgo3wZDz2jd+UETv4hm5i966O2E8Sqs5gbvGnNzrdt1+zYxLZ3tkF5knmPECZ0z
         ocCYZo8nI+iQk65vOj/eGflmgmNPK2L8ajTztR9rKysNPFKZOulMvyMvH6ZPO7AWJdLU
         Jhww==
X-Gm-Message-State: AOAM531eJgr3unzXs4UN053N1V7UpBj2COrkaCY/Z8fhY3h0ItfQlwO/
        aQZjfia1HdcJipPqBSJBiuu2dRnTKTJLgw==
X-Google-Smtp-Source: ABdhPJxLJd3SlMLpkPeMlAHqsczTgCUzOs/WnRe9F+XNXtFnPxzgLdhFU1ipFIltQlIyjCcAGwB6ZA==
X-Received: by 2002:a05:6e02:1488:: with SMTP id n8mr20048398ilk.158.1618861690229;
        Mon, 19 Apr 2021 12:48:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k14sm7017498iov.35.2021.04.19.12.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 12:48:09 -0700 (PDT)
Subject: Re: [PATCH] null_blk: poll queue support
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
 <BYAPR04MB49654A1D4AC52FA3A8110240864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68a28d55-8c50-31e3-505a-2de330914942@kernel.dk>
Date:   Mon, 19 Apr 2021 13:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654A1D4AC52FA3A8110240864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/21 10:49 PM, Chaitanya Kulkarni wrote:
> On 4/17/21 08:30, Jens Axboe wrote:
>> +		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
>> +						blk_rq_sectors(req));
> 
> How about following on the top of this patch ?
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 8efaf21cc053..4c27e37ccc51 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1496,6 +1496,7 @@ static int null_map_queues(struct blk_mq_tag_set *set)
>  static int null_poll(struct blk_mq_hw_ctx *hctx)
>  {
>         struct nullb_queue *nq = hctx->driver_data;
> +       blk_status_t sts;
>         LIST_HEAD(list);
>         int nr = 0;
>  
> @@ -1510,8 +1511,16 @@ static int null_poll(struct blk_mq_hw_ctx *hctx)
>                 req = list_first_entry(&list, struct request, queuelist);
>                 list_del_init(&req->queuelist);
>                 cmd = blk_mq_rq_to_pdu(req);
> -               cmd->error = null_process_cmd(cmd, req_op(req),
> blk_rq_pos(req),
> -                                               blk_rq_sectors(req));
> +               if (cmd->nq->dev->zoned)
> +                       sts = null_process_zoned_cmd(cmd, req_op(req),
> +                                                    blk_rq_pos(req),
> +                                                    blk_rq_sectors(req));
> +               else
> +                       sts = null_process_cmd(cmd, req_op(req),
> blk_rq_pos(req),
> +                                              blk_rq_sectors(req));
> +
> +               cmd->error = sts;
> +
>                 nullb_complete_cmd(cmd);
>                 nr++;
>         }
> 
> If you are okay I can send a well tested patch with little bit code
> cleanup once this is in the tree.

Yes, that might be a good idea. I'll just fold it in, I've got it
sitting separately so far. Just let me know when you've tested it.

-- 
Jens Axboe


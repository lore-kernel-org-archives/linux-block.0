Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9CFC4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 14:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiK2Obp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiK2Obp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:31:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1BF2AE0
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:31:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b21so13563566plc.9
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23+PxjMKYNR0aA5BnIqYmQltq0HenPVL+mv767DsNnY=;
        b=7fFa0BS0IvSHfo0zVux6Zov1C1OUTT2/Nmpkuyz7u4TkyOOgyMLqukqCBbsXz/3b7K
         sv09LSDZ50rPbhfD4I27IxwyLYFghEMKE9+TOHYf09Ho8XDt3JQbzPVFrI2LNrYZ50hI
         6lO95ekqrgNz5wMrf8zatWgqjWY9RAHHi1eTodExJj+M2+TAirfUENCDsKIyCsKL34Yz
         /egG9hCjeogJDoiLgdgvfDYl6ddC5vObAb3uY3dhpzq51alsApb9XMXcDu+8AtxjWer5
         pu1edQX0xvEb96lTXgdDY6a1uzsMGD+yDuuak9T9Agxitm5PeSBYfe1NhX8xKzY0dufq
         iSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23+PxjMKYNR0aA5BnIqYmQltq0HenPVL+mv767DsNnY=;
        b=zqOOsjC8HKHAO9rkUjZ/e++EGKX4qA3JvztDbuCF4uvD39+SuLeENSyRYQoROeKj6V
         Xoo1hCDteCKzOpkiQ7SpDrauQlIrVJbEvO1H6QGGUYHXNJ5YaspNHRnyfovKrAN96RSk
         wcYz1RJ7GkTkV2khJE+4t3ZarEwUwZTy1Y20hpFsbKsFx2TZd9kJplSdg0xoFwicEZeL
         3N+ZfIQHUL9c3e9wmEazLPN3HpC176kYt/95aiHdWZoXwgUg2HayolYu3VXRA/QVLlcm
         IjoP3oaKHsWYfzPHCs0dxBDrFoL4DEyFG/EWEBmpfScUzfXKsYAo50vUbckG5kQsc8h7
         S8cQ==
X-Gm-Message-State: ANoB5pkqcIEuFtCHsY+TFzc8N4gHnFmmmz/EUn46RQs2z+/8szUQeZot
        3dhrAioUHzd/k7TcHlE0ND9ZjQ==
X-Google-Smtp-Source: AA0mqf7OsJ6iTMyaJiG2Zb4DenGucSK9gvy3DI3vGMh3rS3LU/Ze4XcTMV9/7UEqPnYFajGo/RuuHg==
X-Received: by 2002:a17:902:cec7:b0:189:8f65:5792 with SMTP id d7-20020a170902cec700b001898f655792mr9133241plg.114.1669732303626;
        Tue, 29 Nov 2022 06:31:43 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h23-20020a63e157000000b00434272fe870sm8484035pgk.88.2022.11.29.06.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:31:42 -0800 (PST)
Message-ID: <a48919c0-a596-8b2d-e2fd-338a4af5cac9@kernel.dk>
Date:   Tue, 29 Nov 2022 07:31:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] nvme: introduce nvme_start_request
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-2-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221003094344.242593-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/22 3:43?AM, Sagi Grimberg wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9bacfd014e3d..64fd772de817 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -419,6 +419,12 @@ void nvme_complete_rq(struct request *req)
>  }
>  EXPORT_SYMBOL_GPL(nvme_complete_rq);
>  
> +void nvme_start_request(struct request *rq)
> +{
> +	blk_mq_start_request(rq);
> +}
> +EXPORT_SYMBOL_GPL(nvme_start_request);
> +
>  void nvme_complete_batch_req(struct request *req)
>  {
>  	trace_nvme_complete_rq(req);

This really should be an inline. Apart from that, looks fine to me.

-- 
Jens Axboe

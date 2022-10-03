Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D3C433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 08:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJCIzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJCIyh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 04:54:37 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FA55754D
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 01:38:56 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso5414301wmq.2
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 01:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bI6E04hvQn6gIEf5lxXx79EdIOBf9BgYO41pl2Ql6nU=;
        b=6PxTbCILP59PS5Z98RIT47z4R1T5BogtSXFXPo9Ii3YGFIjB2p9nYz1SE4lOFzKU6/
         eimW1YHKg0oZiRR4rwoUYIJoPqk/F2NRtMIS+YZ1W8zl8T0vM1r/bvp0HuoUvfAV3Vw1
         ZRaXHx7mMMIkzrxoPfRrGg5g+OIqRmDDdOSTBcvMROzOsAT51l9vCzvFm3GshFO3kVQ5
         I7PcQEThKgqCU1BKI2KzPtay6p2FJKe0rYWWxkYLTRHzGU5velqjb0ezv8FoVqmH9eyr
         +mokdhEtwkCXj0x/Tors0nIt4oAPQOyTPVhWZo3kTSB0edvmJ7nQuMYLDLUBcqmfvzrT
         oi2Q==
X-Gm-Message-State: ACrzQf0v8ymGjzmsWg5sINP+Onh4i+JQc2IdCyPjj0O61BpJsUWCd5Ua
        fBG71nTHsj0PmKQ2yZ5jo1Y=
X-Google-Smtp-Source: AMsMyM7tUa5qQw15Ft7+AXJUL+6bKHQDW1aff0CYSAlzjYnomMj3mNVUrBDukUf9d81OTI8yY+uVyA==
X-Received: by 2002:a05:600c:4f89:b0:3b4:a6fc:89e5 with SMTP id n9-20020a05600c4f8900b003b4a6fc89e5mr5844437wmq.149.1664786334045;
        Mon, 03 Oct 2022 01:38:54 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b0022afbd02c69sm7071254wrp.56.2022.10.03.01.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:38:53 -0700 (PDT)
Message-ID: <d55d562c-e1ac-1dd8-c756-9b7da3425e98@grimberg.me>
Date:   Mon, 3 Oct 2022 11:38:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
 <cfdf4e12-a855-49c1-2c65-7e49c24cd2c1@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cfdf4e12-a855-49c1-2c65-7e49c24cd2c1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> index 9bacfd014e3d..f42e6e40d84b 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -385,6 +385,8 @@ static inline void nvme_end_req(struct request *req)
>>> ????? nvme_end_req_zoned(req);
>>> ????? nvme_trace_bio_complete(req);
>>> ????? blk_mq_end_request(req, status);
>>> +??? if (req->cmd_flags & REQ_NVME_MPATH)
>>> +??????? nvme_mpath_end_request(req);
>>
>> I guess the order should probably be reversed, because after
>> blk_mq_end_request req may become invalid and create UAF?
> 
> Yes - blk_mq_end_request() will put the tag, it could be reused by the
> time you call nvme_mpath_end_request(). It won't be a UAF as the
> requests are allocated upfront and never freed, but the state will be
> uncertain at that point.

Will reverse that...

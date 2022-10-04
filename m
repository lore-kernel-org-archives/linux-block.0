Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8251FC433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 08:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJDITR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJDITQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 04:19:16 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E0262F
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 01:19:10 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id lt21so1919607ejb.0
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I9T++C1dTMrkMN8MIJbFbiCZcd3AFA2TIFQVEMzhTpg=;
        b=BZSvPDUHYo/Xjtd79iX0WpX0hH66Ll0QOiweo+oD4YOrcjfmVZcPMFlT6D6Pz5R1vl
         xKzUuu94c+R1C8GTCimI1lZ6XR9cXWHSVUaEqgzZaffdpUg233q2lucXofjgMmT4Z6LL
         6gLVbaHydxjLmgio7YxXqJJ1N1U6EoGJO6n29PRKHahWtVbUbS+ji5vjwIxcYuDIRi6z
         W9QtYIDwrmQAMPxY5zmE8/flB0p/1IE1q57hrM9zPNKsIeTnVn0H5+HqY14BJi0cgQX2
         pzRF+a+B3KzDkM861dOcYItC1fORSQOJ8lP2yD36VmsSbRYrGMHEM79krvvMIl9Mjhjg
         WRnA==
X-Gm-Message-State: ACrzQf3VJKhJtLefIjaH+GTLlDD6noZrMlGVwi0pL9Jo6IrQQCZ72dOj
        ArjfR/s4cpIdfaqV1YcBF4ytL4GkhrU=
X-Google-Smtp-Source: AMsMyM6tVzTV2ZQ6B8ODjDNilYUhx+hZ9ISSRb/MrE2RXzOTq2aiu8jq/UiwHAOqYd97Udez3cCvzw==
X-Received: by 2002:a17:907:b03:b0:770:872d:d7e9 with SMTP id h3-20020a1709070b0300b00770872dd7e9mr18037425ejl.272.1664871549513;
        Tue, 04 Oct 2022 01:19:09 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090778c300b0074a82932e3bsm3224679ejc.77.2022.10.04.01.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:19:08 -0700 (PDT)
Message-ID: <0733f642-8b97-b6ce-8a0e-14c3bb8e2a9a@grimberg.me>
Date:   Tue, 4 Oct 2022 11:19:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
 <9db5d7eb-bd84-85e6-c30a-da057f1b2b69@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9db5d7eb-bd84-85e6-c30a-da057f1b2b69@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/4/22 09:11, Hannes Reinecke wrote:
> On 10/3/22 11:43, Sagi Grimberg wrote:
>> Our mpath stack device is just a shim that selects a bottom namespace
>> and submits the bio to it without any fancy splitting. This also means
>> that we don't clone the bio or have any context to the bio beyond
>> submission. However it really sucks that we don't see the mpath device
>> io stats.
>>
>> Given that the mpath device can't do that without adding some context
>> to it, we let the bottom device do it on its behalf (somewhat similar
>> to the approach taken in nvme_trace_bio_complete).
>>
>> When the IO starts, we account the request for multipath IO stats using
>> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
>> in the middle of the request.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/core.c      |  4 ++++
>>   drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 64fd772de817..d5a54ddf73f2 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -384,6 +384,8 @@ static inline void nvme_end_req(struct request *req)
>>           nvme_log_error(req);
>>       nvme_end_req_zoned(req);
>>       nvme_trace_bio_complete(req);
>> +    if (req->cmd_flags & REQ_NVME_MPATH)
>> +        nvme_mpath_end_request(req);
>>       blk_mq_end_request(req, status);
>>   }
>> @@ -421,6 +423,8 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>   void nvme_start_request(struct request *rq)
>>   {
>> +    if (rq->cmd_flags & REQ_NVME_MPATH)
>> +        nvme_mpath_start_request(rq);
>>       blk_mq_start_request(rq);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_start_request);
> 
> Why don't you move the check for REQ_NVME_MPATH into 
> nvme_mpath_{start,end}_request?

I'm less fond of calling a function that may or may not
do anything...

But it is a pattern that exists in the code, if people prefer
it I can change it.

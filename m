Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE33C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDKRSx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjDKRSw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:18:52 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF140E4
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:18:30 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id h24so8667001plr.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233484; x=1683825484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQWl1WZjDCYXV3pPOsGzcGbyFXVgPmqHPrDm41MsitY=;
        b=XWgJ2doDRwus8T5RSDP+T/byT1ubPcmMRD3C5AR8eJzzDbxXhunWKgr2rwDA7UfXYI
         8LPHGSe9U5SN9zUATPGc/jo9shOPaTqnVIpVhsXfwEc4+XG7YkrqvWX3k36cHObEsYT0
         AtP/dvFwBSh9X4y8pdzsJeP4Cq6BS8YfVfwXxz062DylWY9RQjs/P0jLXERelg0+cMwI
         FuLet5B2xDQKKE7H29BXmqPlmwICaSlwZLM0n2a7n6xQdRog4kVutFu/ThU5HXlWnILw
         2d7zcu8HPwDke68jLDkv/gOz0s3WqJxj/oDVCReP20+i7UqpBSxMUeD+SxzAlxTKdeGr
         IVHg==
X-Gm-Message-State: AAQBX9f2Qb4EbmSWDbmfQoPDz1yCkYGLS+TSzxjOscf3ERuh+OZAhQg0
        0FF7GytEFITHVUsrpanrOBA=
X-Google-Smtp-Source: AKy350btzo54/ywUa+GsMDZ04IaCGQcwXtP4DhRV0opdZzf+xU/8CZJqBCPbeft2hCGKQOnk9ttPtg==
X-Received: by 2002:a05:6a20:71c8:b0:da:c080:9b86 with SMTP id t8-20020a056a2071c800b000dac0809b86mr3356661pzb.53.1681233484329;
        Tue, 11 Apr 2023 10:18:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id x24-20020a62fb18000000b0062de9ef6915sm10052095pfm.216.2023.04.11.10.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:18:03 -0700 (PDT)
Message-ID: <8e7af661-a71e-09cd-2894-5443c18282ee@acm.org>
Date:   Tue, 11 Apr 2023 10:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 04/12] block: Requeue requests if a CPU is unplugged
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-5-bvanassche@acm.org> <20230411124042.GB14106@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411124042.GB14106@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 05:40, Christoph Hellwig wrote:
> On Fri, Apr 07, 2023 at 04:58:14PM -0700, Bart Van Assche wrote:
>> +	if (hctx->queue->elevator) {
>> +		struct request *rq, *next;
>> +
>> +		list_for_each_entry_safe(rq, next, &tmp, queuelist)
>> +			blk_mq_requeue_request(rq, false);
>> +		blk_mq_kick_requeue_list(hctx->queue);
>> +	} else {
>> +		spin_lock(&hctx->lock);
>> +		list_splice_tail_init(&tmp, &hctx->dispatch);
>> +		spin_unlock(&hctx->lock);
>> +	}
> 
> Given that this isn't exactly a fast path, is there any reason to
> not always go through the requeue_list?

Hi Christoph,

I will simplify this patch by letting blk_mq_hctx_notify_dead() always 
send requests to the requeue list.

Thanks,

Bart.

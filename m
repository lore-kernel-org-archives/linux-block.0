Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331EFC433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 17:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiGGR6R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGGR6R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 13:58:17 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18B153D24
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 10:58:16 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 145so19850879pga.12
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2022 10:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ho4YF1TF5QwEy3FU6og3Bg4EnhPBQa43lL1RvxN+E5g=;
        b=ezRAvyiPH7dVEYpDDOceRookRhXvAF4FXFJM8lWz+VZJSc2NwnnAzcRU0el3Apo70E
         ymfHO+8zCAH7H7EM7aOwft2gO331DH3JJrd4DLzY6/T5+AiHEULRTUNLveM4RvDNZ3Cl
         597divz/IDib764O7BmtsLCiBpyVPtIQjTUp95FnQalAZ/WKz3XQkVF2DBjRKWWuvhNM
         elZCGZLuIyTCMWndaxOttyC4nzr7EdAXEqSSlQXjPGiUeGFKjMtXF0IDUaPEpQUPd11A
         W3eXElwBKWH6rEMULSivJclrivZIYHt2yhjyusocp/XxPrW/J1YMotFe586LkXGrXySW
         X9fA==
X-Gm-Message-State: AJIora8fzWKSwN9uHMEyxme2E6uBrQMaG1+1nr7QTH6YAYZnq/n9uc8p
        99sd7/90prpsztJuQs/zHph1+62rkhE=
X-Google-Smtp-Source: AGRyM1sIJUSJ94mEBYgSIfnu0RucK6RiN99TzBxpMgeQO38xscYH2k8biS1i8hjCMNLFhRYRXJWZMw==
X-Received: by 2002:a17:90b:390d:b0:1ed:3058:45e5 with SMTP id ob13-20020a17090b390d00b001ed305845e5mr6448681pjb.141.1657216696183;
        Thu, 07 Jul 2022 10:58:16 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k3-20020aa792c3000000b005252680aa30sm27085915pfa.3.2022.07.07.10.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 10:58:15 -0700 (PDT)
Message-ID: <ef46a115-62eb-2fa5-5e7c-264be950bda8@acm.org>
Date:   Thu, 7 Jul 2022 10:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 63/63] fs/zonefs: Use the enum req_op type for request
 operations
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-64-bvanassche@acm.org>
 <f42c76ef-ae9a-71ee-e1e0-1aa3cbbad154@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f42c76ef-ae9a-71ee-e1e0-1aa3cbbad154@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 16:39, Damien Le Moal wrote:
> On 6/30/22 08:31, Bart Van Assche wrote:
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Naohiro Aota <naohiro.aota@wdc.com>
>> Cc: Johannes Thumshirn <jth@kernel.org>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   fs/zonefs/trace.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
>> index 21501da764bd..42edcfd393ed 100644
>> --- a/fs/zonefs/trace.h
>> +++ b/fs/zonefs/trace.h
>> @@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
>>   	    TP_STRUCT__entry(
>>   			     __field(dev_t, dev)
>>   			     __field(ino_t, ino)
>> -			     __field(int, op)
>> +			     __field(enum req_op, op)
>>   			     __field(sector_t, sector)
>>   			     __field(sector_t, nr_sectors)
>>   	    ),
> 
> Nit: the patch title could be more to the point, E.g.
> 
> fs/zonefs: Use the enum req_op type for zone operation trace events
> 
> Otherwise, looks good.
> 
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

How about using the title "fs/zonefs: Use the enum req_op type for 
tracing request operations"?

Thanks,

Bart.

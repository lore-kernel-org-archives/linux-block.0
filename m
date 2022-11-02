Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A31C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKBPSB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBPR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:17:58 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA01403A
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:17:57 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r2so2039984ilg.8
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lNS+Xx1qHEm4fxW4otb86SMhZSYSGG1bOdkiJaRRqs=;
        b=L8Teqfwe2BuKrL82Ol6exMGOEXzTR4IKnsTxRm64mH+xaWYSW/WOL0j5qMcpNluOBC
         KHexlonTGBdxowhxlw8HrE5JgYF2w698kcr/hYoWmyidu31UauWl66bGuB4G3/spGGXD
         T7bcgjqWwLekaG8ihShRXQq8xeP3WPG7zLW2o2Xlq47o+LGdi2zR0+pATDCEmZZtxwLP
         stgx/MjYOX6B79Oq2knOkaradhUIXy+BH8SylDBqe/f0k+Uf+bEgdbAhmyyEpQcF9OMb
         CMr67rJaZssHJoYuytq7kyy2OffGgvDzQ/Sfci/WYjj9m2kUEUEI6dNlWSzPTGtZGY9P
         bwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lNS+Xx1qHEm4fxW4otb86SMhZSYSGG1bOdkiJaRRqs=;
        b=uGoGqwQ6GWctsG3uDLT7irMmQ5/mlFneneEqr1D1FVXTy5FoqdMPGpo1ugEeQyuzkZ
         CwqkUvp/wHR62mPQgwutAlxTNcnQxYuG0rHMRbfkrma7L9ej7vg8kIrSggl1nsCWHRMd
         GSd1MVXR6rkBJX9cD6sF7UxzQU68aJjP/Q/XW1frPLhKHE79f29PWi7veUBn4J7eaj25
         s9A134MXC5KrJ9sPyO2UL157eVxUoDoi1kusHoUuffIgJxkLrMD+aX1NTtZ0jzkAFzM4
         K+1kXLPyT714FqeB2oPghadg1TtQpGw5zgM2+LET2p/xsUtFnfbQElnerLPQg0dvIkTh
         gITA==
X-Gm-Message-State: ACrzQf3Z+w67YGKyrzz6Irw2b68inrOZcvp9GAQjoxytWWDlsISnAjS3
        qzaihk0Yj2wEsc7RRErNL3B9/A==
X-Google-Smtp-Source: AMsMyM5edsHiGYGu23NV480iXRI7KBvb7ilVE0AICatDSaXAapw9nMq1/K7HSVGKfpM97LVjJrrAhQ==
X-Received: by 2002:a05:6e02:1845:b0:300:7877:11f5 with SMTP id b5-20020a056e02184500b00300787711f5mr15991624ilv.97.1667402276688;
        Wed, 02 Nov 2022 08:17:56 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q8-20020a0566022f0800b006cab79c4214sm3075965iow.46.2022.11.02.08.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 08:17:55 -0700 (PDT)
Message-ID: <8125e422-7bc8-46a1-792a-f31cee7a91a3@kernel.dk>
Date:   Wed, 2 Nov 2022 09:17:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
 <Y2E2wFnbeUzAPjo0@infradead.org>
 <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
 <Y2IXjzWL5eHA3Co9@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2IXjzWL5eHA3Co9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/22 1:09 AM, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 07:05:35AM +0900, Damien Le Moal wrote:
>>>> +	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
>>>> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
>>>
>>> How could this even happen?  If we want a debug check,  I think it
>>> should be in submit_bio and a WARN_ON_ONCE.
>>
>> I have not found any code that issues a FUA read. So I do not think this
>> can happen at all currently. The check is about making sure that it
>> *never* happens.
>>
>> I thought of having the check higher up in the submit path but I wanted to
>> avoid adding yet another check in the very hot path. But if you are OK
>> with that, I will move it.
> 
> I'd do something like this:

This looks fine, but if we're never expecting this to happen, I do think
it should just go into libata instead as that's the only user that
cares about it. Yes, that'll lose the backtrace for who submitted it
potentially, but you can debug it pretty easily at that point if you
run into it.

-- 
Jens Axboe



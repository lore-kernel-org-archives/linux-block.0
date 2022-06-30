Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE386C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 18:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiF3SNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiF3SNH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 14:13:07 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34570B1
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:13:04 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id m14so89148plg.5
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zUh2rG+L0yeVRVVu7GCbIp7pDwcQu3W9T9Thx8r4KYY=;
        b=ZTEYUabASVpExkb5MiXrgMVPG0mduwKvLWGnfMN6PNDKyQqtx11jXcqtGgAmnhoLUE
         EsPiG4ABYd9Mcr6d+pxTztlSZqfGU6B5elyG7FGGRJpEnV9hvRiPk6692S3optxzHFyi
         bs/JzMPshZLt+gYj+arcyPKwR5yTZkNVUGMaCjkEDHwFpIQ4sj/DBN2L+BkaYnXir6lK
         pi3jm2GMnTcw8KnZ3b2VqnJols0YR2/+q0V+Q3QBLO8/KH9ziPoJ6Z6PcTSZUtG94KLR
         UXdg+rwQOeaZOiPOG0qebm2KXXn6sJhj+A85qOAYpNnb65MI2UJw6s2ChAcQlCaEtwOI
         nhnQ==
X-Gm-Message-State: AJIora+PERnJC6OvVJ2+WQtHtHn8Mmezj4hx1RGK+/JPIOrDduuVgpWt
        xdiKk8x7355FQ1zgfli+qV4=
X-Google-Smtp-Source: AGRyM1ul75u0NA9KRxNZT8/Dnym2mvfP+nqU3dpyHgdPp+w8rArmtVCezlEJPHgKPrpLp9h9kw8d+g==
X-Received: by 2002:a17:902:e747:b0:16a:58f2:1d1e with SMTP id p7-20020a170902e74700b0016a58f21d1emr16881669plf.17.1656612783531;
        Thu, 30 Jun 2022 11:13:03 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a318800b001ed2fae2271sm2245018pjb.31.2022.06.30.11.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:13:02 -0700 (PDT)
Message-ID: <12bc3e02-898a-5f29-62b7-334937efd867@acm.org>
Date:   Thu, 30 Jun 2022 11:13:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 10/63] blktrace: Trace remapped requests correctly
Content-Language: en-US
To:     =?UTF-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2RIOa3s+S4gCk=?= 
        <junichi.nomura@nec.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-11-bvanassche@acm.org>
 <TYCPR01MB6948A4638DBA55684374AFFA83BA9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <TYCPR01MB6948A4638DBA55684374AFFA83BA9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 19:05, NOMURA JUNICHI(野村 淳一) wrote:
> From: Bart Van Assche <bvanassche@acm.org>
>> Trace the remapped operation and its flags instead of only the data
>> direction of remapped operations. This issue was detected by analyzing
>> the warnings reported by sparse related to the new blk_opf_t type.
>>
>> Cc: Mike Snitzer <snitzer@kernel.org>
>> Cc: Jun'ichi Nomura <junichi.nomura@nec.com>
>> Fixes: b0da3f0dada7 ("Add a tracepoint for block request remapping")
> ..
>>   	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
>> -			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
>> +			req_op(rq), rq->cmd_flags, BLK_TA_REMAP, 0,
>>   			sizeof(r), &r, blk_trace_request_get_cgid(rq));
> 
> Thank you.  I think the change is fine but what it really fixes is
> 1b9a9ab78b0a ("blktrace: use op accessors"), where arguments of
> __blk_add_trace() was extended.

Thanks for the feedback. I will update the "Fixes" tag.

BTW, does the above reply count as a "Reviewed-by"?

Thanks,

Bart.



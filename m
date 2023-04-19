Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC2C77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 22:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjDSWof (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjDSWoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 18:44:34 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4C6EA8
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 15:44:07 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-63d4595d60fso3025415b3a.0
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 15:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681944223; x=1684536223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA4vrI3Esu2z7vBZNEoRsk04bWLH+Oh9ZePo9xRxzVk=;
        b=cVyxF0HEUMP9869+0chQcwi/aKsvlrrbbK9RpndRLjWH+DoHWrIExlrzjvoyqmtLsE
         2FWUOm8Oj+DtYEETjSseuZyIrcf6ysmliuhg8rQ5mV9jgu4qndcppLpXHrFmg+Y/hODf
         fjXlS7/wwwMlEBGgDfMprjsteMdmZZgJjlSreMt/fxow2MPgyVqJESk++fSikLVN7wer
         oXc5aScB79vc3qedsG23Vxc/zvAArHauEePYGQujp7gk0Rj9xIOnKNAxBbcoT22/SiLr
         ZmQl0YREHb/ddsexSKKLF6/xLX1f2A4C6/oHsEv0npnogufK929q1axuwP/5HSzVKb5u
         +Ajw==
X-Gm-Message-State: AAQBX9cj8cA3DTzYYL7mYi1YfZdUnKxPIo6i+GJkBHiEtIEpd8WzNm+E
        wCY9ROc38zPHvRJw/EWkJ2M=
X-Google-Smtp-Source: AKy350ZoAK0uv4daaBOGN+iwfdqdjT4BzicenBFN+Uo2OVPOyja19wkrZqJYCUQZ+ayeLaMxSeHS7w==
X-Received: by 2002:a05:6a20:7d96:b0:f0:9de1:193e with SMTP id v22-20020a056a207d9600b000f09de1193emr200591pzj.6.1681944223548;
        Wed, 19 Apr 2023 15:43:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:216b:53b9:f55c:cf92? ([2620:15c:211:201:216b:53b9:f55c:cf92])
        by smtp.gmail.com with ESMTPSA id w30-20020a63161e000000b00517f165d0a6sm10827858pgl.4.2023.04.19.15.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 15:43:43 -0700 (PDT)
Message-ID: <e6adbe81-c45f-9801-bee6-a5a7ccad8945@acm.org>
Date:   Wed, 19 Apr 2023 15:43:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 06/11] block: mq-deadline: Disable head insertion for
 zoned writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-7-bvanassche@acm.org> <20230419043044.GC25329@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230419043044.GC25329@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/23 21:30, Christoph Hellwig wrote:
> On Tue, Apr 18, 2023 at 03:39:57PM -0700, Bart Van Assche wrote:
>> Make sure that zoned writes (REQ_OP_WRITE and REQ_OP_WRITE_ZEROES) are
>> submitted in LBA order. This patch does not affect REQ_OP_WRITE_APPEND
>> requests.
> 
> As said before this is not correct.  What we need to instead is to
> support proper patch insertation when the at_head flag is set so
> that the requests get inserted before the existing requests, but
> in ordered they are passed to the I/O scheduler.

It is not clear to me how this approach should work if the AT_HEAD flag 
is set for some zoned writes but not for other zoned writes for the same 
zone? The mq-deadline scheduler uses separate lists for at-head and for 
other requests. Having to check both lists before dispatching a request 
would significantly complicate the mq-deadline scheduler.

> This also needs to be done for the other two I/O schedulers.

As far as I know neither Kyber nor BFQ support zoned storage so we don't 
need to worry about how these schedulers handle zoned writes?

Thanks,

Bart.

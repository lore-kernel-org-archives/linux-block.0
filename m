Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565CDEB64DC
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 22:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGRWhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGRWhL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 18:37:11 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48DC1992
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 15:37:10 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-66872d4a141so4134551b3a.1
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 15:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689719830; x=1692311830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3I20rAFuenPVzIVGjvWBJIVUhTHVMUayu8+fWJvgg8=;
        b=ffpF3YoqN81UYU59BFFBa0R0RhZ64Em5+bIgkFocUgx9MYKypIvw7VtLz3/Xiuv9gb
         eCpu0PlvPsmVAxNPRJRNJNhX7bt0lfrIZNCqAEcOiHNnhvv4Hr4VmsUcD6MJ3YOzqtYU
         LzDMm03m6dGmQQWEJ3KrN7jNlheN9T/jM1wSl7gD6rGTLX8KPQA/4sNfiQWEi4LkegmK
         sLgx/AfoblBjvwFm9fnb1h/svzs8+3HtVRmar72313+Di9FicS6C8HyBO1fa+n/rxya0
         HbqGtlFpcu/6S1/p00qz7fDAwABNA5X5Reqx87E/yB0C2N9LFrKD/slSlTC/FNcjoxmX
         JD/w==
X-Gm-Message-State: ABy/qLaUVGPgsHFXE25xnruIfkD+GlrE4kNAVK2EpWe64fEwB9fAJf30
        xuCO1V5btIoYMFjR/l8WpDEG5vcqPdQ=
X-Google-Smtp-Source: APBJJlHZ7yitUfP4LRnWG29Pf6Up6DDNTkEJKjKqh4Dp0tsXLa968ULO89UtqaFmAXN2RrLJV5jAEQ==
X-Received: by 2002:a05:6a20:12c2:b0:134:a8a1:3bf with SMTP id v2-20020a056a2012c200b00134a8a103bfmr690161pzg.30.1689719830044;
        Tue, 18 Jul 2023 15:37:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3cb6:9d30:79d0:90cc? ([2620:15c:211:201:3cb6:9d30:79d0:90cc])
        by smtp.gmail.com with ESMTPSA id m15-20020a170902db0f00b001b02bd00c61sm2349008plx.237.2023.07.18.15.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:37:09 -0700 (PDT)
Message-ID: <e1af3db6-0614-d0f2-a8c4-eb2a1de82e85@acm.org>
Date:   Tue, 18 Jul 2023 15:37:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] block: Introduce a request queue flag for
 pipelining zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-2-bvanassche@acm.org>
 <9feab737-acb6-9e03-effb-8b130fdfa12a@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9feab737-acb6-9e03-effb-8b130fdfa12a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/23 23:34, Damien Le Moal wrote:
> On 7/11/23 03:01, Bart Van Assche wrote:
>> +/* Writes for sequential write required zones may be pipelined. */
>> +#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 8
> 
> I am not a big fan of this name as "pipeline" does not necessarily imply "high
> queue depth write". What about simply calling this
> QUEUE_FLAG_NO_ZONE_WRITE_LOCK, indicating that there is no need to write-lock
> zones ?

Hi Damien,

I'm not a big fan of names with negative words like "no" or "not" embedded.
Isn't pipelining standard computer science terminology? See also
https://en.wikipedia.org/wiki/Pipeline_(computing).

Thanks,

Bart.


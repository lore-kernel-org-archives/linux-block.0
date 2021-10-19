Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE5DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04E760FDA
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhJSNrf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhJSNrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:47:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851CC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:45:20 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so2341218otl.11
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CPMWXO4Y8z2FAKPc50/s17ArNKBdOj2woAp4Z43yQ9Q=;
        b=XWNGm68dvqfappaw4gS51+/YYVfbADmAsTcC7tL+iXIbBBE+gJ59nnm+9SxSCq9rVk
         4ObEz0vI8aROjN+/6FLUaWMwtNOfjpE9xzQ2jEtfrj9Kn4vv2vhzzZazfxLn4cib60cr
         8gbF9SKFcNhLuTn03Nu4b5PeHSCh4/ewR54k7iAUe9T3NFZur/DBzvMbOtITLOF1o5vR
         w+lMOdPxqaxiZO6d6Zz8fNSr4f6i/jPcG+0KVem9ZU4YpWx2wYUeWt9me2V6gxYtM3HJ
         64Iq3hUktHIo76pqVKG/44t1rDYE8+NVuK5YtxV5aK8Hi9Uz4EwtFyw8VBGlDdstDjWy
         pMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPMWXO4Y8z2FAKPc50/s17ArNKBdOj2woAp4Z43yQ9Q=;
        b=TDVBlYppsbb086T82GUNvKHo6g6yTKxb1vMlAWWcTT5fUk5p9XmZcauYWbToa5ojiK
         cNj9MzgTGviyURftgS/39fkGKU7uC0g00QQdWIjWaPGKeiz55eo3CoD9YYWAWlCgohdV
         AkN2+FRGFRVSU8/jU/xPcN5+RySAFj8XbC1X0T4M2JcemSli74vb29bBztnnylADs63c
         XqrZfWsJeVZjtRpXlS/iMxuzkTef3qsKsVwmBKg+qQ0WxsUzk8Kj1RRSXdPethj6NjXO
         K5K65yylEtQP4LvqQFXHQdrcyxPuTVRSFCvGHiheXawQbCcV6PFu3pW17LmMXFZeL78C
         e/lQ==
X-Gm-Message-State: AOAM532j4ry9vglEAGXoj0AAO0Vbt5g/tLSwvJk53lAONhkC60cJfBKI
        5EKjGfBMOJwgCy52KN4oxl3YkCSl9ag=
X-Google-Smtp-Source: ABdhPJy18q52XGWQjZNBo62b57Grz6YZ+esnkUO9VzWbpycPDmQ/mZjxXjXQYCsujfupRRHSrSoGaA==
X-Received: by 2002:a9d:2078:: with SMTP id n111mr5111716ota.259.1634651119114;
        Tue, 19 Oct 2021 06:45:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c37sm3021824otu.36.2021.10.19.06.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 06:45:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: change plugging to use a singly linked list
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211019120834.595160-1-axboe@kernel.dk>
 <20211019120834.595160-2-axboe@kernel.dk> <20211019133456.GA19216@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89426241-cde1-718c-6817-bff3639f1ab5@kernel.dk>
Date:   Tue, 19 Oct 2021 07:45:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019133456.GA19216@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 7:34 AM, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 06:08:33AM -0600, Jens Axboe wrote:
>> +						!from_schedule);
>> +			blk_mq_sched_insert_requests(this_hctx, this_ctx,
>> +						&list, from_schedule);
>> +			depth = 0;
>> +			this_hctx = rq->mq_hctx;
>> +			this_ctx = rq->mq_ctx;
>> +
>>  		}
>>  
>> +		list_add(&rq->queuelist, &list);
> 
> I think this needs to be a list_add_tail to keep the request ordered.

I think it does the right thing, the singly linked list is LIFO, so we
effectively just reverse it here.

-- 
Jens Axboe


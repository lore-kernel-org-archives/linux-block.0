Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F1CC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D2261244
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKDTSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhKDTSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 15:18:06 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA99C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 12:15:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bg25so10193014oib.1
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nNyAaJlG2JbdB116fWvoVeLvLimFvm6IHE3Wu34ru4E=;
        b=U8jg+eWHkrF7KZHD3sTmALPEDiXvUzMOUlBIePWoyBEUVKQ5XxQ7zzsFKpYaNDC6eG
         Wf6ZcbQ/5ljg0gRG0h34HntfQUe9g55+ufyqfirbWqsL5tzUIR4vZvM5NRYYUnZncje7
         melKIflJDxc5kJhhgGo5WZLT3a8/kQ+HGLqiZpqXsHPgdm80bp3oFYW8dEj3FB/CId7Z
         x2Z5ggShQ07ZVVzQzGgwjPygcPBxDg23EXSenwRu0iBBPmreMx0W4eYMDqdN1RdlzO6q
         fKe7nRUJB1j9d7i5yw6SCAM4bUj1YqkwFRIPqCq54gcxbMll702bJz/mYWaYCNSG428i
         hNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nNyAaJlG2JbdB116fWvoVeLvLimFvm6IHE3Wu34ru4E=;
        b=pJe7Iaanow2LSdEGmEV4A+LQVV6KrlFtTue2mylFnA0XSF720wHtl6Z+mfyfD+Z4X8
         7FPQjt/9EPf8Jens6N+mH8qytfUzoCGBd+OhJ+zdmU0EAKHOyned7fgkutICJddDS2e4
         h8iVgaqJBZL1CQDpPmNCwaDfkladAc6XfoJYpEOD9ixSG8ZBT6XGLnR1S/0kprn+Fn55
         V54qMTk6GgbbQydtfbYqln5s4iLqwIVA1BXBqzLtPgkRfpniYS/8DlzbYNB5MsppICZp
         Sq6YswY7n+HQggnvPrGc7OBpxt0iL2yCz8ZOoJ0jlo3W/oSPFH3TWHnwqsb43yaGepI/
         n6Tw==
X-Gm-Message-State: AOAM533mPapsdnHgJyEDDUNgNFBkWF+19Yo6/Z0Dm7rO7Pb13E/ZwJ7b
        mYHm9fOqXquFYoukojXX/NZ+//gkdVr4TA==
X-Google-Smtp-Source: ABdhPJwhbFErOK34z3qxv9M7bv2YNW0oLnr+Yl1PIIbfSvws92VpJcm/D2bta2Kjtu/GkNafE47qaA==
X-Received: by 2002:a05:6808:201d:: with SMTP id q29mr131661oiw.56.1636053327061;
        Thu, 04 Nov 2021 12:15:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o6sm1574880ote.76.2021.11.04.12.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 12:15:26 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
 <YYQuyt2/y1MgzRi0@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
Date:   Thu, 4 Nov 2021 13:15:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQuyt2/y1MgzRi0@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 1:04 PM, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 01:02:54PM -0600, Jens Axboe wrote:
>> On 11/4/21 12:52 PM, Christoph Hellwig wrote:
>>> Looks good:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> So these two are now:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96
>>
>> which is the one I sent here, and then the next one gets cleaned up to
>> remove that queue enter helper:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b
>>
>> Can I add your reviewed-by to this last one as well? Only change is the
>> removal of blk_mq_enter_queue() and the weird construct there, it's just
>> bio_queue_enter() now.
> 
> Sure.

Thanks, prematurely already done, as you could tell :-)

Thanks for the reviews.

-- 
Jens Axboe


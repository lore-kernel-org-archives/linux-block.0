Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA7FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 19:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhKWTGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhKWTGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:06:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B058C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:03:28 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z18so29311938iof.5
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SCB9oy0KJp/bIqtgVSa3RY23L1JbX/3uZwNDX15rUUo=;
        b=GEllDB2DLhXzefh/ToyDgTZtd8FxcURmLxAewc2tymbnUl50Lr/cFAgGHd/jLMo6fj
         80GopZvlEdO9nG147Il/WK0Fw/sksWXuOD6vDovIbUoNfKojrvRdhtzChDj4DYLnmo4U
         ngNmBg/uqGKDJW3Rfcai3dmocZSDvaaBR75qx/7/1NxZ8vCVpFU33NjijDkpy8YcVngg
         Ya8cDydFs2Y2tmMGNVSsZf0ljRSJRl4RYCZXTusJ3JeB71AeUtxlTLCXC06EL/MKoPwP
         /v8wtuvaxclAvpd8TNR9LogSdqJKCiZIB3PWSyEdS8oEgXH2/wiBGbe2uf4IbxfN5ft4
         /X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCB9oy0KJp/bIqtgVSa3RY23L1JbX/3uZwNDX15rUUo=;
        b=rSbpyJ+Djc0OHQ34Eh2Ig8up2omEM+lXNYGmjic2uc8v6yPN3m7JrKzvFDnoZmAtJZ
         8I28z9YlPZaLE8/eNzBs/nJhN+rvpDug0EqKXIXS+WD9LBLF+LT8Ycf7hThYVfpmtE4M
         pD6l71l/JKm31LgF1FbPABE6x1bGDAYAigl2oxxhWVpVmA8pcxK0IHxw2J1Dl9skU9h6
         ZsSF+fUnv8qnLRLqJXj5WjCKk9y/tF2+VlfYJTfaVW07gmh5VeE0nTmY1LDjPmr4o5W+
         BgJyrEENkS++5nm22JuvdYUjd2ajKux6nCwqEzu0bM7bx1rSazlLj9cUSC0cCvwSQrQM
         L7QQ==
X-Gm-Message-State: AOAM530dio6FwNsIglnoAoDMaYjoFY37uSgkvnT37/iQyuBm+99ZIyqg
        /TbVjP9VejCowSY90cd5/eOo2pgtiJbbP3pb
X-Google-Smtp-Source: ABdhPJwettGg0B2RqVJ2SXqEkol7DcvUsRlx2dEYktRj9p+ZoJqxuybD8BwWA8S/pdJFcVjRyHLRVg==
X-Received: by 2002:a05:6638:16c5:: with SMTP id g5mr9223653jat.11.1637694207830;
        Tue, 23 Nov 2021 11:03:27 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s5sm8713847ild.14.2021.11.23.11.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 11:03:27 -0800 (PST)
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123171058.346084-1-axboe@kernel.dk>
 <20211123171058.346084-4-axboe@kernel.dk> <YZ03/OVZcJ+KlfFm@infradead.org>
 <b24a297d-3d57-7f8d-1932-da614454b28d@kernel.dk>
 <YZ06Kd6qpRPt3KG4@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <effc7077-4b49-5508-fb35-19db49c82488@kernel.dk>
Date:   Tue, 23 Nov 2021 12:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ06Kd6qpRPt3KG4@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 11:59 AM, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 11:58:42AM -0700, Jens Axboe wrote:
>> On 11/23/21 11:50 AM, Christoph Hellwig wrote:
>>>> +	spin_lock_irq(&q->stats->lock);
>>>> +	if (q->poll_stat) {
>>>> +		spin_unlock_irq(&q->stats->lock);
>>>> +		kfree(poll_stat);
>>>> +		return true;
>>>> +	}
>>>> +	q->poll_stat = poll_stat;
>>>> +	spin_unlock_irq(&q->stats->lock);
>>>
>>> If we'd use a cmpxchg to install the pointer we could keep the
>>> blk_queue_stats definition private.
>>
>> How about we just move this alloc+enable logic into blk-stat.c instead?
> 
> That's a good idea either way.  But I think cmpxchg is much better
> for installing a pointer than an unrelated lock.

True, I'll do that while moving it.

-- 
Jens Axboe


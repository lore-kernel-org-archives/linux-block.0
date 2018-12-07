Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CBAC64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B5A20850
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oZxJaxHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B5A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGBNZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:13:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35615 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLGBNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 20:13:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1008752plo.2
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mP+0nJoKs9+LBTso2pGhaIsEwO4gged4NgXHNiqvDN4=;
        b=oZxJaxHYHKmO7shakU/T+Gc/GM7yZo0ePFnl7g63ZBR0pZ4JCybhNJXyTIE1wsOOEq
         gFGvjlTu29DSR0FUEavZ31b8zjpgLkz8jvxlucHXIXp0rjFuKtLV/HRXBNyao4e9f01x
         mmT9rX99AJVjD3JfXpx3LdbTYDz4lVmPqjX0WRqxQBP+z250XZVt48Gw41l+zRWpaTFS
         uUuW54w5DVphcbJLJlXi6h0oR8ws64t74JcZqD542xkcKZEb7Q/r4mbxg9Zyeiahv7zs
         ItO0ZDH2tdvom5IlswoW6CpbTkNV6QJXONa71d7kidMwWgXqxBo0D1KD9etPHNeIw64R
         pNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mP+0nJoKs9+LBTso2pGhaIsEwO4gged4NgXHNiqvDN4=;
        b=OkpJn5kM6R3qaFPtfpREqvJErnXfK9vcaqjioHcIvRTlQRp2NRPi8oELyKb0zEjPn0
         fQw+WIaIPk6JLZUIlnVRMU3qS08tUULpA2m1Vbpl4YucZz9p/ga1Nwc946bEieNwM+aS
         mSV6CtR0wRAhFrT49frUJtOmztwvEf8XVqyOoZycQgSuIuMiRs7RBYz1xUiH21G4LNQL
         SVk6awVS31gUrYXUQKaTo2N40TKzTYVQWMGPPtFFGN6zFLMOAKB1/CtZbSiAy6GgV0+v
         iFwGRyfTE5g2OqN0YYc0A0m/KzFZHuog657G4JGmVL0dRxq0u+6fW2c8hLLbPrZXIJwv
         Tqgw==
X-Gm-Message-State: AA+aEWYUunL8bUKFKXbWaevTDKUxlCDo4ewky+LSG+lh/gZjk3OGSkpX
        D81JYWb40q6VxC/BfeZZsAa6AA==
X-Google-Smtp-Source: AFSGD/WKnKm5lunn/RTOOp/MHmH8hRTwL9PkxyZ7eyTfEPfIxZMmmw66BBeiaB2pIe4BoobwOzsnSA==
X-Received: by 2002:a17:902:a83:: with SMTP id 3mr205472plp.276.1544145204218;
        Thu, 06 Dec 2018 17:13:24 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r66sm1891003pfk.157.2018.12.06.17.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 17:13:23 -0800 (PST)
Subject: Re: [PATCH] block: fix direct dispatch issue failure for clones
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
Date:   Thu, 6 Dec 2018 18:13:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 6:04 PM, jianchao.wang wrote:
> 
> 
> On 12/7/18 6:20 AM, Jens Axboe wrote:
>> After the direct dispatch corruption fix, we permanently disallow direct
>> dispatch of non read/write requests. This works fine off the normal IO
>> path, as they will be retried like any other failed direct dispatch
>> request. But for the blk_insert_cloned_request() that only DM uses to
>> bypass the bottom level scheduler, we always first attempt direct
>> dispatch. For some types of requests, that's now a permanent failure,
>> and no amount of retrying will make that succeed.
>>
>> Don't use direct dispatch off the cloned insert path, always just use
>> bypass inserts. This still bypasses the bottom level scheduler, which is
>> what DM wants.
>>
>> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index deb56932f8c4..4c44e6fa0d08 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>>  		 * bypass a potential scheduler on the bottom device for
>>  		 * insert.
>>  		 */
>> -		return blk_mq_request_issue_directly(rq);
>> +		blk_mq_request_bypass_insert(rq, true);
>> +		return BLK_STS_OK;
>>  	}
>>  
>>  	spin_lock_irqsave(q->queue_lock, flags);
>>
> Not sure about this because it will break the merging promotion for request based DM
> from Ming.
> 396eaf21ee17c476e8f66249fb1f4a39003d0ab4
> (blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback)
> 
> We could use some other way to fix this.

That really shouldn't matter as this is the cloned insert, merging should
have been done on the original request.


-- 
Jens Axboe


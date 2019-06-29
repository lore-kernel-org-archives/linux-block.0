Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAEEC4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5C221738
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1qfeaiV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfF2Pv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:51:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43458 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF2Pv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 11:51:29 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so19011888ios.10
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=v1hPMrirNj50WFcu2yNA0rhlTWKwDCN2QyhsEdO4T0c=;
        b=1qfeaiV2FSL/ImqJBbwH2WFUjfqG0NZi4HXsmU68CBvCV4X8ULuGsyA7M8nOKanOGx
         msbYZ+s3xWCkUirVUjbxRmdstwefmPLfRfkSLQEVhEMkdZ93/rCiU4BIuR8ButQyI5lh
         I4jKofnmZ+w9xPQ8Q14+VeIRGwW3L8Zr5iLQE1xc4SbW0uScxEszwFpVie5Itk0rYR50
         YzijMJTLuPEkYSH7tzpMJRj+Gf0FCawsa39bSFUSx/IRUXNT7dkJ3J1kuxW774BC8YDG
         2bsNQheHr5rxbU/gfAP2geE/T77HBfd+kvIE+ZT8MKZBtNjTPeOJIEDgVcefyMkl32hT
         C7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v1hPMrirNj50WFcu2yNA0rhlTWKwDCN2QyhsEdO4T0c=;
        b=pXzhBc9cC9zgXQMOHtZPy8+3zChiNPIP2M9KCSZpOzH+osGpt+hLJPNJtHXmCG9Noq
         LBC0YxUykIGc7ZRyJMQ7TAnETYDKf+ocRAif82lth5XHju2ukm4u6x7S1d3hpq5g3TUm
         VIVppWB6FOhflUSwWBhhiAPSHVNaOlzCDqmV/EyBRS8CT3FeFq4hiqXqv12sYyiPOw1R
         0dEJwMV+S+20I1cHjPS6HkvomaT2eOb4aAYriF5Md7dnfVXfHJTk1y35381KnUwzD0/N
         6bUf9PymQI1tBcUsvuVQJc6DLrW57pmEhQAG4eWyE6qul2ZujVdutgzr7J+8al8kAvFM
         36Dw==
X-Gm-Message-State: APjAAAVEtQKZLAX56VSAyt8TAQ8U0SJpJ8BVbjIw/GGJvTt8tniYQZXX
        BX/Ybk8PAyjImTMJiKuByJXrNw==
X-Google-Smtp-Source: APXvYqxVBrEY1Brkzk46lt1VEYoAtcrJHTKSQERb7slLmRtrnrkcatyl4zvQAD9hehB9LU1judTrBg==
X-Received: by 2002:a6b:7208:: with SMTP id n8mr16929470ioc.151.1561823488537;
        Sat, 29 Jun 2019 08:51:28 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m4sm9132641iok.68.2019.06.29.08.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:51:27 -0700 (PDT)
Subject: Re: [PATCH 1/1] sbitmap: Replace cmpxchg with xchg
To:     Pavel Begunkov <asml.silence@gmail.com>, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
 <0979d23f-bc31-b653-51d0-867dd52bf7ee@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7da51f2b-fda4-0aa4-717e-c13c80cced3e@kernel.dk>
Date:   Sat, 29 Jun 2019 09:51:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <0979d23f-bc31-b653-51d0-867dd52bf7ee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Omar?


On 6/29/19 9:42 AM, Pavel Begunkov wrote:
> Ping?
> 
> On 23/05/2019 08:39, Pavel Begunkov (Silence) wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> cmpxchg() with an immediate value could be replaced with less expensive
>> xchg(). The same true if new value don't _depend_ on the old one.
>>
>> In the second block, atomic_cmpxchg() return value isn't checked, so
>> after atomic_cmpxchg() ->  atomic_xchg() conversion it could be replaced
>> with atomic_set(). Comparison with atomic_read() in the second chunk was
>> left as an optimisation (if that was the initial intention).
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   lib/sbitmap.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 155fe38756ec..7d7e0e278523 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -37,9 +37,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
>>   	/*
>>   	 * First get a stable cleared mask, setting the old mask to 0.
>>   	 */
>> -	do {
>> -		mask = sb->map[index].cleared;
>> -	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
>> +	mask = xchg(&sb->map[index].cleared, 0);
>>   
>>   	/*
>>   	 * Now clear the masked bits in our free word
>> @@ -527,10 +525,8 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>>   		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>>   
>>   		if (waitqueue_active(&ws->wait)) {
>> -			int o = atomic_read(&sbq->wake_index);
>> -
>> -			if (wake_index != o)
>> -				atomic_cmpxchg(&sbq->wake_index, o, wake_index);
>> +			if (wake_index != atomic_read(&sbq->wake_index))
>> +				atomic_set(&sbq->wake_index, wake_index);
>>   			return ws;
>>   		}
>>   
>>
> 


-- 
Jens Axboe


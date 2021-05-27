Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A260C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27295613D8
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhE0UNu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 16:13:50 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34379 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhE0UNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 16:13:50 -0400
Received: by mail-pf1-f170.google.com with SMTP id q25so1466208pfn.1
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 13:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/p1hHTLINmVHF/0lKbVJ9Ndy5v+D57LrwKetIFpXLhk=;
        b=eQMBzJHRhX79FLtYFJE5+T8Bms7/9IGiYtcsiURO5kq3NHPV2lJ7SlpxtPG47PfSQq
         x9+DkYjv+6fHP8UtXWpq7M0I/RbBMoIB37TNkWd3B2czbeAPSbRXPpmVZcekhYyWQ7u3
         ggzo8wVe0kK8wDi+qL+HqXv+UJgYYI3iSyxPOF5AeA5CQDdiRIU/ABfjv3IOcTFcfotY
         wFNJCqC2jKjqXsn6/Pz+GGdiY6lF81zW4uIv+1/n3v8E7pIzTetmSwCeqQnku3tIATNV
         WFEts4SxAZZo4iCxaNFQ3IJRABRZrLZNeVs2X9TjNeoiaeMrihUkpCMN1gv0eerkQd2U
         6YEg==
X-Gm-Message-State: AOAM533euJlrjbNxlA0yj+ufE7UG3voBuweWcdrHDAguTrbri8OtBmdx
        iVvNVdGwEvkrki18AUC8LT0=
X-Google-Smtp-Source: ABdhPJx20jUTEH1N5U/evNuV91TyXw5nu6CChIU2hzum203eAO3bis6pOAnMns6Ba/DHTSQ3wBfsww==
X-Received: by 2002:a63:6784:: with SMTP id b126mr5250518pgc.209.1622146335407;
        Thu, 27 May 2021 13:12:15 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m20sm2506395pfd.133.2021.05.27.13.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 13:12:14 -0700 (PDT)
Subject: Re: [PATCH 8/9] block/mq-deadline: Add I/O priority support
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-9-bvanassche@acm.org>
 <DM6PR04MB7081661E924716B91E4E0899E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d1cf99a8-df7a-f33d-cee0-2906813256ce@acm.org>
Date:   Thu, 27 May 2021 13:12:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081661E924716B91E4E0899E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 8:48 PM, Damien Le Moal wrote:
> On 2021/05/27 10:02, Bart Van Assche wrote:
>> +	if (next->elv.priv[0]) {
>> +		atomic_inc(&dd->merged[prio]);
>> +	} else {
>> +		WARN_ON_ONCE(true);
>> +	}
> 
> I do not think you need the curly braces here.

These are present because patch 9/9 adds more code in this if-statement
and to improve readability of patch 9/9.

>> @@ -392,9 +453,14 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>  {
>>  	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
>>  	struct request *rq;
>> +	enum dd_prio prio;
>>  
>>  	spin_lock(&dd->lock);
>> -	rq = __dd_dispatch_request(dd);
>> +	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
>> +		rq = __dd_dispatch_request(dd, prio);
>> +		if (rq || dd_queued(dd, prio))
>> +			break;
>> +	}
>>  	spin_unlock(&dd->lock);
> 
> Unless I missed something, this means that the aging (fifo list expire)
> mechanism is per prio list but there is no aging between the prio classes. This
> means that an application doing lots of RT direct IOs will completely starve
> other prio classes and hang the applications using them.
> 
> I think we need aging between the prio classes too to avoid that.

OK, I will add an aging mechanism.

Bart.

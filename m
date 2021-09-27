Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C25C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC5160EE9
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 23:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbhI0XNv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:13:51 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:33702 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhI0XNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 19:13:50 -0400
Received: by mail-pj1-f52.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso846318pjb.0
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 16:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ul4tGaolRzhYmtw3yojFN4LHSe3D3At6SLvMcj5mjQM=;
        b=NcrciBwXkGorRDwFvc0n1qjxK3XJ280utPD6BpZYiJRtJqxZ4ZB6Demaa6IKxYDqk+
         RuX6oJLi3c92SFnuqG8BkvRzAzgys7u5bPIbzb10p9hLSHpq93zp4oLjCwaYsNQNlknm
         +qr4BiUqJFcKOvV1Y8rItjcgdDseaKccjQejVxFoy8RDaV5QFbhCP87Gy9KKfHCfRGXT
         jx5BW7iMkICA7ncO0mkgE+kTh/OKDvmPebyGrbEIwS7/9O/XiO3M4IT6M/rs/pwTnd9c
         jBsJ68rjvJKfMr+teu2QDLlnGCnqwSsIieub/YGORLrotQYVyAE51Dy2o+npcMnBzSDg
         521Q==
X-Gm-Message-State: AOAM530x5qiZtf5fmvLE3xgXAC9lC8rvi8Wi5J6wXq13kq1v3rQv4HUg
        9I+snBdbpZuTuEVH526q8sU=
X-Google-Smtp-Source: ABdhPJyUk+OmLJRh24xFxcItN3/vHRCobxeQKTKc6OHimMcbuLoJWYFTpUxYpXlPIqQyNvMpxCqTsA==
X-Received: by 2002:a17:903:1103:b0:13a:1dd7:485f with SMTP id n3-20020a170903110300b0013a1dd7485fmr1896222plh.6.1632784331823;
        Mon, 27 Sep 2021 16:12:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3e98:6842:383d:b5b2])
        by smtp.gmail.com with ESMTPSA id m22sm3915606pfo.176.2021.09.27.16.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 16:12:11 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
 <1d0893c3-da0a-e473-e37d-15df8e6d468e@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <82e092db-5d54-6c20-4fa1-3c0d860003dd@acm.org>
Date:   Mon, 27 Sep 2021 16:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1d0893c3-da0a-e473-e37d-15df8e6d468e@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 3:53 PM, Damien Le Moal wrote:
> On 2021/09/28 7:03, Bart Van Assche wrote:
>>   /*
>>    * deadline_dispatch_requests selects the best request according to
>> - * read/write expire, fifo_batch, etc
>> + * read/write expire, fifo_batch, etc and with a start time <= @latest.
> 
> s/@latest/@latest_start ?
> 
>>    */
>>   static struct request *__dd_dispatch_request(struct deadline_data *dd,
>> -					     struct dd_per_prio *per_prio)
>> +					     struct dd_per_prio *per_prio,
>> +					     unsigned long latest_start)

Right, the comment above this function needs to be updated.

Bart.

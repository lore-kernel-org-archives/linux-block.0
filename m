Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3200ECAAD4
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 13:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiHZNgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245585AbiHZNgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 09:36:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D81ADC5F5
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 06:36:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b142so1151078iof.10
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3a+z00Gw2hAbx/w565m3qWMn6fnpdBfIyLFEIebsD0I=;
        b=srAtmf9Mkp2Z4TqPvYfpM1Fa8E4ytyMQ5HRRbxxaZFzYsxs0zFkVl4qKXXUb44fkSX
         m4D60YYCHBn+5NeuYusIsJTZRrcDz8D7IxbJBZbU/YRPBhWenJVWp8Or9R+ZAXfiuy6Z
         tsGDP/ER+poVb7lOR1R80fciFr4jnHmtWvANioNMqtwzTeZ92/fmdEv+MeBF2MMsLZqR
         AFb+aZ1kbNXpOPexFkSOEuCxWdEuOjHVlzMnwKjrQLbMFtUFcSS5kiiycTe+R/XwhSnW
         JDlb7QmmcUFu0ooE3N6lOBP9yv9bojnKwbXmEkOSM4+6kNFHQ4gac1C/PZSschiqvgrL
         4+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3a+z00Gw2hAbx/w565m3qWMn6fnpdBfIyLFEIebsD0I=;
        b=12BmgeBTDHzfkvY6Y7nko05w63Us6xLzcMAOAWgtoCPfAkCfO+Earc4WJqn3mO4/ic
         pAwrqZh+5+Ebzdh8IpnX2Dr/JhEHzDRcGsBGkcU7zNnjrg8IlHJE0lN6Gz5LI0ABQhpU
         Ge8f0YF1SQcFD61PvgQ8BXBG6zEWo+UV+leMDmRyTvnrAf69x5ghGu38HdvrqovI4HPy
         H+CK1XUY6foe0KKJHDFYa4YTy1tdSf/vbSUqMoHsyHMRhCo69hzBAseADsbjnx2SCN5g
         Tg48VPyygSWDCa9V/2yimpEzL73WgQwvcWo78/jp0qsy4cslEzPY4buZ2eOUQjl1OBJF
         alOA==
X-Gm-Message-State: ACgBeo0E/JMVH3m2h4XgqmI+/S/xv2PX6gTZFK1JCXNMrHQLF82kQqSl
        2WPWaju3Wcxu5FTlLQkzQ9c2yw==
X-Google-Smtp-Source: AA6agR7SX+IuqG+ECrpcxgXw0ywxmhWsosal1s2HJu/4QUhOmt1lkt2h/z+w6d+ZyxLpUvW8L3BwfQ==
X-Received: by 2002:a05:6638:3f16:b0:346:ca43:b56e with SMTP id ck22-20020a0566383f1600b00346ca43b56emr4302888jab.117.1661520971580;
        Fri, 26 Aug 2022 06:36:11 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l203-20020a6b3ed4000000b0067fb21ad9c3sm1092483ioa.22.2022.08.26.06.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 06:36:11 -0700 (PDT)
Message-ID: <81c70a13-0317-49b7-c3b6-61f6aaa21c10@kernel.dk>
Date:   Fri, 26 Aug 2022 07:36:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Content-Language: en-US
To:     gumi@linux.alibaba.com, 'Bart Van Assche' <bvanassche@acm.org>,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org
References: <000a01d8b8fb$7b4a7950$71df6bf0$@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000a01d8b8fb$7b4a7950$71df6bf0$@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/22 9:25 PM, gumi@linux.alibaba.com wrote:
> On 8/25/22 00:09, Gu Mi wrote:
>> The problem occurs in two async processes, One is when a new IO calls 
>> the blk_mq_start_request() interface to start sending,The other is 
>> that the block layer timer process calls the blk_mq_req_expired 
>> interface to check whether there is an IO timeout.
>>
>> When an instruction out of sequence occurs between blk_add_timer and 
>> WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface 
>> blk_mq_start_request,at this time, the block timer is checking the new 
>> IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT and 
>> req->deadline is 0 at this time, the new IO will be misjudged as a 
>> timeout.
>>
>> Our repair plan is for the deadline to be 0, and we do not think that 
>> a timeout occurs. At the same time, because the jiffies of the 32-bit 
>> system will be reversed shortly after the system is turned on, we will 
>> add 1 jiffies to the deadline at this time.
>>
>> Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
>> ---
>> v1->v2:
>>
>> time_after_eq() can handle the overflow, so remove the change on 
>> 32-bit in blk_add_timer().
>>
>>   block/blk-mq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c index 4b90d2d..6defaa1 
>> 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1451,6 +1451,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
>>   		return false;
>>   
>>   	deadline = READ_ONCE(rq->deadline);
>> +	if (unlikely(deadline == 0))
>> +		return false;
>>   	if (time_after_eq(jiffies, deadline))
>>   		return true;
>>   
> 
> rq->deadline == 0 can be a valid deadline value so the above patch
> doesn't look right to me.

Gu, you need to fix your quoting of emails, these are impossible to
read.

That aside, I think there's a misunderstanding here. v1 has some
parts and v2 has others. Please post a v3 that has the hunk
that guarantees that deadline always has the lowest bit set if
assigned, and the !deadline check as well.

-- 
Jens Axboe



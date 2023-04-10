Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C03BC76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 17:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjDJRXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDJRXq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 13:23:46 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588DC1BFF
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:23:46 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id 20so7034638plk.10
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681147426; x=1683739426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bnl9h7ZWIPPgCvWY3p1s/MaPZtRAP0mSZQHFW8DoXGk=;
        b=5NPKKqend8PmrZt/nO4NHjJu7B1iY/8JAlLl+YYtG38v2StdzsGTKEnn1nZnu3/asv
         ElzCLq7sT/CIgFEoGjw5C8XSvVC+Uh/aiKYR2UfdULDHUBvjLl/RAF+jzfgmg1Wfk3He
         CklFFXid+Uw4lKuWzWKsTFlGq3uW3qKMFF+fydQnBQW0SDCHwL6smoFtJB1nyP/XBfeC
         2rb6JG2ELYF5ISpa8L3OmedG1w/11Sq5Qege0vlVkL5OgidbhpUcSC3DrnT0E8oFZyfv
         vWkrF6h7yX7NsXl0T25b3HQN14H+vOjlWGKAXjLOHo1wUH82E+Pnwdsfwivfp1UCn6Kg
         13fQ==
X-Gm-Message-State: AAQBX9dwwolj3XJFiJNbYuTIkfDbCnsXzbHtqqRAs+CvLOGnp5nbCuxl
        VXFTcWJ2H/HZAK2IAsqxZ/k=
X-Google-Smtp-Source: AKy350ZSSFn7Uyw8a5hvT2aQjtxD39n9jxOfWTKSwHqlo/Na9MVgZgYVHjWqLxZsEWenDGfLLk29Sg==
X-Received: by 2002:a17:903:120b:b0:1a4:f8e7:29ed with SMTP id l11-20020a170903120b00b001a4f8e729edmr16852554plh.41.1681147425721;
        Mon, 10 Apr 2023 10:23:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902bd4c00b001a5023e7395sm7675748plx.135.2023.04.10.10.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:23:45 -0700 (PDT)
Message-ID: <2399ce21-ed71-9a87-9e88-f91a37822699@acm.org>
Date:   Mon, 10 Apr 2023 10:23:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 11/12] block: mq-deadline: Fix a race condition related
 to zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-12-bvanassche@acm.org>
 <daabaf7e-6672-689c-ecd1-efea0407b6a1@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <daabaf7e-6672-689c-ecd1-efea0407b6a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 01:16, Damien Le Moal wrote:
> On 4/8/23 08:58, Bart Van Assche wrote:
>> +		WARN_ON_ONCE(!blk_queue_is_zoned(q));
> 
> I do not think this WARN is useful as blk_req_can_dispatch_to_zone() will always
> return true for regular block devices.

Hi Damien,

I will leave it out.

Are you OK with adding a blk_rq_zone_no() definition if 
CONFIG_BLK_DEV_ZONED is not defined (as has been done in this patch) or 
do you perhaps prefer that I surround the code blocks that have been 
added by this patch and in which blk_rq_zone_no() is called by #ifdef 
CONFIG_BLK_DEV_ZONED / #endif?

>> +
>> +		if (!blk_queue_nonrot(q)) {
>>   			rq = deadline_skip_seq_writes(dd, rq);
>> +			if (!rq)
>> +				break;
>> +			rq = deadline_earlier_request(rq);
>> +			if (WARN_ON_ONCE(!rq))
>> +				break;
> 
> I do not understand why this is needed.

Are you perhaps referring to the deadline_earlier_request() call? The 
while loop below advances 'rq' at least to the next request. The 
deadline_earlier_request() call compensates for this by going back to 
the previous request.

Thanks,

Bart.

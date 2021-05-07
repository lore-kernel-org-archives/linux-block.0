Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E81C433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2BE60C41
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhEGBLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:11:12 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:36402 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEGBLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:11:12 -0400
Received: by mail-pl1-f169.google.com with SMTP id a11so4314310plh.3
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 18:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFKCqxvRVmgvb9R3lnP4wg+rz1E8QD/dHYCMGwapRZc=;
        b=ryBZHZwR7h1ukLZa/o5VMVV/Jzit9aOlRAdBqtmS1pwJ5jxPnqrtbncN6t15u9vgvc
         PowvyVqUp3fpfm9dYx9QEE22SN8dGdxhCUKD1AIa7ti/GDzxlvx7Y4B6sR4PP707pr3Y
         DuPlEeFr5PpgYz+3xslBc3LvsrGZ1+c4kiXDQBOc4PXqNOWImxyvP8Y6+uWSqPPvASPQ
         LOSsreHZM1SHFPES0HkqvEUZIZ94Rqcb9DO1iG8oVZeNHJnQHuieHFn1BTu+HdbtlOSx
         FE/lYpDkKPBshKSMBloUGQkfnTFvNzNdmryELK2R/YqEoHQob51uZy2jN6qgGQ1MGrVg
         OFlw==
X-Gm-Message-State: AOAM530IWYUTut/FY2KNbCh+UuzFHUUEgzqmlGDpgZMUQ7zNQKcWet0d
        JUL/YdF9VCmkP15TNQ//G4s=
X-Google-Smtp-Source: ABdhPJzLzXBLB1n0QaKuV2qKQyOdX9C4vkDS28zfKZlDDQVshtYe6eZsEspdsqattO4iJl3RoOC58g==
X-Received: by 2002:a17:90a:a589:: with SMTP id b9mr7542854pjq.80.1620349811833;
        Thu, 06 May 2021 18:10:11 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b6sm3309493pfb.27.2021.05.06.18.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 18:10:11 -0700 (PDT)
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org> <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org> <YJSFm99PUlLedF+D@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <739456b9-e8d4-310e-9bf3-7b8930a1e51c@acm.org>
Date:   Thu, 6 May 2021 18:10:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJSFm99PUlLedF+D@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/21 5:11 PM, Ming Lei wrote:
> On Thu, May 06, 2021 at 07:51:53AM -0700, Bart Van Assche wrote:
>> I'm not sure that would be a better name since I don't think that it is
>> necessary to hold that lock around the cmpxchg() calls. How about using
>> something like the following code in blk_mq_clear_rq_mapping() instead
>> of the code in v5 of patch 3/4?
>>
>> 	spin_lock_irqsave(&drv_tags->lock, flags);
>> 	spin_unlock_irqrestore(&drv_tags->lock, flags);
>>
>> 	list_for_each_entry(page, &tags->page_list, lru) {
>> 		/* use cmpxchg() to clear request pointer selectively */
>> 	}
> 
> This way won't work as expected because iterating may happen between
> releasing drv_tags->lock and cmpxchg(->rqs[]), then freed requests
> may still be touched during iteration after they are freed in blk_mq_free_rqs().

Right, the unlock should happen after the pointers have been cleared. 
But I think it is safe to move the spin_lock call down such that both 
the spin_lock and spin_unlock call happen after the pointers have been 
cleared. That is sufficient to guarantee that all 
blk_mq_find_and_get_req() calls either happen before or after the spin 
lock / unlock pair. blk_mq_find_and_get_req() calls that happen before 
the pair happen before the request pointers are freed. Calls that happen 
after the spin lock / unlock pair will either read NULL or a pointer to 
a request that is associated with another queue and hence won't trigger 
a use-after-free.

Bart.

Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26849C3A5A1
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01302339F
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 19:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfHVTw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:52:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38568 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfHVTw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 15:52:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so4669655pfg.5
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2019 12:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DK8QaPljbev5PJxNCaiQinBv791dt3WlySGZV+hYP0g=;
        b=ILAsfsIavuo11uskJFpRMT2qy49LLjxsexyu+5OWLYuTY0062D06/tRISSJ+rMMFUu
         H/BGkBbdLjedU6BWT854b+KReU875fhUSl+oYyIVVF4dEBBnY4Q/1uxMjCHOBVqsbXKW
         lcfg80W83Jn/8e841smWleGp0VDrC8i2kN+2+hYnubNQIiqf+EUJGRpJvX0WR78dOgJf
         f8qVCqsXX8jLYw1gqbnnqrNbCoRuCLnuKJ6XhYNnvdaS01Dlc/MXAO3NMQ1lLk9ArgvZ
         eP0LNlxSOWGy4Y/11P4N+YhD3LGRnMTybQAl2uHxQ4rD/ewZvaWV5gheIFT4IkJRYrZI
         E/5Q==
X-Gm-Message-State: APjAAAXNvXM/Ycl/0bbs0JaHCzPBj5yimD8G/zrGMMhMW8xX/E6Rj9oT
        p/wFyCmv1+l8OTgpMinRjsg=
X-Google-Smtp-Source: APXvYqxFXO9GO7aaeYxNfT66ERAZqY9ISyplkQayz+FEXAVBN7vo1Q5/tU/wqLxns3ysqEFW4FoLGA==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr757304pgc.139.1566503576433;
        Thu, 22 Aug 2019 12:52:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d12sm230697pfn.11.2019.08.22.12.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 12:52:55 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] block: split .sysfs_lock into two locks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-7-ming.lei@redhat.com>
 <6d97a960-52b5-5134-5382-dff73be00722@acm.org>
 <20190822012839.GB28635@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <04b567f5-df49-3d44-1707-14fe8445843e@acm.org>
Date:   Thu, 22 Aug 2019 12:52:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822012839.GB28635@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 6:28 PM, Ming Lei wrote:
> On Wed, Aug 21, 2019 at 09:18:08AM -0700, Bart Van Assche wrote:
>> On 8/21/19 2:15 AM, Ming Lei wrote:
>>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>>> index 31bbf10d8149..a4cc40ddda86 100644
>>> --- a/block/blk-mq-sysfs.c
>>> +++ b/block/blk-mq-sysfs.c
>>> @@ -247,7 +247,7 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
>>>    	struct blk_mq_hw_ctx *hctx;
>>>    	int i;
>>> -	lockdep_assert_held(&q->sysfs_lock);
>>> +	lockdep_assert_held(&q->sysfs_dir_lock);
>>>    	queue_for_each_hw_ctx(q, hctx, i)
>>>    		blk_mq_unregister_hctx(hctx);
>>> @@ -297,7 +297,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>>>    	int ret, i;
>>>    	WARN_ON_ONCE(!q->kobj.parent);
>>> -	lockdep_assert_held(&q->sysfs_lock);
>>> +	lockdep_assert_held(&q->sysfs_dir_lock);
>>>    	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
>>>    	if (ret < 0)
>>
>> blk_mq_unregister_dev and __blk_mq_register_dev() are only used by
>> blk_register_queue() and blk_unregister_queue(). It is the responsibility of
>> the callers of these function to serialize request queue registration and
>> unregistration. Is it really necessary to hold a mutex around the
>> blk_mq_unregister_dev and __blk_mq_register_dev() calls? Or in other words,
>> can it ever happen that multiple threads invoke one or both functions
>> concurrently?
> 
> hctx kobjects can be removed and re-added via blk_mq_update_nr_hw_queues()
> which may be called at the same time when queue is registering or
> un-registering.

Shouldn't blk_register_queue() and blk_unregister_queue() be serialized 
against blk_mq_update_nr_hw_queues()? Allowing these calls to proceed 
concurrently complicates the block layer and makes the block layer code 
harder to review than necessary. I don't think that it would help any 
block driver to allow these calls to proceed concurrently.

Thanks,

Bart.

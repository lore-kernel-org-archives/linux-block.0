Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41839 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeAEEBu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 23:01:50 -0500
Subject: Re: [PATCH v1 05/10] bcache: stop dc->writeback_rate_update if cache
 set is stopping
To: tang.junhui@zte.com.cn
Cc: mlyle@lyle.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1515069707-18825-1-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <1242ca61-a848-eb17-3d2b-e2e037178846@suse.de>
Date: Fri, 5 Jan 2018 12:01:33 +0800
MIME-Version: 1.0
In-Reply-To: <1515069707-18825-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/01/2018 8:41 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Hello Coly,
> 
>> When cache set is stopping, calculating writeback rate is wast of time.
>> This is the purpose of the first checking, to avoid unnecessary delay
>>from bcache_flash_devs_sectors_dirty() inside __update_writeback_rate().
> 
> I thought twice, and found there is still a race.
> 
> work update_writeback_rate is runing:                                                                                
>> @@ -91,6 +91,11 @@ static void update_writeback_rate(struct work_struct *work)
>>     struct cached_dev *dc = container_of(to_delayed_work(work),
>>                          struct cached_dev,
>>                          writeback_rate_update);
>> +    struct cache_set *c = dc->disk.c;
>> +
>> +    /* quit directly if cache set is stopping */
>> +    if (test_bit(CACHE_SET_STOPPING, &c->flags))
>> +        return;
>>
>>     down_read(&dc->writeback_lock);
>>
>> @@ -100,6 +105,10 @@ static void update_writeback_rate(struct work_struct *work)
>>
>>     up_read(&dc->writeback_lock);
>>
>> +    /* do not schedule delayed work if cache set is stopping */
>> +    if (test_bit(CACHE_SET_STOPPING, &c->flags))
>> +        return;
>> +
> 
> and if cancel_delayed_wsrksync() runs at this moment, the code can not prevent the
> work re-arming itself to workqueue. So maybe we need a locker to protect it.    
> 

Hi Junhui,

Nice catch! Yes, there should be something here to avoid such race. I
will fix it in v2 patch.

Thanks for the hint.

Coly Li

>>     schedule_delayed_work(&dc->writeback_rate_update,
>>                   dc->writeback_rate_update_seconds * HZ);
>> }

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeADI4U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 03:56:20 -0500
Subject: Re: [PATCH v1 06/10] bcache: stop dc->writeback_rate_update,
 dc->writeback_thread earlier
To: tang.junhui@zte.com.cn
Cc: mlyle@lyle.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1515000433-6039-1-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <bfc45abe-dd4b-95e7-1fec-2507caebdf38@suse.de>
Date: Thu, 4 Jan 2018 16:56:00 +0800
MIME-Version: 1.0
In-Reply-To: <1515000433-6039-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/01/2018 1:27 AM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Hello Coly,
> Thanks for your works!
> 

Hi Junhui,

> Acctually stopping write-back thread and writeback_rate_update work in 
> bcache_device_detach() has already done in:
> https://github.com/mlyle/linux/commit/397d02e162b8ee11940a4e9f45e16fee0650d64e
>> Is it nessary to add "rate_update_canceled" to identify that
> whether writeback_rate_update work are already stoped or not? 
> I think it is ok to call cancel_delayed_work_sync(&dc->writeback_rate_update)
> twice before the memory of writeback_rate_update being released (It will return
> -ENOENT).
> 

Good suggestion, I just find after cancel_delayed_work_sync() returns
the worker is in idle state, so call cancel_delayed_work_sync() to an
idle worker will return 0 immediately, so rate_update_canceled is
unnecessary.

It seems your patch is enough and does the job. Let me test v2 patch set
against bcache-for-next, if it works I will remove this patch from my
patch set.

Thanks for your hint :-)

Coly Li

>> Delayed worker dc->writeback_rate_update and kernel thread
>> dc->writeback_thread reference cache set data structure in their routine,
>> Therefor, before they are stopped, cache set should not be release. Other-
>> wise, NULL pointer deference will be triggered.
>>
>> Currenly delayed worker dc->writeback_rate_update and kernel thread
>> dc->writeback_thread are stopped in cached_dev_free(). When cache set is
>> retiring by too many I/O errors, cached_dev_free() is called when refcount
>> of bcache device's closure (disk.cl) reaches 0. In most of cases, last
>> refcount of disk.cl is dropped in last line of cached_dev_detach_finish().
>> But in cached_dev_detach_finish() before calling closure_put(&dc->disk.cl),
>> bcache_device_detach() is called, and inside bcache_device_detach()
>> refcount of cache_set->caching is dropped by closure_put(&d->c->caching).
>>
>> It is very probably this is the last refcount of this closure, so routine
>> cache_set_flush() will be called (it is set in __cache_set_unregister()),
>> and its parent closure cache_set->cl may also drop its last refcount and
>> cache_set_free() is called too. In cache_set_free() the last refcount of
>> cache_set->kobj is dropped and then bch_cache_set_release() is called. Now
>> in bch_cache_set_release(), the memory of struct cache_set is freeed.
>>
>> bch_cache_set_release() is called before cached_dev_free(), then there is a
>> time window after cache set memory freed and before dc->writeback_thread
>> and dc->writeback_rate_update stopped, if one of them is scheduled to run,
>> a NULL pointer deference will be triggered.
>>
>> This patch fixes the above problem by stopping dc->writeback_thread and
>> dc->writeback_rate_update earlier in bcache_device_detach() before calling
>> closure_put(&d->c->caching). Because cancel_delayed_work_sync() and
>> kthread_stop() are synchronized operations, we can make sure cache set
>> is available when the delayed work and kthread are stopping.
>>
>> Because cached_dev_free() can also be called by writing 1 to sysfs file
>> /sys/block/bcache<N>/bcache/stop, this code path may not call
>> bcache_device_detach() if d-c is NULL. So stopping dc->writeback_thread
>> and dc->writeback_rate_update in cached_dev_free() is still necessary. In
>> order to avoid stop them twice, dc->rate_update_canceled is added to
>> indicate dc->writeback_rate_update is canceled, and dc->writeback_thread
>> is set to NULL to indicate it is stopped.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>

[code snip]

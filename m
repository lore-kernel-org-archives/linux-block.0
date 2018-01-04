Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751798AbeADISA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 03:18:00 -0500
Subject: Re: [PATCH v1 09/10] bcache: add io_disable to struct cache_set
To: tang.junhui@zte.com.cn
Cc: mlyle@lyle.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1515002376-6411-1-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <0ae606b1-df66-501a-c0b9-8ddd075bfad6@suse.de>
Date: Thu, 4 Jan 2018 16:17:53 +0800
MIME-Version: 1.0
In-Reply-To: <1515002376-6411-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/01/2018 1:59 AM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Hello Coly,
> 
> This patch is great!
> 
> One tips,
> Could you replace the c->io_disable with the already exsited c->flags? 
> So we can just need to add a new macro such as CACHE_SET_IO_DISABLE.
> 

Hi Junhui,

Your suggestion is cool! I will do it in v2 set. Thanks.

Coly Li


>> When too many I/Os failed on cache device, bch_cache_set_error() is called
>> in the error handling code path to retire whole problematic cache set. If
>> new I/O requests continue to come and take refcount dc->count, the cache
>> set won't be retired immediately, this is a problem.
>>
>> Further more, there are several kernel thread and self-armed kernel work
>> may still running after bch_cache_set_error() is called. It needs to wait
>> quite a while for them to stop, or they won't stop at all. They also
>> prevent the cache set from being retired.
>>
>> The solution in this patch is, to add per cache set flag to disable I/O
>> request on this cache and all attached backing devices. Then new coming I/O
>> requests can be rejected in *_make_request() before taking refcount, kernel
>> threads and self-armed kernel worker can stop very fast when io_disable is
>> true.
>>
>> Because bcache also do internal I/Os for writeback, garbage collection,
>> bucket allocation, journaling, this kind of I/O should be disabled after
>> bch_cache_set_error() is called. So closure_bio_submit() is modified to
>> check whether cache_set->io_disable is true. If cache_set->io_disable is
>> true, closure_bio_submit() will set bio->bi_status to BLK_STS_IOERR and
>> return, generic_make_request() won't be called.
>>
>> A sysfs interface is also added for cache_set->io_disable, to read and set
>> io_disable value for debugging. It is helpful to trigger more corner case
>> issues for failed cache device.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
[snip]

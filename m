Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C1C432BE
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 01:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCB9604D7
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 01:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhH1BLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 21:11:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58318 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhH1BLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 21:11:47 -0400
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17S1AfbL073427;
        Sat, 28 Aug 2021 10:10:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 28 Aug 2021 10:10:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17S1Af82073354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 28 Aug 2021 10:10:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
 <20210827184302.GA29967@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
Date:   Sat, 28 Aug 2021 10:10:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827184302.GA29967@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/28 3:43, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 01:03:45AM +0900, Tetsuo Handa wrote:
>>
>> loop_unregister_transfer() which is called from cleanup_cryptoloop()
>> currently lacks serialization between kfree() from loop_remove() from
>> loop_control_remove() and mutex_lock() from unregister_transfer_cb().
>> We can use refcount and loop_idr_spinlock for serialization between
>> these functions.
> 
> 
> So before we start complicating things for loop_release_xfer - how
> do you actually reproduce loop_unregister_transfer finding a loop
> device with a transfer set?  AFAICS loop_unregister_transfer is only
> called form exit_cryptoloop, which can only be called when
> cryptoloop has a zero reference count.  But as long as a transfer
> is registered an extra refcount is held on its owner.

Indeed, lo->lo_encryption is set to non-NULL by loop_init_xfer() after a refcount
is taken and lo->lo_encryption is reset to NULL by loop_release_xfer() before
that refount is dropped, and these operations are serialized by lo->lo_mutex. Then,
lo->lo_encryption == xfer can't happen unless forced module unload is requested.

That is, it seems that unregister_transfer_cb() is there in case forced module
unload of cryptoloop module was requested. And in that case, there is no point
with crashing the kernel via panic_on_warn == 1 && WARN_ON_ONCE(). Simple printk()
will be sufficient.

Removing unregister_transfer_cb() (if we ignore forced module unload) will be
a separate patch.

> 
>> @@ -2313,20 +2320,20 @@ static int loop_add(int i)
>>  		goto out;
>>  	lo->lo_state = Lo_unbound;
>>  
>> -	err = mutex_lock_killable(&loop_ctl_mutex);
>> -	if (err)
>> -		goto out_free_dev;
>> -
>>  	/* allocate id, if @id >= 0, we're requesting that specific id */
>> +	idr_preload(GFP_KERNEL);
>> +	spin_lock(&loop_idr_spinlock);
>>  	if (i >= 0) {
>> -		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
>> +		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_ATOMIC);
>>  		if (err == -ENOSPC)
>>  			err = -EEXIST;
>>  	} else {
>> -		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
>> +		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_ATOMIC);
>>  	}
>> +	spin_unlock(&loop_idr_spinlock);
>> +	idr_preload_end();
> 
> Can you explain why the mutex is switched to a spinlock?  I could not
> find any caller that can't block, so there doesn't seem to be a real
> need for a spinlock, while a spinlock requires extra work and GFP_ATOMIC
> allocations here.  Dropping the _killable probably makes some sense,
> but seems like a separate cleanup.

In order to annotate that extra operations that might sleep should not be
added inside this section. Use of sleepable locks tends to get extra
operations (e.g. wait for a different mutex / completion) and makes it unclear
what the lock is protecting. I can imagine a future that someone adds an
unwanted dependency inside this section if we use mutex here.

Technically, we can add preempt_diable() after mutex_lock() and
preempt_enable() before mutex_unlock() in order to annotate that
extra operations that might sleep should be avoided.
But idr_alloc(GFP_ATOMIC)/idr_find()/idr_for_each_entry() etc. will be
fast enough.

> 
>> +	if (!lo || !refcount_inc_not_zero(&lo->idr_visible)) {
>> +		spin_unlock(&loop_idr_spinlock);
>> +		return -ENODEV;
>>  	}
>> +	spin_unlock(&loop_idr_spinlock);
> 
>> +	refcount_dec(&lo->idr_visible);
>> +	/*
>> +	 * Try to wait for concurrent callers (they should complete shortly due to
>> +	 * lo->lo_state == Lo_deleting) operating on this loop device, in order to
>> +	 * help that subsequent loop_add() will not to fail with -EEXIST.
>> +	 * Note that this is best effort.
>> +	 */
>> +	for (ret = 0; refcount_read(&lo->idr_visible) != 1 && ret < HZ; ret++)
>> +		schedule_timeout_killable(1);
>> +	ret = 0;
> 
> This dance looks pretty strange to me.  I think just making idr_visible
> an atomic_t and using atomic_cmpxchg with just 0 and 1 as valid versions
> will make this much simpler, as it avoids the need to deal with a > 1
> count, and it also serializes multiple removal calls.

Yes if we ignore forced module unload (which needs to synchronously check
lo->lo_encryption) of cryptoloop module.

If we don't ignore forced module unload, we could update my patch to keep only
mutex_destroy() and kfree() deferred by a refcount, for only lo->lo_state,
lo->lo_refcnt and lo->lo_encryption would be accessed under lo->lo_mutex
serialization. There is no need to defer "del_gendisk() + idr_remove()"
sequence for concurrent callers.


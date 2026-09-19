Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037BF2E5B2A;
	Sat, 19 Sep 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814830; cv=none; b=pJCjzVvSNzgravj4iWzahaUYXCj98XI6c+rcJ1dkM44owJY7Dl/tOOkK/LIziGdgzdYJAz9/CHw8BiqKfpPNeFZP0ULH8aGU7CD/QLrUogulgHe7ovr4VsU3fBn9H9nbZElnG3Y4ivn6K9vc7EcySi064y+rHHeVN+R2dK4PBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814830; c=relaxed/simple;
	bh=rd5JL2uCKAQd45ccIiM+TM1pPA1RboIRuKCBefuWJCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT/u+yKK2/hqwSVFYYCJR1t7Vsx0oRHwoGHtthqQLd2lpK1dxgji7bNq0IYQxDYBNRpn1gyED4jAevIKH8LId/IHIwJb+kBsmMR1tN48d62KGu8nWTWV/W63sR3jS9qPVK7aecvR8PaCMKDQt72W+LUSStMTh27lMzPeCSXtLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68JAjo4U056451;
	Sat, 19 Sep 2026 19:45:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68JAjoFN056448
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 19:45:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a3850b6f-a209-48d0-867c-3c764a740022@I-love.SAKURA.ne.jp>
Date: Sat, 19 Sep 2026 19:45:47 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] loop: Perform __loop_clr_fd() after
 disk->open_mutex is dropped.
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <f597b6e6-77a7-4c09-9d72-e5a9cbe6d7c2@I-love.SAKURA.ne.jp>
 <8ac41772-c397-4069-8878-7a1924e8b8a3@I-love.SAKURA.ne.jp>
 <f232b118-f4d0-426a-94d4-eb9aa1f2d626@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <f232b118-f4d0-426a-94d4-eb9aa1f2d626@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav312.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/19 5:41, Bart Van Assche wrote:
> On 9/18/26 8:00 AM, Tetsuo Handa wrote:
>> +    /* Step 1: Flush all outstanding I/O, without open_mutex held. */
>> +    /*
>> +     * Since loop_queue_rq() is called with RCU read lock, this synchronize_rcu()
>> +     * makes sure that no more queue_work() calls are made from loop_queue_work()
>> +     * from loop_queue_rq(). Subsequent loop_queue_rq() calls which are made after
>> +     * this synchronize_rcu() returned shall see lo->lo_state != Lo_bound and
>> +     * return with BLK_STS_IOERR.
>> +     */
>> +    synchronize_rcu();
> 
> Calling blk_mq_quiesce_queue(lo->lo_queue) and
> blk_mq_unquiesce_queue(lo->lo_queue) is cleaner than calling
> synchronize_rcu(). Additionally, it makes the purpose more clear.

I appreciate your suggestions regarding APIs to use. However, since we don't
know why this problem started to manifest (it is possible that a bug was
introduced in the block layer APIs), I consider that we should start with
raw API (for least dependencies). We can monitor syzbot reports for 2 weeks
after this patch is applied to the linux tree. If my patch fails to fix
this problem, we can reconsider what we are missing. After that period,
you can apply your follow-up patches to the linux tree. If your patch
restarts to manifest this problem, we can suspect the delta.

> 
>> +    /*
>> +     * In order to flush outstanding I/O (without open_mutex for deadlock
>> +     * avoidance) before clearing the backing device, defer __loop_clr_fd()
>> +     * to lo_post_release().
>> +     * The Lo_rundown state guarantees that lo_open() will fail with -ENXIO.
>> +     * The failing lo_open() guarantees that lo_release() will not overwrite
>> +     * lo->rundown_owner until __loop_clr_fd() resets to the Lo_unbound state.
>> +     */
>>       if (need_clear)
>> +        WRITE_ONCE(lo->rundown_owner, current);
> 
> The above code can be moved before the mutex_unlock() call and the
> "need_clear" variable can be eliminated.

OK.

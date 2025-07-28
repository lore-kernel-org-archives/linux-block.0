Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5782737E3;
	Mon, 28 Jul 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722526; cv=none; b=b94YF0CthcGMZFiMEm1Jp0gVV3Eo5/FfMoHNG9PAp81Crm/P/7G6V5y3oXVOrNEZs04tqnjWHwjGzpWrvFQPFf8MD6SBOILbQz4er7xA1VH5ROQg2ADiei4/IvqkeCo5X8lQcUROYcTBfhKp83M3NtBIurWzPxgjeS3aB8E2USk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722526; c=relaxed/simple;
	bh=SHUD7JaD1vv7oqQPznOq9ukykwMfLFPM3jklsusef4I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FFnEei1DrpUNF544r0LKzW/SH/iH2fTHi+rSpike5u7fBgBOUtKPgeeiPyJi88K5m+E+Mlb2XS2K9IGWyN24e7KYbT9y2iP1dKf+krqsqK+fv5EAiO4TjjA8i3oO2kBE76cG7wBn8xiUtoIbtHS0WUA2uH4qgrYtnWGJdWpCvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8R+Bf6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8R+Bf6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8510CC4CEE7;
	Mon, 28 Jul 2025 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753722526;
	bh=SHUD7JaD1vv7oqQPznOq9ukykwMfLFPM3jklsusef4I=;
	h=Date:From:Reply-To:Subject:To:Cc:References:In-Reply-To:From;
	b=L8R+Bf6X9lusCj5uRPFr1kbTPN4bYkHS2qrlDkWpBIDqt+xR2TJsl4uzzQWLINgZu
	 y8DnnVWLldB9vIUprrWB1EWy5peMM5u3VV6S6ea7jbIOttxG1C4xXyt47dA/rbCMu2
	 rWnd+s6vzTpzNFa0UTdsKcHK924RZD72YGzM0YbVuqd+YfXyOTRFSXx6JSUdaW8bzl
	 5/AGc3nu6w5PHcBpJVNzMFgpCp/+KXpYn0fDsJWx40cPkBbORMltNHeQcvuKfF31W1
	 iYTdy4dihyPjBu9cmkSdu06XNDHAf+MMAd5/Fo2r6bp6KBXP4AsxjGbebPvvlqXN92
	 4UeK9801rs+7w==
Message-ID: <9dc51c34-1e5d-4da2-bc00-a89e7c173073@kernel.org>
Date: Tue, 29 Jul 2025 01:08:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yu Kuai <yukuai@kernel.org>
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH v2] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
To: Jan Kara <jack@suse.cz>
Cc: dlemoal@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250725180334.40187-1-yukuai@kernel.org>
 <64sbgvovtubkm2zelenee6pjkdciqlgqmri3bmycce6y265sy4@uptdqvz7g2lk>
Content-Language: en-US
In-Reply-To: <64sbgvovtubkm2zelenee6pjkdciqlgqmri3bmycce6y265sy4@uptdqvz7g2lk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/28 17:28, Jan Kara 写道:
> On Sat 26-07-25 02:03:34, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently issue io can grab queue_lock three times from bfq_bio_merge(),
>> bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
>> necessary if icq is already created because both queue and ioc can't be
>> freed before io issuing is done, hence remove the unnecessary queue_lock
>> and use rcu to protect radix tree lookup.
>>
>> Noted this is also a prep patch to support request batch dispatching[1].
>>
>> [1] https://lore.kernel.org/all/20250722072431.610354-1-yukuai1@huaweicloud.com/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Looks good! Just one small comment below. With that fixed feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>> index ce82770c72ab..ea9c975aaef7 100644
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -308,19 +308,18 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
>>   
>>   #ifdef CONFIG_BLK_ICQ
>>   /**
>> - * ioc_lookup_icq - lookup io_cq from ioc
>> + * ioc_lookup_icq - lookup io_cq from ioc in io issue path
>>    * @q: the associated request_queue
>>    *
>>    * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
>> - * with @q->queue_lock held.
>> + * from io issue path, either return NULL if current issue io to @q for the
>> + * first time, or return a valid icq.
>>    */
>>   struct io_cq *ioc_lookup_icq(struct request_queue *q)
>>   {
>>   	struct io_context *ioc = current->io_context;
>>   	struct io_cq *icq;
>>   
>> -	lockdep_assert_held(&q->queue_lock);
>> -
>>   	/*
>>   	 * icq's are indexed from @ioc using radix tree and hint pointer,
>>   	 * both of which are protected with RCU.  All removals are done
> In this comment there's still reference to holding 'q lock'. I think you
> should replace that with justification why when called from IO issue path
> we are guaranteed found pointer is safe to use.
Thanks for the review! How about:

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index ea9c975aaef7..fd77e655544f 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -322,9 +322,9 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)

         /*
          * icq's are indexed from @ioc using radix tree and hint pointer,
-        * both of which are protected with RCU.  All removals are done
-        * holding both q and ioc locks, and we're holding q lock - if we
-        * find a icq which points to us, it's guaranteed to be valid.
+        * both of which are protected with RCU, io issue path ensures that
+        * both request_queue and current task are valid, the founded icq
+        * is guaranteed to be valid until the io is done.
          */
         rcu_read_lock();
         icq = rcu_dereference(ioc->icq_hint);

>
> 								Honza


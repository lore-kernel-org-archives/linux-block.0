Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A012E414
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846475; cv=none; b=ItMXCDaTpwgzgRnW4kDya+sy5H1q8r2bS+MPawgmvopyXiW94j6WbUyP9qcAHzXYtaTmyGYEV57/91aXNBshwY6vUoxr3djwiTwu385e36pguYDdO595ldWonV3755DpSC5LuKfgq8pXUhZzPZBSMlOv3DY8rZ0NOETbbEwPpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846475; c=relaxed/simple;
	bh=6iK/30nGnwc+YNAmc9Xnema7Giu7cVIzuaDea8hMs1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1X2Z5WTL8NKxYHHyDazH5hk0s/BuVjx6RuU8qxRrJaSJbG8kGcoIE0KcHD/cnW+6Y+5RldgUnnebXzTKRAPdAJzwa67HjWiKd/TAiH1YE4gLLQcUEpVDEC5stBt/B9d5TMoXLcSUHEdUfCILg+IVlU0M9DisqFL7sE1XHv0OtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C/VcUeJS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C/VcUeJS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779846470; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+++8enUEtwpg+3X/60iThRXdIPk9VylOuP2juRxAZNM=;
	b=C/VcUeJSgFlQHMeBO6xzJgNOa8MRw5yZu6rPxCiEnBltWfVpNttHquCpaQX9dKvm9NUkEKebrNik+ecxPwwrEXWTpIAPPM8nA2w95Id6SpDizluVgN4fw6EKtsJMDe7FTz8CuVwI+SuE4qsL32wMv6vPX972T1YCmhpNR/EaQPQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3hh4Cq_1779846469;
Received: from 30.178.83.117(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X3hh4Cq_1779846469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 09:47:50 +0800
Message-ID: <1134d5f3-3cb5-469e-a23b-0a68ce61b998@linux.alibaba.com>
Date: Wed, 27 May 2026 09:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rename need_dispatch to cautious_dispatch in
 blk-mq sched
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260526131103.3105411-1-kanie@linux.alibaba.com>
 <458c5c9c-8740-4079-8800-f30e074fafef@kernel.dk>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <458c5c9c-8740-4079-8800-f30e074fafef@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/5/26 23:54, Jens Axboe 写道:
> On 5/26/26 7:11 AM, Guixin Liu wrote:
>> The local boolean in __blk_mq_sched_dispatch_requests() decides whether
>> to fall back to the per-ctx round-robin path (blk_mq_do_dispatch_ctx())
>> instead of the batch flush path (blk_mq_flush_busy_ctxs()).  The whole
>> function is about dispatching anyway, so the name "need_dispatch" is
>> not particularly informative and can mislead readers into thinking that
>> a false value means "skip dispatching".
>>
>> Rename it to "cautious_dispatch" to match the comment right above the
>> check ("dequeue request one by one from sw queue if queue is busy")
>> and to convey the actual intent: take the cautious, fair, one-at-a-time
>> path either when we just drained hctx->dispatch (so the device has
>> recently pushed back) or when the dispatch_busy EWMA still indicates
>> congestion.  The fast batch path is only taken when neither signal
>> suggests recent backpressure.
> If we're going to do churn like that, it should at least be an
> improvement. 'cautious_dispatch' tells the reader nothing about
> what kind of behavior this modifies. 'piecemeal_dispatch' would
> be much better, as it actually accurately describes what it
> does.
Sure, 'piecemeal_dispatch' indeed better, changed in v2. Best Regards, 
Guixin Liu


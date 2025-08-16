Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232501DDF7;
	Sat, 16 Aug 2025 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305386; cv=none; b=QQdSEfjl2mL0MQiP1fQAt0gm5WzWfvJQT27dvcLRXf0ExhydDQBPE7EA/n491yFrsJxX2VqIrUTKUY+FdIXPhvgXI7wLrr0RpZl4XEMmACjh7jryQo4QZ9OC6fTTrH4qyB+VkcJRVpcCqFdR2QQkY9VgN3ygbJjBZQ45H1/h3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305386; c=relaxed/simple;
	bh=wnSxeYT9jHCqs9ggL6pLznwdycg1HMBffXZUon7ufJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=em9EFvg8E5rWDTJG5Mb+zSmBOGQGPNKk+lk+FiT3g9fQD4PeO6DF+sQKC17izf/sKNnSPoyJ406x7Q/FMpW9ZXXKNGeFlFFR5ob+nfwvNDK8zt3I56YBfKp1PEX0ZUp+x3spGoD85/ie5yz46cUWy3ejEWwOBLHQ0GAL8LyFFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDb6fUv3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDb6fUv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54664C4CEEB;
	Sat, 16 Aug 2025 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755305385;
	bh=wnSxeYT9jHCqs9ggL6pLznwdycg1HMBffXZUon7ufJ8=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZDb6fUv3HKVbVKnbpw7YxqlGvlnjre+mC1S6LNYqVToeBEWK7fkKPA5Y5lNxJajq4
	 iYBfsCBgTXmamfoisw4LmehVy1MZ8cOXwmnvH7c1Ghy7ikerxmSQPHWnWnQ8VAIbyw
	 Lu3l0jES/AOoxlQ8QZPgtaL2pDR8Urv6cgPJA3xlqq5MxywZM8trMR3i6+gPkeGgfp
	 bhCRk0xiq/MW7t3OPc6tNGp20RHIovuiofPHS+xU0KNNqUsptYcHI+WZnEIsyGHEjX
	 y3m409dP4P5Khj3ODizLTIUaGc/j+VHQY+MT2lVufYKyDS+YvK22V5xnxEaTBfSgIp
	 X2hkopCKKjM7w==
Message-ID: <9194a254-5cbc-4adc-8710-271d95395b96@kernel.org>
Date: Sat, 16 Aug 2025 08:49:41 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 04/10] blk-mq: serialize updating nr_requests with
 update_nr_hwq_lock
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hare@suse.de, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-5-yukuai1@huaweicloud.com> <aJ9IkylydqSNZqwC@fedora>
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <aJ9IkylydqSNZqwC@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/8/15 22:47, Ming Lei 写道:
> On Fri, Aug 15, 2025 at 04:02:10PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> request_queue->nr_requests can be changed by:
>>
>> a) switching elevator by update nr_hw_queues
>> b) switching elevator by elevator sysfs attribute
>> c) configue queue sysfs attribute nr_requests
>   ->elevator_lock is grabbed for updating ->nr_requests except for queue
> initialization, so what is the real problem you are trying to solve?
>
In order to fix the regression and prevent deadlock, we'll have to 
allocate memory

in the case bitmap tags grow before freezing the queue, also prevent 
nr_requests

to be updated by case a and b concurrently.


Thanks,

Kuai

> Thanks,
> Ming
>
>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84C2CA8
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157525; cv=none; b=bj04TgFIqnoFJ6WOfLH80q0UOdGxvJRm23DPmCZHImo2YQUf6qxvdPUYS46BxWmI+uUl/0O1oPdUY4IExgp5fShAf4ZTt7spsEqV5BxVVT6GJkoZenwlbTt9g/Yav1d+NaHW74H462xREURcrk5LEZrCGKVCP87Tw0rVE8sy30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157525; c=relaxed/simple;
	bh=pZtgrDo+nGaUpROwpN3o7YDRFjlTkS87lF/JlVn3qJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMIM5svNV9+84GQ0AVUDAytv3PjJjAJWQv8WYlIkxsky3vGUvkHq8KYy0AOcUs7OvVj5I7UVQugf52Lzryej0IeFy5v4ebwOEOZPjfwS2tS501JA9dcNkoupQKIoCtI/VEayEz+ns3D+Qn9DJDdR9COocbZhilm49MBPuA7rnSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiDI+147; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiDI+147"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB94C4CED2;
	Mon,  6 Jan 2025 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736157525;
	bh=pZtgrDo+nGaUpROwpN3o7YDRFjlTkS87lF/JlVn3qJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FiDI+147q160Bi843SaYzy9d4AtNwPX9gUZbFV+YWJJMqNltH7YwUBXdy9RdWmNTc
	 Zyr/ZCBHwBiLTxwipMZf8JpQ40DHIj0dqYL4sxk1NddzdLku7zYby69f1sS+BEvawW
	 w5wDkAD6wFWlRUwldwKVLHEIDYCFhCOANHwqwuHblpPKKNv5yBuq2zVnNPjg89joEG
	 Mk1BOuwv4+WxF4apKP1UVC2IoFT1hNGc1WgAUKnktZjS0siyTuvXQ/2jNVkipcZieL
	 nO+H0u1I3Z0L0fSnWv3kSBROslpp1EMCGjdPw9cOhJZH6NlaX3m8AizIfg4y/Gl2o7
	 NuR+drj6/r1Jg==
Message-ID: <30064337-9fe1-47c7-b4ec-c999b06a1b47@kernel.org>
Date: Mon, 6 Jan 2025 18:58:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue
 freeze and limits lock order
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-3-dlemoal@kernel.org> <20250106083014.GD18408@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106083014.GD18408@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 5:30 PM, Christoph Hellwig wrote:
> On Sat, Jan 04, 2025 at 10:25:21PM +0900, Damien Le Moal wrote:
>> __blk_mq_update_nr_hw_queues() freezes a device queues during operation,
>> which also includes updating the BLK_FEAT_POLL feature flag for the
>> device queues using queue_limits_start_update() and
>> queue_limits_commit_update(). This call order thus creates an invalid
>> ordering of a queue freeze and queue limit locking which can lead to a
>> deadlock when the device driver must issue commands to probe the device
>> when revalidating its limits.
>>
>> Avoid this issue by moving the update of the BLK_FEAT_POLL feature flag
>> out of the main queue remapping loop to the end of
>> __blk_mq_update_nr_hw_queues(), after the device queues have been
>> unfrozen.
> 
> What happens if I/O is queued after the unfreeze, but before clearing
> the poll flag?

Ah, yes, that would potentially be an issue... Hmmm... Maybe a better solution
would be to move the start update out of the main loop and do it first, before
the freeze. What I do not fully understand with the code of this function is
that it does freeze and limit update for each tag list of the tag set, but
there is only a single request queue for all of them. So I am confused. Why
does the blk_mq_freeze_queue and poll limit setting have to be done in the loop
multiple times for each tag list ? I do not see it... If we can move these out
of the tag list loops, then correcting the ordering becomes easy.

-- 
Damien Le Moal
Western Digital Research

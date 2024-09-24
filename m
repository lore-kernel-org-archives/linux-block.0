Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514E77104;
	Tue, 24 Sep 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158258; cv=none; b=BONIMYmTZHQPAMuUWmHzHSTqrT8PeIP+bDst0Lu8Nfjm3fCYuOlOhGZavlzA4ydv30m4t5pbbYD3OiYsGXquy4A5PDOSjkwFQv2DZUuCvh7Dqex2z8LzUAcKu1jweU5zYb7lWeTZ1QiJaVAz3peCjUVzpvDGTKgqjk3ZWJrm77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158258; c=relaxed/simple;
	bh=TD6pAib6dE+VMMQwUFyZPy+NtgjTK80jpeya+pkA1kE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MwoVQ5Kcs6dkeL3xGM5tEP+kiKyO26diahGA9aAqTu3oaS6TC3QnriSGkV+5ixRf9MLiRz9qFwJ9Kz9jKUS1dZwSWj0Qu60tj9uht75CFaFmoJ1UcuFHs68EQEywdRtjF3aVfkOEGe4Da6MQUIBoshohWC/WmXhaLCDQGSnsQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E90eYb5P; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E90eYb5P"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727158253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9t7lQoHcHfAf+J7NuASpai8ucCshnv8Mc8AC5MWNPU=;
	b=E90eYb5PCWu6N7LwZU/TJ7EBi7/c7qRe1YxV0TtfNHlV3YGTW+tTLR6/Dws4RX2ekx/AcK
	pcQBqAbD7VNftyI2YGWOFAkft+vpi+DKdqvGo7pWmrMOE0zOPxnR8LCCuDX3oontZzMkgA
	ZNySLGEtIoF5QkIh4/0oY6gTQQ7aTJw=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v3 0/3] Fix some starvation problems in block layer
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240914072844.18150-1-songmuchun@bytedance.com>
Date: Tue, 24 Sep 2024 14:10:06 +0800
Cc: ming.lei@redhat.com,
 Muchun Song <songmuchun@bytedance.com>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C70283DE-699F-41BF-8C64-4155DD00D976@linux.dev>
References: <20240914072844.18150-1-songmuchun@bytedance.com>
To: axboe@kernel.dk
X-Migadu-Flow: FLOW_OUT



> On Sep 14, 2024, at 15:28, Muchun Song <songmuchun@bytedance.com> wrote:
> 
> We encounter a problem on our servers where hundreds of UNINTERRUPTED
> processes are all waiting in the WBT wait queue. And the IO hung detector
> logged so many messages about "blocked for more than 122 seconds". The
> call trace is as follows:
> 
>    Call Trace:
>        __schedule+0x959/0xee0
>        schedule+0x40/0xb0
>        io_schedule+0x12/0x40
>        rq_qos_wait+0xaf/0x140
>        wbt_wait+0x92/0xc0
>        __rq_qos_throttle+0x20/0x30
>        blk_mq_make_request+0x12a/0x5c0
>        generic_make_request_nocheck+0x172/0x3f0
>        submit_bio+0x42/0x1c0
>        ...
> 
> The WBT module is used to throttle buffered writeback, which will block
> any buffered writeback IO request until the previous inflight IOs have
> been completed. So I checked the inflight IO counter. That was one meaning
> one IO request was submitted to the downstream interface like block core
> layer or device driver (virtio_blk driver in our case). We need to figure
> out why the inflight IO is not completed in time. I confirmed that all
> the virtio ring buffers of virtio_blk are empty and the hardware dispatch
> list had one IO request, so the root cause is not related to the block
> device or the virtio_blk driver since the driver has never received that
> IO request.
> 
> We know that block core layer could submit IO requests to the driver
> through kworker (the callback function is blk_mq_run_work_fn). I thought
> maybe the kworker was blocked by some other resources causing the callback
> to not be evoked in time. So I checked all the kworkers and workqueues and
> confirmed there was no pending work on any kworker or workqueue.
> 
> Integrate all the investigation information, the problem should be in the
> block core layer missing a chance to submit that IO request. After
> some investigation of code, I found some scenarios which could cause the
> problem.
> 
> Changes in v3:
>  - Collect RB tag from Ming Lei.
>  - Adjust text to fit maximum 74 chars per line from Jens Axboe.

Hi Jens,

Friendly ping... Do you have any concerns regarding this version?

Muchun,
Thanks.

> 
> Changes in v2:
>  - Collect RB tag from Ming Lei.
>  - Use barrier-less approach to fix QUEUE_FLAG_QUIESCED ordering problem
>    suggested by Ming Lei.
>  - Apply new approach to fix BLK_MQ_S_STOPPED ordering for easier
>    maintenance.
>  - Add Fixes tag to each patch.
> 
> Muchun Song (3):
>  block: fix missing dispatching request when queue is started or
>    unquiesced
>  block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding
>    requests
>  block: fix ordering between checking BLK_MQ_S_STOPPED and adding
>    requests
> 
> block/blk-mq.c | 55 ++++++++++++++++++++++++++++++++++++++------------
> block/blk-mq.h | 13 ++++++++++++
> 2 files changed, 55 insertions(+), 13 deletions(-)
> 
> -- 
> 2.20.1
> 


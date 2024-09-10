Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE634D8B7
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936617; cv=none; b=sNSnsbuqOQLVDU84X6mzHssKIcyr5G+nnM/p8Yo+lBcPmxaWkUyNEBx/yzfKBRIWwOiVj/0Cr/10JkvuhwYS2FMXnR9SLx8138g2YMRgVfURZKwnhJuyuRhdoIcgHLBZuoqoxoiBm9TDOdrw8VzNHZ1eCanJZdTQNCucDUOU8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936617; c=relaxed/simple;
	bh=MO1+TYt1fooyuHeWj4ED+l72iQRQtHitJtZNEgDT8Ds=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tnseCer/6bbbOIffLod6yUXiqrz3Z0SJownR0Cqxsjtg5XxCewIYule8bU+/oF6YUaS1gjvpUkyMfreLAdQnfWmcQ1vvpVzKV7yOZTVV9fzR/MjIerkYsluMDnmjN15wx+VhKpJiMk3hGD54DHGUsrLf+tarPVuas0DXzpXgB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GiFah3pC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GiFah3pC"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725936613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHDUbdcPstyqiYRBW25kFRFq01/4AzGKKxPsu7QkdtM=;
	b=GiFah3pC4S6ld4TTzU1y+OYysYTH0wsMIauHK+TRCXK2VLpaUcv8Oi8LIWOA3SSRCLoPpN
	qqo8zTLY2z/x8XNxB9DULxLPRe/THr8pad/UoXcp4gDn9KRlViJolkQWIIDjJ3MyRvNUS/
	Gzy88T3pufPqkC3U1DZborYIxbIYMUk=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 0/3] Fix some starvation problems in block layer
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240903081653.65613-1-songmuchun@bytedance.com>
Date: Tue, 10 Sep 2024 10:49:32 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FCC991B-1D0A-4127-B95A-8021ABAF2FA8@linux.dev>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 3, 2024, at 16:16, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> We encounter a problem on our servers where hundreds of UNINTERRUPTED
> processes are all waiting in the WBT wait queue. And the IO hung =
detector
> logged so many messages about "blocked for more than 122 seconds". The
> call trace is as follows:
>=20
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
>=20
> The WBT module is used to throttle buffered writeback, which will =
block
> any buffered writeback IO request until the previous inflight IOs have
> been completed. So I checked the inflight IO counter. That was one =
meaning
> one IO request was submitted to the downstream interface like block =
core
> layer or device driver (virtio_blk driver in our case). We need to =
figure
> out why the inflight IO is not completed in time. I confirmed that all
> the virtio ring buffers of virtio_blk are empty and the hardware =
dispatch
> list had one IO request, so the root cause is not related to the block
> device or the virtio_blk driver since the driver has never received =
that
> IO request.
>=20
> We know that block core layer could submit IO requests to the driver =
through
> kworker (the callback function is blk_mq_run_work_fn). I thought maybe =
the
> kworker was blocked by some other resources causing the callback to =
not be
> evoked in time. So I checked all the kworkers and workqueues and =
confirmed
> there was no pending work on any kworker or workqueue.
>=20
> Integrate all the investigation information, the problem should be in =
the
> block core layer missing a chance to submit that IO request. After
> some investigation of code, I found some scenarios which could cause =
the
> problem.

Hi Jens Axboe,

May I ask if you have any suggestions for those fixes? Or if they could
be merged?

Muchun,
Thanks.

>=20
> Changes in v2:
>  - Collect RB tag from Ming Lei.
>  - Use barrier-less approach to fix QUEUE_FLAG_QUIESCED ordering =
problem
>    suggested by Ming Lei.
>  - Apply new approach to fix BLK_MQ_S_STOPPED ordering for easier =
maintenance.
>  - Add Fixes tag to each patch.
>=20
> Muchun Song (3):
>  block: fix missing dispatching request when queue is started or
>    unquiesced
>  block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding
>    requests
>  block: fix ordering between checking BLK_MQ_S_STOPPED and adding
>    requests
>=20
> block/blk-mq.c | 55 ++++++++++++++++++++++++++++++++++++++------------
> block/blk-mq.h | 13 ++++++++++++
> 2 files changed, 55 insertions(+), 13 deletions(-)
>=20
> --=20
> 2.20.1
>=20


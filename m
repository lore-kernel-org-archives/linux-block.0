Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E10273FC
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022682; cv=none; b=c7vmdBh9n8/nFKPnsdPsOuAFUZnRo8W2HP4MHahswf0hg102jPLh5coHavY0AC4L7l56aPoZh1/al7M5Gbq8OBrdbTgSP+/bw1iq/BiUO62uEgV7Vgv04bj/cuGtffzBzA0ha7qfsBwE4BnmT7DVyUuJvqrn86EVret9Wnaj9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022682; c=relaxed/simple;
	bh=w2xGw0kf1LAJk2nilXrmfyIL7CmAHpBdbeUvJbXLY9o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uHRM3gmhBWEHv3woXWZtjDzHgi1nApon3DXYEe08gfm5txiDIf2fzDJN3NqQ7O2II+5vPxpg/8oY9tWHIpSMMDui1dIi6BWbCbp4Z5EkUwW8FeBNQ1Ly7CkvBP5sF0HCAZis4u/tFM2UHyJx/jsX6WZKlvATAFdVk+aIU/tvuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VSZ54J9L; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VSZ54J9L"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726022678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTPaT1mpDIECM66gDBZIhhRa7JcORm56tkLLqPerpl0=;
	b=VSZ54J9LV9VheI1eD2TRgMsZx0KwIq49xq7pETTakvF7K4CIxqXnb/0XG7Nl1ivRPl1aTR
	CmL/OXXl4zy5wcDtXFGdXdWKDkVzS8i/XWkRcVev5VnBfpfwkNav/+Bfbuy9x8v+IChwwE
	sC9wYVWYCY8d65v3CRupF5fkfGvqe0Y=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 1/3] block: fix missing dispatching request when queue
 is started or unquiesced
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <0e4e1f5a-30fd-430b-99ec-8b1004d8e3fd@kernel.dk>
Date: Wed, 11 Sep 2024 10:43:56 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai1@huaweicloud.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <476C2322-BD02-4631-9588-E182847F9EC6@linux.dev>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-2-songmuchun@bytedance.com>
 <0e4e1f5a-30fd-430b-99ec-8b1004d8e3fd@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Migadu-Flow: FLOW_OUT



> On Sep 10, 2024, at 21:17, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 9/3/24 2:16 AM, Muchun Song wrote:
>> Supposing the following scenario with a virtio_blk driver.
>>=20
>> CPU0                                    CPU1                          =
          CPU2
>>=20
>> blk_mq_try_issue_directly()
>>    __blk_mq_issue_directly()
>>        q->mq_ops->queue_rq()
>>            virtio_queue_rq()
>>                blk_mq_stop_hw_queue()
>>                                        blk_mq_try_issue_directly()    =
         virtblk_done()
>>                                            if (blk_mq_hctx_stopped())
>>    blk_mq_request_bypass_insert()                                     =
             blk_mq_start_stopped_hw_queue()
>>    blk_mq_run_hw_queue()                                              =
                 blk_mq_run_hw_queue()
>>                                                =
blk_mq_insert_request()
>>                                                return // Who is =
responsible for dispatching this IO request?
>>=20
>> After CPU0 has marked the queue as stopped, CPU1 will see the queue =
is stopped.
>> But before CPU1 puts the request on the dispatch list, CPU2 receives =
the interrupt
>> of completion of request, so it will run the hardware queue and marks =
the queue
>> as non-stopped. Meanwhile, CPU1 also runs the same hardware queue. =
After both CPU1
>> and CPU2 complete blk_mq_run_hw_queue(), CPU1 just puts the request =
to the same
>> hardware queue and returns. It misses dispatching a request. Fix it =
by running
>> the hardware queue explicitly. And blk_mq_request_issue_directly() =
should handle
>> a similar situation. Fix it as well.
>=20
> Patch looks fine, but this commit message is waaaaay too wide. Please
> limit it to 72-74 chars. The above ordering is diagram is going to
> otherwise be unreadable in a git log viewing in a terminal.

Thanks for your reply. I'll adjust those lines to make the digram more
readable.

Muchun,
Thanks.

>=20
> --=20
> Jens Axboe


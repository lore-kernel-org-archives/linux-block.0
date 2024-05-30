Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84584E1F
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102050; cv=none; b=Uqn7Vj208Lc0YXdYIUIZf9uVELRKTUbX5HCJgGFWaEia1ef/UiJesfuL4vL7rLD0sUK0JRxzmTz4R5swiw0ENwTu16eCKGjNRBZCt9KL21ilPbwx9cKnxKh0RwjO15mrYGjarx9B4IPiaeXwprJjgZdD9DfwRVfSbHeGhYTIxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102050; c=relaxed/simple;
	bh=ZXKTlRYXVuLxCxIJXVRBgNNViO881p7pXt3fVtyL7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKF3Bt0LOhgPr3aqGu1yUSUEymMhHNJYsjpfEtrGzKvfnuR+8DUJ0u5AM+BevyvMc1hGbc5iElQ2U2Xx1oss6Uq8/lSSN9zCf+NCdWqcEtCHefKZZMyeRfeupVgpm7OiK3pe7MiB8zDml6IKf9uERr1qoGXQIcFD0SwzPQWRRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u11nqIdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u11nqIdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B9C3277B;
	Thu, 30 May 2024 20:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717102049;
	bh=ZXKTlRYXVuLxCxIJXVRBgNNViO881p7pXt3fVtyL7Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u11nqIdpfSgTRvxelwE0qy2coZ9guK1Qppf4+iWKVKYvvb9FSwoYJ1N2IUSp1CfA9
	 yc1wO8lDqLIX5r3n+PcGvSn4PW/oaPfPnbHktAMcrGNt3E5OCxMXUI240zm98fd9Gg
	 mK6M9azq62nJgfD4JTqmk3WuLd8DxpmL/Zz3vX+LdyfVTAggQ0NqVbxCLjYd4zZWc/
	 vN6U22zVzof5O+jVFkmP+k1CIpbJ7UeLY5N11RUviVnzzo9kbc/hM1qg4H7CrzYEC2
	 50gLuDKkAwnLTQjwnKilS0/uA9I/EucMG/qdkRCK6gPO/VRiv1qkg9XrvAR/6DUdrv
	 6iwBNwOvUkSkw==
Date: Thu, 30 May 2024 14:47:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH v7] block: Improve IOPS by removing the fairness code
Message-ID: <Zljl3kAfL0WfFkoZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20240529213921.3166462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529213921.3166462-1-bvanassche@acm.org>

On Wed, May 29, 2024 at 02:39:20PM -0700, Bart Van Assche wrote:
> There is an algorithm in the block layer for maintaining fairness
> across queues that share a tag set. The sbitmap implementation has
> improved so much that we don't need the block layer fairness algorithm
> anymore and that we can rely on the sbitmap implementation to guarantee
> fairness.
> 
> On my test setup (x86 VM with 72 CPU cores) this patch results in 2.9% more
> IOPS. IOPS have been measured as follows:
> 
> $ modprobe null_blk nr_devices=1 completion_nsec=0
> $ fio --bs=4096 --disable_clat=1 --disable_slat=1 --group_reporting=1 \
>       --gtod_reduce=1 --invalidate=1 --ioengine=psync --ioscheduler=none \
>       --norandommap --runtime=60 --rw=randread --thread --time_based=1 \
>       --buffered=0 --numjobs=64 --name=/dev/nullb0 --filename=/dev/nullb0
> 
> Additionally, it has been verified as follows that all request queues that
> share a tag set process I/O even if the completion times are different (see
> also test block/035):
> - Create a first request queue with completion time 1 ms and queue
>   depth 64.
> - Create a second request queue with completion time 100 ms and that
>   shares the tag set of the first request queue.
> - Submit I/O to both request queues with fio.
> 
> Tests have shown that the IOPS for this test case are 29859 and 318 or a
> ratio of about 94. This ratio is close to the completion time ratio.
> While this is unfair, both request queues make progress at a consistent
> pace.

I suggested running a more lopsided workload on a high contention tag
set: here's an example fio profile to exaggerate this:

---
[global]
rw=randread
direct=1
ioengine=io_uring
time_based
runtime=60
ramp_time=10

[zero]
bs=131072
filename=/dev/nvme0n1
iodepth=256
iodepth_batch_submit=64
iodepth_batch_complete=64

[one]
bs=512
filename=/dev/nvme0n2
iodepth=1
--

My test nvme device has 2 namespaces, 1 IO queue, and only 63 tags.

Without your patch:

  zero: (groupid=0, jobs=1): err= 0: pid=465: Thu May 30 13:29:43 2024
    read: IOPS=14.0k, BW=1749MiB/s (1834MB/s)(103GiB/60002msec)
       lat (usec): min=2937, max=40980, avg=16990.33, stdev=1732.37
  ...
  one: (groupid=0, jobs=1): err= 0: pid=466: Thu May 30 13:29:43 2024
    read: IOPS=2726, BW=1363KiB/s (1396kB/s)(79.9MiB/60001msec)
       lat (usec): min=45, max=4859, avg=327.52, stdev=335.25

With your patch:

  zero: (groupid=0, jobs=1): err= 0: pid=341: Thu May 30 13:36:26 2024
    read: IOPS=14.8k, BW=1852MiB/s (1942MB/s)(109GiB/60004msec)
       lat (usec): min=3103, max=26191, avg=16322.77, stdev=1138.04
  ...
  one: (groupid=0, jobs=1): err= 0: pid=342: Thu May 30 13:36:26 2024
    read: IOPS=1841, BW=921KiB/s (943kB/s)(54.0MiB/60001msec)
       lat (usec): min=51, max=5935, avg=503.81, stdev=608.41

So there's definitely a difference here that harms the lesser used
device for a modest gain on the higher demanding device. Does it matter?
I really don't know if I can answer that. It's just different is all I'm
saying.

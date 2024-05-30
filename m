Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE941760
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102947; cv=none; b=L4N0mHglLcDNRLY2TwwNH2SEXOLgmEja7Hl83wVDOvjgraU9dK6xEQeW1UQ4dqSySKLeSpQlygwT8UbXRtxalhjcInQannlErKCB5Fk/ZtShU0WjGLoPUsGYgd1ccbTqCFNTg+B2LpwxTMU5rMufR89DW9fzc7MS7QH8gl2vw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102947; c=relaxed/simple;
	bh=voWv5FHQHCqYFiXcjS2HPlspZ7YlnvrMwCAAXVjnEnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+D+c2vphLIvH4gBgFWkS15m/EKyfIuKtydxs9Hbjexj2/pQ/9j5uN7i7Cj4pSLKcZshdQVwdbyd+KLqiT+Zg5fYG6tLNr+axiMx2JAZEfhBk8AfcOML2cQHMeWfelh29td76exDS5c6uw+9QWHZmZfsVoMom1Xxf75y6kPo32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xT1evD1U; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xT1evD1U"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VqzGS6cxHz6Cnk9F;
	Thu, 30 May 2024 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717102941; x=1719694942; bh=6bAUfahgmHMpoalhPw8TCE+O
	gptaKUPJkplnVVWeTXE=; b=xT1evD1UghZj1tuHm+Akea8JQ1XwWePsKUWEXZcH
	Ts0MLroX3oXpbQPhMpOQWR/d53MxORZaq1LFD57/y4uIVvgmSHOXy3I4SXsR75LG
	+jjjePpXl53isMch8c/FHQGZNuVW+DF7DgpElRPdovrzu3OUjQ52BtlYEvUKWp6Y
	t+RmehVeZAKM8bACV670kV3J7IGKB5nE5Yo+RqRXngfox8AAWsff6Wrj07uZH69c
	gFs8W7NbtHqTppyrF+nDEBYXss8QYin+LYQqAck+qGHEYoP/FFYr7JhQq6D/NoPe
	Qxlpo0zGnzIkwKKMJTrm7Rh14ueyODUccB2wChibF6Ucbw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id daOa94n_FtBB; Thu, 30 May 2024 21:02:21 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VqzGN6Q9pz6Cnk9B;
	Thu, 30 May 2024 21:02:20 +0000 (UTC)
Message-ID: <a5c1716f-b21b-42d2-8ce3-13627566c754@acm.org>
Date: Thu, 30 May 2024 14:02:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] block: Improve IOPS by removing the fairness code
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
References: <20240529213921.3166462-1-bvanassche@acm.org>
 <Zljl3kAfL0WfFkoZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zljl3kAfL0WfFkoZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 13:47, Keith Busch wrote:
> I suggested running a more lopsided workload on a high contention tag
> set: here's an example fio profile to exaggerate this:
> 
> ---
> [global]
> rw=randread
> direct=1
> ioengine=io_uring
> time_based
> runtime=60
> ramp_time=10
> 
> [zero]
> bs=131072
> filename=/dev/nvme0n1
> iodepth=256
> iodepth_batch_submit=64
> iodepth_batch_complete=64
> 
> [one]
> bs=512
> filename=/dev/nvme0n2
> iodepth=1
> --
> 
> My test nvme device has 2 namespaces, 1 IO queue, and only 63 tags.
> 
> Without your patch:
> 
>    zero: (groupid=0, jobs=1): err= 0: pid=465: Thu May 30 13:29:43 2024
>      read: IOPS=14.0k, BW=1749MiB/s (1834MB/s)(103GiB/60002msec)
>         lat (usec): min=2937, max=40980, avg=16990.33, stdev=1732.37
>    ...
>    one: (groupid=0, jobs=1): err= 0: pid=466: Thu May 30 13:29:43 2024
>      read: IOPS=2726, BW=1363KiB/s (1396kB/s)(79.9MiB/60001msec)
>         lat (usec): min=45, max=4859, avg=327.52, stdev=335.25
> 
> With your patch:
> 
>    zero: (groupid=0, jobs=1): err= 0: pid=341: Thu May 30 13:36:26 2024
>      read: IOPS=14.8k, BW=1852MiB/s (1942MB/s)(109GiB/60004msec)
>         lat (usec): min=3103, max=26191, avg=16322.77, stdev=1138.04
>    ...
>    one: (groupid=0, jobs=1): err= 0: pid=342: Thu May 30 13:36:26 2024
>      read: IOPS=1841, BW=921KiB/s (943kB/s)(54.0MiB/60001msec)
>         lat (usec): min=51, max=5935, avg=503.81, stdev=608.41
> 
> So there's definitely a difference here that harms the lesser used
> device for a modest gain on the higher demanding device. Does it matter?
> I really don't know if I can answer that. It's just different is all I'm
> saying.

Hi Keith,

Thank you for having run this test. I propose that users who want better
fairness than what my patch supports use an appropriate mechanism for
improving fairness (e.g. blk-iocost or blk-iolat). This leaves the choice
between maximum performance and maximum fairness to the user. Does this
sound good to you?

Thanks,

Bart.

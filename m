Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755676;
	b=uAKhL602gGiy1CR/rJOV2kYzuv61YolELQnVHREVrHbAPGtDXHOxmv4sFvXY6eNu0hI+
	 2AQJ6uv331gZz8vy+ZoG45Wwl/luu3sYgSLJuKUZoJc5qxFNZNqwhmF7FfIvjTag1m9tI
	 lJXV/9EW3TI9xW3nsu8wKOy1UVM7kIHApP+8dgmhkq4ySSihfrhkw1Z7zAR+JsCLdWnmm
	 WWBwwT6tqDKna6tFfOtGe6LUZcl0HZ4tDMZKihDcopqmYwKUGpYrQSyCLoQ7q67RYpv3k
	 O3zRrT7K2NNztngVjmg7ouJNgRLpmFlf+BAlR0xnbtIcGqcBI7GpwGnKYHOaezEyOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755676;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5cygoKyDem6jl3IIN+AbxX+FnzVwflEWGyoiGRY80Yg=;
	b=hVJPrN9Xz4mXA+dv3okYPOapp1MuyfPDaR9uoqI2DzjGW4maHq1mEkpPNzEttOH+r8Qx
	 qtykrsQsi5nrpqkRURqIZ71Q3CvwNKeiTQbphwgZaUV0VaA7rjnAQFEkxQdg0hExUjfd9
	 RSagilaCySXOw8uqUJNMx/xzH3MNWNs2Cub7LZXUJYQdO52kGyo8keyBH5s3pl4wQp5RL
	 iJ4zWTWgnVw3hGMe5J0NZ8bzWh2ZO25WuHzOxyrDqNBT6A7oM1M2XsHoo7mChu3AhZQfe
	 SuY254BclbFSvBHd7Kfy/l1t/bbTXdy75VJbIRjmCLsAHvL/LC6L8T/z5xZ32Z4gdQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=T7hu9hVa;
	arc=none smtp.remote-ip=202.108.3.23
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88763606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 11:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88763606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=T7hu9hVa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1792755673;
	bh=5cygoKyDem6jl3IIN+AbxX+FnzVwflEWGyoiGRY80Yg=;
	h=From:Subject:Date:Message-ID;
	b=T7hu9hVax26zxqcRaWleaqz5PkCMUoMt7y7Z3deG6meK8VIjBMexx1HeWRIP8554C
	 0vABZjs0or3gfvrpj9vC6rD7FzbukNFxBoYnxKpcufDHYYAcgdbLS/CfHE5aSl2ls9
	 YLcDF+BYuSYTeUv2sbZGFMukcoyhIPzV2Nkfa3J0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.116.244])
	by sina.com (10.54.253.31) with ESMTP
	id 6ADB47CC00006537; Fri, 23 Oct 2026 19:41:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5283336815912
X-SMAIL-UIID: 834902246C7247D7A48A785F4A216E1C-20261023-194104-1
From: Hillf Danton <hdanton@sina.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Barry Song <21cnbao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Date: Fri, 23 Oct 2026 19:40:49 +0800
Message-ID: <20261023114050.1011-1-hdanton@sina.com>
In-Reply-To: <atrnvuQkeldgPqH5@google.com>
References: 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 23 Oct 2026 14:01:32 +0900 Sergey Senozhatsky wrote:
> On (26/10/22 19:11), Hillf Danton wrote:
> [..]
> > What I am confused is -- why decompression needs to run faster without boosting
> > compression up. Where is the compressed material?
> 
> In a typical embedded device (e.g. android) zram write is swap-out
> (direct, indirect kswapd, or backgroud service swapping out idle apps),
> users don't see those.  zram read, on the contrary, is what users
> see - because that's swap-in, read bursts when user brings back idle
> app (camera app, etc.) which needs to get back to foregound quickly.
> So, the read path is more important.
> 
> I tested the series against PE.
> 
Thanks for sharing data.

> readers vs readers (no writers) 3 runs
> 
>     BASE+PE     IOPS 1,449k  avg 3.48us  sd 155.6us  p99.99 26.8us  max 280,820us
>                 IOPS 1,435k  avg 3.69us  sd 322.9us  p99.99 24.2us  max 540,512us
>                 IOPS 1,459k  avg 3.46us  sd  92.8us  p99.99 25.5us  max 172,186us
>     PATCHED+PE  IOPS 1,457k  avg 3.31us  sd  15.9us  p99.99 25.5us  max   7,580us
>                 IOPS 1,475k  avg 3.28us  sd  14.6us  p99.99 24.5us  max   7,327us
>                 IOPS 1,463k  avg 3.32us  sd  17.2us  p99.99 28.5us  max   6,816us
> 
     BASE+PE     IOPS 1,449k
                 IOPS 1,435k
                 IOPS 1,459k
		+)----------
		      4,343
	       /3)----------
		      1,447

     PATCHED+PE  IOPS 1,457k
                 IOPS 1,475k
                 IOPS 1,463k
		+)----------
		      4,395
	       /3)----------
		      1,465

		(1,465 - 1,447) / 1,447 = 18 / 1,447 = 1%


> R/W stream split makes sense for reasons that we already mentioned.
> Readers don't need to be blocked on Writers - they don't compete for
> the same data.  And, moreover, readers don't need to be serialized at
> all for stateful decompression.
> 
> writers vs readers 3 runs
> 
>     BASE+PE     IOPS 1,271k  avg 5.57us  sd 1,393us  p99.99 27.5us  max 1,581,800us
>                 IOPS 1,461k  avg 3.43us  sd    78us  p99.99 23.9us  max   227,015us
>                 IOPS 1,444k  avg 3.48us  sd   222us  p99.99 23.9us  max   592,628us
>     PATCHED+PE  IOPS 1,457k  avg 3.32us  sd    18us  p99.99 27.5us  max     5,620us
>                 IOPS 1,464k  avg 3.31us  sd    17us  p99.99 24.2us  max     5,621us
>                 IOPS 1,475k  avg 3.29us  sd    16us  p99.99 26.5us  max     5,620us
> 
     BASE+PE     IOPS 1,271k
                 IOPS 1,461k
                 IOPS 1,444k
		+)----------
		      4,176
	       /3)----------
		      1,392

     PATCHED+PE  IOPS 1,457k
                 IOPS 1,464k
                 IOPS 1,475k
		+)----------
		      4,396
	       /3)----------
		      1,465

		(1,465 - 1,392) / 1,392 = 73 / 1,392 = 5%


	improvment	within 5%	more than 10%	more than 20%
	(mIngo's) rule	safely ignored	good		standing ovation

More than two miles away from standing ovation.

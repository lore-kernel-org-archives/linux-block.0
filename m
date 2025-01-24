Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255C23A0
	for <linux-block@vger.kernel.org>; Fri, 24 Jan 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711021; cv=none; b=OpISEjeZzxBxYJiPmwLIoCnZypMslcaaKaJVaB4yIPaQCv/7RRw2LYqpu4TWwDVGNV46Llq43kWixYIFW9JMK5/tbk90y8Rit7/PCxzlIqGHtTDoWUj9xEPyOwx7uC4SOsFdH2bngA808lXTRRvRDPjpmGSkh4NGofWi5LZwWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711021; c=relaxed/simple;
	bh=ZNu6YTLe1jRQVQcIbdcrSgax4kIomomoZUYkdluRHaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0d7qLWTnn8i0xn5OMDgtLYTOcp3u5Td7CnRCvhWMQ4tj9h2o/2SgaYKZl42EyaI7MvfN7OcnEx5wrA5KqBYqWYpMGnaCj9VCHrqmnP1oH6GK3TFyGVA35JS+gYRa/q1VRUuFdD3mQ1YfKN8n9eQjgJOn73YV5PoO2ivrdbLHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYck4434; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYck4434"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F06CC4CED2;
	Fri, 24 Jan 2025 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737711021;
	bh=ZNu6YTLe1jRQVQcIbdcrSgax4kIomomoZUYkdluRHaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gYck4434HARM0665coIXkMFB1pbhzT+0tJ0dKbjUx1Idd9JDI0FIKBqcNx9tvzK++
	 A0Pmab/QpJ7+ciEzqtQe0LX4d00s4wxo8xuTMiNsQEjrv1XQLCOBMLkG3xMkN17jeM
	 7AtNJlS2PGNP92Zk95GDfS49cnR44sGuTxl+DqedyXeDEJaqkh00fvea7Siuocd1/t
	 vQJVmUPugH0i13mz2/D357djOdbPlbgqptjEN1kt5tJlG9V/LibegFb1AQ36Qul6oa
	 4H63cdiHChD1OEBIYeg5kflYS7Gf2E8DkEuogzjyG9ONqmDmndWfYdcjEhug3B1kK0
	 eIcxqzkTwudbA==
Message-ID: <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
Date: Fri, 24 Jan 2025 18:30:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora>
 <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de> <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z4ETvfwVfzNWtgAo@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 21:34, Ming Lei wrote:
>> It is easy to extend rublk/zoned in this way with io_uring io emulation, :-)
> 
> Here it is:
> 
> https://github.com/ublk-org/rublk/commits/file-backed-zoned/
> 
> Top two commits implement the feature by command line `--path $zdir`:
> 
> 	[rublk]# git diff --stat=80 HEAD^^...
> 	 src/zoned.rs   | 397 +++++++++++++++++++++++++++++++++++++++++++++++----------
> 	 tests/basic.rs |  49 ++++---
> 	 2 files changed, 363 insertions(+), 83 deletions(-)
> 
> It takes 280 new LoC:
> 
>     - support both ram-back and file-back
>     - completely async io_uring IO emulation for zoned read/write IO
>     - include selftest code for running mkfs.btrfs/mount/read & write IO/umount

Hi Ming,

My apologies for the late reply. Conference travel kept me busy.
Thank you for doing this. I gave it a try and measured the performance for some
write workloads (using current Linus tree which includes the block PR for 6.14).
The zloop results shown here are with a slightly tweaked version (not posted)
that changes to using a work item per command instead of having a single work
for all commands.

1 queue:
========
                              +-------------------+-------------------+
                              | ublk (IOPS / BW)  | zloop (IOPS / BW) |
 +----------------------------+-------------------+-------------------+
 | QD=1,    4K rnd wr, 1 job  | 11.7k / 47.8 MB/s | 15.8k / 53.0 MB/s |
 | QD=32,   4K rnd wr, 8 jobs | 63.4k / 260 MB/s  | 101k / 413 MB/s   |
 | QD=32, 128K rnd wr, 1 job  | 5008 / 656 MB/s   | 5993 / 786 MB/s   |
 | QD=32, 128K seq wr, 1 job  | 2636 / 346 MB/s   | 5393 / 707 MB/s   |
 +----------------------------+-------------------+-------------------+

8 queues:
=========
                              +-------------------+-------------------+
                              | ublk (IOPS / BW)  | zloop (IOPS / BW) |
 +----------------------------+-------------------+-------------------+
 | QD=1,    4K rnd wr, 1 job  | 9699 / 39.7 MB/s  | 16.7k / 68.6 MB/s |
 | QD=32,   4K rnd wr, 8 jobs | 58.2k / 238 MB/s  | 108k / 444 MB/s   |
 | QD=32, 128K rnd wr, 1 job  | 4160 / 545 MB/s   | 5715 / 749 MB/s   |
 | QD=32, 128K seq wr, 1 job  | 3274 / 429 MB/s   | 5934 / 778 MB/s   |
 +----------------------------+-------------------+-------------------+

As you can see, zloop is generally much faster. This shows the best results from
several runs as performance variation from one run to another can be significant
(for both ublk and zloop).

But as mentioned before, since this is intended to be a test tool for file
systems, performance is not the primary goal here (though the higher the better
as that shortens test times). Simplicity is. And as Ted also stated, introducing
a ublk and rust dependency in xfstests is far from ideal.


-- 
Damien Le Moal
Western Digital Research

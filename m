Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616470;
	b=RMUy7Pm/qIqXdPOdxC9um+vk5X243dUSzN5hguC0Ar0XTbbbIIxZ6QJplu6Ne3u5BJNP
	 F2/iQnToEd9vIdKBPaMmAuOkrk6KXn8jUqAnifPfxWmUZa4/S1ktb2CrB+JqCJCe/7L23
	 TYERJIVJIGmnfJaVBW8/5W02tBO2fI4jSAKR2V3Jf3SFYJVXUz901QmWbueYOvYkpnEQL
	 27qRj6yXlimS78M4xSgyJQCQPhskZTXEV9YZYwKSg7HPdo5s9e3iJiAh3CASI6F/OPKVj
	 eNZrm9Fdc3X+Dlhlnz0o9yiWnn7HQ3Gcw+2O49GzKZ5Fh5cxz3JoWeC5Ihjf1HGoovg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616470;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9xFDwKa9QE4RkXSn8pB3Ype9/9E+5MMs7HrH2FQlI88=;
	b=AdHzEqQoaqseep+QMtMF2tO5l+8snGygO6hBkjcU6662CH+9NoiPuJS5EuTkyzRrzomY
	 gO3XfqoXPiwHBCOToUB0qWBtHzXEHzY4qV5n2K+Kdm8iJCnC4PrQDvvG2S3FP43eKsD7F
	 6l0qJqHXr7v6ObGEqAImbLt5OG2BNy3jQNhIRyboEPJvlvASSkn8z102vw3GziMQe4CHG
	 lK+1HvkB4QsI/X9rTWBJHEeL1CiAtLCqott+SWDg0CkIj6Sq/W0sxvYE8ZUJtxAmJ0Feg
	 kP9p6cRK8bt4k+nvsXK8psIHwOZDSmPPeojnW3dbo1y7f+9PpwpOnZXGBBmKLWw6U3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoR+o3ND;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F91606A31E;
	Wed, 21 Oct 2026 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoR+o3ND
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629C51F000C1;
	Wed, 21 Oct 2026 21:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616470;
	bh=9xFDwKa9QE4RkXSn8pB3Ype9/9E+5MMs7HrH2FQlI88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IoR+o3NDBCbVzx84h6KUCMBpq9z9MmhjRp+GwGzx1iOzdg041DTSdBwRmG8vwROCR
	 y8+hHxzBHJddtwOQOETh3Pv/ickuZbLpyg2VoCjaroTQJcTJkv8xVBmmhvZ4MJTF5O
	 53Q0I1CAENdcAVZbdxuB+MzJccXA8v938TRmBLXtBs5pjtfmN0JM/WF9GbsGMXpLih
	 Yji9iEOGTpsPPGHJJrIN60SuZ9Ifgm6lq3Lv7KYuwo6/tFHmoB7VB2k0ENa8b9xv9q
	 gjMYrF1RCEyY5ltlVzur4riJCoalnifF3QketRB7dkJZuWsvg8MrPyQRBQqQ67366i
	 BcV4K1YukWElQ==
Date: Wed, 21 Oct 2026 15:01:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 0/5] nvme-fabrics: fix connects with isolated CPUs and
 queue mapping bugs
Message-ID: <atkoFMy-_dmOG5ED@kbusch-mbp>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>

On Wed, Oct 14, 2026 at 09:46:38AM +0200, Daniel Wagner wrote:
> Connecting a fabrics controller fails when all CPUs of a hardware
> context are isolated with isolcpus=domain or an isolated cpuset
> partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
> kworker on isolated CPUs") the CPU mask of such a hardware context is
> empty and blk_mq_alloc_request_hctx() fails the Connect command with
> -EXDEV. Patch 2 lets passthrough requests use the software context of a
> housekeeping CPU instead.
> 
> Patches 3-5 fix the fabrics queue mapping:
> 
>   - Stale io_queues[] entries after a reconnect with fewer queues crash
>     blk_mq_map_swqueue().
>   - A queue type can get more queues than online CPUs, so connecting
>     fails with -EXDEV.
>   - Without queues left for polling, the queue claims poll support and
>     polled I/O ends up on a non-poll queue.
> 
> Patch 1 fixes a regression in nvme-7.4 found while testing: since commit
> 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
> nvme_tcp_init_request takes a mutex before it is initialized, which
> disables lock debugging on the first connect.

It seems the nvme patches (1, 3-5) can be applied independently of the
blk-mq patch, so I staged those in nvme-7.4.

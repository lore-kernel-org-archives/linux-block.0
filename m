Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B84FD78A;
	Wed, 14 Oct 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976089; cv=none; b=Cclh6HZ7ar5Ww8wgM+Anz1u+v9wh/6pm1XDaHi0hZAiwj5RjrPn+U7kM/1lmmc1ABOlGs34qJS24fuJbO83KgRpg5PVmiio6eQmeWnZFyiYzp8XRjgUnG1yZY7bxrgqj0QYsTuhO6r/T9YAeta5j8gSrNk+yN1rWTK/WZyniAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976089; c=relaxed/simple;
	bh=C3cdXxW3oIVvXLN20S2yg2KYv9rJoNH7n1I1pHYWSsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX9BgUe/11E3hCza9GB3GhqJqTpBUXXWGTLt95dGZ1n1KtRdgPXCkUqJqxPHsJrg6KjP8+1TxsHuSQT63oAcI4KP6qXxhdKF1BoYLbYJUXlC5rMqLnsVUF/7sPQA9RHWv/AKPvy9CMYgspCYb0CifaOMV+9M+EkgrwCwN6Arp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nB6LFWfZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pnHayja4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nB6LFWfZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pnHayja4"
Date: Wed, 14 Oct 2026 13:08:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791976085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4HIVicNUEkWaEf5vxreRaAv/P+iiyWT06y2a+BOPck=;
	b=nB6LFWfZvb8nqlWPiOb13UkngmDtaGsp/QS9XPkasOJ8ITVIizl4r3tQZJ0yL0qyi6CeOc
	81bbrJQumGG8Gv/y0Ps+h2CH9Z25ifL1Ynqus4BGX0yvIW7b+8raic/ddxDVZ/zx2vSqlU
	pkRcs8kkShGvMHJd01nYDdTW+pyuD/ZhMUP+1ZiW2nFaDMcOQdYCO6Vx3jDQY8rhtDSGs6
	oQPECjuoGdzWJUlrtXTGb4TxDdI2jDTmJoGjfx6jUT0sd7SIy1RceCuzLrgPFzGPJCYW88
	5EY9tBu3ygBLeAz0ZmHLGW+OX6dW8e8tvJwoLzic8OIcrGi1PrB9O2EcCR9o7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791976085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4HIVicNUEkWaEf5vxreRaAv/P+iiyWT06y2a+BOPck=;
	b=pnHayja4QgBTOO90/DVNLIclCUyCzXLwNHAYkrwFM9XyUDN5y5XkXt1mBdqixkYG1S4tIQ
	rprbRQUHVC+2dYAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/5] nvme-tcp: initialize pf_cache_lock when allocating
 the controller
Message-ID: <20261014110804.VsqI0ZaP@linutronix.de>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>

On 2026-10-14 09:46:39 [+0200], Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
> and startup") the I/O tag set is allocated before the I/O queues.
> blk_mq_alloc_tag_set calls nvme_tcp_init_request for every request,
> which takes pf_cache_lock of the request's queue, but nvme_tcp_alloc_queue
> initializes that mutex only later.  With CONFIG_DEBUG_MUTEXES the first
> connect triggers DEBUG_LOCKS_WARN_ON(lock->magic != lock) in
> __mutex_lock and lock debugging is disabled.
> 
> Initialize pf_cache_lock for all queues when allocating the controller
> and keep it for the lifetime of the controller.
> 
> Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")

I only see 2a8513091d2f0 ("nvme-rdma: parallelize I/O queue allocation
and startup"). That tcp commit is not in next-20261013.

Other than that, it looks reasonable ;)
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Sebastian

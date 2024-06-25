Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E7148307;
	Tue, 25 Jun 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299254; cv=none; b=CgF7xiSX1v6iwpcNwl4VQoaFlx62cjuLEB2zaj4i0WGNPBVBMoijEuZk31wI8RmReVn+nMjwZj/sKW0nCYVNagOtt6xyHnotDanHnoQydZPncyqLH18Iiq7dXGrbdcMg2CcQt2SDUQB8YtNQ31/WUunh0fDf9bUozt+eDOKjbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299254; c=relaxed/simple;
	bh=dGrZjtVSHKU5+GCBAYFSpZpDnRcUS3c9ECKW1gTcYsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/QZGgpTloWgU+N4ExkC9oMynLJ0vEyzd8p43yW65WDZsBrjGDlka7cA1biQRW1dx/CtFtZzX3/bZoGzyTxuUdwDWbWGutBBqYbf9M9rbcDZ6jSYi5wmcTfkgWrC9dfFdfpnoAMXg1o3YTa4wFZZrOaTJz2yfefg12dqoMyICoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipv+GCo/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+H7/aRC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipv+GCo/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+H7/aRC"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719299250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSI7fj3SMbgXLwqwSqXjXKJNJqsQgRCaFKgsC6I5fZU=;
	b=ipv+GCo/a3XKt1bVhJ8qHmQ5iX9Y3xQeAwTl/NVuKmfo3NwwWPQ4ZG+8oJfO6PUR/YrrRV
	qzcPbG2cqMmLO3jzlf3kxT3KrpJ/HSBr8DwOgIHJ0Zgo770WTAClKqwUE8pJyIpRtpqsn8
	+C/RtY6LHcyXj61YjXH+LSSOOy5L0Jf6l7lVR71qp5J06nzqXRsc7BifCtuuC2chCMIfHK
	ccTgrQBT55cPvqX827TetCpeLSAFybY18O4YDXVtuwUBajpQN7AR3PWlzYPZV8FLPAIswh
	6z/3dQxrXIDT1lvoBnoMiLHntKaIo4Gg4iHl5Ud9S94WGbOl3GhdeumZ5Ssxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719299250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSI7fj3SMbgXLwqwSqXjXKJNJqsQgRCaFKgsC6I5fZU=;
	b=T+H7/aRCp62Ttz3TJuYUoPdXWA9RMxgNdzwdKonscOY2UYnMchLq93iXOKqY8hFfo3KAYU
	fYuHJypFsZD1HqDw==
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Frederic Weisbecker <fweisbecker@suse.com>,
 Mel Gorman <mgorman@suse.de>, Sridhar Balaraman
 <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
In-Reply-To: <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
 <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
 <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
Date: Tue, 25 Jun 2024 09:07:30 +0200
Message-ID: <878qyt7b65.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 08:37, Hannes Reinecke wrote:
> On 6/24/24 11:00, Daniel Wagner wrote:
>> On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
>>>> Do you think we should introduce a new type or just use the existing
>>>> managed_irq for this?
>>>
>>> No idea really.  What was the reason for adding a new one?
>> 
>> I've added the new type so that the current behavior of spreading the
>> queues over to the isolated CPUs is still possible. I don't know if this
>> a valid use case or not. I just didn't wanted to kill this feature it
>> without having discussed it before.
>> 
>> But if we agree this doesn't really makes sense with isolcpus, then I
>> think we should use the managed_irq one as nvme-pci is using the managed
>> IRQ API.
>> 
> I'm in favour in expanding/modifying the managed irq case.
> For managed irqs the driver will be running on the housekeeping CPUs 
> only, and has no way of even installing irq handlers for the isolcpus.

Yes, that's preferred, but please double check with the people who
introduced that in the first place.

Thanks,

        tglx

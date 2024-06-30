Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5DE13C699
	for <linux-block@vger.kernel.org>; Sun, 30 Jun 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719755295; cv=none; b=TktIRc+hg7fuEKBQ5RmtlbAcm4B/fKhC81rx58m9E4P39cUhEf4C0yawygX9VQWf5RBjpOlH16ajZbqP0RXGbHr0MD7XpIoQJFnD2/Ts+5nBx4fdxkWmkvXmwtOzkQbC2NX8JisUpJoPLBC3ggFV94vfvV9VUbu3PiMhqsA22CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719755295; c=relaxed/simple;
	bh=k71OjCSh0vMFVHrLDF34+IOm4TtSp9sQdk61Kiji0vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCGH4XP2GGMtleYeBtKACj1jP+T5rYurHpQ8EyEHScpwTngNFHGqFKDjudYqHaYa4/A5aocG5F9Vl2xcJfQKWb9M2gcGsNz+1kXUFYDiFgdYbKgUued9XFbXV/D8/e+o9J/BChkUskQxqeNqGWUajb/d67iLRPqqf4qx2+MQOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+fy5G70; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+fy5G70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719755292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VkDOdMIsniFpm2cKteEk2JCW/+hO2AKxPlRMWh7Erws=;
	b=M+fy5G70ERGPB6u8d2J3twi2kgJHwkGCrx6dzBvbzWAOovJyuMavultm4m6sv+unXNnqCd
	N6u4+d3h3bK08bA4WXC6Xq5HDlKv3qgZMLxBrR1MMSmR9+xj4KB+dBTe07RrE8VeFAbl2h
	9ShuQ0KoFXSyQeVtxkseUmWYX9NdaMk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-R6LD5x_9MgiPhABxNEo1bA-1; Sun,
 30 Jun 2024 09:48:08 -0400
X-MC-Unique: R6LD5x_9MgiPhABxNEo1bA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD627195608B;
	Sun, 30 Jun 2024 13:48:05 +0000 (UTC)
Received: from fedora (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E041519560AA;
	Sun, 30 Jun 2024 13:47:56 +0000 (UTC)
Date: Sun, 30 Jun 2024 21:47:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <ZoFiB3wDIBbFGONn@fedora>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
 <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
 <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
 <878qyt7b65.ffs@tglx>
 <rk2ywo6y3ppki2gfogter2p2p2b556kmawqsuqrif3xcalsc2m@aosprmhypcav>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rk2ywo6y3ppki2gfogter2p2p2b556kmawqsuqrif3xcalsc2m@aosprmhypcav>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jun 25, 2024 at 10:57:42AM +0200, Daniel Wagner wrote:
> On Tue, Jun 25, 2024 at 09:07:30AM GMT, Thomas Gleixner wrote:
> > On Tue, Jun 25 2024 at 08:37, Hannes Reinecke wrote:
> > > On 6/24/24 11:00, Daniel Wagner wrote:
> > >> On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
> > >>>> Do you think we should introduce a new type or just use the existing
> > >>>> managed_irq for this?
> > >>>
> > >>> No idea really.  What was the reason for adding a new one?
> > >> 
> > >> I've added the new type so that the current behavior of spreading the
> > >> queues over to the isolated CPUs is still possible. I don't know if this
> > >> a valid use case or not. I just didn't wanted to kill this feature it
> > >> without having discussed it before.
> > >> 
> > >> But if we agree this doesn't really makes sense with isolcpus, then I
> > >> think we should use the managed_irq one as nvme-pci is using the managed
> > >> IRQ API.
> > >> 
> > > I'm in favour in expanding/modifying the managed irq case.
> > > For managed irqs the driver will be running on the housekeeping CPUs 
> > > only, and has no way of even installing irq handlers for the isolcpus.
> > 
> > Yes, that's preferred, but please double check with the people who
> > introduced that in the first place.
> 
> The relevant code was added by Ming:
> 
> 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed
> interrupts")
> 
>     [...] it can happen that a managed interrupt whose affinity
>     mask contains both isolated and housekeeping CPUs is routed to an isolated
>     CPU. As a consequence IO submitted on a housekeeping CPU causes interrupts
>     on the isolated CPU.
> 
>     Add a new sub-parameter 'managed_irq' for 'isolcpus' and the corresponding
>     logic in the interrupt affinity selection code.
> 
>     The subparameter indicates to the interrupt affinity selection logic that
>     it should try to avoid the above scenario.
>     [...]
> 
> From the commit message I read the original indent is that managed_irq
> should avoid speading queues on isolcated CPUs.
> 
> Ming, do you agree to use the managed_irq mask to limit the queue
> spreading on isolated CPUs? It would make the io_queue option obsolete.

Yes, managed_irq is introduced for not spreading on isolated CPUs, and
it is supposed to work well.

The only problem of managed_irq is just that isolated CPUs are
spread, but they are excluded from irq effective masks.


Thanks,
Ming


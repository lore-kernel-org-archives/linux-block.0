Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E082DF8E
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OfyVzYnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC32C433C7;
	Wed,  6 Dec 2023 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701904367;
	bh=q0AAb5LsQDqYl5vBMK1bSmG4E29bCARdra+SeV0W4Q0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=OfyVzYnc72UgxM0i9NwfjylRMNW9Ocbubs21NdcPhncJI2nB+iSzMiykfFSfL6PIK
	 GW7+nhMSl2Ic54XMLLoBBqtqgICD74gNCnnUbCLKiNP31mir7Uav2qWblO2VlB8Hbm
	 RmenOPVqi4HZF06nJS2fUMlhpWy8kjpbLeSOp/Jo=
Date: Wed, 6 Dec 2023 15:12:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Yi Zhang
 <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>, Chengming Zhou
 <zhouchengming@bytedance.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu
 hotplug lock in group_cpus_evenly
Message-Id: <20231206151246.99bbf0f253b85f053bea9199@linux-foundation.org>
In-Reply-To: <20231120120059.ef0614c2295b2102100cb56e@linux-foundation.org>
References: <20231120083559.285174-1-ming.lei@redhat.com>
	<20231120120059.ef0614c2295b2102100cb56e@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 12:00:59 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 20 Nov 2023 16:35:59 +0800 Ming Lei <ming.lei@redhat.com> wrote:
> 
> > group_cpus_evenly() could be part of storage driver's error handler,
> > such as nvme driver, when may happen during CPU hotplug, in which
> > storage queue has to drain its pending IOs because all CPUs associated
> > with the queue are offline and the queue is becoming inactive. And
> > handling IO needs error handler to provide forward progress.
> > 
> > Then dead lock is caused:
> > 
> > 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> > handler is waiting for inflight IO
> > 
> > 2) error handler is waiting for CPU hotplug lock
> > 
> > 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> > error handling can't provide forward progress.
> > 
> > Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> > in which two stage spreads are taken: 1) the 1st stage is over all present
> > CPUs; 2) the end stage is over all other CPUs.
> > 
> > Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> > remove the CPU hotplug lock by storing it into one local cache. This way
> > doesn't change correctness, because all CPUs are still covered.
> 
> I'm not sure what is the intended merge path for this, but I can do lib/.
> 
> Do you think that a -stable backport is needed?  It sounds that way.
> 
> If so, are we able to identify a suitable Fixes: target?  That would
> predate f7b3ea8cf72f3 ("genirq/affinity: Move group_cpus_evenly() into
> lib/").  

No?  I think this predates 428e211641ed8 ("genirq/affinity: Replace
deprecated CPU-hotplug functions." also.

I'll slap a cc:stable on it and I'll let you and the -stable
maintainers figure it out.


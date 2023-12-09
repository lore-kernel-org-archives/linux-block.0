Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TM/3vw7L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356201705
	for <linux-block@vger.kernel.org>; Fri,  8 Dec 2023 18:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702088867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAI0NuHLd7A7hcfMNmxQThYQE6RIisLpIwIrNRbX2Ig=;
	b=TM/3vw7LdqkS30J0HG/6BPtj73pKZG8EN8PiV9EI8KCOV9YOYD43Db+D3O3T8w3ni+gdez
	RiLSOQo40cnswvtW05O4aDGNEtLuP+TLXoL7UeYd76w4vuJ4r+GlDQhCsgIDbeDK0pTTfb
	3eDlTODEMV5jh+cxPduoKLOyWhQzh5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-uIlvz8xnOAONWZ2y1JLgnw-1; Fri, 08 Dec 2023 21:27:43 -0500
X-MC-Unique: uIlvz8xnOAONWZ2y1JLgnw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1757F805844;
	Sat,  9 Dec 2023 02:27:43 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 773B4492BC6;
	Sat,  9 Dec 2023 02:27:37 +0000 (UTC)
Date: Sat, 9 Dec 2023 10:27:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
Message-ID: <ZXPQlIREBiX46trU@fedora>
References: <20231120083559.285174-1-ming.lei@redhat.com>
 <20231120120059.ef0614c2295b2102100cb56e@linux-foundation.org>
 <20231206151246.99bbf0f253b85f053bea9199@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206151246.99bbf0f253b85f053bea9199@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, Dec 06, 2023 at 03:12:46PM -0800, Andrew Morton wrote:
> On Mon, 20 Nov 2023 12:00:59 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Mon, 20 Nov 2023 16:35:59 +0800 Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > group_cpus_evenly() could be part of storage driver's error handler,
> > > such as nvme driver, when may happen during CPU hotplug, in which
> > > storage queue has to drain its pending IOs because all CPUs associated
> > > with the queue are offline and the queue is becoming inactive. And
> > > handling IO needs error handler to provide forward progress.
> > > 
> > > Then dead lock is caused:
> > > 
> > > 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> > > handler is waiting for inflight IO
> > > 
> > > 2) error handler is waiting for CPU hotplug lock
> > > 
> > > 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> > > error handling can't provide forward progress.
> > > 
> > > Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> > > in which two stage spreads are taken: 1) the 1st stage is over all present
> > > CPUs; 2) the end stage is over all other CPUs.
> > > 
> > > Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> > > remove the CPU hotplug lock by storing it into one local cache. This way
> > > doesn't change correctness, because all CPUs are still covered.
> > 
> > I'm not sure what is the intended merge path for this, but I can do lib/.
> > 
> > Do you think that a -stable backport is needed?  It sounds that way.
> > 
> > If so, are we able to identify a suitable Fixes: target?  That would
> > predate f7b3ea8cf72f3 ("genirq/affinity: Move group_cpus_evenly() into
> > lib/").  
> 
> No?  I think this predates 428e211641ed8 ("genirq/affinity: Replace
> deprecated CPU-hotplug functions." also.
> 
> I'll slap a cc:stable on it and I'll let you and the -stable
> maintainers figure it out.

The issue should be introduced since 3ee0ce2a54df ("genirq/affinity: Use get/put_online_cpus
around cpumask operations") in v4.8, but the logic has been changed a lot, so
may take some effort to backport to longterm stables.

The issue is reported from RH QA test, in which both cpu hotplug and
nvme error recovering are triggered at same time, and easy to duplicate
in QE lab, but may be hard to trigger in production environment.

Thanks, 
Ming


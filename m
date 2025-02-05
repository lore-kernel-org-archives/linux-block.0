Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A17C2EF
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738727021; cv=none; b=A/7n+ffSk4x9diXW0qXVYVwgOk6Sf5WoSf0A518S10PMnud3e/NkDLU9TDdpgC2QxrNmsa0es+GMJsgr/JASd0bAtIJQiz8/nTTfjOa6d1eAqWi/99WuZj2GTSfOFiqcDAFaXqe8TsDb2xg2uOy6TMGwnBJVSgRbzWP6jVsGMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738727021; c=relaxed/simple;
	bh=PZ/aBcioxUtkm3dDR5XmAFgkv828VHHvzAUodIki40w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba/Ahkge/YhuOdAX+HJmAG3Cq+sm3ANAtYwVxQglbX6NOmtGZZB5+gywxev4HCYAVhTNhKB7em9OjuMAJj9Yez95RBrEMr9NrtVyfHTxkjLB6ss3FX3nsRllh4za6+cfQI+LLiSCMADyXK5nD3NagR4mz0OhzKeMs3NIZlOpjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPRrKyQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPRrKyQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738727018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSsWj8LNQdz2tcqWbyO4UyrDW2svsaI8vA5XJVU+fw0=;
	b=jPRrKyQyF68rrMg2/uMKeNqJbzESnU+4cbw4bD9HSvCpVdLPjFqaqssfltC5x1RxFcTNfI
	Y6DUgfY2EKNLoz4hb0dIDTtr6tMuUlG/avPxcaNwwfnmLyOdBGfVDmBDuyLLMUFnfz01fj
	wmZLx0Rus4T2zA47eopb2BBtRaq70EM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-Zk2Ijm4BPmO93ba5qxZxoA-1; Tue,
 04 Feb 2025 22:43:37 -0500
X-MC-Unique: Zk2Ijm4BPmO93ba5qxZxoA-1
X-Mimecast-MFC-AGG-ID: Zk2Ijm4BPmO93ba5qxZxoA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 661A719560B1;
	Wed,  5 Feb 2025 03:43:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94BA418008C8;
	Wed,  5 Feb 2025 03:43:31 +0000 (UTC)
Date: Wed, 5 Feb 2025 11:43:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <Z6LeXsYw_qq4hqoC@fedora>
References: <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de>
 <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora>
 <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
 <Z5OHy76X2F9H6EWP@fedora>
 <cb5d4dad-35a9-400e-9c53-785fba6f5a87@kernel.org>
 <Z5xJh84xZbjcO-nJ@fedora>
 <a63406f1-6a45-4d07-b998-504bd2d6d0d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63406f1-6a45-4d07-b998-504bd2d6d0d7@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Feb 04, 2025 at 12:22:53PM +0900, Damien Le Moal wrote:
> On 1/31/25 12:54, Ming Lei wrote:
> > On Wed, Jan 29, 2025 at 05:10:32PM +0900, Damien Le Moal wrote:
> >> On 1/24/25 21:30, Ming Lei wrote:
> >>>> 1 queue:
> >>>> ========
> >>>>                               +-------------------+-------------------+
> >>>>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
> >>>>  +----------------------------+-------------------+-------------------+
> >>>>  | QD=1,    4K rnd wr, 1 job  | 11.7k / 47.8 MB/s | 15.8k / 53.0 MB/s |
> >>>>  | QD=32,   4K rnd wr, 8 jobs | 63.4k / 260 MB/s  | 101k / 413 MB/s   |
> >>>
> >>> I can't reproduce the above two, actually not observe obvious difference
> >>> between rublk/zoned and zloop in my test VM.
> >>
> >> I am using bare-metal machines for these tests as I do not want any
> >> noise from a VM/hypervisor in the numbers. And I did say that this is with a
> >> tweaked version of zloop that I have not posted yet (I was waiting for rc1 to
> >> repost as a rebase is needed to correct a compilation failure du to the nomerge
> >> tage set flag being removed). I am attaching the patch I used here (it applies
> >> on top of current Linus tree)
> >>
> >>> Maybe rublk works at debug mode, which reduces perf by half usually.
> >>> And you need to add device via 'cargo run -r -- add zoned' for using
> >>> release mode.
> >>
> >> Well, that is not an obvious thing for someone who does not know rust well. The
> >> README file of rublk also does not mention that. So no, I did not run it like
> >> this. I followed the README and call rublk directly. It would be great to
> >> document that.
> > 
> > OK, that is fine, and now you can install rublk/zoned with 'cargo
> > install rublk' directly, which always build & install the binary of
> > release version.
> > 
> >>
> >>> Actually there is just single io_uring_enter() running in each ublk queue
> >>> pthread, perf should be similar with kernel IO handling, and the main extra
> >>> load is from the single syscall kernel/user context switch and IO data copy,
> >>> and data copy effect can be neglected in small io size usually(< 64KB).
> >>>
> >>>>  | QD=32, 128K rnd wr, 1 job  | 5008 / 656 MB/s   | 5993 / 786 MB/s   |
> >>>>  | QD=32, 128K seq wr, 1 job  | 2636 / 346 MB/s   | 5393 / 707 MB/s   |
> >>>
> >>> ublk 128K BS may be a little slower since there is one extra copy.
> >>
> >> Here are newer numbers running rublk as you suggested (using cargo run -r).
> >> The backend storage is on an XFS file system using a PCI gen4 4TB M.2 SSD that
> >> is empty (the FS is empty on start). The emulated zoned disk has a capacity of
> >> 512GB with sequential zones only of 256 MB (that is, there are 2048
> >> zones/files). Each data point is from a 1min run of fio.
> > 
> > Can you share how you create rublk/zoned and zloop and the underlying
> > device info? Especially queue depth and nr_queues(both rublk/zloop &
> > underlying disk) plays a big role.
> 
> rublk:
> 
> cargo run -r -- add zoned --size 524288 --zone-size 256 --conv-zones 0 \
> 		--logical-block-size 4096 --queue ${nrq} --depth 128 \
> 		--path /mnt/zloop/0
> 
> zloop:
> 
> echo "add conv_zones=0,capacity_mb=524288,zone_size_mb=256,\
> base_dir=/mnt/zloop,nr_queues=${nrq},queue_depth=128" > /dev/zloop-control

zone is actually stateful, maybe it is better to use standalone backing
directory/files.

> 
> The backing storage is using XFS on a PCIe Gen4 4TB M.2 SSD (my Xeon machine is
> PCIe Gen3 though). This drive has a large enough max_qid to provide one IO queue
> pair per CPU for up to 32 CPUs (16-cores / 32-threads).

I just setup one XFS over nvme in real hardware, still can't reproduce the big gap in
your test result. Kernel is v6.13 with zloop patch v2.

`8 queues` should only make a difference for the test of "QD=32,   4K rnd wr, 8 jobs".
For other single job test, single queue supposes to be same with 8 queues.

The big gap is mainly in test of 'QD=32, 128K seq wr, 1 job ', maybe your local
change improves zloop's merge? In my test:

	- ublk/zoned : 912 MiB/s
	- zloop(v2) : 960 MiB/s.

BTW, my test is over btrfs, and follows the test script:

 fio --size=32G --time_based --bsrange=128K-128K --runtime=40 --numjobs=1 \
 	--ioengine=libaio --iodepth=32 --directory=./ublk --group_reporting=1 --direct=1 \
	--fsync=0 --name=f1 --stonewall --rw=write

> 
> > I will take your setting on real hardware and re-run the test after I
> > return from the Spring Festival holiday.
> > 
> >>
> >> On a 8-cores Intel Xeon test box, which has PCI gen 3 only, I get:
> >>
> >> Single queue:
> >> =============
> >>                               +-------------------+-------------------+
> >>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
> >>  +----------------------------+-------------------+-------------------+
> >>  | QD=1,    4K rnd wr, 1 job  | 2859 / 11.7 MB/s  | 5535 / 22.7 MB/s  |
> >>  | QD=32,   4K rnd wr, 8 jobs | 24.5k / 100 MB/s  | 24.6k / 101 MB/s  |
> >>  | QD=32, 128K rnd wr, 1 job  | 14.9k / 1954 MB/s | 19.6k / 2571 MB/s |
> >>  | QD=32, 128K seq wr, 1 job  | 1516 / 199 MB/s   | 10.6k / 1385 MB/s |
> >>  +----------------------------+-------------------+-------------------+
> >>
> >> 8 queues:
> >> =========
> >>                               +-------------------+-------------------+
> >>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
> >>  +----------------------------+-------------------+-------------------+
> >>  | QD=1,    4K rnd wr, 1 job  | 5387 / 22.1 MB/s  | 5436 / 22.3 MB/s  |
> >>  | QD=32,   4K rnd wr, 8 jobs | 16.4k / 67.0 MB/s | 26.3k / 108 MB/s  |
> >>  | QD=32, 128K rnd wr, 1 job  | 6101 / 800 MB/s   | 19.8k / 2591 MB/s |
> >>  | QD=32, 128K seq wr, 1 job  | 3987 / 523 MB/s   | 10.6k / 1391 MB/s |
> >>  +----------------------------+-------------------+-------------------+
> >>
> >> I have no idea why ublk is generally slower when setup with 8 I/O queues. The
> >> qd=32 4K random write with 8 jobs is generally faster with ublk than zloop, but
> >> that varies. I tracked that down to CPU utilization which is generally much
> >> better (all CPUs used) with ublk compared to zloop, as zloop is at the mercy of
> >> the workqueue code and how it schedules unbound work items.
> > 
> > Maybe it is related with queue depth? The default ublk queue depth is
> > 128, and 8jobs actually causes 256 in-flight IOs, and default ublk nr_queue
> > is 1.
> 
> See above: both rublk and zloop are setup with the exact same number of queues
> and max qd.
> 
> > Another thing I mentioned is that ublk has one extra IO data copy, which
> > slows IO especially when IO size is > 64K usually.
> 
> Yes. I do keep this in mind when looking at the results.
> 
> [...]
> 
> >>> Simplicity need to be observed from multiple dimensions, 300 vs. 1500 LoC has
> >>> shown something already, IMO.
> >>
> >> Sure. But given the very complicated syntax of rust, a lower LoC for rust
> >> compared to C is very subjective in my opinion.
> >>
> >> I said "simplicity" in the context of the driver use. And rublk is not as
> >> simple to use as zloop as it needs rust/cargo installed which is not an
> >> acceptable dependency for xfstests. Furthermore, it is very annoying to have to
> > 
> > xfstests just need user to pass the zoned block device, so the same test can
> > cover any zoned device.
> 
> Sure. But the environment that allows that still needs to have the rust
> dependency to pull-in and build rublk before using it to run the tests. That is
> more dependencies for a CI system or minimal VMs that are not necessarilly based
> on a full distro but used to run xfstests.

OK, it isn't too hard to solve:

- `install cargo` in the distribution if `cargo` doesn't exist

- run 'cargo install rublk' if rublk isn't installed



Thanks,
Ming


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117F70838
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812292; cv=none; b=MIbDAmGjoiD8sg9xuzgv9mjfnpUFdNci4AwI8YsjFNKkYk18bgQUCHAlt9PVXvOVheZTTWH5TjkSvwIjynBAbMrWZoybm3X7ptRC4WLmmWnYhl4NZqgxtPxKk0+CIS0Ka4foPg0sbHig8d6lZkslTz7wCzgSZtuxcIzOEK/NttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812292; c=relaxed/simple;
	bh=h383WTieKGBXuyD4LGBsdDNiqVZtRmPi096eiHFI4S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWOqv1Mqhh1OQxPWezS/4n9TzeIALpQoHqRrOx3SVQHSMfvmTMV/0ZjBkmzQZeD0NdUrZfkvGIuinpfAswf6W35dQOYpHnIWlhvIEX9SjVsrJ8Dz0BEbZ6IiVYu4CBZURYrmcuxc1xc4r+5ZXVqkVu3jMIR9d/JW7t8h3jQdzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQf3ifiE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQf3ifiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738812288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72Yvsn7/ra1USam5/8ljvS+Hw1RNlRQujL6a4iWdwuc=;
	b=iQf3ifiEn5IxEHHHNIGNArCjYKWKR+Q/KtQ+96JsJgyc8d9JM1HMsKD61eKIPMOyvMM1Am
	xbLl10883CxL+/wBxTM2a+RC8BQ/Dfq6tA2GiL/Tx2s9J+6rHrdfWu2zLn37wZjOQM2jiY
	3ZXMvHunxURkxPBYBNJltF0ydFSUOwM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-SfN4wQcNPMG6JhPtrm1Ckw-1; Wed,
 05 Feb 2025 22:24:44 -0500
X-MC-Unique: SfN4wQcNPMG6JhPtrm1Ckw-1
X-Mimecast-MFC-AGG-ID: SfN4wQcNPMG6JhPtrm1Ckw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C3EA1955DDD;
	Thu,  6 Feb 2025 03:24:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.133])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA7C5195608D;
	Thu,  6 Feb 2025 03:24:38 +0000 (UTC)
Date: Thu, 6 Feb 2025 11:24:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <Z6QrceGGAJl_X_BM@fedora>
References: <20250108090912.GA27786@lst.de>
 <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora>
 <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
 <Z5OHy76X2F9H6EWP@fedora>
 <cb5d4dad-35a9-400e-9c53-785fba6f5a87@kernel.org>
 <Z5xJh84xZbjcO-nJ@fedora>
 <a63406f1-6a45-4d07-b998-504bd2d6d0d7@kernel.org>
 <Z6LeXsYw_qq4hqoC@fedora>
 <f6d82d47-ff27-43e8-a772-0ab90a2f86c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6d82d47-ff27-43e8-a772-0ab90a2f86c4@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Feb 05, 2025 at 03:07:51PM +0900, Damien Le Moal wrote:
> On 2/5/25 12:43 PM, Ming Lei wrote:
> >>> Can you share how you create rublk/zoned and zloop and the underlying
> >>> device info? Especially queue depth and nr_queues(both rublk/zloop &
> >>> underlying disk) plays a big role.
> >>
> >> rublk:
> >>
> >> cargo run -r -- add zoned --size 524288 --zone-size 256 --conv-zones 0 \
> >> 		--logical-block-size 4096 --queue ${nrq} --depth 128 \
> >> 		--path /mnt/zloop/0
> >>
> >> zloop:
> >>
> >> echo "add conv_zones=0,capacity_mb=524288,zone_size_mb=256,\
> >> base_dir=/mnt/zloop,nr_queues=${nrq},queue_depth=128" > /dev/zloop-control
> > 
> > zone is actually stateful, maybe it is better to use standalone backing
> > directory/files.
> 
> I do not understand what you are saying... I reformat the backing FS and
> recreate the same /mnt/zloop/0 directory for every test, to be sure I am not
> seeing an artifact from the FS.

I meant same backfiles are shared for two devices.

But I guess it may not be big deal.

> 
> >> The backing storage is using XFS on a PCIe Gen4 4TB M.2 SSD (my Xeon machine is
> >> PCIe Gen3 though). This drive has a large enough max_qid to provide one IO queue
> >> pair per CPU for up to 32 CPUs (16-cores / 32-threads).
> > 
> > I just setup one XFS over nvme in real hardware, still can't reproduce the big gap in
> > your test result. Kernel is v6.13 with zloop patch v2.
> > 
> > `8 queues` should only make a difference for the test of "QD=32,   4K rnd wr, 8 jobs".
> > For other single job test, single queue supposes to be same with 8 queues.
> > 
> > The big gap is mainly in test of 'QD=32, 128K seq wr, 1 job ', maybe your local
> > change improves zloop's merge? In my test:
> > 
> > 	- ublk/zoned : 912 MiB/s
> > 	- zloop(v2) : 960 MiB/s.
> > 
> > BTW, my test is over btrfs, and follows the test script:
> > 
> >  fio --size=32G --time_based --bsrange=128K-128K --runtime=40 --numjobs=1 \
> >  	--ioengine=libaio --iodepth=32 --directory=./ublk --group_reporting=1 --direct=1 \
> > 	--fsync=0 --name=f1 --stonewall --rw=write
> 
> If you add an FS on top of the emulated zoned deive, you are testing the FS
> perf as much as the backing dev. I focused on the backing dev so I ran fio
> directly on top of the emulated drive. E.g.:
> 
> fio --name=test --filename=${dev} --rw=randwrite \
>                 --ioengine=libaio --iodepth=32 --direct=1 --bs=4096 \
>                 --zonemode=zbd --numjobs=8 --group_reporting --norandommap \
>                 --cpus_allowed=0-7 --cpus_allowed_policy=split \
>                 --runtime=${runtime} --ramp_time=5 --time_based
> 
> (you must use libaio here)

Thanks for sharing the '--zonemode=zbd'.

I can reproduce the perf issue with the above script, and the reason is related
to io-uring emulation and zone space pre-allocation.

When FS WRITE IO needs to allocate space, .write_iter() returns -EAGAIN
for each io-uring write, then the write is always fallback to io-wq, cause
very bad sequential write perf.

It can be fixed[1] simply by pre-allocating space before writing to the
beginning of each seq-zone.

Now follows result in my test over real nvme/XFS:

+ ./zfio /dev/zloop0 write 1 40
    write /dev/zloop0: jobs   1 io_depth   32 time   40sec
	BS   4k: IOPS   171383 BW   685535KiB/s fio_cpu_util(25% 38%)
	BS 128k: IOPS     7669 BW   981846KiB/s fio_cpu_util( 5% 11%)
+ ./zfio /dev/ublkb0 write 1 40
    write /dev/ublkb0: jobs   1 io_depth   32 time   40sec
	BS   4k: IOPS   179861 BW   719448KiB/s fio_cpu_util(29% 42%)
	BS 128k: IOPS     7239 BW   926786KiB/s fio_cpu_util( 6%  9%)

+ ./zfio /dev/zloop0 randwrite 1 40
randwrite /dev/zloop0: jobs   1 io_depth   32 time   40sec
	BS   4k: IOPS     8909 BW    35642KiB/s fio_cpu_util( 2%  5%)
	BS 128k: IOPS      210 BW    27035KiB/s fio_cpu_util( 0%  0%)
+ ./zfio /dev/ublkb0 randwrite 1 40
randwrite /dev/ublkb0: jobs   1 io_depth   32 time   40sec
	BS   4k: IOPS    20500 BW    82001KiB/s fio_cpu_util( 5% 12%)
	BS 128k: IOPS     5622 BW   719792KiB/s fio_cpu_util( 6%  8%)



[1] https://github.com/ublk-org/rublk/commit/fd01a87abb2f9b8e94c8da24e73683e4bb12659b

[2] `z` (zone fio test script) https://github.com/ublk-org/rublk/blob/main/scripts/zfio

Thanks,
Ming


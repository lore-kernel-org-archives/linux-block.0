Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847623754
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297531; cv=none; b=LAisoBR79znwwRFRiUDL+kHldV4zrC4Pihrbzr0l6wq9+65mpEznr8Dkpi96RKQR5dUawjHXwlKMSGnblLV9zjvdB06IAuT3l0uHUCOqQW3tUhhGc5//iGBcPdSvZySeeIcG1LhB1XvWuI7d0I1TKVO5EiSyvKBvmJ7oK2JIA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297531; c=relaxed/simple;
	bh=enyi5kLqoU25LQS2dJwSur4uBTbCSnfjWV6CftFWkDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf8R1JhDzq1n00m0bcautGNguMKnxPsNEB/Xsm2qSNl86HJhrSx5KKJyrhH88KuAK2SaHilF/ls6qcR9TDGjsp62uasv1/H7AppBfIce9gjrI9ZrJo6GPK4SZbfNSt6qMXFQMKmEqn2UmMcFNBnVKNAjiRwDcR6lT417B9e83dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IRKs2zjY; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IRKs2zjY"
Date: Fri, 5 Apr 2024 02:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712297526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNLgUz/+lOOfevg+dkBVhtWYDruDKjanIbvBZcBNA/0=;
	b=IRKs2zjYyJ+KMctnQ/0DhUhMApuNjL3MOVy2oE2cIRgQtQyuG8NLyNivvmfAB6NMHG59CY
	mySU2wZE4wOa4XuwJiuNgMUVdZiASjZtqJp5AynHbabVbPjawmiAQ4FO3HGKVrsGoDcHJs
	Td/GPXPJIlnETLxp8CXjqtVEV0OjDw8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Message-ID: <2zvjinuyaxg22d4az76n3ad7injl7ru46xzh64tuqtx3qrtwzo@zhdq434oypwg>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
 <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 06:15:19PM -0500, Martin K. Petersen wrote:
> 
> Kanchan,
> 
> > - Generic user interface that user-space can use to exchange meta. A
> > new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
> > direct IO.
> 
> Yep. I'm interested in this too. Reviving this effort is near the top of
> my todo list so I'm happy to collaborate.
> 
> > NVMe SSD can do the offload when the host sends the PRACT bit. But in
> > the driver, this is tied to global integrity disablement using
> > CONFIG_BLK_DEV_INTEGRITY.
> 
> > So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
> > that the filesystem can send. The block-integrity and NVMe driver do
> > the rest to make the offload work.
> 
> Whether to have a block device do this is currently controlled by the
> /sys/block/foo/integrity/{read_verify,write_generate} knobs. At least
> for SCSI, protected transfers are always enabled between HBA and target
> if both support it. If no integrity has been attached to an I/O by the
> application/filesystem, the block layer will do so controlled by the
> sysfs knobs above. IOW, if the hardware is capable, protected transfers
> should always be enabled, at least from the block layer down.
> 
> It's possible that things don't work quite that way with NVMe since, at
> least for PCIe, the drive is both initiator and target. And NVMe also
> missed quite a few DIX details in its PI implementation. It's been a
> while since I messed with PI on NVMe, I'll have a look.
> 
> But in any case the intent for the Linux code was for protected
> transfers to be enabled automatically when possible. If the block layer
> protection is explicitly disabled, a filesystem can still trigger
> protected transfers via the bip flags. So that capability should
> definitely be exposed via io_uring.

I've little interest in checksum calculation offload - but protected
transfers are interesting.

bcachefs moves data around in the background (copygc, rebalance), and
whenever we move existing data we're careful to carry around the
existing checksum and revalidate it at every step, and when we have to
compute a new checksum (fragmenting an existing extent) we compute new
checksums and check that they sum up to the old checksum.

It'd be pretty cool to push this down into the storage device (and up
into the page cache as well).

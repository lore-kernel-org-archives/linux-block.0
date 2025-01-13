Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117421C232B;
	Mon, 13 Jan 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759126; cv=none; b=rizRzpKnhno9jm2q/dMQb11SHJruWhBqNNKyhr94xLLlSChoTm+3JcNCsRmUNKLztUPNEnDkWOn5s1fm+Ypjq4a0XCuuTvhflQAcHKBx24W8ETUo8XjFmGtBep3DmOOweHgckrJeb8rjMXjXvXuX9RtOWI0cG+p2cE4a/uubOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759126; c=relaxed/simple;
	bh=IaMJ3tlwj9HZFQWpNE9772SC5tWbzY51Exa37x31d2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hoCOWk98//RCWdcvJPOJWtu3spg36jblPq61N8emDtwcFDex+Gh1ffvkBQiwMsm+hSKGjyjpsML/m40+JUtFxXAKBreep7VqodypFxtBvCqstLcUM9VFHvgn2eS3tjHqU5Nn4AMGByG2f1bJFJZUk5z+Pn0um7T7h9vegJwS6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGfrTxq0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGfrTxq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736759126; x=1768295126;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IaMJ3tlwj9HZFQWpNE9772SC5tWbzY51Exa37x31d2U=;
  b=nGfrTxq0yIEl9JK8FP3UcaPEHcuzM+DJ+RYwXbJwMxgPigxEPC4a+rur
   Pmh0kn1oPwzedXZMGAMZJtmP6Mlh06WtPPAh6GON8h7f7onMQE68eNv0m
   FvtBtdEkrhovtc+SLBru8uOoJuKULnaGZ8MCFdRWCYXMR8sCkxE43hWRC
   Hx0R7kJTLok/SHxZDH9QBpeaXq5fsa2xMrsA36xymMqnfN+UEKRTGmAz2
   MwtETWDGzN9XbAs05UsGnGZQEKgslXVAB/47t1hjpbTZTrS6Pr9ALzLIo
   G3ylgeSNcllHNtDScWRnMitUVp/nZcNmMWK1YjN5saLh947URzcqxbvx5
   w==;
X-CSE-ConnectionGUID: SxHIAR5ySvyZG8g9WGB5IA==
X-CSE-MsgGUID: y4Gyx/3aR+yVWeGOETMzQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37119650"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37119650"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:05:25 -0800
X-CSE-ConnectionGUID: IBvieIYvTzmxA6X4GWxjEQ==
X-CSE-MsgGUID: UwEaS1gqRDynZ6jC4bmULQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105279498"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.246.140]) ([10.245.246.140])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:05:22 -0800
Message-ID: <d35f083853fd3407d03a6f610396f14140a4eec0.camel@linux.intel.com>
Subject: Re: [PATCH V2] block: mark GFP_NOIO around sysfs ->store()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
 stable@vger.kernel.org
Date: Mon, 13 Jan 2025 10:05:19 +0100
In-Reply-To: <Z4TWUCoZV_NVzHMa@fedora>
References: <20250113084103.762630-1-ming.lei@redhat.com>
	 <076ee902633a7293393748cb972cc4a7743ec5c1.camel@linux.intel.com>
	 <Z4TWUCoZV_NVzHMa@fedora>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-13 at 17:01 +0800, Ming Lei wrote:
> On Mon, Jan 13, 2025 at 09:50:37AM +0100, Thomas Hellstr=C3=B6m wrote:
> > Hi!
> >=20
> > On Mon, 2025-01-13 at 16:41 +0800, Ming Lei wrote:
> > > sysfs ->store is called with queue freezed, meantime we have
> > > several
> > > ->store() callbacks(update_nr_requests, wbt, scheduler) to
> > > allocate
> > > memory with GFP_KERNEL which may run into direct reclaim code
> > > path,
> > > then potential deadlock can be caused.
> > >=20
> > > Fix the issue by marking NOIO around sysfs ->store()
> > >=20
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > Reported-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > > Closes:
> > > https://lore.kernel.org/linux-block/ead7c5ce5138912c1f3179d62370b84a6=
4014a38.camel@linux.intel.com/
> > > Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable
> > > IO
> > > schedulers")
> >=20
> > Does this fix also the #2 lockdep splat in that email?
>=20
> No.
>=20
> The #2 splat fix has been merged to for-6.14/block, and this patch
> only
> covers the one reported in the Closes link.

I actually reported two new splats in the Closes link.

(The second was found when using the suggested lockdep priming, but
would ofc emerge sooner or later without it). I'm pretty sure
Christoph's series was applied when that patch emerged, but I can retry
if you want.

Thanks,
Thomas



>=20
> https://lore.kernel.org/linux-block/20250110054726.1499538-1-hch@lst.de/
>=20
>=20
> Thanks,=20
> Ming
>=20


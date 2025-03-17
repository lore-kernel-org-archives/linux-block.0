Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95051A2860;
	Mon, 17 Mar 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236700; cv=none; b=ODtutI4dW5B4mbzmfKPmMhObwBtZVwLcKo4mgd1+Muk0+MdIb/mb/e4hZWjAosFBXR+9SeRi3t+QeCf9iA/rnaA05OE/Zti2+aAq4cE/Hsq7xfij1/njqU97TXOZ+AZWJs+xi2CWbQNQCOclithw7SdwblgAPg0YXCC05WbGbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236700; c=relaxed/simple;
	bh=39OVTY6F/UnTTojg2v2I6px85IZIQ5P7czNQSmDtm4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Abx5MAjbs4yoZi7QpKtj3pY78DF3f9PvBt6bSmjil8NRPp0g5HRyt/1sLlc2f6Jer/ZI8h26z8lFaB2tUbDxhHd03SzCESUNG6Gb33oRVcAvu7upDJ4RNwFBcXhC9geGytc5FR+suMYD/S5cDmWVouIwQcfwcq0wOLW3zfyZRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mThr8JO4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mThr8JO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742236699; x=1773772699;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=39OVTY6F/UnTTojg2v2I6px85IZIQ5P7czNQSmDtm4Q=;
  b=mThr8JO4epncEm8LKTkp4mw5HbL2H0zWr4oSFfRISweKp9x0tYhg9qzj
   iCC8A6qgp+J8xDgYY6Llcb/kWT2gXBTu223pQvw2w+yH1RKf0retcdFsd
   d1envx2+omCEbErInU0ZB8el2PlebZx9S88fqadXPU83hpbRiLkZzOFpK
   8UVNpKOAK3ZDi7hfaE4PBr5evLKUKN3BBysKyr5UU60yjFQhEafLm5lZc
   1v3haZh7uFbr9sqmwCUAWtaF2iir6kU8k6sSZz7xUzsjxLHAk8hiFdCil
   PZQgV944dXbeQJjw4lSLhYhW8aHiXcS75HtM4/e2/StSox8eXfDGyTmi4
   A==;
X-CSE-ConnectionGUID: Dlri5rglRV6nKO0W7pEOuQ==
X-CSE-MsgGUID: qTOwnNlbQqiSYq7f+sAPKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43230773"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43230773"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:38:18 -0700
X-CSE-ConnectionGUID: 2TxeDznFTcGtjANJYrwKjg==
X-CSE-MsgGUID: JE2/MoTxS1G7MFn7ywJRRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122202900"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.97]) ([10.245.246.97])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:38:16 -0700
Message-ID: <e3b4f44ad493da5c39749d1721702b133937b321.camel@linux.intel.com>
Subject: Re: [RFC PATCH] block: Make request_queue lockdep splats show up
 earlier
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Ming Lei
	 <ming.lei@redhat.com>
Date: Mon, 17 Mar 2025 19:38:13 +0100
In-Reply-To: <5b81f4be-427f-4083-8cbe-e201d0f255c5@acm.org>
References: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
	 <f46f0286-8052-4a29-9d89-376bf9b48d8a@acm.org>
	 <13031d34692b0c97799de81c0b83875d56076e13.camel@linux.intel.com>
	 <5b81f4be-427f-4083-8cbe-e201d0f255c5@acm.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-17 at 11:28 -0700, Bart Van Assche wrote:
> On 3/17/25 11:13 AM, Thomas Hellstr=C3=B6m wrote:
> > On Mon, 2025-03-17 at 10:37 -0700, Bart Van Assche wrote:
> > > On 3/17/25 10:11 AM, Thomas Hellstr=C3=B6m wrote:
> > > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > > index d6c4fa3943b5..4aa439309406 100644
> > > > --- a/block/blk-core.c
> > > > +++ b/block/blk-core.c
> > > > @@ -455,6 +455,12 @@ struct request_queue
> > > > *blk_alloc_queue(struct
> > > > queue_limits *lim, int node_id)
> > > > =C2=A0=C2=A0=C2=A0	lockdep_init_map(&q->q_lockdep_map, "&q-
> > > > > q_usage_counter(queue)",
> > > > =C2=A0=C2=A0=C2=A0			 &q->q_lock_cls_key, 0);
> > > > =C2=A0=C2=A0=20
> > > > +	/* Prime io_lockdep_map as reclaim tainted */
> > > > +	fs_reclaim_acquire(GFP_KERNEL);
> > > > +	rwsem_acquire_read(&q->io_lockdep_map, 0, 0,
> > > > _RET_IP_);
> > > > +	rwsem_release(&q->io_lockdep_map, _RET_IP_);
> > > > +	fs_reclaim_release(GFP_KERNEL);
> > > > +
> > > > =C2=A0=C2=A0=C2=A0	q->nr_requests =3D BLKDEV_DEFAULT_RQ;
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0	return q;
> > >=20
> > > Hmm ... my understanding is that it is fine if FS code calls
> > > block
> > > layer
> > > code but also that block layer code never should call FS code.
> >=20
> > That added code only mimics the locking sequence that happens
> > during
> > reclaim with the existing code to register the locking order
> > expected
> > by the reclaim code. If anything violates that, lockdep splat [2]
> > will
> > appear.
> >=20
> > So I'm not quite following your comment?
> Shouldn't the above code be added in the VFS code rather than in the
> block layer?

It registers a known locking order WRT reclaim(GFP_KERNEL) for the q-
>io_lockdep_map, which is itself initialized in this function. I
believe any known locking orders should be registered at the place the
lockdep map is initialized.

Thanks,
Thomas


>=20
> Thanks,
>=20
> Bart.


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B251ABEA5;
	Mon, 17 Mar 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235196; cv=none; b=dQpAnG4GjVJJ1MNNnhF/mdzLaLlLWjS1czjlq0/oOtywJOB0wCZa7FwpDeOPT+e6MNOPm0om/lqPM2SQIPL3DVr23F8FTt++U50ybA2RviJ/p3XPWDVl3cm32rM/wh7conppYF/YpvxE4QJuQgo6Ofq0OVVTQHdoBzqNKmmV2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235196; c=relaxed/simple;
	bh=CdqT/iX+lZWiEgjU/+zBMCqVBmevxH9AyLG2YfvdO4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgi0wdt9n8f61MuFIxZLmBl6xkDniffKf80PB2Ks8C7FcN00AtGh7D8L4JAdM/Ov8WV0evMZ7cfLAX+x1eelvtjb5ph0lYODzmoEHH6n8HHas//qPU5CheOc19VAWmJiUVyds+7XGBRgy6fulj8Z3CJYm7uaHBvqxyAQ2lA4QeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzJ8cktr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzJ8cktr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235195; x=1773771195;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CdqT/iX+lZWiEgjU/+zBMCqVBmevxH9AyLG2YfvdO4A=;
  b=YzJ8cktrhaNOxxSyXFWty/tEp02vk63vO8LWb+zjiSnucjfzFcAFa8oY
   kThsAPZOdWNDoqiCfMzJ6ewTIsjoKnMSjyBr9t8SwIxHUlJ5Y5Nb7IvOS
   rG94dacou9XOAP2b6Rdp16RLWHrLv2XAB7bIIVI9uTwH4KbDPm9PRVWth
   OmYaecFVEg01x1anuGysc6liYRsYXadSXfP4rXfIvwj9Lp0q/wUfaraut
   aBx48AMFEKyqnFQGVYfDS81W/3FboneBrkw1cp2z93ZZ7B9xAg8eE2HrY
   tnBZlOQYhG9oF3ndggtFKg4uhA38s9A5vne3/u9BW+yFYCnfbwbyhajqe
   Q==;
X-CSE-ConnectionGUID: M0AloHhCSZSq6TrdxnIEfw==
X-CSE-MsgGUID: vspzo7mXSP2b5LVbKIWs2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="68703170"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="68703170"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:13:14 -0700
X-CSE-ConnectionGUID: gnujzs2KSgGBpHOHdYR71g==
X-CSE-MsgGUID: a25C9PqpR8G4bqweTg7ycQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122026428"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.97]) ([10.245.246.97])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:13:12 -0700
Message-ID: <13031d34692b0c97799de81c0b83875d56076e13.camel@linux.intel.com>
Subject: Re: [RFC PATCH] block: Make request_queue lockdep splats show up
 earlier
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Ming Lei
	 <ming.lei@redhat.com>
Date: Mon, 17 Mar 2025 19:13:10 +0100
In-Reply-To: <f46f0286-8052-4a29-9d89-376bf9b48d8a@acm.org>
References: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
	 <f46f0286-8052-4a29-9d89-376bf9b48d8a@acm.org>
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

On Mon, 2025-03-17 at 10:37 -0700, Bart Van Assche wrote:
> On 3/17/25 10:11 AM, Thomas Hellstr=C3=B6m wrote:
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index d6c4fa3943b5..4aa439309406 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -455,6 +455,12 @@ struct request_queue *blk_alloc_queue(struct
> > queue_limits *lim, int node_id)
> > =C2=A0=C2=A0	lockdep_init_map(&q->q_lockdep_map, "&q-
> > >q_usage_counter(queue)",
> > =C2=A0=C2=A0			 &q->q_lock_cls_key, 0);
> > =C2=A0=20
> > +	/* Prime io_lockdep_map as reclaim tainted */
> > +	fs_reclaim_acquire(GFP_KERNEL);
> > +	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> > +	rwsem_release(&q->io_lockdep_map, _RET_IP_);
> > +	fs_reclaim_release(GFP_KERNEL);
> > +
> > =C2=A0=C2=A0	q->nr_requests =3D BLKDEV_DEFAULT_RQ;
> > =C2=A0=20
> > =C2=A0=C2=A0	return q;
>=20
> Hmm ... my understanding is that it is fine if FS code calls block
> layer
> code but also that block layer code never should call FS code.
>=20
> Thanks,
>=20
> Bart.

That added code only mimics the locking sequence that happens during
reclaim with the existing code to register the locking order expected
by the reclaim code. If anything violates that, lockdep splat [2] will
appear.

So I'm not quite following your comment?

Thanks,
Thomas



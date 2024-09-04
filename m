Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCB1D0174;
	Wed,  4 Sep 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449848; cv=none; b=qGJ8jGcu+UnmPV45B+fx9SVxfeyk6YqCTojGYHzWebgDgM9pozU5paC1o+94BDmZbzbpH3/WxhEFZXheoP6aj5ApLEMQHefNKFmhDdp3uRB3Ha0JwxMFNrC/dcc1nHl0LoyBtBy+GnteZ2zgORoTBxelfeC0R0ckKWGCsEfbd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449848; c=relaxed/simple;
	bh=lRos+11KAZDw53IL+N4zcF9ywPDf4xoTLHGEzFfBl6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YpeBbJIOuKwpao+caooQN9AvWF7R9PQRvsKkkjLvpxv8EjmCZ7uhlJ9En2HG3W+HmKFiIUPepLeomlVAFyBx/CS7IAhDsx4Q1Nksm46A+1MYHkYJccygfvvt4sUz0SsTsrPTKQkAIqrrgGzECyozb9I/njFpvUPhH19Nx5Nw3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JThyy4wk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JThyy4wk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725449847; x=1756985847;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lRos+11KAZDw53IL+N4zcF9ywPDf4xoTLHGEzFfBl6Y=;
  b=JThyy4wkva2NrJ6tFGDOiCrur64KACva09PdpyoCH3URmWN2S/hj+be9
   JpV0RszNF9T5jgshJhD9+smQe4q2QgiekaPNj9mKNMMRffSUij27c0MrI
   BkBP+v6UjQrHztFiO/31zDZ76pH9DQ0LQxYS9/c26Gkf3guTpzjfrxjae
   A7TSxKgkFp17hO66FSZrN0uk9DVu/q6hIh9AcxkHX3zzrYhtjS3CXSmWi
   bDrHHWuvuj6pCwRp91XEIMpn8mkHXqTspQmo2tkJsKBJyYssOtJ8mgO4l
   RZMuhEHWtK/Rl+HHshZsLPEvaQRUtsBCavUSYQVvWmE4Gr6m79kywe1+2
   A==;
X-CSE-ConnectionGUID: fe4qM0LCR3qn5sCkEZ+86A==
X-CSE-MsgGUID: wyemx6tPQBCOvcT3FdaJOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23665072"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23665072"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:37:26 -0700
X-CSE-ConnectionGUID: MYbUOAjyR8uKUbqk7xmESA==
X-CSE-MsgGUID: zMUdkLqwRCeY08JRXG6DMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="96038929"
Received: from sschumil-mobl2.ger.corp.intel.com ([10.245.246.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:37:24 -0700
Message-ID: <f67b46158be286ebfad2215022d2c903b4156388.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] bdev: add support for CPU latency PM QoS tuning
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 04 Sep 2024 14:37:20 +0300
In-Reply-To: <ZtHWkn2FJhAa+Vvo@fedora>
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
	 <20240829075423.1345042-2-tero.kristo@linux.intel.com>
	 <e5e97bad-075a-4d78-af78-3bbc124c06b1@kernel.dk>
	 <e38630e41353d083f7c0f4d726218aa5f3b36827.camel@linux.intel.com>
	 <ZtHWkn2FJhAa+Vvo@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 22:26 +0800, Ming Lei wrote:
> On Fri, Aug 30, 2024 at 02:55:56PM +0300, Tero Kristo wrote:
> > On Thu, 2024-08-29 at 05:37 -0600, Jens Axboe wrote:
> > > On 8/29/24 1:18 AM, Tero Kristo wrote:
> > > > diff --git a/block/bio.c b/block/bio.c
> > > > index e9e809a63c59..6c46d75345d7 100644
> > > > --- a/block/bio.c
> > > > +++ b/block/bio.c
> > > > @@ -282,6 +282,8 @@ void bio_init(struct bio *bio, struct
> > > > block_device *bdev, struct bio_vec *table,
> > > > =C2=A0	bio->bi_max_vecs =3D max_vecs;
> > > > =C2=A0	bio->bi_io_vec =3D table;
> > > > =C2=A0	bio->bi_pool =3D NULL;
> > > > +
> > > > +	bdev_update_cpu_latency_pm_qos(bio->bi_bdev);
> > > > =C2=A0}
> > > > =C2=A0EXPORT_SYMBOL(bio_init);
> > >=20
> > > This is entirely the wrong place to do this, presumably it should
> > > be
> > > done at IO dispatch time, not when something initializes a bio.
> > >=20
> > > And also feels like entirely the wrong way to go about this,
> > > adding
> > > overhead to potentially each IO dispatch, of which there can be
> > > millions
> > > per second.
> >=20
> > Any thoughts where it could/should be added?
> >=20
> > I moved the bdev_* callback from bio_init to the below location and
> > it
> > seems to work also:
> >=20
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 3b4df8e5ac9e..d97a3a4252de 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2706,6 +2706,7 @@ static void __blk_mq_flush_plug_list(struct
> > request_queue *q,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk_queue_quiesced(q))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdev_update_cpu_latency_pm_qos(q-=
>disk->part0);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->mq_ops->queue_rqs(&plug->=
mq_list);
>=20
> IO submission CPU may not be same with the completion CPU, so this
> approach looks wrong.
>=20
> What you are trying to do is to avoid IO completion CPU to enter
> deep idle in case of inflight block IOs.
>=20
> Only fast device cares this CPU latency, maybe you just need to call
> some generic helper in driver(NVMe), and you may have to figure out
> the exact IO completion CPU for hardware queue with inflight IOs.
>=20
> Thanks,
> Ming
>=20

Thanks for feedback, I've updated my patch to work on the NVMe driver
instead, taking the queue CPU affinity into account. I will send a
separate RFC of that out soonish to the corresponding list.

-Tero


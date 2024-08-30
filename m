Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76614EC41;
	Fri, 30 Aug 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018967; cv=none; b=hwJYw3wd5rEeBTfDo+gf3LA31BHqWCL/5meBVRqpjo3oaP7N1QvAUPVPQWiHBJlsAlNdI6AqBkJJMX4yO0jAGuUQDQ35XqzFU9mNwmBL/1Tcf/4+hn+3OiAeJYZGwfgELBPxuDYztQH66uZS3Nu0twE7puxwamTmeiEd+yb/9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018967; c=relaxed/simple;
	bh=N4EnbV+vH2+NmjnRoAsap91PvDS0Eur6swEdvFRdWpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KH5Own2azTZF0iOQRPZeUiSzQR6loUCwYHJOofiHZ2ZGgrpIMny0rR6BC7QwySeT8BiQ3Z1GECkc89eUez9RyZNrq4GIHRNEnKmdMwXbXZWW67jYiW56V8o//uvK3FCFNtwRPD2znaqxR63D0z/WDzZDJ5dmokFGe1cCDczqBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m53Qcfe5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m53Qcfe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725018962; x=1756554962;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=N4EnbV+vH2+NmjnRoAsap91PvDS0Eur6swEdvFRdWpM=;
  b=m53Qcfe53wyOtK39OsoNrUV/JNKFykFxC8YK0X/jf/GXm88sKK92qus+
   E7D9gDFxEE5ViPkRHUU5cjev2i0W2CaATnZIwOmXZ8kBODvxRAQWf+0CS
   Bd3Eb2s4pIdlltF9Nye6nKOC2VB2/6KFauzVrVNvY1UTuXKNmuxQb9lck
   u1Pmmx+d4RqsJfcynSi7FCPtaQ75Ote0uXuHGanU45nBH7kLa4eFnT+Ac
   B0YucA01mKMOYUNBzYSkvlxwUJWAHLUCb5xMlNRIsbtYBvApbH4CdvqVF
   wErPWzwdRwePIwTyG95xM8jlaLEfMtP6QcuUMHeXTL19w6Z2rhX+7ZbB5
   Q==;
X-CSE-ConnectionGUID: ndQJbe42S2mrLJWhJ5I7eg==
X-CSE-MsgGUID: X+pN3g0aS5qq8qq2QWAsqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34226843"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34226843"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:56:01 -0700
X-CSE-ConnectionGUID: vlZ38EGxRHK0ideqvjH64A==
X-CSE-MsgGUID: l1RMm7HPS/Gem9BmMfDdaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64064486"
Received: from mwiniars-desk2.ger.corp.intel.com ([10.245.246.70])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:55:59 -0700
Message-ID: <e38630e41353d083f7c0f4d726218aa5f3b36827.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] bdev: add support for CPU latency PM QoS tuning
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Aug 2024 14:55:56 +0300
In-Reply-To: <e5e97bad-075a-4d78-af78-3bbc124c06b1@kernel.dk>
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
	 <20240829075423.1345042-2-tero.kristo@linux.intel.com>
	 <e5e97bad-075a-4d78-af78-3bbc124c06b1@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 05:37 -0600, Jens Axboe wrote:
> On 8/29/24 1:18 AM, Tero Kristo wrote:
> > diff --git a/block/bio.c b/block/bio.c
> > index e9e809a63c59..6c46d75345d7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -282,6 +282,8 @@ void bio_init(struct bio *bio, struct
> > block_device *bdev, struct bio_vec *table,
> > =C2=A0	bio->bi_max_vecs =3D max_vecs;
> > =C2=A0	bio->bi_io_vec =3D table;
> > =C2=A0	bio->bi_pool =3D NULL;
> > +
> > +	bdev_update_cpu_latency_pm_qos(bio->bi_bdev);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(bio_init);
>=20
> This is entirely the wrong place to do this, presumably it should be
> done at IO dispatch time, not when something initializes a bio.
>=20
> And also feels like entirely the wrong way to go about this, adding
> overhead to potentially each IO dispatch, of which there can be
> millions
> per second.

Any thoughts where it could/should be added?

I moved the bdev_* callback from bio_init to the below location and it
seems to work also:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b4df8e5ac9e..d97a3a4252de 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2706,6 +2706,7 @@ static void __blk_mq_flush_plug_list(struct
request_queue *q,
 {
        if (blk_queue_quiesced(q))
                return;
+       bdev_update_cpu_latency_pm_qos(q->disk->part0);
        q->mq_ops->queue_rqs(&plug->mq_list);
 }
=20


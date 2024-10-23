Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BE1DFEF;
	Wed, 23 Oct 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689989; cv=none; b=Wr2rlIfuEYqTpJLgqrqtuANG+fNFRykLwBzeklO1eUrIhoBoACIW0+zOizt+uGiuCCqc8Y9cYGHuziyiG+1L5bBZJSkjdlttTlA/G2Uy0JY4y38Mhq0yudAXUvM49EvbjlMl8BJhLpqVx+C0ZTWGjcxMhrdKfyH5XaLxyHQpgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689989; c=relaxed/simple;
	bh=C3erVz82tfNvDb362fEzo83f3STSjhuRqLUdPl8pVjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYSO7YOquVhE+5Rhr1aT33/y2bIsG80ty9AsWdZNnWjdzYd2B83YRT4aLgqzpSepRKcIFEDBulXMTiCESBf5qErwmKi57XW0GO4yO2sOQ8W66GYzezPKgpO2iVk9xmjeC7tnrOMlaAgC/SpqcXmL6JtTM/Rd2FmHlkqn6jabqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MW5gKwLG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MW5gKwLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689988; x=1761225988;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=C3erVz82tfNvDb362fEzo83f3STSjhuRqLUdPl8pVjA=;
  b=MW5gKwLGd3/hVbHDgOr/naUuUIeZaxfuUIT3wBR7nPwP5FuI2XfKKTMW
   HLwUYe5QtWPP+mdTZepL8b/TT6qwYYhFQiFmRlY4Hgd3IYhyUrXlMoo6o
   +I+OgG3Ub1Awjhzm46PMzrrkL38zGvsdyqtNCwBThafqz2u2vhD8qxpgs
   5jIg/dpg9MTtMI0RrYGeDM4DROl6+ZjwMArHfJnXS6P0hkNfHPMrT6Ajo
   nXaoVI911m6nFlmQu3FZv0nxwSsI2LQ3kfEQk2KjQQz9l65XKc9SfGLBP
   gdkP1hxmwSwH/E1wFNp1e141VQW9ECl3wSdKQQMfFAnkY0yLPM1vBnWmt
   g==;
X-CSE-ConnectionGUID: DYpVvpdGRDSqyHL3NSDNiw==
X-CSE-MsgGUID: b5r5qST8QkGqLXQbJQPDSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29379235"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="29379235"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:26:26 -0700
X-CSE-ConnectionGUID: plTvsQr6RXaYNMZDiCfKTA==
X-CSE-MsgGUID: GBzCtDPZRj6v+kkMbkUc5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="110993727"
Received: from lfiedoro-mobl.ger.corp.intel.com ([10.245.246.76])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:26:24 -0700
Message-ID: <fa2bc7e5088fd309d846a57edf06520dc83632ba.camel@linux.intel.com>
Subject: Re: [PATCHv2 2/2] blk-mq: add support for CPU latency limits
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Oct 2024 16:26:21 +0300
In-Reply-To: <cb9d65fe-47b9-4539-a8d0-9863e8ebf49f@kernel.dk>
References: <20241018075416.436916-1-tero.kristo@linux.intel.com>
	 <20241018075416.436916-3-tero.kristo@linux.intel.com>
	 <cb9d65fe-47b9-4539-a8d0-9863e8ebf49f@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-18 at 08:21 -0600, Jens Axboe wrote:
> On 10/18/24 1:30 AM, Tero Kristo wrote:
> > @@ -2700,11 +2701,62 @@ static void blk_mq_plug_issue_direct(struct
> > blk_plug *plug)
> > =C2=A0static void __blk_mq_flush_plug_list(struct request_queue *q,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct blk_plug *plug)
> > =C2=A0{
> > +	struct request *req, *next;
> > +	struct blk_mq_hw_ctx *hctx;
> > +	int cpu;
> > +
> > =C2=A0	if (blk_queue_quiesced(q))
> > =C2=A0		return;
> > +
> > +	rq_list_for_each_safe(&plug->mq_list, req, next) {
> > +		hctx =3D req->mq_hctx;
> > +
> > +		if (next && next->mq_hctx =3D=3D hctx)
> > +			continue;
> > +
> > +		if (q->disk->cpu_lat_limit < 0)
> > +			continue;
> > +
> > +		hctx->last_active =3D jiffies + msecs_to_jiffies(q-
> > >disk->cpu_lat_timeout);
> > +
> > +		if (!hctx->cpu_lat_limit_active) {
> > +			hctx->cpu_lat_limit_active =3D true;
> > +			for_each_cpu(cpu, hctx->cpumask) {
> > +				struct dev_pm_qos_request *qos;
> > +
> > +				qos =3D per_cpu_ptr(hctx-
> > >cpu_lat_qos, cpu);
> > +				dev_pm_qos_add_request(get_cpu_dev
> > ice(cpu), qos,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > DEV_PM_QOS_RESUME_LATENCY,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->disk-
> > >cpu_lat_limit);
> > +			}
> > +			schedule_delayed_work(&hctx-
> > >cpu_latency_work,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msecs_to_jiffies(q-
> > >disk->cpu_lat_timeout));
> > +		}
> > +	}
> > +
>=20
> This is, quite literally, and insane amount of cycles to add to the
> hot
> issue path. You're iterating each request in the list, and then each
> CPU
> in the mask of the hardware context for each request.

Ok, I made some optimizations to the code, sending v3 shortly. In this,
all the PM QoS handling and iteration of lists is moved to the
workqueue, and happens in the background. The initial block requests
(until the workqueue fires) may run with higher latency, but that is
most likely an okay compromise.

PS: Please bear with me, my knowledge of the block layer and/or NVMe is
pretty limited. I am sorry if these patches make you frustrated, that
is not my intention.

-Tero

>=20
> This just won't fly, not at all. Like the previous feedback, please
> figure out a way to make this cheaper. This means don't iterate a
> bunch
> of stuff.
>=20
> Outside of that, lots of styling issues here too, but none of that
> really matters until the base mechanism is at least half way sane.
>=20


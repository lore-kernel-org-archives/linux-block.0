Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311CD1391
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776300531; cv=none; b=pg2NI2ndhrq/gFuF1E6Jxu8RTq59/+uS4piF4PurV9YY4J4ti2g0rJ39khZQxyORoi7L6YqCDFXcarNoobuGNSGcqo+b6Lk1peOWCcuG1KSQUFw6d4SvZFOrwG8lX/bFff7LalLhNuQjyu+GLIW40kbFu9hMlz17XesX0Htm/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776300531; c=relaxed/simple;
	bh=vSZrDHJWdUT3fc0mnfVsASM38Ik77OOrDrcLveHcMs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwlcvpc/uZms8dMhWDmAipeM6xIP+whrGVGnIbBlGZ8TFlS15iZk3QFw3bUKEatV6Lo5xb4awK0ui/J6i5erL5Z23nOjcDPP5nZvT6HhWmzWuSOWjyfCuw2J4E0FCWQOvLwhZ80DX+0LVC75rKXeD1rWHFs40+BGxFQIZkLZdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skoBSyKp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skoBSyKp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so5156329f8f.0
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776300529; x=1776905329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wHjoL5bgW6OaCvqxEnCcQc9CZYqGIAVWFc6AfVy0os=;
        b=skoBSyKpEbnqLE+Ih7apOk1zMZ4dHF7IPwdY0sFTXBWs3tgSCcPjvVzGsLCbhAxlxC
         0V/GNB6TkloHl40/Zvgl8eq9t86vs1ZFEiH60HpJ58uDHSsrn7AJ3BMr2FOtMAd3YLjL
         5T8UB4t+OF7FcwiKKodzRRHqcsSl39X1ZM8WQA+oZhx9z2sCNYtaoukxeIN10JA3XFOk
         OjXRUSeu+4foQxNvzItoFo8bsf1FYgKq70bPajJUS/HjBhh65L0f4wtqwpJkPn/lVcgs
         630kegkVXuYw8KOCgBFzVMaNt+cmb/sM5GcvuebI0TvoogO7E4TlkucwU0eZdTTTZyI4
         ZMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776300529; x=1776905329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wHjoL5bgW6OaCvqxEnCcQc9CZYqGIAVWFc6AfVy0os=;
        b=i5+zJN/AlxYY5homZGywFTDjCuLDYKzPjlzElim22bLBORNGKcpMAl6mSzNRFTY+am
         mgp5AzpHq5ATEgG2wqWcX8YXSq2hHAi19k+m5ZbR6ESVcZ34NUYQ1qMsnmziA1jbhHVS
         Lv8PYkUJGSr9udkQYTjE0qBthhXs/WmK+nl6ylH5LtoRE+niwIKg4lBcImf3bBOuRHE0
         1lWETfFPFQk5nKl7xdSmjBRTVqisuSzA54ptTleQSkutd1U1YUKWzaPGeBI1MvaiQBHA
         XFn/QZ8syY0DEjvxar//S6ownyBbEVVJNTJhZOauVM5BWJ7+q/nMb5ezsifKDRufZSfS
         CgWw==
X-Forwarded-Encrypted: i=1; AFNElJ/1X763JaNZYQlGXQXbYUAj4iflfY0E9KhqXqvfDRTHao0HSPFf+2pb1nEbBrs8PKeFoPbUFgZd6/5w6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GS4jqhvbIXuJspxdeM1w/vz2Z/i2JNmtLiSf+s0pqGqIoWTc
	QWDOBO97nbWKjWdRa1GjbaNfA3kxinRVnJUcxrak6irguCOS29nu/Pxj
X-Gm-Gg: AeBDiesaLhW+4vXGzeZ0z5bYG3SSBPe/pGHVlXKE7nSgMCv1dJYxfAYHxyqQN6N71OO
	y7YffCie16y2nnFe4lwNHAZ+DqdFJVksHWit9jDMmQ60l9y5zdEoXc/xRtL8dQpHH4YdgErxmX1
	xeEqr1jow5F9VhWnDisYY2TQ6WTKzlqyakNsPCYNfPUUs2IBJ71DmOk7KEJvmgZJdFQbHRmZkn0
	l/I+T9SqKHrgPSt40zLAAfNdR9yKA2I9wRnXqCoNAy8myLUpEHOKgjNc1H5FyJG9Le0d2KGxfR1
	PeaRQVb+1tB+ZvV9XM6FS+MOtZxv3k7qJxCwTQuyK9R1qY/mhVaY2AjWwhe5/fZmZy3AZlaO5v3
	Iz3qO9BWGQXUaLLltj3Lmr/u0gNo+Ba6mAxtW3QmgVXRPGET2J9TtF/+ilzkv9+qMph2H3AVb47
	LX+qrnNSyVo+I3Jn+HOAcDHm7ddOv4UqxmjjV3S02tcZsv5JekUnlL
X-Received: by 2002:a05:6000:1a89:b0:43d:7b51:5178 with SMTP id ffacd0b85a97d-43d7b515250mr19740589f8f.5.1776300528339;
        Wed, 15 Apr 2026 17:48:48 -0700 (PDT)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:74aa:4903])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3dfff3sm8344319f8f.26.2026.04.15.17.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:48:47 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:48:26 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <aeAx2g-nJQO2yyS4@fedora>
References: <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora>
 <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
 <ad0Hk48y5JEeMlFk@fedora>
 <fouvg7qn7g4yah7jsvzkdmweesbp4aqmhx37gf3ow5medzvuyk@5n3ddkijosr6>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fouvg7qn7g4yah7jsvzkdmweesbp4aqmhx37gf3ow5medzvuyk@5n3ddkijosr6>

On Wed, Apr 15, 2026 at 10:56:37AM -0400, Aaron Tomlin wrote:
> On Mon, Apr 13, 2026 at 11:11:15PM +0800, Ming Lei wrote:
> > But typical applications aren't supposed to submit IOs from these
> > isolated CPUs, so in reality, it isn't a big deal.
> 
> Hi Ming,
> 
> While that may be true for general-purpose workloads, it is a fundamentally
> incorrect assumption for the highly specialised environments that actually
> rely on strict CPU isolation, such as High-Frequency Trading (HFT).
> 
> The requirement in these strict environments is not that the isolated CPU
> performs zero I/O. Rather, the requirement is that the isolated CPU must be
> shielded from the unpredictable latency of the hardware completion
> interrupt.

Again it is just your opinion, not a bug report, may not be a fact, right?
Which kind of HFT application submits IO from isolated CPU?

However, as I mentioned, I don't object this patchset, but you have to fix all
wrong comment & document & bug found in review first.


Thanks, 
Ming

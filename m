Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFD2D8377
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891995; cv=none; b=DBLwEKHWKNj0dAyZS9tJKpGbzJCsEqqsnBpmksssiCw0gkrRNWYNq3ws8Ic992L1uGmYztwKGKVy6DsTCdGZWKF/vX8jCZWkcQi8ZDftXQeDrI9dbs2TsVi1Js7xOf3U8tuOzlt0I6orPEyEV1F3Mux3X3yoh79S2MgRw4RUeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891995; c=relaxed/simple;
	bh=7lrT8ca/WW4Fm/idiqIKhyx8k+KZaFJexiXo1fc8v4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx7UKXeruOtN3BSFbae7kpUfoV74Hh5fs5/LBxRGb/CnTaf3yu/tUEwH+VTdeCiX8sxEmmHHccJqslvFgPNEfFmNSyHAV4O3fp0l5G18aLmy1VzIF7M+zOFn+CesvdrCqUgYCtXLZ3NC0R4WzwD8PFFFJvPbm24dvGlsCE5pAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XeviEHRC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XeviEHRC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4832701b9b7so35833165e9.2
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 02:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770891992; x=1771496792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lrT8ca/WW4Fm/idiqIKhyx8k+KZaFJexiXo1fc8v4A=;
        b=XeviEHRC0jHKRw4rabMzgU0YH/t55Fsgv7e6WAZ/Dp723wmXcbRzIHabp2iXNCSwPE
         VPLGQ/AWk7uwYdoCwomsRU3IYLaCjW4q1vMFhOA4ifIDBJvka6pN9Q62PKJr2EaQdN3S
         xSHTi42hSU6XsLCvBcVzv2cesb2euWd+ymyMPPtkAFg02cQmDVVVj7YfyYGZlmHJILNt
         +4TskdTs3Bj+qIgydhOw1oehc5Qdr3ZT657E0FbvtrQA4Dok9DLt/0AtSuQKmJpYnAnf
         A36p5zlLYuX6CP154HSRmWrUXw+TU6hwk2hjaNIUKUlitla7nmmSDj/nFCNpyAYEiabU
         xToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891992; x=1771496792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lrT8ca/WW4Fm/idiqIKhyx8k+KZaFJexiXo1fc8v4A=;
        b=RLOnw6Z0W2m7Vrexc4XLSSjxuUI8uC7WECdWZOrwrfo9dWSsoqAnUYMegYcWUUYm7G
         r34BvBi8awPj1rZDhEpTuC3Db5fS1A8q9vA+WyM7xR1kuu+URTlntZObqGwQ8ebMZQzM
         KKJUp3yyTj67koxKAoMqjUO4xfHtsaLlTvVqhxAQ0UN91Jpd5CRhS4DnS3N/JncC/SMI
         Su4l2WcQqpf6uQ+vnRrSxP/UbYzNV8vEuMBzZAkBnG3+06mmxqqEam7iYXndnazkhZq7
         XH0g3AakGcUF50pizp0U97aXQ5O9XUhMAxUVFab9xMBjsMbn2vbuvvkWzqh5FwjheKSi
         GAdg==
X-Forwarded-Encrypted: i=1; AJvYcCWnBmIAFFZoIBNzlm2qR6FXD375wcZJefcQEaAB9TNb/ZJ84e85ZJ4/yLc3qRD7NGAF3tKVMC40Og0eMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqno3yWGVmp/wjaqcVxWUC3iJkeqTooaK7qVJha+0KPqCDllnP
	gN1KokfSSTY9mbQhR+H1rKMlRlP+eq0SLbWBw+vjRCjQInVnoa/G7BYv8jsyYTOL6Z8=
X-Gm-Gg: AZuq6aL2l5eE/qhPMk3yQSwe+wst7xilw5ogjc7aSDWSe1w7TrzRKfCM4hLl7r/YNUT
	A5OpJix4aADwChZOFfNDQ5PGC+xrTJKOAi7Wsvk5uOuLdgIO4AL6fV0ddCj+Q+9Xr2QPD/PP2YW
	AQgqnR2B5i09ACeVUGA3p+1GJXHdGOf9IvuaxbL6bpoOxIG+Hfod+Y//QTYJCosCHAi14WBZ4YE
	pPtc4VeQ4cIajD3kloSvocUOf0Vu4qnW5ZiHulg3QnLHI+QSb0q7Fqry35GXeVdVlIe3yaKstxn
	pKi0PgCSg8+AlXz1Rz+vALTinxrIhvx9PgYzZUUfbdmh8/fRsliXg2lf6nimktPqo7CXIs64UlN
	WB8VhHYT1jA1HLd0euHiHjneqvOmza2yi1nVMikQLjETg+QaFF6lAlI6NVqPq9oxbkkJEiP/7pS
	+lv4eFbtBR+nug+AppevfceBQGEw5ZmicKKWQi+pwWoGA=
X-Received: by 2002:a05:600c:c494:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4836570e54cmr32039815e9.24.1770891992143;
        Thu, 12 Feb 2026 02:26:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4378e72c203sm4467424f8f.2.2026.02.12.02.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:26:31 -0800 (PST)
Date: Thu, 12 Feb 2026 11:26:29 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] blk-cgroup: add CONFIG_BLK_CGROUP_DEBUG_STATS option
Message-ID: <jf2bkbvk3h5j3mqfldu66egbvbeq62mzdenuimpgn7d4tfkrpx@b2s6zzdgmgyh>
References: <20260204-blk_cgroup_debug_stats-v1-1-09c0754b4242@debian.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndpqitjmtn3vcpwo"
Content-Disposition: inline
In-Reply-To: <20260204-blk_cgroup_debug_stats-v1-1-09c0754b4242@debian.org>


--ndpqitjmtn3vcpwo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] blk-cgroup: add CONFIG_BLK_CGROUP_DEBUG_STATS option
MIME-Version: 1.0

Hello Breno.

On Wed, Feb 04, 2026 at 08:15:12AM -0800, Breno Leitao <leitao@debian.org> wrote:
> Add a Kconfig option to enable blkcg_debug_stats by default at compile
> time. When CONFIG_BLK_CGROUP_DEBUG_STATS is enabled, additional debugging
> information is shown in the cgroup io.stat file, including cost.wait,
> cost.indebt, and cost.indelay for iocost, as well as latency statistics
> for iolatency.

This seems to be toggleable quite easily anytime at runtime (not sysctl
but modprobe config), not a boot cmdline where CONFIG_ default could
step in.

This only guards printing of already collected stats (sometimes even
without kernel consumers), not sure if it's that useful.

blk-cgroup isn't modularized since 32e380aedc3de ("blkcg: make
CONFIG_BLK_CGROUP bool") v3.5-rc1~42^2~92 exposing it like a module
parameter is historical artifact.

So I'd dare to propose removing it altogether and print those stats
everytime. Readers of the nested-keys format should survive that.
(I don't even see the param documented.)

And if there were eager readers that'd be affected performance-wise,
more conventional would be to make this only boot cmdline parameter that
could static-branch also the stat collection spots (for some more
benefit). And then would also a CONFIG_urable default make sense.

WDYT?

Michal

--ndpqitjmtn3vcpwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaY2q0BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ag0eAEA11t6G6sXuJd5qgGckJt+
kYrhlMR5UyfYWqtl83O1icQBAIls9699cgxyP41vPeyz0q1GPr+XgPvxnly87RCO
ticG
=bajm
-----END PGP SIGNATURE-----

--ndpqitjmtn3vcpwo--

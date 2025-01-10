Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29820E709
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519811; cv=none; b=Owhj6xA0lSTKJaUicpzPFXtbB5oDWGlrYv1z+Q4//pDVDZ2SZHjydz9KDZhuK7V7rSoRBoMxZmbrY7z2RHu8U9KvE87zT2Hngv0jwk90W0kJGTkfQn+XANnVUSGU513mA/HSzHitCge5bWZPV8A2HfYZfXaWGaR6DcKuU7XAmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519811; c=relaxed/simple;
	bh=fpw543KIkA+/3jAiYw/mMdoi3SBccKBd93jiWgKawGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sf5uUpnWi1lBTwMsnIKWQ4dsoAgbFZY4Juzo+dofBAdy47Z5roOhuDdakfzYbqTtPhlN2YUMitrw0CIHFQMnMlqsoJzoapIHa7VFxxY02uam4WB3zI53ANj8WNOqYgS/xKlhU3XkQ+n72VFPTFgtXZrK+ul0l2hPY5sPVbUizyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+Paorli; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+Paorli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736519810; x=1768055810;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fpw543KIkA+/3jAiYw/mMdoi3SBccKBd93jiWgKawGM=;
  b=R+Paorli+w7ZVrbgOs5PDw0Sdq0GRb3cyo+UxwbrQUREVdBf/PsvN9hr
   JVTzYtP7YRpXUblhqbrowPs+UEfRW79cWUEKJhbJopgtRaj96aYqcCVuy
   tuN3go7+hs7m9ELJPEcrVUcs/Y14PLvVOOd5LBE3tF3lf/UL6GMbJDXqV
   Z0EoTmoPy6NE0ZsKfKLIWFsuQPE66WNKtKB5A+0ObF/VxloiOBIRbY2N7
   sTB3UFBujXv+HbVitO/STCLgnFiOWFxBUYI/dBRgCUxDSwGdBdQ3WeMxB
   hAu/+Fg1O1hUJV7Dapw3QsiXWGlj8Glht2ArEKYsnqKhEUtk7BBWFIQMa
   Q==;
X-CSE-ConnectionGUID: YCLtNTm4TOOzOG+85WN4+A==
X-CSE-MsgGUID: XLQbfCqQSMqfXi38vcFWyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="59292912"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="59292912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 06:36:49 -0800
X-CSE-ConnectionGUID: 8iZKLASkRDKvtUKtpioWAw==
X-CSE-MsgGUID: b06YnnUnRHCpdva5PElvIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108792023"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.246.11]) ([10.245.246.11])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 06:36:48 -0800
Message-ID: <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org
Date: Fri, 10 Jan 2025 15:36:44 +0100
In-Reply-To: <Z4EO6YMM__e6nLNr@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
	 <Z4EO6YMM__e6nLNr@fedora>
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

On Fri, 2025-01-10 at 20:13 +0800, Ming Lei wrote:
> On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellstr=C3=B6m wrote:
> > Ming, Others
> >=20
> > On 6.13-rc6 I'm seeing a couple of lockdep splats which appear
> > introduced by the commit
> >=20
> > f1be1788a32e ("block: model freeze & enter queue as lock for
> > supporting
> > lockdep")
>=20
> The freeze lock connects all kinds of sub-system locks, that is why
> we see lots of warnings after the commit is merged.
>=20
> ...
>=20
> > #1
> > [=C2=A0 399.006581]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > [=C2=A0 399.006756] WARNING: possible circular locking dependency
> > detected
> > [=C2=A0 399.006767] 6.12.0-rc4+ #1 Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0 U=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N
> > [=C2=A0 399.006776] ---------------------------------------------------=
-
> > --
> > [=C2=A0 399.006801] kswapd0/116 is trying to acquire lock:
> > [=C2=A0 399.006810] ffff9a67a1284a28 (&q->q_usage_counter(io)){++++}-
> > {0:0},
> > at: __submit_bio+0xf0/0x1c0
> > [=C2=A0 399.006845]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 but task is already holding lock:
> > [=C2=A0 399.006856] ffffffff8a65bf00 (fs_reclaim){+.+.}-{0:0}, at:
> > balance_pgdat+0xe2/0xa20
> > [=C2=A0 399.006874]=20
>=20
> The above one is solved in for-6.14/block of block tree:
>=20
> 	block: track queue dying state automatically for modeling
> queue freeze lockdep

Hmm. I applied this series:

https://patchwork.kernel.org/project/linux-block/list/?series=3D912824&arch=
ive=3Dboth

on top of -rc6, but it didn't resolve that splat. Am I using the
correct patches?

Perhaps it might be a good idea to reclaim-prime those lockdep maps
taken during reclaim to have the splats happen earlier.

Thanks,
Thomas


>=20
> >=20
> > #2:
> > [=C2=A0=C2=A0 81.960829]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > [=C2=A0=C2=A0 81.961010] WARNING: possible circular locking dependency
> > detected
> > [=C2=A0=C2=A0 81.961048] 6.12.0-rc4+ #3 Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0 U=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>=20
> ...
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #3 (&q->limits_lock){+.+.}-{4:4}:
> > [=C2=A0=C2=A0 81.967815]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mu=
tex_lock+0xad/0xb80
> > [=C2=A0=C2=A0 81.968133]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme=
_update_ns_info_block+0x128/0x870
> > [nvme_core]
> > [=C2=A0=C2=A0 81.968456]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme=
_update_ns_info+0x41/0x220 [nvme_core]
> > [=C2=A0=C2=A0 81.968774]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme=
_alloc_ns+0x8a6/0xb50 [nvme_core]
> > [=C2=A0=C2=A0 81.969090]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme=
_scan_ns+0x251/0x330 [nvme_core]
> > [=C2=A0=C2=A0 81.969401]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asyn=
c_run_entry_fn+0x31/0x130
> > [=C2=A0=C2=A0 81.969703]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc=
ess_one_work+0x21a/0x590
> > [=C2=A0=C2=A0 81.970004]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 work=
er_thread+0x1c3/0x3b0
> > [=C2=A0=C2=A0 81.970302]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kthr=
ead+0xd2/0x100
> > [=C2=A0=C2=A0 81.970603]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_=
from_fork+0x31/0x50
> > [=C2=A0=C2=A0 81.970901]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_=
from_fork_asm+0x1a/0x30
> > [=C2=A0=C2=A0 81.971195]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
>=20
> The above dependency is killed by Christoph's patch.
>=20
>=20
> Thanks,
> Ming
>=20


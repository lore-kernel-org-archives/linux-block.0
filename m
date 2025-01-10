Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE881CDFD4
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504521; cv=none; b=r82OMKgY6sP01O41QJG53DrvHvSQsXpyfWvkM3yPHeF8PjpnsD8AIIn5HmKZPJtynOgr+9lUAWHsYnGUijm/nmOFrf3C+EOUs+p87toEXPL6YAWEe33LwTOI++LTgsZYl99AVRQU5rBSI5OYomKkNsGT6gUJz41KS1zGeaoiPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504521; c=relaxed/simple;
	bh=Xw5sE9LLXtKWN411x3yPdvmMfBqAYqtcLVIKJcotmsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inhn+Ubnk77kl9b5f82OpKh1z4OmTtAsTW+26/GioC8WpAkz3ESHc0oFKKg7Y+0kn56nogjw40BmLxY/jqpTDhM2gxo0X1NyIZFkTq5maeSXVdU1/bJehQJtOujDQu+4ORmLb+r7t/BSblC2s9oTIpEs0GwkqlREMJI0JjpgsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hy53rNWm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hy53rNWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736504520; x=1768040520;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Xw5sE9LLXtKWN411x3yPdvmMfBqAYqtcLVIKJcotmsc=;
  b=Hy53rNWmkuBQbW37fCkqZ3OjhU4PM0F5sHkVFpKPYZPGA+njRS8T2RvY
   xvpLvJpYCuIRBdnwNIFV1JK5IaPaiQ1zC3N6eAn1jdNssnS7+LYCs0sVK
   ReBJrRvo+klcGBRwFF+la0nHIq21glJ1QXpViPZZblV3nMp7bU/1uUIuW
   vR0Zu3ubE3Ydvp9pkLDU7E2pwrLgjkpJkXm8St5EdqzAmLdD0r6eAu3r1
   JC/D6oYN+TcCzEQdmgeW+PC1UvT49C+4oGQ+lqTd7zYy2DGbuNrfo+0PX
   6+ErBnNdTSngLEWiguhVPTaNtDpvpfJybPtWkj19EZqaLKQpetKyjR660
   w==;
X-CSE-ConnectionGUID: M5yM1+Z1RxqRxYrvhx6Zlg==
X-CSE-MsgGUID: BqAz69kXTYySWpGa/Y8MtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47788053"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="47788053"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 02:21:59 -0800
X-CSE-ConnectionGUID: JSf5KfjmQEKy2zzOvRlSfA==
X-CSE-MsgGUID: nff6YFpqS9WvJXI4nS3iFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="134535438"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.246.11]) ([10.245.246.11])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 02:21:57 -0800
Message-ID: <b925a97006cf7c7239efa237377ad0fa87cbc0f3.camel@linux.intel.com>
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Date: Fri, 10 Jan 2025 11:21:53 +0100
In-Reply-To: <20250110101451.GA12633@lst.de>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
	 <20250110101451.GA12633@lst.de>
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

On Fri, 2025-01-10 at 11:14 +0100, Christoph Hellwig wrote:
> On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellstr=C3=B6m wrote:
> > Ming, Others
> >=20
> > On 6.13-rc6 I'm seeing a couple of lockdep splats which appear
> > introduced by the commit
> >=20
> > f1be1788a32e ("block: model freeze & enter queue as lock for
> > supporting
> > lockdep")
> >=20
> > The first one happens when swap-outs start to a scsi disc,
> > Simple reproducer is to start a couple of parallel "gitk" on the
> > kernel
> > repo and watch them exhaust available memory.
> >=20
> > the second is easily triggered by entering a debugfs trace
> > directory,
> > apparently triggering automount:
> > cd /sys/kernel/debug/tracing/events
> >=20
> > Are you aware of these?
>=20
> Yes, this series fixes it:
>=20
> https://lore.kernel.org/linux-block/20250110054726.1499538-1-hch@lst.de/
>=20
> should be ready now that the nitpicking has settled down.
>=20

Great. Thanks.
/Thomas


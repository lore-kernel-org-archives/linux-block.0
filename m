Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00B233D69;
	Mon, 13 Jan 2025 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758243; cv=none; b=YStXAQbbUB7wCj7u0j2bY1XcvxGC9RIfVQLlNm5wUOlbu5w5v1+zZMWP3wiuer7cZyyFu1LWDTy4bYsjCDQ+fgp6pBQyIy+fEVPLYamRd2d4EHhANKVhfBrfCoy7mKkN/MtTHGCphtmlaWlE2Y6jS2VZQaocZs2mILV00XlOZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758243; c=relaxed/simple;
	bh=lOjzCZuVFUYZ2DYqrDEDjrLLFambwKITGEe5jq15s9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mP2Xo5MCCLytnud2ulUuYfP9pifkYmbEGt8xBUQWqOlpUPgC9PJlwlbftizoQxmWN5QtDO+SSf02hhxpjxdPU8A+u4uzhbJuw+qxGQ05d3PBpDlbXfjUoM6eKY+iqFOhfwYmP9rmDC2KAr1kXab2pUaN0/rBip2qqTYgux15uQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6bbD9R5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6bbD9R5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736758242; x=1768294242;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lOjzCZuVFUYZ2DYqrDEDjrLLFambwKITGEe5jq15s9E=;
  b=e6bbD9R5nTNgOeK8AwCrvykcY9KQekjKNkMnLSzef4Ahv1gH4U58As5O
   k/E7/UStSZRttbbDkkQ4lGR45p5e3rcrkPR9SZodBAQf3OjpSLGNQHUHO
   ge/uDwtFG6OuLwn6BuJOSPYoryrZlagEEe07DT1YsvNXHFH7JDJQyxfrt
   pGwZrTe4qmgT/eU0GK4+wGZ6E2bK7WYQjGGER+21skD07kMNtHaJwsmRg
   OwLWCfRtzTqQzzWX1NvdGD0A9B1if4hzNrHP7Qt1XHtaDY28QU+aTwHfR
   MET/RkudkHpU7GkigvwiMKwUeEYjStPw7veWFdft2lcZsKXjnrpt/+9aY
   g==;
X-CSE-ConnectionGUID: x3dyqeNISxqx45CKj0ejug==
X-CSE-MsgGUID: dtlp1L26Rg2qc1QidqFSnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="47669334"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47669334"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:50:41 -0800
X-CSE-ConnectionGUID: 0EFW0wjFRQ+IPlzWOiUAbA==
X-CSE-MsgGUID: dVGIK+RyQDK9QSv3/x0Hig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104222763"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.246.140]) ([10.245.246.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:50:39 -0800
Message-ID: <076ee902633a7293393748cb972cc4a7743ec5c1.camel@linux.intel.com>
Subject: Re: [PATCH V2] block: mark GFP_NOIO around sysfs ->store()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>, 
	stable@vger.kernel.org
Date: Mon, 13 Jan 2025 09:50:37 +0100
In-Reply-To: <20250113084103.762630-1-ming.lei@redhat.com>
References: <20250113084103.762630-1-ming.lei@redhat.com>
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

Hi!

On Mon, 2025-01-13 at 16:41 +0800, Ming Lei wrote:
> sysfs ->store is called with queue freezed, meantime we have several
> ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> memory with GFP_KERNEL which may run into direct reclaim code path,
> then potential deadlock can be caused.
>=20
> Fix the issue by marking NOIO around sysfs ->store()
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reported-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Closes:
> https://lore.kernel.org/linux-block/ead7c5ce5138912c1f3179d62370b84a64014=
a38.camel@linux.intel.com/
> Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO
> schedulers")

Does this fix also the #2 lockdep splat in that email?
Thanks,

Thomas



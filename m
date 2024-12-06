Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3421771C
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502239; cv=none; b=ahp5CGz/1FsD+JsUPzISG49myAj8fBnxIUsGoTPsIa4bZILQdEluMwId7n3unbMDUrI1RWcmjR91jEpvrkvAAliPNFwMQgvL0ATnAvsTSwnYalXt4bT2qkeVQAilo6oAYwlRfbiCqB8f17FR2JEFiRXaiNpRCyXfbzRu9U04GYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502239; c=relaxed/simple;
	bh=ByL5KlPEIfnKLV7rIZoXO+Eszw7LwEsbAk+KON6Y53w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdhoj0Lc30b33kIOj27/Aze3GXJ+LKJlsfVu6VCVLdHuY54BohXG/0xcba03ykao8okneCT3lVJmnbv7pjVsmfUesGFrsyFWiwRtyVyGEKcJvHGo5506PPvyH223BqapTXDTlyzzCJK8YLwzd4B7zeNd+UiT5rzJOxbXth0VJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nd8+svdH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd8+svdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733502238; x=1765038238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ByL5KlPEIfnKLV7rIZoXO+Eszw7LwEsbAk+KON6Y53w=;
  b=Nd8+svdH5rogcGokRYLsKveIyYq8fVg7k+0ARN0KpEVCegjiootU9ibS
   sZzVo+ugrcH6ZslpP5YiCQlYeFfppoFaGnI0uVUE5n4mYVXqbljVnR7mi
   GonT9Qeuvvo1sAWr1rzZz58Ug0Aet+JcyV7EKwPUrygumj46pGYryWFfe
   IFRaUH+Xrv194JGaL5EmNjvyNfr6Ru1z/sKrseHmaGKiIetm4vikQAeCq
   Z+qE+41AcYVtCZW4AF5yhIH/zflbPpAdA9gAjTsrC6m83ZAuRtPnZTU8G
   0Mz4NgQCMQMB4bG6PxAAKKhS/8HGzrc6ubSjiReE5KNtPn6igGoi6+U4/
   A==;
X-CSE-ConnectionGUID: 8+fz8u6KQUSjq8j/q32sxA==
X-CSE-MsgGUID: 9qUjXpE/TaGVbSZtwJj4cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33595824"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="33595824"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:23:57 -0800
X-CSE-ConnectionGUID: JBAj6KXpTlGzY9P28N8BSQ==
X-CSE-MsgGUID: yvFiyj6OSf2C8yHgshxyKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94642678"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:23:56 -0800
Date: Fri, 6 Dec 2024 08:23:54 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] blk-mq: fix lockdep warning between
 sysfs_lock and cpu hotplug lock
Message-ID: <Z1MlGjnT6PrfHmnT@agluck-desk3>
References: <20241206111611.978870-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206111611.978870-1-ming.lei@redhat.com>

On Fri, Dec 06, 2024 at 07:16:05PM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st patch is one prep patch.
> 
> The 2nd one fixes lockdep warning triggered by dependency between
> q->sysfs_lock and cpuhotplug_lock.
> 
> 
> Ming Lei (2):
>   blk-mq: register cpuhp callback after hctx is added to xarray table
>   blk-mq: move cpuhp callback registering out of q->sysfs_lock
> 
>  block/blk-mq.c | 108 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 14 deletions(-)

Ming,

Thanks for the patches. They work for me.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E019992C;
	Fri, 30 Aug 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019318; cv=none; b=M41vA3rfMdjJKhfyHK1ofPo1x0ovePYw7/K1qCqxmn3B4tIdH1XPkwQEsMhSj60BdicBD/ngktoGVDONUqIRbc1RAvwQCLLCqBpM2newW6mmjyb6yNM1+cyPtqYIVsDzOR5CKNAnb0iD2+gWwTxiXT47d4CYeP1v+CPJ3WzH9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019318; c=relaxed/simple;
	bh=E72GKG427WbHUAlEX1PF2kGDsmhjOHh7crmqXQZrAQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxP/8PFBZcOWnvs/7b7bWlqHssLSwsQlZCpql9pt8Wn6Jbf3c0+VlORffBlc4LqEffjuEBPrPmyGsjqU7YTE242usEKcYF0Mw7MIx3v67BXjY8+F8LM2yWApWnIRnXXyn4xi4JctP1TkPsocg5dZLGb3s/wQ11HqiI+3uE+XoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRnkBZ9k; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRnkBZ9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725019317; x=1756555317;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=E72GKG427WbHUAlEX1PF2kGDsmhjOHh7crmqXQZrAQI=;
  b=kRnkBZ9kjjZk0VMWn94ce9Q7NWOkBsHjc+LsHaG9Z4daqp57WfMKql1V
   VUIM4XRI/FtCXVMTX7llfoD5CfTIFyLhunBw7nDQor89HarU/Eu6ha5Wx
   HTaPyFcu5/LlkWv+Vdr8O20QdvxAavBwuuWMIXkAkJx+y98eatTFaqcDl
   rSwDWwUN5Gv4nhvZ30NvZD+N00SMUqFzEV2eyZ4K4ozpfOPVzhh5O9H5W
   pEtYKWDJITXVBi5+5RfsePdAc7667SPkAglcbGyrlz2tLfunziOYNuvHy
   4dmy5PQx/pUsWB5ceEMr/ojfpf3BhRpI/Qx2Fb80UkFp/kw+U9d8lCqtj
   w==;
X-CSE-ConnectionGUID: pEdOqsuuSmispRvt9gS4OA==
X-CSE-MsgGUID: mFa7Rd6fSfS1FLPCmZbyCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="41138222"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="41138222"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 05:01:56 -0700
X-CSE-ConnectionGUID: xKVIgp6SQFqtUiQBWwsmAg==
X-CSE-MsgGUID: mrR2uUrYTS2iA9T6gertpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64628677"
Received: from mwiniars-desk2.ger.corp.intel.com ([10.245.246.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 05:01:55 -0700
Message-ID: <f4cdcb6e6cbef86629b2924bd630ef9e0ad0f673.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] block: CPU latency PM QoS tuning
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Aug 2024 15:01:51 +0300
In-Reply-To: <517e19eb-010c-4509-bec3-c3f8316f2c0f@acm.org>
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
	 <517e19eb-010c-4509-bec3-c3f8316f2c0f@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 07:04 -0400, Bart Van Assche wrote:
> On 8/29/24 3:18 AM, Tero Kristo wrote:
> > Any thoughts about the patches and the approach taken?
>=20
> The optimal value for the PM QoS latency depends on the request size
> and on the storage device characteristics. I think it would be better
> if the latency value would be chosen automatically rather than
> introducing yet another set of tunable sysfs parameters.

Are these device parameters stored somewhere in the kernel? I did try
looking for this kind of data but could not find anything useful; thats
the main reason I implemented the sysfs tunables.

-Tero

>=20
> Thanks,
>=20
> Bart.
>=20


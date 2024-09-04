Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3718890D;
	Wed,  4 Sep 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449747; cv=none; b=b1/0Mlh4t1CkGBhd0k1/mkQTX78r3HtJpCiJYU/4R39AI3mZQZXANlhAaIY32XjMVE12NcIY/qqRfGYQ27YyRnQqkdvOCwd/ayfTLZ7kNjp1T8T96enDbZMOb3fRagByUk+49sX64c5NG1/kAeElSU2vJe53Cw+yKRSc4f3LwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449747; c=relaxed/simple;
	bh=j/YkXGtNjnjKPaO5mhaU9i4Ba/SEM7wp20VLAWCRQoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aQoepTkEApnrYbE39pwLmE2kEG+7CJIJqwUY4iefZ02MsJMl/N1vzDX0AZ2i1LA5AO3nxs/eJfKvEokqlbGl1XbKqunXjc4zGYoVh/HOs9AOhb4fknuVGGsNVZX3d7nOKhwW+sDQ2PAJE1oeymBIpc84FjOh9tqihqw5PmtXb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuLpYmrH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuLpYmrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725449746; x=1756985746;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=j/YkXGtNjnjKPaO5mhaU9i4Ba/SEM7wp20VLAWCRQoE=;
  b=WuLpYmrHq6zKgu7UZGw9XF13C1KmDc3QKDeor9oRHNdLl9AuTfJUsWTT
   RFqbuR0loYEl1dJfMid4MByM8zUM3WIpVEyhIMVkPWPr0wzL8DnBp7pea
   4f8mAQJGtyEnrI9AoOMZenQLS8df+jaNl2GsnLONIfHQdSreBBJRTAjJR
   Z40ROk4XCMNfc0d/3mZ2CtJJa43yOZuGmNfSuR92Lax3WOLHhvUoe2w74
   sw+qbd3nq6hbbRGaTNJTPkPzigzdbeAgd+DDGHF+sf2ixj2Vg1S2Q1kvO
   uYoCDmQ+zwdFt/wZTKDq6mjDnC61auFY7izwXzo0eqa0fcbI3YWINN23g
   w==;
X-CSE-ConnectionGUID: Awu2b5QJTtu0YCv0cYREVw==
X-CSE-MsgGUID: BwL7d7XMQl+jsjS/ZXAFbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24212754"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24212754"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:35:45 -0700
X-CSE-ConnectionGUID: dZRWIQrQS62iOjiL6DJ9+A==
X-CSE-MsgGUID: zQzq+hsNQmqP1n+5/X1SFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69407571"
Received: from sschumil-mobl2.ger.corp.intel.com ([10.245.246.254])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:35:43 -0700
Message-ID: <b675fa9573c3a2b0f51054a692975b69f8f8bd5e.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] block: CPU latency PM QoS tuning
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Sep 2024 14:35:40 +0300
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
>=20
> Thanks,
>=20
> Bart.
>=20

Hi all,

Based on the feedback received, I've updated my patch to work on the
NVMe driver level instead of block layer. I'll send that to the
corresponding list as a separate RFC, but for now these two patches can
be ignored.

-Tero

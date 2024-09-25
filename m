Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF1157472;
	Wed, 25 Sep 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249883; cv=none; b=c4sXmLUR3/w2zB+Az6pvGUloPiyuATu1bFEJWSORyHz7vti22opUL9KN6/SPBlnepW0K/tL19/pf9dynY7kClOwNHfqOSkLw1WhY/5WqKQhE1FdH28RwPeqVt/M/fwiVepAOmu5zHRLo0yHnHWwmkFZtFiYUNqCpbAFXgax2fX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249883; c=relaxed/simple;
	bh=FsOhK/LiJhTIlz6gkBzMHtsb7SO4o21EIbdA7S2Uuy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+N9YOZcguFynE1renBk5IP/F1ozPNURU6P04AI9fR7zVBGwMXm7O6d5WD1LLdVkPdNNiv4aQWgt7fTI5jLypLMpqzWrZRpcLrYFBg7NyCRAEpmb1Mj93P5olnaliUMG4DJ7tQOs8jtPz9VdzjO3SIDWTe3s+xI3M22FMLpVI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxNR5KQH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxNR5KQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727249882; x=1758785882;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FsOhK/LiJhTIlz6gkBzMHtsb7SO4o21EIbdA7S2Uuy0=;
  b=ZxNR5KQHbi2fJKF900r5UBghSwhOyvSAmxZ1UzxaG7vI8VxU0Vsbpxz4
   ts54oxFnkZlS22rC90MlhQkOqaH3zh02buZX33/fkAllV2kP7noftbEun
   XTl0YJyaNbKoz+/15e6k92dB3F49a9IUXHvG4kys/VlYqWJ5h2aq/9AZB
   BII71r4HgeBdAiZfvEAzhnRe0tFy317gsEOFNDKBBdYzJqIw4ZyV16R4v
   /CMUqSNruCXFrIw/IaNOqpQlufCZOQ3TvvQKDaR0JfEhUntFE4z1Q37tl
   zytsToye3AMWxVRjP2B1KVENLzaH1s34kFWL/qM4n8SQ0K4I+UxN+KBxi
   w==;
X-CSE-ConnectionGUID: 5WOLng8bQkiSyo4ApJVzdw==
X-CSE-MsgGUID: 2GJ/2cI5TsaYRaNlVMJX4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="30170172"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="30170172"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:38:01 -0700
X-CSE-ConnectionGUID: u5wksEuyQeqKIJnd7TdxPw==
X-CSE-MsgGUID: soM3O1iYRzmfD+y6VzmREw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="95009705"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:37:55 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  "David Hildenbrand" <david@redhat.com>,  Chris Li
 <chrisl@kernel.org>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,  Al
 Viro <viro@zeniv.linux.org.uk>,  "Dan Schatzberg"
 <schatzberg.dan@gmail.com>,  Kairui Song <kasong@tencent.com>,  Barry Song
 <baohua@kernel.org>,  Jens Axboe <axboe@kernel.dk>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <linux-arm-kernel@lists.infradead.org>,
  <linux-mediatek@lists.infradead.org>,  <linux-block@vger.kernel.org>,
  Casper Li <casper.li@mediatek.com>,  "Chinwen Chang"
 <chinwen.chang@mediatek.com>,  Andrew Yang <andrew.yang@mediatek.com>,
  John Hsu <john.hsu@mediatek.com>,  <wsd_upstream@mediatek.com>
Subject: Re: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and
 SWP_READ_SYNCHRONOUS_IO
In-Reply-To: <20240919112952.981-1-qun-wei.lin@mediatek.com> (Qun-Wei Lin's
	message of "Thu, 19 Sep 2024 19:29:50 +0800")
References: <20240919112952.981-1-qun-wei.lin@mediatek.com>
Date: Wed, 25 Sep 2024 15:34:22 +0800
Message-ID: <87frporxtt.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Qun-Wei Lin <qun-wei.lin@mediatek.com> writes:

> This patchset introduces 2 new feature flags, BLK_FEAT_READ_SYNCHRONOUS and
> SWP_READ_SYNCHRONOUS_IO.
>
> These changes are motivated by the need to better accommodate certain swap
> devices that support synchronous read operations but asynchronous write
> operations.
>
> The existing BLK_FEAT_SYNCHRONOUS and SWP_SYNCHRONOUS_IO flags are not
> sufficient for these devices, as they enforce synchronous behavior for both
> read and write operations.

Which kind of device needs this?  Read fast, but write slow?

--
Best Regards,
Huang, Ying

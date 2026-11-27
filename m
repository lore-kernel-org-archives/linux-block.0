Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813794;
	b=hRJNRy/esW2RjioQnRkCbRi6e6PDoKD8E+X+AcGvzi5U0Ovat7OkNJOQzRKDMGnJq1wO
	 Ig3QIqdnNmSR/DP0H6zk8PugxqCkl4Am+9cgtO2sDIfidqJkuFhD1QYbPOgiW5fMBvS0h
	 IJD/haUeAR8TgKq4v16k/HorpIPOGbZzZGQtJcA4QUFamaQ9IPmuk1GwWRnsLYlenoRwa
	 gk/nt5EcH6JYcW0NzzkVysryRBDqUZcS0YLoNZ92Dk3qUjAMxIBvu/x0nX0ZRu9ZY95Wt
	 fSVXNaV4xZdMzwcmmV9bgJkWqhM+xmZGZV7kBa3wGVbJjreKATHm+9AQgl69JcWtlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813794;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=b8wN83zNuLdxfhURbP01LmD8RetsAxNhZ3b+B2xuzOQ=;
	b=nGHakKg5rYWzDP5cmEwBN1tUOrQV6T++UmWcEJB3MYyi3ZLeXuXAh139cUp0uQSYmN1q
	 awmZ7+U0BokPvzgziujMouCBSr7DjxceDDyzmi0Tk2wkY/yFEVbV4Gcd/9lhnlchSRDPL
	 pnFJBaS/IiiIObU4MVuvmamqgaVcOsFm/BcZYhJHtBk7psjJp7dK46y2QRuwn03KsyAQb
	 WGILD1oKYseuvDDnDCbeQn1Sb99aECqvzkPura0fibuuPY6f/R3etNnL7ZlBnBfR8NR+N
	 R+mDcLusA0TGCKk2wVyZfA7nl6dMjRfehVVBgvyXdxyyNh11f5Xxd8uVFvPBqHhIZ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bz2qE0Z8;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E83606A31C;
	Fri, 27 Nov 2026 21:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0E83606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bz2qE0Z8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795813793; x=1827349793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ru+ziasidtLhoZH/GxyiIw2iqMUGXKKo8SAN9rrYi48=;
  b=Bz2qE0Z8F35I0AI5hpuNVh0zJzp0PmUrm1wMo7QkN3YR/PCYULPFS/KE
   8dIfUT59SU0wjnuGlsNv8Y1b7U2b50jqawFhwm4eJ9DfQA5lAAxdrkdfy
   NZubV2WGUrbSbs5raA3osIl8K1JAhXthCZTLxfdW+mGmrDeu4i++4A/FG
   cGTCmebiBox6vmq8ZDOYqBpi9XMXuUgNUT49OQ9RlLfHzxNN/41J4XQhY
   v9ySPRnqbYQxkLhUm+riaqpQamrh7RSnDWfJoxPRTsDxsuWe3StlO5Zuu
   PFs3Yg8bijhkPy1aMTqXC/xxlhj9rbi+y/UCQQ3LCm/O7jeXVKkE1iuVN
   A==;
X-CSE-ConnectionGUID: //g4Z98DRcGshyrU12exrQ==
X-CSE-MsgGUID: 7w0rklRuTs6kSAHIorjkXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4776488"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4776488"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 13:09:52 -0800
X-CSE-ConnectionGUID: VRJ92++kS6CCUGYFQ2Sx3w==
X-CSE-MsgGUID: x53bdMfHS3O+GlqFeCSmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12622127"
Received: from igk-lkp-server01.igk.intel.com (HELO 146cf1e082f1) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 27 Nov 2026 13:09:50 -0800
Received: from kbuild by 146cf1e082f1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xX3CV-000000000M6-3Fca;
	Fri, 27 Nov 2026 21:09:47 +0000
Date: Fri, 27 Nov 2026 22:08:57 +0100
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Andreas Gruenbacher <agruen@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: Re: [PATCH v4 02/21] drbd: extend wire protocol definitions for DRBD
 9
Message-ID: <20261127215935.7Z22nJ4s-lkp@intel.com>
References: <20261125153511.3060599-3-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125153511.3060599-3-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa7014f8d7565cfea117eac36a5de0a05eba65a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20261125-163451
base:   aa7014f8d7565cfea117eac36a5de0a05eba65a4
patch link:    https://lore.kernel.org/r/20261125153511.3060599-3-christoph.boehmwalder%40linbit.com
patch subject: [PATCH v4 02/21] drbd: extend wire protocol definitions for DRBD 9
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
docutils: docutils (Docutils 0.23, Python 3.13.5, on linux)
sphinx: sphinx-build 9.2.0
reproduce: (https://download.01.org/0day-ci/archive/20261127/20261127215935.7Z22nJ4s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127215935.7Z22nJ4s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/networking/xfrm_proc.rst references a file that doesn't exist: Documentation/networking/xfrm_proc.rst
   Warning: Documentation/translations/zh_CN/scsi/scsi_mid_low_api.rst references a file that doesn't exist: Documentation/Configure.help
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
   Warning: arch/arm/xen/enlighten.c references a file that doesn't exist: Documentation/devicetree/bindings/arm/xen.txt
   Warning: arch/powerpc/sysdev/mpic.c references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
>> Warning: drivers/block/drbd/drbd_protocol.h references a file that doesn't exist: Documentation/application-resync-synchronization.rst
   Warning: rust/kernel/sync/atomic/ordering.rs references a file that doesn't exist: srctree/tools/memory-model/Documentation/explanation.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/virtual/lguest/lguest.c
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,\b(\S*)(Documentation/[A-Za-z0-9
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/devicetree/dt-object-internal.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,^Documentation/scheduler/sched-pelt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

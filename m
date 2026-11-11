Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357326;
	b=NXhGhS7Zj/8cUKuST9HWpRprYnxfmJ1LgQaSVrBBQxhIIEJueGm96yVTLjCqmhWiEOLI
	 1fjiX+AMLuqXFghgAE9GzzwmOYktgimxahPgLUOQBUmVBzE+XeTqkutXwQmBLwgftWh/f
	 hGH5BT46DZJYxA6GIgAXeDl5VV0nAh5ZvRkJy35TtTxl5tw8Sskh6u/HiRYz0kEVF8gUQ
	 DHoGIEJ/XDyKyfA+Ca0HhNgL7haIHhrNkGoPDlBQpeGqFbgQgVF4AJIRSNm0fgmQ1eWIx
	 IJlI0yVO430OA4Cw7gJPKyDPqH/Mhaow65sRvocu5CEGSIWSECH9/33NhMTyeqe0fbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357326;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/LjX/apOanhMTTgHpb6dSpB5C318IV1ibkYKm6FseBw=;
	b=u4vCJYE2lG7APfpKA9imKPd4uXR9QKu1TdDFE53zL5+aC6jiej+GduVL8fk/AqfGYrhw
	 nfRh8j2xo1PDCC+gD/byLOQ7GRwNohxH19Ny1ekByBpiQ3bsn9BwtwUPjcpoNBxVBGJKw
	 Ux9Kpxmy9A8rjhzDh+GQN5x3Maqj/H29AfKtTf6BEuZCHYLJ+9PNGnGYuDbzuy79wRf4N
	 Llq89nsTDZWQk0gIqGERndyag2F+YFZ0bH7z6vANW6LG655emIu9vFFkm+IcMfqFswHfH
	 bBkmpMWD8xGlOP+0IdNEqxkCMmIB2Hy9bYZbwAK4P/PbpgfXlSrF4G1uuWL2RzGA2nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QDe3hksN;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBD606A321;
	Wed, 11 Nov 2026 00:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ADBD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QDe3hksN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794357324; x=1825893324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dkzIzMmZB7REKDaD0rvd1ZSTaFpES2DqmGzbU4n1gyY=;
  b=QDe3hksNQJVlwy0jDN/sbLcS8O7sNyzwEbC1SNTiMXdpBKv+XDV5pQsS
   nWwSU/GoRBWb2ihlJHdWNk4WCmxJ1yCvXSTWqWDWu4DgBCOZlGMkaN82Y
   B6eBv43M2udXRe0hkAb+15qeqaX5LHNOzIkbK5jILDlM/mNi9XKYHos+v
   4e2jUCDlDtstfR1mRU+m4xz+X2hzkVQJKE/75v0u8z3Rg3i7Y5e8vX9Cv
   T9CEfASYbwjiQPNEDxb+fBt54L5FiKnVIIhHnwAfToPx8WKF9Zoher4vZ
   lxBb6HaEY8ZpNbuyKHZzN6NYnIcSnmNTUoTiKY5Ael/wJneucKl2pgeez
   Q==;
X-CSE-ConnectionGUID: XzKMMXpHQSqKVUX8v8cpZg==
X-CSE-MsgGUID: FlQKHCdrStuTk8pI/HVanA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3001346"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3001346"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 16:35:24 -0800
X-CSE-ConnectionGUID: 4lPyzWirRJmaoaHl5EEZzw==
X-CSE-MsgGUID: aOGxk3CETXGrilTz8KFS9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="10074205"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 10 Nov 2026 16:35:22 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQwJ5-00000000xlr-1Jmy;
	Wed, 11 Nov 2026 00:35:19 +0000
Date: Wed, 11 Nov 2026 08:34:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v3 20/20] drbd: remove BROKEN for DRBD
Message-ID: <202611110819.YiyLkWx7-lkp@intel.com>
References: <20261110162646.3028472-21-christoph.boehmwalder@linbit.com>
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
In-Reply-To: <20261110162646.3028472-21-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa7014f8d7565cfea117eac36a5de0a05eba65a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20261110-172626
base:   aa7014f8d7565cfea117eac36a5de0a05eba65a4
patch link:    https://lore.kernel.org/r/20261110162646.3028472-21-christoph.boehmwalder%40linbit.com
patch subject: [PATCH v3 20/20] drbd: remove BROKEN for DRBD
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20261111/202611110819.YiyLkWx7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611110819.YiyLkWx7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611110819.YiyLkWx7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/block/drbd/drbd_transport_tcp.c:670 function parameter 'transport' not described in 'dtt_socket_ok_or_free'
>> Warning: drivers/block/drbd/drbd_transport_tcp.c:670 function parameter 'what' not described in 'dtt_socket_ok_or_free'
>> Warning: drivers/block/drbd/drbd_transport_tcp.c:670 function parameter 'transport' not described in 'dtt_socket_ok_or_free'
>> Warning: drivers/block/drbd/drbd_transport_tcp.c:670 function parameter 'what' not described in 'dtt_socket_ok_or_free'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

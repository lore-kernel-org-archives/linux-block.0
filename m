Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BF2EA75E;
	Mon,  3 Aug 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767430; cv=none; b=OnGlB0GbHndK+zOnSBve3OiT07JbgCiUTTIQk/UM+bA4EWsm4asG8Iah2C+At2a3IN2Gp4OaI4PBB3zVV4AcC6eqj+dDW89qB7II7fg8KvsD3uRs8fQAknsCCfaSUPJpkqKnZGifVj7YUn86yRa+VIJoBWbkeQeo7D73V2p+kK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767430; c=relaxed/simple;
	bh=0ylbr2e+UhF90GrPAgiwQl2i+ENO0yXSLMl5gsN/X0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr0khSfu8/IS99ytZ01ufHrMR4N/4wQIVqRSkvdXyuYcNFJX6gs81HGklWPfY7htCLwjIQkE08Eq5MFftHmFsVPXB5jeHYHXF9YnQdQCLKWTKtTk+dFVuetSzRT6DXIXvYANDT8cDMWQou2iAGCsQ5ulIj/RMOnH6FAE/E6fKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hegr8Cz8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hegr8Cz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785767428; x=1817303428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ylbr2e+UhF90GrPAgiwQl2i+ENO0yXSLMl5gsN/X0I=;
  b=Hegr8Cz8lQVxt/SOqenDeIxuToDcfSqW431Db2OypHN9ZKxL4M1n1LDL
   D4EP6z/HFdi9cqtVX4wm8vuTJaq3fi8zM2o45H19ZH6NBR/ElSLhQVx4M
   /rVsJNRjmJwChK3Alp1zV0oJX1xMATMuQ10Iy0PjFify2gYmuQxJ/pu8V
   //e5njiFr82SiRjYULCTvbfMgSCsMyKyBJpIKv+MeLTno93Wo7gz+dOxI
   rcTNjkfWKU04jhOEAOdb++H/PCerm+qknKOUSJHfOtb7tU7U9LVDr/fiY
   qCo9V3dO1ii68lF4WXf2pJsicGc4dgyh0xMCyW8eXeezuN8fREO7yb2Ee
   Q==;
X-CSE-ConnectionGUID: QEp2I2YvSzaTNKaxiSmO6w==
X-CSE-MsgGUID: p4Z/SJGvRoG5/df4MTdcwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96958818"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="96958818"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:30:19 -0700
X-CSE-ConnectionGUID: Mg2PfLUTTgaiZdjDlK/WMA==
X-CSE-MsgGUID: vBbIqnJoR5urgr7iZYpsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="291165749"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Aug 2026 07:30:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqtfv-0000000077Z-35zH;
	Mon, 03 Aug 2026 14:29:56 +0000
Date: Mon, 3 Aug 2026 22:29:36 +0800
From: kernel test robot <lkp@intel.com>
To: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, ojeda@kernel.org,
	a.hindborg@kernel.org, paul@paul-moore.com, aliceryhl@google.com,
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk,
	brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org,
	nm@ti.com, sboyd@kernel.org, m.wilczynski@samsung.com,
	boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk,
	daniel.almeida@collabora.com, shankari.ak0208@gmail.com,
	lyude@redhat.com, j@jananu.net, lossin@kernel.org,
	acourbot@nvidia.com, markus.probst@posteo.de,
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Message-ID: <202608032252.nPlw6icN-lkp@intel.com>
References: <20260628095132.47753-1-trev@trevrosa.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628095132.47753-1-trev@trevrosa.dev>

Hi Trevor,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus drm/drm-next drm-misc/drm-misc-next akpm-mm/mm-everything linus/master v7.2-rc6]
[cannot apply to next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Trevor-Chan/rust-aref-make-AlwaysRefCounted-inc_ref-an-associated-function/20260803-160221
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20260628095132.47753-1-trev%40trevrosa.dev
patch subject: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an associated function
config: x86_64-buildonly-randconfig-001-20260803 (https://download.01.org/0day-ci/archive/20260803/202608032252.nPlw6icN-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260803/202608032252.nPlw6icN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608032252.nPlw6icN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0424]: expected value, found module `self`
   --> rust/kernel/pwm.rs:637:50
   |
   634 |     fn inc_ref(obj: &Self) {
   |        ------- this function doesn't have a `self` parameter
   ...
   637 |         unsafe { bindings::get_device(&raw mut (*self.0.get()).dev) };
   |                                                  ^^^^ `self` value is a keyword only available in methods with a `self` parameter
   |
   help: add a `self` receiver parameter to make the associated `fn` a method
   |
   634 |     fn inc_ref(&self, obj: &Self) {
   |                ++++++

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

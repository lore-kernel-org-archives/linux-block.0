Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7632AAD6
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000411; cv=none; b=XxSGhsvl9lFkZL0QiHZL5XoEpQUNPKmu8w4Y4slbMhVdtDfYyOHF0h6E955Ux/AozVy3kJlIoItELMUmmI30AFvOYuj+gKijLPZETz/8bEwnIqNPm3Fx2H9PXv3PZIO3ZpxndTPXVnW8AixJABpEB0vGCs1XPKp6hbbdXvkuFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000411; c=relaxed/simple;
	bh=Zj9FhbnM1hJ+o73taQpfbaKpvMFUH2QEHLmDk1RIlC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG2JSlWjgYN/L29B6AKSovb3FOf11wNyLlIRvvzPRgSno7Va1F6uZVOcLAWRMTBTCQEzpHdXoRM4M+KSrIRnqs+YM0pYv2xMczTPn/PqwnvGJX6aADVg6tMRhYVkfLjWIzSeXZ0HUnXbgoOeuQbqaf9byUfKHt9XsZ4ZTIPCgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi+dhZSn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi+dhZSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780000409; x=1811536409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zj9FhbnM1hJ+o73taQpfbaKpvMFUH2QEHLmDk1RIlC0=;
  b=Pi+dhZSn8qz6PImG3QjM6+8rhjd1SeiK+woe8OaMNkHUsMP+s3/n6IM4
   cwlbo0v/knmQqKU01IUjRW78kJVN44Z9slw/CdXvkeqCQkJHALEtpnEom
   azoLGYWaatsSXuhgJmqGiSmNshWgF6kUuLKQXao28rJDqOjqbDorqCrAV
   kb0F6YN3xmrb/f3Jvk7hI+eMhari6AovPWW9FidOdU3cQwnTeJCmQzozz
   iBi95VW1UCsy6MOXAmskk5Ky9Uq3KyEu6GiDQtiTnWdoeLQbvHKDTXUcf
   0+ifq5WrQBZN2lT3aEbUk9VDEyaXNwDZpHeLvSUkart915Jfooa47e9Ni
   Q==;
X-CSE-ConnectionGUID: eE+daQBzQuikVg0OjAfzew==
X-CSE-MsgGUID: 61PdQpoWTDe7qh5B7sCZEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92327111"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="92327111"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 13:33:27 -0700
X-CSE-ConnectionGUID: 2wnFMkTtS7qQXnam381Esg==
X-CSE-MsgGUID: n1YgZry0RA+DqbsA2ND2DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="244472099"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 28 May 2026 13:33:21 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wShPq-000000000Zp-40GA;
	Thu, 28 May 2026 20:33:18 +0000
Date: Thu, 28 May 2026 22:32:41 +0200
From: kernel test robot <lkp@intel.com>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Caleb Sander Mateos <csander@purestorage.com>,
	Sung-woo Kim <iam@sung-woo.kim>, Josef Bacik <josef@toxicpanda.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>, Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Luke Wang <ziniu.wang_1@nxp.com>,
	Kees Cook <kees@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH v1] block: switch numa_node to int in blk_mq_hw_ctx and
 init_request
Message-ID: <202605282203.xhTf7sMS-lkp@intel.com>
References: <20260523125210.272274-1-mateusz.nowicki@posteo.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523125210.272274-1-mateusz.nowicki@posteo.net>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on 45255ea1ca096b11b1303c9b54502a28f3a31dd1]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Nowicki/block-switch-numa_node-to-int-in-blk_mq_hw_ctx-and-init_request/20260523-205439
base:   45255ea1ca096b11b1303c9b54502a28f3a31dd1
patch link:    https://lore.kernel.org/r/20260523125210.272274-1-mateusz.nowicki%40posteo.net
patch subject: [PATCH v1] block: switch numa_node to int in blk_mq_hw_ctx and init_request
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260528/202605282203.xhTf7sMS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605282203.xhTf7sMS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605282203.xhTf7sMS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0308]: mismatched types
   --> rust/kernel/block/mq/operations.rs:274:28
   |
   274 |         init_request: Some(Self::init_request_callback),
   |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
   |                       |
   |                       arguments to this enum variant are incorrect
   |
   = note: expected fn pointer `unsafe extern "C" fn(_, _, _, i32) -> _`
   found fn item `unsafe extern "C" fn(_, _, _, u32) -> _ {OperationsVTable::<T>::init_request_callback}`
   help: the type constructed contains `unsafe extern "C" fn(*mut blk_mq_tag_set, *mut bindings::request, u32, u32) -> i32 {OperationsVTable::<T>::init_request_callback}` due to the type of the argument passed
   --> rust/kernel/block/mq/operations.rs:274:23
   |
   274 |         init_request: Some(Self::init_request_callback),
   |                       ^^^^^---------------------------^
   |                            |
   |                            this argument influences the type of `Some`
   note: tuple variant defined here
   --> /opt/cross/rustc-1.88.0-bindgen-0.72.1/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:597:5
   |
   597 |     Some(#[stable(feature = "rust1", since = "1.0.0")] T),
   |     ^^^^

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

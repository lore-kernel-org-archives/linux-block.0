Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6B175BF;
	Wed, 25 Dec 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735110669; cv=none; b=oazYvHqSj3bJ9BdYMGlcJp0jQYcb+MVfmtoHseLi8ZD7hlUyJVrZLD2wSN4nVuuIs6ujYMYq3c61vRh3Ba43h2+wVbpJ3B4RQdY3+dXdklyV/bzh6n2SRzT2Dsp7gGr1kZC5xG+bEazCyefu6tI0vtbHivZntDc5yvCBkDFeBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735110669; c=relaxed/simple;
	bh=gnhsxX4oXEW7P+r6OA1bGGNyoF9DXTncUB6iNrQ94fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYzPuzn877DOmcdsR7QgaZxtVio1atkNqSArbwn7KSnz+FFZHo+xD9ptM21QEQU1+/a/Up6KYgvMrW8YtzwcFIjZLKbuQ19c33gjNbsa54FazNOA8tZ/JKmEtLKNcA6WZrIyiLC7ONHF+i+bIZXd00NRAMLPHMRQ6W/0baeZnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcGnI2Y/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcGnI2Y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735110666; x=1766646666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnhsxX4oXEW7P+r6OA1bGGNyoF9DXTncUB6iNrQ94fs=;
  b=LcGnI2Y/bvj4Rwg1HQjsX1Z1ruszbGociLye4LojRlOZ5fVw9z4aBkAd
   kQ9kb1Zv0GcCa+VbNkxLjnK5IzFy5xPr730zfz4H2UIv/nCQBOVLHEGRf
   20mfDrDA5QT16gUn5VDP9vVRGG9fqOVykUIGwYDMZ5FFBv/AsUkW+oMZT
   /LJae120xgFOiksIXnfICJXFZCqvG9uav1qEK4JBa2lBh0PrN9y0MIPFV
   xT5HCOpr3j2J0cwbsfYllflaVjxTj90IOKccKoDO1H+bja7irVq3eayZ2
   HCxcNP5EwuS91Er/BT+vscvEaNleleCL/LH9RNHBYtG63e12jyRECzDOK
   Q==;
X-CSE-ConnectionGUID: KAMFkOUQSZqADZCnoDlaNg==
X-CSE-MsgGUID: CiwG6d8tQZGubIdhJ3dsTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35596762"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="35596762"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 23:11:06 -0800
X-CSE-ConnectionGUID: 7KGvvfJBQF+IM8eX/9HkOA==
X-CSE-MsgGUID: 42+rJXalTxSo9k1P1rGe/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="100171071"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Dec 2024 23:10:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQLXd-0001mZ-15;
	Wed, 25 Dec 2024 07:10:49 +0000
Date: Wed, 25 Dec 2024 15:09:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mitchell Levy <levymitchell0@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH v2 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Message-ID: <202412251433.T3BhO2CQ-lkp@intel.com>
References: <20241219-rust-lockdep-v2-1-f65308fbc5ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-rust-lockdep-v2-1-f65308fbc5ca@gmail.com>

Hi Mitchell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0c5928deada15a8d075516e6e0d9ee19011bb000]

url:    https://github.com/intel-lab-lkp/linux/commits/Mitchell-Levy/rust-lockdep-Remove-support-for-dynamically-allocated-LockClassKeys/20241220-050220
base:   0c5928deada15a8d075516e6e0d9ee19011bb000
patch link:    https://lore.kernel.org/r/20241219-rust-lockdep-v2-1-f65308fbc5ca%40gmail.com
patch subject: [PATCH v2 1/2] rust: lockdep: Remove support for dynamically allocated LockClassKeys
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20241225/202412251433.T3BhO2CQ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241225/202412251433.T3BhO2CQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412251433.T3BhO2CQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unsafe block missing a safety comment
   --> rust/kernel/sync.rs:45:13
   |
   45  |             unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
   |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   ::: rust/kernel/block/mq/gen_disk.rs:111:17
   |
   111 |                 static_lock_class!().as_ptr(),
   |                 -------------------- in this macro invocation
   |
   = help: consider adding a safety comment on the preceding line
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
   = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`
   = note: this warning originates in the macro `static_lock_class` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> warning: unsafe block missing a safety comment
   --> rust/kernel/sync.rs:45:13
   |
   45  |             unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
   |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   ::: rust/kernel/workqueue.rs:218:21
   |
   218 |             work <- new_work!("Queue::try_spawn"),
   |                     ----------------------------- in this macro invocation
   |
   = help: consider adding a safety comment on the preceding line
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
   = note: this warning originates in the macro `$crate::static_lock_class` which comes from the expansion of the macro `new_work` (in Nightly builds, run with -Z macro-backtrace for more info)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

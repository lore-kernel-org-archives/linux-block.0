Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58082488
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634845; cv=none; b=q+uiwUJGQYop1wvVezh3QDFvZJdCf3P0Fn/qXyylnHBfaoo81tw1/BfOFG1+atIM0DD8t1xyFUdmsMdMdEym6+qVOVXVUgQv9oqDPOYwYCpgnUNzWPzl6m9oBW5bOnyWiD7m1b89tXDPByE+UajyRAcdovdmar0WpECRfdRhcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634845; c=relaxed/simple;
	bh=E1uuvaghrSReazGwqHun9+V8fVcgzEF8XlyjgajDGXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY4GEIo8XKQ4hDLUzW3NCL2695TcwWxFzcP7wrAhW09aniZhiI50CcUxSsIaeqS69I8JNoNyX7DX8FD9/z+JUbQ6tYGpxzW1hOKH8gZNRrKDGu66UlHJg6Qa28clkY/VYkiumK7htBxddjdKVfOnqlb8D5sK3HsB9TeMSjGszVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOKStWhc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOKStWhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715634843; x=1747170843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E1uuvaghrSReazGwqHun9+V8fVcgzEF8XlyjgajDGXs=;
  b=TOKStWhcVi8sHWA/ZhNunwA9EJkLSkawf0pOp9h/BC6ddV93NfBv/utc
   ilubASD+fHhqDsyshF2hbhVrdvVJYtrP7qb5KeKUnPe06z6VDjvgoppva
   NGR0Z8ptuWO39PmA5b3HYuafPN/CX8RBAuwLkVfZ5thu7+cO+bw7cK0mF
   fqlDD2OY4f3chiycIgJoWOSUIaxnzZASG3oWJkWe7dYedfIt53j4cukh8
   I8pzCPnWV74gPFf95X/svsSfvbELPj2F+2d2uIw0DJN15TjZX/Kgaxi+5
   sTJzLd+L7U9+hnnl7Akp1RfTRwzHZM1N6y4q40XMHO9O+G3S9cFc7poZr
   w==;
X-CSE-ConnectionGUID: JWC6UHIgQnem+eCkiKetqg==
X-CSE-MsgGUID: bkXi9QM/SdiKnNX/h2Nxcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="36969975"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="36969975"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 14:14:02 -0700
X-CSE-ConnectionGUID: 9QLpOo6JRiSHs1VUV9L7tg==
X-CSE-MsgGUID: PYjTIi1RQj2KhTLsdMpLNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30407013"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 May 2024 14:13:55 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6czZ-000AiB-0D;
	Mon, 13 May 2024 21:13:53 +0000
Date: Tue, 14 May 2024 05:13:51 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <greg@kroah.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <202405140410.Pg9JrkDO-lkp@intel.com>
References: <20240512183950.1982353-2-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512183950.1982353-2-nmi@metaspace.dk>

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fec50db7033ea478773b159e0e2efb135270e3b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/rust-block-introduce-kernel-block-mq-module/20240513-024107
base:   fec50db7033ea478773b159e0e2efb135270e3b7
patch link:    https://lore.kernel.org/r/20240512183950.1982353-2-nmi%40metaspace.dk
patch subject: [PATCH 1/3] rust: block: introduce `kernel::block::mq` module
config: x86_64-buildonly-randconfig-004-20240514 (https://download.01.org/0day-ci/archive/20240514/202405140410.Pg9JrkDO-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405140410.Pg9JrkDO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405140410.Pg9JrkDO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: method `to_blk_status` is never used
   --> rust/kernel/error.rs:133:19
   |
   97  | impl Error {
   | ---------- method in this implementation
   ...
   133 |     pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
   |                   ^^^^^^^^^^^^^
   |
   = note: `#[warn(dead_code)]` on by default

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E314EC56
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601516; cv=none; b=Vt4PkiGA1zGpcP9Me5kLc6VGGxpwS8KPrRT4uWleiUJaHfECDrahv7Fu1YSBcP1arMoW8jAvJXxMmE410uBrX8FpIHTFKJUo6nU2zaKAXoglXNSjpKPtAlNurz4d4qQaEisK/igMXRVKFgpv6gFedBbGtVP2pPsrR2nEaAot+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601516; c=relaxed/simple;
	bh=PrR35GiulFe05GlhKAd3AxFWa4/eHJrBCI6ecndk+OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEL+kDjdW4ft2XpKveoKgp6YC0CsllYthkN8VbLOzNbZxHg58iHYGVa/eAjhekbOMVMRvUE41dYlae1oE0bAtNW3Vvwkqrbka9N+xLmuSXmeXqYkmQ5u1Yk138/pde0Cu3HEa36Np4j2/xwy0n4GhhCNytLKaojzf7m9LPtf9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDsbwYu6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDsbwYu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715601514; x=1747137514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrR35GiulFe05GlhKAd3AxFWa4/eHJrBCI6ecndk+OY=;
  b=gDsbwYu6C0poVoBsp++mFv5iJ23bAgUlZskbCcbbQRL39+ZyiSrPMOqF
   3cvVmT3GOB2lfslRDmGVFdwC2+JpssepSk7BEQtlRg1/YRypQLFfc/JSE
   gD0BiZ1c+6uJDE6uKiM+yVJ4QVOmefn4QmMZxzGwqN8t+Gi8B+xy2UTYJ
   uLtKmCNxMUZv5gXaXS8JM8y/90gxC1FLnO12Lkt0BH1IaIWLUd3+68Lh9
   PnPR4w+PPR7L39sYfO5CHajbBGq8N1ShSPnT9U+oLTYpy68BLRuWMVpgj
   yybh+uOcHpeTpkOLiqFkQG/McQMGupMSuzL2qtUo7NS5g9G+Sh6XXVQ05
   A==;
X-CSE-ConnectionGUID: 2mPdNUkBS4KYVBXHNHn1Bg==
X-CSE-MsgGUID: m6iHfVqZR5iCmov6g2b81g==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="15342083"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="15342083"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:58:34 -0700
X-CSE-ConnectionGUID: xcwqmTJNRtKYJ0Jq01KgPA==
X-CSE-MsgGUID: XpeGDUyYSCqR90C+hNbjig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30270709"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 May 2024 04:58:27 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6UK0-000A6N-2c;
	Mon, 13 May 2024 11:58:24 +0000
Date: Mon, 13 May 2024 19:58:19 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202405131926.5TqIqaTc-lkp@intel.com>
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
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240513/202405131926.5TqIqaTc-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405131926.5TqIqaTc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405131926.5TqIqaTc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unresolved link to `GenDisk`
   --> rust/kernel/block/mq.rs:10:18
   |
   10 | //! - Create a [`GenDisk<T>`], passing in the `TagSet` reference
   |                  ^^^^^^^^^^ no item named `GenDisk` in scope
   |
   = help: to escape `[` and `]` characters, add '' before them like `[` or `]`
   = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
--
>> warning: unresolved link to `GenDisk::add`
   --> rust/kernel/block/mq.rs:11:47
   |
   11 | //! - Add the disk to the system by calling [`GenDisk::add`]
   |                                               ^^^^^^^^^^^^ no item named `GenDisk` in scope
--
>> warning: unresolved link to `Operations::RequestData`
   --> rust/kernel/block/mq.rs:22:45
   |
   22 | //! associated types in `Operations`, see [`Operations::RequestData`] for an
   |                                             ^^^^^^^^^^^^^^^^^^^^^^^ the trait `Operations` has no associated item named `RequestData`
--
>> warning: unresolved link to `Request::start`
   --> rust/kernel/block/mq.rs:30:51
   |
   30 | //! mark start of request processing by calling [`Request::start`] and end of
   |                                                   ^^^^^^^^^^^^^^ the struct `Request` has no field or associated item named `start`
--
>> warning: unresolved link to `Request::end`
   --> rust/kernel/block/mq.rs:31:40
   |
   31 | //! processing by calling one of the [`Request::end`], methods. Failure to do so
   |                                        ^^^^^^^^^^^^ the struct `Request` has no field or associated item named `end`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

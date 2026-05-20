Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D83EF647;
	Wed, 20 May 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296147; cv=none; b=bvRgVAh+XImw7NC4FUvJUSv2PMQUC7pca+wPyPtRZwp24wLAwpC75GrpGnIJBSTKw4/ltRsvQiaAokxTSqujAXA7LpM97rRXClaJWA+LlJku9iCrz1NPeliVEQbHdKjq4lKizCCriwiIuaLYEtd7mFAEs61MHM87jVdZRaMFkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296147; c=relaxed/simple;
	bh=lvT89uq5Kv8IZjAUDt6UH4Pi6VcaFu6bqBH87dubLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY3qdCNA8KxDgjyfo6cxquPz/Inzh5WEk1j0zgj4izoVGtnRpvtqwUjyzC2QMnIHsWoTW/5W3nnlg5F62IbA1YWv9XqBU7iLdl0zho8WHstV3jMA7PXekL/RRJwNCig4eoKMILOoG5IOkpleoeXRuLA3p98/xbILCZhhY1sFreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6oSkTs2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6oSkTs2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779296146; x=1810832146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvT89uq5Kv8IZjAUDt6UH4Pi6VcaFu6bqBH87dubLA0=;
  b=c6oSkTs2uYod5S6AN6T8HyAzY1nxCi/5nPXK4zB150KWxgytPfEFBkgV
   32a6Gemcs21DzoklbKejpJKLVMIP/V52GQs0bNxPx++iSclu3em5Gyx2W
   ycrQnKsHU2tjc3YEJptxR7uKVpCKIS8kYAJe2DYKSxXKTmJzam5AtWY7+
   Z/NwWzNek9hRFG+aZwqHDaEGtCxogJY76CKIZzWQQmDWhsHPJdasdXqUL
   mGC7qsK/31C+e6LnXHsXPLopJ/aCzO79nyra90rKAjxJ3tkbrDCxf0py0
   GZIhHKL9F4n9yfmtwETlm9EUq8+b935pwVaM31UJqHl6wSSWvgslWf1I2
   A==;
X-CSE-ConnectionGUID: AwvP2boWRIiia1plqExJdQ==
X-CSE-MsgGUID: BT5ql0uWQS2MAWVVXoFf8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90501642"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90501642"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 09:55:44 -0700
X-CSE-ConnectionGUID: m2evV3TAT56o8oTJQucmDg==
X-CSE-MsgGUID: vt+I01hBTLK0PUQLZQDntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240485816"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 20 May 2026 09:55:40 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPkCn-00000000AbJ-216B;
	Wed, 20 May 2026 16:55:37 +0000
Date: Wed, 20 May 2026 18:55:27 +0200
From: kernel test robot <lkp@intel.com>
To: Malte Wechter <maltewechter@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
	Malte Wechter <maltewechter@gmail.com>
Subject: Re: [PATCH] rust: add procedural macro for declaring configfs
 attributes
Message-ID: <202605201854.YArCKAtw-lkp@intel.com>
References: <20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com>

Hi Malte,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 254f49634ee16a731174d2ae34bc50bd5f45e731]

url:    https://github.com/intel-lab-lkp/linux/commits/Malte-Wechter/rust-add-procedural-macro-for-declaring-configfs-attributes/20260520-154816
base:   254f49634ee16a731174d2ae34bc50bd5f45e731
patch link:    https://lore.kernel.org/r/20260520-configfs-syn-v1-1-6c5b80a9cef2%40gmail.com
patch subject: [PATCH] rust: add procedural macro for declaring configfs attributes
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260520/202605201854.YArCKAtw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605201854.YArCKAtw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605201854.YArCKAtw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unclosed HTML tag `Configuration`
   --> rust/macros/lib.rs:561:30
   |
   561 | ///                 Subsystem<Configuration>,
   |                              ^^^^^^^^^^^^^^^
   |
   = note: `#[warn(rustdoc::invalid_html_tags)]` on by default
   help: try marking as source code
   |
   561 | ///                 `Subsystem<Configuration>`,
   |                     +                        +
--
>> warning: unclosed HTML tag `Configuration`
   --> rust/macros/lib.rs:564:30
   |
   564 | ///                 Subsystem<Configuration>,
   |                              ^^^^^^^^^^^^^^^
   |
   help: try marking as source code
   |
   564 | ///                 `Subsystem<Configuration>`,
   |                     +                        +
--
>> warning: unresolved link to `crate::configfs_attrs`
   --> rust/kernel/configfs.rs:240:1
   |
   240 | / /// A configfs group.
   241 | | ///
   242 | | /// To add a subgroup to configfs, pass this type as `ctype` to
   243 | | /// [`crate::configfs_attrs`] when creating a group in [`GroupOperations::make_group`].
   | |_______________________________________________________________________________________^
   |
   = note: the link appears in this line:
--
>> warning: unresolved link to `kernel::configfs_attrs`
   --> rust/kernel/configfs.rs:630:1
   |
   630 | / /// Operations supported by an attribute.
   631 | | ///
   632 | | /// Implement this trait on type and pass that type as generic parameter when
   633 | | /// creating an [`Attribute`]. The type carrying the implementation serve no
   ...   |
   640 | | /// attributes via the [`kernel::configfs_attrs`] macro, to tie
   641 | | /// `AttributeOperations` implementations to concrete named attributes.
   | |_______________________________________________________________________^
   |
   = note: the link appears in this line:
--
>> warning: unresolved link to `kernel::configfs_attrs`
   --> rust/kernel/configfs.rs:672:7
   |
   672 | /// [`kernel::configfs_attrs`] macro to declare a static set of attributes for a
   |       ^^^^^^^^^^^^^^^^^^^^^^ no item named `configfs_attrs` in module `kernel`
--
>> warning: unresolved link to `kernel::configfs_attrs`
   --> rust/kernel/configfs.rs:678:7
   |
   678 | /// [`kernel::configfs_attrs`] macro.
   |       ^^^^^^^^^^^^^^^^^^^^^^ no item named `configfs_attrs` in module `kernel`
--
>> warning: unresolved link to `kernel::configfs_attrs`
   --> rust/kernel/configfs.rs:723:1
   |
   723 | / /// A representation of the attributes that will appear in a [`Group`] or
   724 | | /// [`Subsystem`].
   725 | | ///
   726 | | /// Users should not directly instantiate objects of this type. Rather, they
   727 | | /// should use the [`kernel::configfs_attrs`] macro to statically declare the
   728 | | /// shape of a [`Group`] or [`Subsystem`].
   | |__________________________________________^
   |
   = note: the link appears in this line:

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6136C0D3;
	Fri,  6 Mar 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822142; cv=none; b=fVn57mwPmGAqntvBHBeCJ1YRSpz8lIwH7DjTMoCyf/eri9ByQO/8oRqr7MP19Sox1dzyIm0kUXaOkcyIdHTa3vRM+gPeBF27JCLD6JVJ5JnOWb14EXoWKl+gA7pF2Egc48FmZocfPyes+AtfmSx/9L1v68N/hb3kdqpSWCwA5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822142; c=relaxed/simple;
	bh=PnOYd++9D/NC6pzAhyfUCqczA9LK0rZ55pi87hLP8wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8yRd+Q5W0sACdjf4c63yxpqO0v7OX7bMm6/RzcbRJrn7cgy4Ycvv4V+9ZdRpKetvGrJv8w+4AIZi4iCe9O3zFmkAjP9yA/w4VxL4vXDGeGvd3mIhYDzM74liFun3lmXmm2fN63MjT+uRsJN3aj621o/9zd+D5ytxEG+Uxh1lM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ggfg6849; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ggfg6849"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772822139; x=1804358139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PnOYd++9D/NC6pzAhyfUCqczA9LK0rZ55pi87hLP8wQ=;
  b=Ggfg6849QXhjnBbEtfePyeayIWuQEQ3plwvz0XvL/YrNvtajfGjzS2AR
   uNls+SuhnXZB1cTh4T609ToaErjtZUFuF7eu1BfemVtcPf2IV1Wxxe5Zc
   Y/W4+2Vx9xKbByn1inIzvs6GI/3sc/EXW2KumZmm2wcJ5I1IyWHWdkK26
   jou62H4IXqSIbTGb61xxN2VlFj/G2EzrRaHsdr/sjd7/H3LsaNGksxchO
   35TwELjfiZGlr4VKua7ghbKNdEqqDIK5swtMzxNte060SlDLBXadFZsEW
   V/F7q4H3ZCsazO2VicOrOmeAlp48hM7jQIa6LjP4YTu45Q/L9XgLl97eW
   g==;
X-CSE-ConnectionGUID: dPiciPqpQ+ir2OtxLb41RA==
X-CSE-MsgGUID: cT5uaeY+RD6odYMvAAlLEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="77537835"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="77537835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 10:35:38 -0800
X-CSE-ConnectionGUID: ibsvGUyoQ9Offwi88FhFww==
X-CSE-MsgGUID: ROHfWkN5Q+OaALsLthe0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="216829715"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 Mar 2026 10:35:35 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vya1N-000000001EH-0Xnc;
	Fri, 06 Mar 2026 18:35:33 +0000
Date: Sat, 7 Mar 2026 02:34:59 +0800
From: kernel test robot <lkp@intel.com>
To: luoqing <l1138897701@163.com>, axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
Message-ID: <202603070226.gVmbTzRU-lkp@intel.com>
References: <20260306080056.1262324-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306080056.1262324-1-l1138897701@163.com>

Hi luoqing,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on device-mapper-dm/for-next linus/master v7.0-rc2 next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/luoqing/dm-bufio-Use-struct_size-helper-in-kmalloc/20260306-165625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260306080056.1262324-1-l1138897701%40163.com
patch subject: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20260307/202603070226.gVmbTzRU-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070226.gVmbTzRU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070226.gVmbTzRU-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:420:26: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                        ^
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:420:57: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                       ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:420:57: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                       ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
>> block/bio.c:660:17: error: static assertion failed due to requirement '!(!(!__builtin_types_compatible_p(struct bio_vec *, struct bio_vec *)))': must be array
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:436:18: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^
   include/linux/overflow.h:420:36: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^
   include/linux/compiler.h:208:28: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:421:32: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                              ^
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:421:63: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                             ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:421:63: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                             ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
>> block/bio.c:660:17: error: static assertion failed due to requirement '!(!(!__builtin_types_compatible_p(struct bio_vec *, struct bio_vec *)))': must be array
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:436:18: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^
   include/linux/overflow.h:421:42: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^
   include/linux/compiler.h:208:28: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:437:45: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                           ^
   include/linux/overflow.h:420:26: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                        ^
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:437:45: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                           ^
   include/linux/overflow.h:420:57: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                       ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:437:45: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                           ^
   include/linux/overflow.h:420:57: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                       ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
>> block/bio.c:660:17: error: static assertion failed due to requirement '!(!(!__builtin_types_compatible_p(struct bio_vec *, struct bio_vec *)))': must be array
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:437:26: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^
   include/linux/overflow.h:420:36: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^
   include/linux/compiler.h:208:28: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:437:45: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                           ^
   include/linux/overflow.h:421:32: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                              ^
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:437:45: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                           ^
   include/linux/overflow.h:421:63: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                             ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:437:45: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                           ^
   include/linux/overflow.h:421:63: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                             ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
>> block/bio.c:660:17: error: static assertion failed due to requirement '!(!(!__builtin_types_compatible_p(struct bio_vec *, struct bio_vec *)))': must be array
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:437:26: note: expanded from macro 'struct_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^
   include/linux/overflow.h:421:42: note: expanded from macro 'flex_array_size'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^
   include/linux/compiler.h:208:28: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
   include/linux/alloc_tag.h:251:9: note: expanded from macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:420:26: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                        ^
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:255:10: note: expanded from macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:420:57: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                       ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:255:10: note: expanded from macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
         |                                         bi_io_vec
   include/linux/overflow.h:436:37: note: expanded from macro 'struct_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                                   ^
   include/linux/overflow.h:420:57: note: expanded from macro 'flex_array_size'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                       ^
   include/linux/compiler.h:208:64: note: expanded from macro '__must_be_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/slab.h:956:52: note: expanded from macro 'kmalloc'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                                            ^
   include/linux/alloc_tag.h:265:31: note: expanded from macro 'alloc_hooks'
     265 |         alloc_hooks_tag(&_alloc_tag, _do_alloc);                        \
         |                                      ^
   include/linux/alloc_tag.h:255:10: note: expanded from macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^
   include/linux/blk_types.h:236:19: note: 'bi_io_vec' declared here
     236 |         struct bio_vec          *bi_io_vec;
         |                                  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +660 block/bio.c

   637	
   638	/**
   639	 * bio_kmalloc - kmalloc a bio
   640	 * @nr_vecs:	number of bio_vecs to allocate
   641	 * @gfp_mask:   the GFP_* mask given to the slab allocator
   642	 *
   643	 * Use kmalloc to allocate a bio (including bvecs).  The bio must be initialized
   644	 * using bio_init() before use.  To free a bio returned from this function use
   645	 * kfree() after calling bio_uninit().  A bio returned from this function can
   646	 * be reused by calling bio_uninit() before calling bio_init() again.
   647	 *
   648	 * Note that unlike bio_alloc() or bio_alloc_bioset() allocations from this
   649	 * function are not backed by a mempool can fail.  Do not use this function
   650	 * for allocations in the file system I/O path.
   651	 *
   652	 * Returns: Pointer to new bio on success, NULL on failure.
   653	 */
   654	struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
   655	{
   656		struct bio *bio;
   657	
   658		if (nr_vecs > BIO_MAX_INLINE_VECS)
   659			return NULL;
 > 660		return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
   661	}
   662	EXPORT_SYMBOL(bio_kmalloc);
   663	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

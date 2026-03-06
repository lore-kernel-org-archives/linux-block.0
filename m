Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95CB3ED11E;
	Fri,  6 Mar 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812984; cv=none; b=ickUGgd7X6EvKrUJFo+ttOlN+ssB/9MdHNytTdy05BeiPGGZev2wGqqi4s4+e/+u+mZdn0G/94b+Tjvte9uHHtJCGjBKgLJRS0eSfwBbh6DlUMy5nWojkPKIyZ74Vk2Qzz8Pf4RIkQEKe3KggF9HTbrHkSJUVbSBlILLIznujnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812984; c=relaxed/simple;
	bh=fLs3E2bxvZzTGFJbAiGWh5iCk1fT6iMxDt9JTU7OHtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaKX6DioX4ybmv8eAmSVWLlaKIXJ/5LXieJ5JVxguwhMucrzAWvewXi0WPXAy2YdqmobWs3ICMgYtHpn5ZWPHrtNc7zQnPSWVwMYM8njCNk0Z0L7qafdrFLE8GdQqvRA+pJpIRdZC53DE+plb7AbRbPCxUIAUe44gcO9N/y8BEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5m4rJFi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5m4rJFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772812981; x=1804348981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLs3E2bxvZzTGFJbAiGWh5iCk1fT6iMxDt9JTU7OHtc=;
  b=h5m4rJFivyL/2zX4CPcGPKO7tCIBs8pjpgLyztNlKuXZRozhUhFvXJ0D
   TAEUu6Q4MsZhNGg1oQZfKv8Xgdf74xyfitPItRWnzF1v5+TuV/2LchIJU
   iGP5gnOagMWH50rOf9DvyrnSKHQDta5lhBoSpswpvNUVWFjVrWJUgTd6u
   WijMByBNvJ95MVxR74GLfSGxjhYve8RnPoZUwqfXDWg1MePqucD7toLkm
   ymp8YD8z3m1sTDUeCUqKGLr+u5YRVInvzWMxdShWS/YISbkbpCS8NwGbT
   2852WJ3k5CHIfieV0jpyKQQfwKdo4jMK6MT2vg0YGhTM+oqZ6DaDXAWYv
   w==;
X-CSE-ConnectionGUID: 0KeuuBJbQW24r65jSYUySQ==
X-CSE-MsgGUID: 8V4jblDHSFWzk5kzRUliGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84557730"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="84557730"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 08:03:00 -0800
X-CSE-ConnectionGUID: pKJNS7cGTQ+eKq/SsiHEEg==
X-CSE-MsgGUID: Qvdk7JBoQMKiePHkewjCEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="256973037"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 06 Mar 2026 08:02:58 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyXdf-000000002Gz-3OgN;
	Fri, 06 Mar 2026 16:02:55 +0000
Date: Fri, 6 Mar 2026 17:02:53 +0100
From: kernel test robot <lkp@intel.com>
To: luoqing <l1138897701@163.com>, axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
Message-ID: <202603061636.1njuAoiZ-lkp@intel.com>
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
[also build test ERROR on device-mapper-dm/for-next linus/master v7.0-rc2 next-20260305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/luoqing/dm-bufio-Use-struct_size-helper-in-kmalloc/20260306-165625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260306080056.1262324-1-l1138897701%40163.com
patch subject: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260306/202603061636.1njuAoiZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603061636.1njuAoiZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603061636.1njuAoiZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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
>> block/bio.c:660:34: error: no member named 'bio_vec' in 'struct bio'; did you mean 'bi_io_vec'?
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

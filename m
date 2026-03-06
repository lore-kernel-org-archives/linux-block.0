Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8722641FC;
	Fri,  6 Mar 2026 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824123; cv=none; b=Ci8L6AfKDvMc+7GCrjnVICgMbLFrV7IsQx4Q1wsikCjO6zd06pDUQst1opvHog/83zoBptMNJN4fyFBvZzaCZRYW6dl/jmsNZhkKLSIDKDgD+bzEe+Y5j6oEFrCPzC2aux6uPfNA9syA4J4boMonXq4ER7VQDPznQrdaS8ltHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824123; c=relaxed/simple;
	bh=ef6hFzUxVh7i6/XJUGmlO/PZAmpLYp45lR4Vp7jAp4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqhUoD3zD0JqML92oZjhhhBajI5CNim/aUiU6ZAWDRirHekvRs727od61isJq9AsSHKcVz0fOjUhGx79y5ZcpAC5lT66hcIi27kOqLPsSnfnTp59L+M+A8taFyz1WuWYkoiebGK0seqPxpukbh2bK0yYQvxT02rKIk+jE+JtlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZeLqDn0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZeLqDn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772824121; x=1804360121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ef6hFzUxVh7i6/XJUGmlO/PZAmpLYp45lR4Vp7jAp4s=;
  b=PZeLqDn0ofPHr24cX+548FlILrFLaxuMTZZn42V4r9ZCgsrSlpHrryAH
   XR4RYcmokPeqa29s88mwfZPZsTy0apd5zmAjaSDCLuUJjUubNwPd2eUUO
   bb06ABYepI++4+lAzcgrpx+jv7DRSmxqkpeXw/EMtdToXtGEoNYTXl+ct
   Vwn7MwmtKaheY5pi/K+8thla+6isPTr45onPI+V4jgHIeqee0I/CCw9++
   t9KHDDr1CELNunOimh2++SYlRSfdqQN8eHit1tRLweH2S/AUu/MxFFMxx
   +TWrgwNN5Ha9NW2cI6G5x6wm46uS0HGc5g0zQ6qINEK8Iw+0b1cG5eQ2U
   A==;
X-CSE-ConnectionGUID: Ig9Jh8bhS0y+F5mYzqV8bQ==
X-CSE-MsgGUID: DrWRtHRRTieBJ9xpNqYHVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84265954"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="84265954"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 11:08:41 -0800
X-CSE-ConnectionGUID: mjJzv60jSHyvMFoX7v3H0w==
X-CSE-MsgGUID: Qe7inai+RcmS90l6gHCxUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="215747403"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 11:08:38 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyaXM-000000001Hh-0nzs;
	Fri, 06 Mar 2026 19:08:36 +0000
Date: Sat, 7 Mar 2026 03:07:54 +0800
From: kernel test robot <lkp@intel.com>
To: luoqing <l1138897701@163.com>, axboe@kernel.dk
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
Message-ID: <202603070229.0LteZRkh-lkp@intel.com>
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
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260307/202603070229.0LteZRkh-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070229.0LteZRkh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070229.0LteZRkh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:19,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:8,
                    from block/bio.c:5:
   block/bio.c: In function 'bio_kmalloc':
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not an integer
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not an integer
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not an integer
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not an integer
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^
   include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:437:40: note: in expansion of macro 'flex_array_size'
     437 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not an integer
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^
   include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:420:50: note: in expansion of macro '__must_be_array'
     420 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
   block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
   block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                        ^~~~~~~~~~~
   block/bio.c:660:41: error: 'struct bio' has no member named 'bio_vec'; did you mean 'bi_io_vec'?
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                                         ^~~~~~~
   include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:956:49: note: in expansion of macro 'alloc_hooks'
     956 | #define kmalloc(...)                            alloc_hooks(kmalloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   block/bio.c:660:16: note: in expansion of macro 'kmalloc'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
         |                ^~~~~~~
   include/linux/compiler.h:208:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:207:35: note: in expansion of macro '__same_type'
     207 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:208:58: note: in expansion of macro '__is_array'
     208 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/overflow.h:421:56: note: in expansion of macro '__must_be_array'
     421 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:436:32: note: in expansion of macro 'flex_array_size'
     436 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   block/bio.c:660:24: note: in expansion of macro 'struct_size'
     660 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);


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

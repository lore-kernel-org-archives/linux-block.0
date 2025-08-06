Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF741C3027;
	Wed,  6 Aug 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473327; cv=none; b=PqBMqditraHHDL9RJK2cWXIonGZIWD771MGj0Pc58NAY/S1EmZJSYWyEf89BT5fdaqDtgOZW+2dpYYAnVioojd2FBKWKRIW+ddJKe/OhEZmDhmWBowK63IiA23sfpFbx4eTWeP67VfJVzzOx+9l5eriqP8G/2MIT4jeV13fL4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473327; c=relaxed/simple;
	bh=EP/2nbnxkVQbVU2omhh0DFzLJaZBfDQ/1aC8njt6IuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsM7DqMcbF7Kw3gIC0pKoU4XjcxErEMsP9EJgf6bP6qjLPPqT2jCkf5v45jZtcSkJXloCySyfTM1XD7hjWFfwXSG/RodRRruHfpsNyNoEhQpoJsKyEBo3rAiFjsQ9iYmxgmC+rvp7yoSpWAbf2M42D4IDG3dw5cxvTrgvHg0FaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcWPGh9A; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcWPGh9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754473326; x=1786009326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EP/2nbnxkVQbVU2omhh0DFzLJaZBfDQ/1aC8njt6IuQ=;
  b=BcWPGh9ARFEAeZeavTj65ZAkE0EaijhtDQbjuI1N1Yc3BlcAY8zn9yTR
   zHluwMNGsHoFbmGzNrKHUytOZXVi2Jz56K49+LJ99jM5ldlhm09N8+jDa
   SNW3rXXk/jwmNUVkD54fIStuWcBWM32VgzyBmlJ4Fp6ZsKY9LB/9WsSas
   7RZ2oVit8K+xnZ7aLOQT3HwZ8nyLF93IqUolJl6T05J2yVw559uH8SN3r
   VUAs1e6lVxl+rRYJwWFNC3plHNpr7ogn7Ps/mZ6jPdJYtxrj91KRVfl19
   /7Zo8PSBYmnxr0ROH99LlQC6K8jz6I1TUvlW5WQDCd9T3boofJSl8ku0p
   g==;
X-CSE-ConnectionGUID: aQZ0uHwrSZmZBB3n5zSgtQ==
X-CSE-MsgGUID: f6M9eK/8QQGfxBH4iS/yWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="67862281"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67862281"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 02:42:05 -0700
X-CSE-ConnectionGUID: wqJnxfUNR3e2Nnv3NYwAZg==
X-CSE-MsgGUID: nHxQ1/O0TCac0jLf/m1d5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170003161"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 06 Aug 2025 02:42:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujaed-0001U6-0p;
	Wed, 06 Aug 2025 09:41:58 +0000
Date: Wed, 6 Aug 2025 17:41:44 +0800
From: kernel test robot <lkp@intel.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
	akpm@linux-foundation.org, ming.lei@redhat.com, dlemoal@kernel.org,
	jack@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v3 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
Message-ID: <202508061722.0vTVFHLe-lkp@intel.com>
References: <20250805073748.606294-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805073748.606294-2-yukuai1@huaweicloud.com>

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/lib-sbitmap-convert-shallow_depth-from-one-word-to-the-whole-sbitmap/20250806-100430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250805073748.606294-2-yukuai1%40huaweicloud.com
patch subject: [PATCH v3 1/2] lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
config: sparc-randconfig-001-20250806 (https://download.01.org/0day-ci/archive/20250806/202508061722.0vTVFHLe-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508061722.0vTVFHLe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508061722.0vTVFHLe-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from ./arch/sparc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from arch/sparc/include/asm/smp_32.h:15,
                    from arch/sparc/include/asm/smp.h:7,
                    from arch/sparc/include/asm/switch_to_32.h:5,
                    from arch/sparc/include/asm/switch_to.h:7,
                    from arch/sparc/include/asm/ptrace.h:120,
                    from arch/sparc/include/asm/thread_info_32.h:19,
                    from arch/sparc/include/asm/thread_info.h:7,
                    from include/linux/thread_info.h:60,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from lib/sbitmap.c:7:
   lib/sbitmap.c: In function '__map_depth_with_shallow':
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   lib/sbitmap.c:222:20: note: in expansion of macro 'do_div'
     222 |         reminder = do_div(shallow_word_depth, sb->depth);
         |                    ^~~~~~
   In file included from arch/sparc/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from lib/sbitmap.c:7:
>> include/asm-generic/div64.h:195:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     195 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   lib/sbitmap.c:222:20: note: in expansion of macro 'do_div'
     222 |         reminder = do_div(shallow_word_depth, sb->depth);
         |                    ^~~~~~
   In file included from ./arch/sparc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from arch/sparc/include/asm/smp_32.h:15,
                    from arch/sparc/include/asm/smp.h:7,
                    from arch/sparc/include/asm/switch_to_32.h:5,
                    from arch/sparc/include/asm/switch_to.h:7,
                    from arch/sparc/include/asm/ptrace.h:120,
                    from arch/sparc/include/asm/thread_info_32.h:19,
                    from arch/sparc/include/asm/thread_info.h:7,
                    from include/linux/thread_info.h:60,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from lib/sbitmap.c:7:
>> include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
     199 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    unsigned int *
   lib/sbitmap.c:222:20: note: in expansion of macro 'do_div'
     222 |         reminder = do_div(shallow_word_depth, sb->depth);
         |                    ^~~~~~
   include/asm-generic/div64.h:174:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'unsigned int *'
     174 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~
   cc1: some warnings being treated as errors


vim +/__div64_32 +199 include/asm-generic/div64.h

^1da177e4c3f415 Linus Torvalds     2005-04-16  176  
^1da177e4c3f415 Linus Torvalds     2005-04-16  177  /* The unnecessary pointer compare is there
^1da177e4c3f415 Linus Torvalds     2005-04-16  178   * to check for type safety (n must be 64bit)
^1da177e4c3f415 Linus Torvalds     2005-04-16  179   */
^1da177e4c3f415 Linus Torvalds     2005-04-16  180  # define do_div(n,base) ({				\
^1da177e4c3f415 Linus Torvalds     2005-04-16  181  	uint32_t __base = (base);			\
^1da177e4c3f415 Linus Torvalds     2005-04-16  182  	uint32_t __rem;					\
^1da177e4c3f415 Linus Torvalds     2005-04-16  183  	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
911918aa7ef6f86 Nicolas Pitre      2015-11-02  184  	if (__builtin_constant_p(__base) &&		\
911918aa7ef6f86 Nicolas Pitre      2015-11-02  185  	    is_power_of_2(__base)) {			\
911918aa7ef6f86 Nicolas Pitre      2015-11-02  186  		__rem = (n) & (__base - 1);		\
911918aa7ef6f86 Nicolas Pitre      2015-11-02  187  		(n) >>= ilog2(__base);			\
c747ce4706190ef Geert Uytterhoeven 2021-08-11  188  	} else if (__builtin_constant_p(__base) &&	\
461a5e51060c93f Nicolas Pitre      2015-10-30  189  		   __base != 0) {			\
461a5e51060c93f Nicolas Pitre      2015-10-30  190  		uint32_t __res_lo, __n_lo = (n);	\
461a5e51060c93f Nicolas Pitre      2015-10-30  191  		(n) = __div64_const32(n, __base);	\
461a5e51060c93f Nicolas Pitre      2015-10-30  192  		/* the remainder can be computed with 32-bit regs */ \
461a5e51060c93f Nicolas Pitre      2015-10-30  193  		__res_lo = (n);				\
461a5e51060c93f Nicolas Pitre      2015-10-30  194  		__rem = __n_lo - __res_lo * __base;	\
911918aa7ef6f86 Nicolas Pitre      2015-11-02 @195  	} else if (likely(((n) >> 32) == 0)) {		\
^1da177e4c3f415 Linus Torvalds     2005-04-16  196  		__rem = (uint32_t)(n) % __base;		\
^1da177e4c3f415 Linus Torvalds     2005-04-16  197  		(n) = (uint32_t)(n) / __base;		\
c747ce4706190ef Geert Uytterhoeven 2021-08-11  198  	} else {					\
^1da177e4c3f415 Linus Torvalds     2005-04-16 @199  		__rem = __div64_32(&(n), __base);	\
c747ce4706190ef Geert Uytterhoeven 2021-08-11  200  	}						\
^1da177e4c3f415 Linus Torvalds     2005-04-16  201  	__rem;						\
^1da177e4c3f415 Linus Torvalds     2005-04-16  202   })
^1da177e4c3f415 Linus Torvalds     2005-04-16  203  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832811C6F61;
	Tue,  1 Oct 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793269; cv=none; b=KTYUFCv5RRlNo2QHwex2XhFYXJ53tY7Uuh4ajM/ACbDj1yHoVvfoCmnHvRv/exEKNYlvZrssDfcMLaJ0jMKqZBnozI7X3KhnNQVWCIV4X/fjJjeOL5ARhuhnFtfMiG1+uHsuX+JOvzhtlPIUpUUi53I52RAIPl/iQ/K723QbjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793269; c=relaxed/simple;
	bh=MJJbugmM7odwoRbXpKB1hsqqSBdhArseeVwNZ793jek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw7gA5M7A68s/6SHAJNl4BEVBZ6N3/lB7kRN1fKIXx2bEh1RZIyYBu+d5ZCCioHRvZYSd6udObCM5E+3e/ohdkMTMEhtKtWOupla32PWt5lHbHyEZqyVzR0CgdsyA+Htht1wq1IXDqxfvZXgF1M8PZNpGjHVDkA8IB9eqStTrKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLe3oRNz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLe3oRNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727793267; x=1759329267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MJJbugmM7odwoRbXpKB1hsqqSBdhArseeVwNZ793jek=;
  b=KLe3oRNzuFPj3ibEJJxp25cwVNcXaqcb199SGi1qGt6gZtfXghXHvBMa
   RuuW33yFGrcEtMngy5EeYdNek56aFKIMY11mMhEHZLGLY6w2uqaRmAl3N
   sknMi8PgIiXMY4AL9b1C0TUaUYlgiGfykzlFILY4BPiy9DvL+knVy6Euf
   CeMJq4Nd1AdmhBVTA7tV6tMC6lr7isLIMBONVnSqECZjFahhVsQBKfZmm
   QvXIdK3P7k/ojmxn+Q4y+U2eUTaDIl6u4y3HZR2YuBsRlD731mRsoy5D/
   ntoa0231Q98Q7EPLaffHYF/YcyTyk3GfRpOC13vX/vJ2hWuVMWdXuzSp0
   g==;
X-CSE-ConnectionGUID: ZGwKFmycRbCU+PG1Sa1wyg==
X-CSE-MsgGUID: WwXdaCDgTc6maVo+UIoZzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="49453565"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="49453565"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 07:34:26 -0700
X-CSE-ConnectionGUID: IfogJOA3T2SDDvZ2ZGNcTA==
X-CSE-MsgGUID: AqoDEJpFQFauxKQ5jPkGDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78439207"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2024 07:34:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svdxC-000Qmb-0m;
	Tue, 01 Oct 2024 14:34:18 +0000
Date: Tue, 1 Oct 2024 22:33:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 3/5] string: add strends() helper to check if a string
 ends with a suffix
Message-ID: <202410012202.g0GogVZR-lkp@intel.com>
References: <20240930113045.28616-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930113045.28616-4-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on kees/for-next/hardening robh/for-next lwn/docs-next linus/master v6.12-rc1 next-20241001]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/block-add-support-for-defining-read-only-partitions/20240930-193609
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240930113045.28616-4-ansuelsmth%40gmail.com
patch subject: [PATCH v4 3/5] string: add strends() helper to check if a string ends with a suffix
config: s390-randconfig-001-20241001 (https://download.01.org/0day-ci/archive/20241001/202410012202.g0GogVZR-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410012202.g0GogVZR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410012202.g0GogVZR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/purgatory/../lib/string.c:16,
                    from arch/s390/purgatory/string.c:3:
   include/linux/string.h: In function 'strends':
>> include/linux/string.h:366:27: error: implicit declaration of function 'memcmp' [-Wimplicit-function-declaration]
     366 |         return n >= m && !memcmp(str + n - m, suffix, m);
         |                           ^~~~~~
   include/linux/string.h:65:1: note: 'memcmp' is defined in header '<string.h>'; this is probably fixable by adding '#include <string.h>'
      64 | #include <asm/string.h>
     +++ |+#include <string.h>
      65 | 


vim +/memcmp +366 include/linux/string.h

   355	
   356	/**
   357	 * strends - does @str end with @suffix?
   358	 * @str: string to examine
   359	 * @suffix: suffix to look for.
   360	 */
   361	static inline bool strends(const char *str, const char *suffix)
   362	{
   363		size_t n = strlen(str);
   364		size_t m = strlen(suffix);
   365	
 > 366		return n >= m && !memcmp(str + n - m, suffix, m);
   367	}
   368	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

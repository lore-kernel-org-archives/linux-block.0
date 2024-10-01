Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14B199FCE;
	Tue,  1 Oct 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819296; cv=none; b=VeQoCbVshKH+fTwTsmA+rdS+bGdGWkc3j5Kt20iT0Uz9vZ8lW5Kv5H+fGEdsn+mHKvHo9nPQ3/V0osP1yEZ1M9mtQbrcqN+CJcOf0Rdu4qlt4nai2YR0Ih/PEocTTC/FPBKsCTT00XOKsTf+I5ZzWaE1u0P7oT60XTFWADYw+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819296; c=relaxed/simple;
	bh=mMUExZQ+EvnU7XLWDsD1aa5LRPKUL7dBR3emnkPwhDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppNZFCZkp+762i44xosNGmfoFWq1LFp5QZ4cW89xxsH3B0ZKY/dwa4+ODHciDDX+fNmu/EwemvJuiPLQlLL6RLQIqyH7MIw7veccN/HPxZDHIir3HmdmvSjh7dwTHaV28tLTfdQx+P2yN7cdtcA1k4aKibGlMwEfu1J62+Rf8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9weqt/R; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9weqt/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727819295; x=1759355295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mMUExZQ+EvnU7XLWDsD1aa5LRPKUL7dBR3emnkPwhDE=;
  b=l9weqt/Rl7Fr/uirgRGXXlURxJQQ8lvryO5rAlFhc+o9PGyFzHIQRLOr
   jJZtnIifLnmXw6KPgt4PMCHrZszc28xWDWriURGlqcWv5G8fSZSjuUaIE
   ghzrj2oGV0fgSTHsshg4hyEZfty8OuLQlcbTbERrHHdTeffTP9URvrOdC
   gLrrScYBMMq0Gbr6G6eMLUA2IQeemHRwMNGGhaMF3f4f7zMfK3wQoShmk
   mwjDJLIE55xin1wIeSK+CKs6upOz3ze/s950QQntG9kTzpwLiX5N9PYwK
   zgw29M5fogThr+dLhMfRgxwHmECDe6bBc9ESinzIowpZoigDSFjjSqKjl
   A==;
X-CSE-ConnectionGUID: 7MdkgM5qSv6XBwVBhQOmqA==
X-CSE-MsgGUID: HtHeXpiWSFa7DMe620vrUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37536479"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="37536479"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 14:48:14 -0700
X-CSE-ConnectionGUID: y2fAfsQlTzuDYDQiHGjUJA==
X-CSE-MsgGUID: Zj22m4xJSb+txgUc2smUsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78671028"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 14:48:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svkiz-000RDN-23;
	Tue, 01 Oct 2024 21:48:05 +0000
Date: Wed, 2 Oct 2024 05:47:11 +0800
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
Message-ID: <202410020546.DL6BnsOs-lkp@intel.com>
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
config: s390-randconfig-r061-20241001 (https://download.01.org/0day-ci/archive/20241002/202410020546.DL6BnsOs-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020546.DL6BnsOs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020546.DL6BnsOs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/purgatory/string.c:3:
   In file included from arch/s390/purgatory/../lib/string.c:16:
>> include/linux/string.h:366:20: error: call to undeclared function 'memcmp'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     366 |         return n >= m && !memcmp(str + n - m, suffix, m);
         |                           ^
   1 error generated.


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

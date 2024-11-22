Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D417E0E8;
	Fri, 22 Nov 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287586; cv=none; b=Hgy8+hC6D7FpXR/IIzlK5ncw5lPSCdooS1m06XVDqAZnpGGs7ZTQkNaTzY/54CEXXrpnODRNHfA8+9G0/QyP0X1q8f+enK/p/dcaXhgOqozxGPNHWaY1asJKIhbBKuwE1Z627Kbnjm2GuzolEKA3A9BogOdLZfbIxL14daA32R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287586; c=relaxed/simple;
	bh=6MRxe1RXEDQmx20zfZHiNg5vIxEzoVzg9DTQQkLwMwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZPoxNSvQRXmZp2FO7iG451MLWtzvok4AuH60/lqZzQ+zIlkuUt1ryUdWjGbGc0YgDi00Qr7KKHyZt4HY4RDBZ2VrXwQz9RfKP8/wb/92lUTqxoz5g0t7VpHRtBeDrD613hoRW4Dfiq+aWy0r7a97JVyOKcBXbUNswY6BYS9WUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iq4pTcV4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iq4pTcV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732287583; x=1763823583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6MRxe1RXEDQmx20zfZHiNg5vIxEzoVzg9DTQQkLwMwQ=;
  b=iq4pTcV41AvelFtOi1xGb6FrADFOjSYNgcoyNx+4MmKI5B3puMvhtbSC
   uMFU3nYH45lRSDuz+0AFAatZq2csyLMdu/91DKYw1p0EoiOhNcc7zbO1F
   InJtDNQP09HvQJNbUEALnz6y4kmzy7IkMHX1VFIqguN85m/X9kX7ckQTF
   Z2N0m4nDqfXKV1xdeIdUyi7SeFLiSGtEO23CyaJj77rnyA3bv7LGrPun1
   nN1jBjFO+dwamrAsQFGB+JZhS6fWDiQuudiVboE2F4UsNyQgr+HaI7c6Y
   0a6kNy45VFVfYJsaq19jYQilB7+lC8NKDgJHbRxCC6CGV0rb7r1HhPC/K
   A==;
X-CSE-ConnectionGUID: RieVGhNNRkKNf/hjBYIFVA==
X-CSE-MsgGUID: R9qfe71tT/G/5RO2zCMdPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="31803405"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="31803405"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 06:59:42 -0800
X-CSE-ConnectionGUID: Rt7U4HtIScq5aIGdJQR3+w==
X-CSE-MsgGUID: KWjV/QnAQQSeiNIrWyHyKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95544424"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Nov 2024 06:59:40 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEV8D-0003zz-11;
	Fri, 22 Nov 2024 14:59:37 +0000
Date: Fri, 22 Nov 2024 22:59:25 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Romanov <avromanov@salutedevices.com>, minchan@kernel.org,
	senozhatsky@chromium.org, axboe@kernel.dk, terrelln@fb.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel@salutedevices.com,
	Alexey Romanov <avromanov@salutedevices.com>
Subject: Re: [PATCH v1 3/3] zram: introduce crypto-api backend
Message-ID: <202411222217.SkVD8y1f-lkp@intel.com>
References: <20241119122713.3294173-4-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119122713.3294173-4-avromanov@salutedevices.com>

Hi Alexey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.12 next-20241122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Romanov/zram-pass-zcomp-instead-of-zcomp_params-to-create_context-method/20241121-135511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241119122713.3294173-4-avromanov%40salutedevices.com
patch subject: [PATCH v1 3/3] zram: introduce crypto-api backend
config: x86_64-randconfig-012-20241122 (https://download.01.org/0day-ci/archive/20241122/202411222217.SkVD8y1f-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411222217.SkVD8y1f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411222217.SkVD8y1f-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/zram/zcomp.c:233:12: warning: 'init_crypto_api_backends' defined but not used [-Wunused-function]
     233 | static int init_crypto_api_backends(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/init_crypto_api_backends +233 drivers/block/zram/zcomp.c

   232	
 > 233	static int init_crypto_api_backends(void)
   234	{
   235		struct crypto_alg *alg;
   236		struct zcomp_ops *ops;
   237	
   238		list_for_each_entry(alg, &crypto_alg_list, cra_list) {
   239			if (!crypto_has_comp(alg->cra_name, 0, 0))
   240				continue;
   241	
   242			if (backend_enabled(alg->cra_name))
   243				continue;
   244	
   245			ops = get_backend_crypto_api(alg->cra_name);
   246			if (IS_ERR_OR_NULL(ops))
   247				return PTR_ERR(ops);
   248	
   249			list_add(&ops->list, &backends);
   250		}
   251	
   252		return 0;
   253	}
   254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

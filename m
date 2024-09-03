Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE74210186;
	Tue,  3 Sep 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352495; cv=none; b=B6FOek62X6TI7me1kKmAGPFv3sv4Jv0Zx7uiLzmz8+zx0SH1aPHjS683/Vx6wvPDwVJrTsAmcPe2ZxHph3r26l4tqsGjHoDrxHcMF99zd9/GuEqtSfYcgxfO3Iv2EUDyVrvRne2uHDOOHl1B6V6qMY1CWqgNlzVCvk3qj7FDSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352495; c=relaxed/simple;
	bh=93ogvXYCPWXi4B+wZugd1x2KMKT6reNeZI7rhPacqVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wneu36+tObTCdZR175Pj50neQl71C+uc+Y2x4dQJzHfVBoU8fwD0QnZikodDwWwBcT5e+gVZCcDO6sK8IzbeO8YA0Yp5oxRM1fMO9hx4rJHkci3pSJqQ9wpuLtDgQNvxPHIu3jC0Xv2jDIi7BfsKw15yacbtlw4TzVUHAQRgsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGYOwN9/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGYOwN9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725352493; x=1756888493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=93ogvXYCPWXi4B+wZugd1x2KMKT6reNeZI7rhPacqVM=;
  b=HGYOwN9/eOTzzLcsUUDOcSrRx3p/b959HZPYiiXdVI+fbD4IyYHyPcHS
   pAnOsVfmW0T2rsP082EHDpzJLKIJESuR+/rCdHYIJV2dIYAu/MEaPo9LK
   uuAJWpW9PvQ5rg3/I5WMCGx71aIsc7xmAyy0e4bqLsRmm5H0QXYJdAKkS
   qn1KC8ciDyrEsolAjFIxZUFjvoAz4Q955Krum+Tlw2TLKO6uaUsL5Xvv8
   Oef7prnrrdzEX/NAMsyx0rnaQkvQyuxFwvzcSvuVelorVS5zO+abWnfqo
   L7bJr591phr0D2oDcFug3bEogu20sYvh18udkr9OZUFwSWzjQcn0EoyAh
   A==;
X-CSE-ConnectionGUID: yNTH1vrWTayT7+sN1BhAqQ==
X-CSE-MsgGUID: dI8nZm1ERQKjrzMTBi252Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24092371"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24092371"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 01:34:52 -0700
X-CSE-ConnectionGUID: gL+DaA9yS3q7sZACReu1/g==
X-CSE-MsgGUID: obJYgvG7Tz2JxAbOjV1zYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="102274617"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Sep 2024 01:34:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slOzw-0006Pm-2f;
	Tue, 03 Sep 2024 08:34:48 +0000
Date: Tue, 3 Sep 2024 16:33:52 +0800
From: kernel test robot <lkp@intel.com>
To: ZhangHui <zhanghui31@xiaomi.com>, axboe@kernel.dk
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhanghui31@xiaomi.com
Subject: Re: [PATCH] block: move non sync requests complete flow to softirq
Message-ID: <202409031507.wUCw4k8n-lkp@intel.com>
References: <20240902064409.25637-1-zhanghui31@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902064409.25637-1-zhanghui31@xiaomi.com>

Hi ZhangHui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.11-rc6 next-20240902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ZhangHui/block-move-non-sync-requests-complete-flow-to-softirq/20240902-144744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240902064409.25637-1-zhanghui31%40xiaomi.com
patch subject: [PATCH] block: move non sync requests complete flow to softirq
config: x86_64-randconfig-122-20240903 (https://download.01.org/0day-ci/archive/20240903/202409031507.wUCw4k8n-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240903/202409031507.wUCw4k8n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409031507.wUCw4k8n-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> block/blk-mq.c:1196:45: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted blk_opf_t const [usertype] is_sync @@     got bool @@
   block/blk-mq.c:1196:45: sparse:     expected restricted blk_opf_t const [usertype] is_sync
   block/blk-mq.c:1196:45: sparse:     got bool
   block/blk-mq.c: note: in included file (through include/linux/module.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +1196 block/blk-mq.c

  1193	
  1194	bool blk_mq_complete_request_remote(struct request *rq)
  1195	{
> 1196		const blk_opf_t is_sync = op_is_sync(rq->cmd_flags);
  1197	
  1198		WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
  1199	
  1200		/*
  1201		 * For request which hctx has only one ctx mapping,
  1202		 * or a polled request, always complete locally,
  1203		 * it's pointless to redirect the completion.
  1204		 */
  1205		if ((rq->mq_hctx->nr_ctx == 1 &&
  1206		     rq->mq_ctx->cpu == raw_smp_processor_id()) ||
  1207		     rq->cmd_flags & REQ_POLLED)
  1208			return false;
  1209	
  1210		if (blk_mq_complete_need_ipi(rq)) {
  1211			blk_mq_complete_send_ipi(rq);
  1212			return true;
  1213		}
  1214	
  1215		if ((rq->q->nr_hw_queues == 1) || !is_sync) {
  1216			blk_mq_raise_softirq(rq);
  1217			return true;
  1218		}
  1219		return false;
  1220	}
  1221	EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
  1222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

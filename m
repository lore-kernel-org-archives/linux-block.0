Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51457C4332F
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 15:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJ3P2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJ3P2A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 11:28:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC5A9;
        Mon, 30 Oct 2023 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698679678; x=1730215678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6T6UPqWYgJB+UcA/dxsApCw6zxraf4JHxXI0YyflEQE=;
  b=eG76oflJ19ojEmWp+IbOF49SCcs1U1d6hCvWi4Ws77KPbJhOE9oAqa2C
   6FVDV8SJiV/ffEK7HjiFp1PoVBmqI7PFK69cDcNBsYZhPixaHiyc2e+BG
   brx9sKXFT6LAX69sWgf/frkCIVvtQ9FF21ylcTPFATKvA8DDb+kkFaeL9
   pLIxX/p/ZjsZ6dxeYp2Xb4vniZnTc9kT8U3l2diue9+26U7dxNgkivc4f
   XnvGI096KP2XLN9SVZblJ0pGc973Nqjgs2ImOxH1SzcKMIsOLwFduvkh9
   ZsQ7VFnX56y5e53JbiBQXeVghMOPJV5znto5Bg+CGxyoT166EEbUhh0wb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="373139870"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373139870"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760301000"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="760301000"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2023 08:27:55 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxUBE-000DMR-2c;
        Mon, 30 Oct 2023 15:27:53 +0000
Date:   Mon, 30 Oct 2023 23:27:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, axboe@kernel.dk, hch@lst.de,
        joshi.k@samsung.com, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <202310302318.pPweFNME-lkp@intel.com>
References: <20231027181929.2589937-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181929.2589937-2-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/block-bio-integrity-directly-map-user-buffers/20231028-022107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20231027181929.2589937-2-kbusch%40meta.com
patch subject: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20231030/202310302318.pPweFNME-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310302318.pPweFNME-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310302318.pPweFNME-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/blkdev.h:17,
                    from lib/vsprintf.c:47:
   include/linux/bio.h: In function 'bio_integrity_map_user':
>> include/linux/bio.h:799:1: error: expected ';' before '}' token
     799 | }
         | ^
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1682:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1682 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +799 include/linux/bio.h

   794	
   795	static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
   796						 unsigned int len, u32 seed)
   797	{
   798		return -EINVAL
 > 799	}
   800	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

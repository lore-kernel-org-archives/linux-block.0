Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E654C761A6
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 19:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjC3TXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjC3TXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 15:23:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C33CA1C
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680204189; x=1711740189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+En+FPxNTvoULOGa+u0T1QqJO9VImC93u8e+kPzfxo=;
  b=PkE61N6SipJPPInNDM8Q54s0rtlaLBtMltHZ6O8qbCyH7AmDEYXvuoB7
   UJdHR0AmPKTPzen/jBW22VhuGQWO5S6G3SuQeygxTqR+kB5Sq3KLoWrcH
   wl6Bv/KPr8iIzK4j1GSE2Z/ubmI+jdZ4v4aB/V4qn11xDHu9PT3OpfRtz
   a+uCZ8wVkpeP2CmlM66pT26gj/UfQm/5wO3uIvYHGnhvEVeZgAMtzX45G
   nJ8IUqg2fFSy9C3gc+fwM5q8OT/O+hAAfGqtxG/nWNZnKrBxH8cq5qQbZ
   28cBG/mq2ifMGIEKd7tAkdkFBtk6blmKe2SaJWA6jo3FzCQ7Jay+pyHos
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="329788630"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="329788630"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 12:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="687376956"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="687376956"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2023 12:23:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phxrW-000L8k-1n;
        Thu, 30 Mar 2023 19:23:06 +0000
Date:   Fri, 31 Mar 2023 03:22:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alyssa Ross <hi@alyssa.is>, chaitanyak@nvidia.com,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     oe-kbuild-all@lists.linux.dev, axboe@kernel.dk, hch@lst.de,
        hi@alyssa.is, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] loop/009: add test for loop partition uvents
Message-ID: <202303310316.QS2vADHM-lkp@intel.com>
References: <20230330160247.16030-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160247.16030-1-hi@alyssa.is>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alyssa,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alyssa-Ross/loop-009-add-test-for-loop-partition-uvents/20230331-001157
patch link:    https://lore.kernel.org/r/20230330160247.16030-1-hi%40alyssa.is
patch subject: [PATCH blktests] loop/009: add test for loop partition uvents
reproduce:
        scripts/spdxcheck.py

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310316.QS2vADHM-lkp@intel.com/

spdxcheck warnings: (new ones prefixed by >>)
>> tests/loop/009: 2:27 Invalid License ID: GPL-3.0+

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

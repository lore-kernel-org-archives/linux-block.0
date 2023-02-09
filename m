Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8DC61DA4
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 16:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBIQW7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBIQW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 11:22:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC05CBD0
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 08:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675959772; x=1707495772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hb8iCDJ0aTsCVjjHlP2Amw1KTUPvms2VDEUedaLEWbc=;
  b=ljfhkeRyG2enivEddBfcallpApAf+2U37OTcJa9xXqWmhKTSOYdt4X5r
   +l1caRj3qmHpTK2hBkVzzGn3pccjMcAY7VRKgzr+5dzzM3BClUm/aig9k
   RH58vISsBuRRjPGyf6HaISn0Apz+pRkp/DU2J6dTGGzEZHka2N/auY4mh
   fLy8n3GTBwP9HmMMbVPVuje/hz6q01c/+9Iu0sM83P0LZ5GYKju8dd8ec
   c9aYA01PU/mdqO8wmWHzbY69wz9aBo96Q+vxCWXLE1S2BC6aOukrb8wWy
   /lpaKLhHnWCF4OQ+0CNLkbivzqrn0Jx7b/K0KV0TU7h8ApJCaHYabM1M7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331453822"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="331453822"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:22:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="731374997"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="731374997"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2023 08:22:49 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQ9hA-0005Ag-0y;
        Thu, 09 Feb 2023 16:22:48 +0000
Date:   Fri, 10 Feb 2023 00:22:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kanchan Joshi <joshi.k@samsung.com>, shinichiro.kawasaki@wdc.com
Cc:     oe-kbuild-all@lists.linux.dev, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH blktests] nvme/046: add test for unprivileged passthrough
Message-ID: <202302100053.tumPI2Xy-lkp@intel.com>
References: <20230209094541.248729-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209094541.248729-1-joshi.k@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Kanchan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hch-configfs/for-next]
[also build test WARNING on linus/master v6.2-rc7 next-20230209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/nvme-046-add-test-for-unprivileged-passthrough/20230209-174831
base:   git://git.infradead.org/users/hch/configfs.git for-next
patch link:    https://lore.kernel.org/r/20230209094541.248729-1-joshi.k%40samsung.com
patch subject: [PATCH blktests] nvme/046: add test for unprivileged passthrough
reproduce:
        scripts/spdxcheck.py

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302100053.tumPI2Xy-lkp@intel.com/

spdxcheck warnings: (new ones prefixed by >>)
   drivers/cpufreq/amd-pstate-ut.c: 1:28 Invalid License ID: GPL-1.0-or-later
>> tests/nvme/046: 2:27 Invalid License ID: GPL-3.0+

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

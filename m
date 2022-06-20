Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED31C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 20:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiFTU3B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 16:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFTU3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 16:29:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5880E18377
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655756940; x=1687292940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uuDK9vO1SgjIAiA0aRUpe6EVAjPMgf+eFydy1mpDeGM=;
  b=NjHVDFUidtyC5zsOX7VwRsqoGp2/MRFoCIgXDL9OtwLDzPkTvPZrnkgj
   g+Hruxwzw3ckWRNhx2OjYMQxT6dMfdsc6/ajNyUNusH7udipmmfoyGFC+
   HKNne74rBqhA3meIoSzh0IGOPNCkFHkf87+ZXqoWJZ9NBqKIDUHLaWQG3
   J+Sjk0iVamuhkwiwC8hAosV3uX1GlUbZBhcySjiKx4ubCOKUSyuVnZlHn
   i1RmCj8kEbE7850xMMpBMxX4SlbbXdnZaWg5q7F5JnLi60+Nhi9DChNEB
   AymfOFGyhntImSD7mYfDXQcnJuGQEfQbSqBDJIKwM/iS87B9aYMMliBKH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263002714"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="263002714"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 13:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="764212528"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2022 13:28:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3O13-000VxM-Bz;
        Mon, 20 Jun 2022 20:28:57 +0000
Date:   Tue, 21 Jun 2022 04:28:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/8] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Message-ID: <202206210442.Th4HzcuP-lkp@intel.com>
References: <20220620161153.11741-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620161153.11741-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/block-Fix-IO-priority-mess/20220621-001427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: x86_64-randconfig-a003-20220620 (https://download.01.org/0day-ci/archive/20220621/202206210442.Th4HzcuP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/73f39284cec50db7a3e973a9a4ed56f7f706dd1b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/block-Fix-IO-priority-mess/20220621-001427
        git checkout 73f39284cec50db7a3e973a9a4ed56f7f706dd1b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `get_current_ioprio':
>> include/linux/ioprio.h:53: undefined reference to `__get_task_ioprio'
>> ld: include/linux/ioprio.h:53: undefined reference to `__get_task_ioprio'
>> ld: include/linux/ioprio.h:53: undefined reference to `__get_task_ioprio'
>> ld: include/linux/ioprio.h:53: undefined reference to `__get_task_ioprio'
>> ld: include/linux/ioprio.h:53: undefined reference to `__get_task_ioprio'


vim +53 include/linux/ioprio.h

    50	
    51	static inline int get_current_ioprio(void)
    52	{
  > 53		return __get_task_ioprio(current);
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

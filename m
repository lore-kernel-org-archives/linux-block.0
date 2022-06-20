Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FF6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 21:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiFTVuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 17:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbiFTVuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 17:50:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226419F86
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655761809; x=1687297809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=76yWOCnmaKg28UmMxEHE7Dh1YumlYva2+NORg8cz358=;
  b=KR23tAJgmC4zNXQP0kmZUaqSMOpzDaZvF7jUesI/gRNu1x0UysjeQrN1
   5l0N7RyUBd7llkBzwRIXH8R5z5G06xPZWRrGdeILxS6oI1RMI9ObrB/mc
   c5RqWe8k7jH+kdDap6KwCNEdX1TGde5hHc1nByN5E+Do95xbVxBxag7Ii
   Qm3HUPOu4++N4LUGQyIDdv/aa48auESWbAoxgaPUREzVvYySQTrykgodT
   SGBjSy3p3H6N7Ug2ocKBPOt8SHfbBiy3i7tTcuG0Btbq9UnlQHmx1XvPP
   /TTb8cPtkPcz7Xj2AZ7yHj1jgxDR5rz1Ffv82iSnRm5CMm/4INvc+ZM1A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="268698173"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="268698173"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 14:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="584847401"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2022 14:50:06 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3PHa-000Wab-1y;
        Mon, 20 Jun 2022 21:50:06 +0000
Date:   Tue, 21 Jun 2022 05:49:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/8] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Message-ID: <202206210522.eVU8S1DL-lkp@intel.com>
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
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20220621/202206210522.eVU8S1DL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/73f39284cec50db7a3e973a9a4ed56f7f706dd1b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/block-Fix-IO-priority-mess/20220621-001427
        git checkout 73f39284cec50db7a3e973a9a4ed56f7f706dd1b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: fs/read_write.o: in function `.L10':
   read_write.c:(.text+0x80): undefined reference to `__get_task_ioprio'
   riscv64-linux-ld: fs/seq_file.o: in function `seq_read':
>> seq_file.c:(.text+0x458): undefined reference to `__get_task_ioprio'
   riscv64-linux-ld: fs/splice.o: in function `.L171':
>> splice.c:(.text+0x8c6): undefined reference to `__get_task_ioprio'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

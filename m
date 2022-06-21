Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2A1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 00:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbiFUAMU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiFUAMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 20:12:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB963E8
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655770339; x=1687306339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3LGjYJET3QsD34Iv5RQ8gArWSNbMQJ3af6CDxOHbJLk=;
  b=BEqEwGrniFemITcZTcOLYb7FIDKMgviym8Um758mvD0XBrkfFPPl69Pp
   ewKXCBVYGBaCtLPmRL9DL/3sEo/0okMVXJp2EfuoAIXd3us+Qd8iJQAHs
   w6ct7BgjYofA/cWCJF2AbMwuzyuHgGSrkpgGUANgLdG0nmqnq6z4KowXs
   c5fNLE0NCMMCIQC0jhhL80YYwHHUxVcZQSGT9BOomsBgiNK8kjU5nCveU
   d4ypf8DOg36kLSXjQC8CutvGTAw3yvTalyka0dGTaMrDxaqdUkWLhr8eW
   E8iKHlsQ/3Qjx0owBLSRI/UoFMMDq1/Uk6cZ6CsuzWDvurPiaPt2WeVd8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263024986"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="263024986"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 17:12:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="764266992"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2022 17:12:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3RVA-000XHl-LX;
        Tue, 21 Jun 2022 00:12:16 +0000
Date:   Tue, 21 Jun 2022 08:11:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/8] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Message-ID: <202206210847.sBhjsEiQ-lkp@intel.com>
References: <20220620161153.11741-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620161153.11741-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/block-Fix-IO-priority-mess/20220621-001427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: mips-randconfig-m031-20220619 (https://download.01.org/0day-ci/archive/20220621/202206210847.sBhjsEiQ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
block/ioprio.c:184 get_task_raw_ioprio() warn: inconsistent indenting

vim +184 block/ioprio.c

   183	
 > 184		ret = security_task_getioprio(p);
   185		if (ret)
   186			goto out;
   187		task_lock(p);
   188		if (p->io_context)
   189			ret = p->io_context->ioprio;
   190		else
   191			ret = IOPRIO_DEFAULT;
   192		task_unlock(p);
   193	out:
   194		return ret;
   195	}
   196	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

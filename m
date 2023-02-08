Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F25DC05027
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 10:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBHKgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 05:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBHKgb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 05:36:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF147426
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 02:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675852586; x=1707388586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wuKUaDG3nhGakKAMflDpyFUzigTaRC9OJjlo6xuqn+w=;
  b=MIyGh095geoQg9G+NYbOdnMF52BIauIx1SzbiLYz3fGkHRMwSg1jaIRR
   tIQ0GaZ7Z/y/zCjHj2/cgJVnOwv0ANXO9/37PDL/zF4PLvHZWKAMkVNe8
   J3UN0veTLjAlAGkZ1oXvj9T79fkAxYkBseRfl0AOgpPxY+XhVMuklnN6V
   twqUfd96vdb1WDCzg2Z6pdAtSNWzpGm5YEmtQXlQ748pAIMKEtebMBw7V
   icSfKlfvyDWJKc/SxMq50aU7Maoh8M+LIGKIIPRujlFT0fWpUxksKr68J
   qwKEtGqrHg+FFflPGKW39SSOsuztbZVFJ4q2hT4CVjDjBlw4EebMBJWTb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415985401"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415985401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 02:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="660610481"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="660610481"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2023 02:35:02 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPhn3-0004Og-37;
        Wed, 08 Feb 2023 10:35:01 +0000
Date:   Wed, 8 Feb 2023 18:34:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2] blktests: add test to cover umount one deleted disk
Message-ID: <202302081836.q16rGKum-lkp@intel.com>
References: <20230208010235.553252-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208010235.553252-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc7 next-20230208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/blktests-add-test-to-cover-umount-one-deleted-disk/20230208-090437
patch link:    https://lore.kernel.org/r/20230208010235.553252-1-ming.lei%40redhat.com
patch subject: [PATCH V2] blktests: add test to cover umount one deleted disk
reproduce:
        scripts/spdxcheck.py

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

spdxcheck warnings: (new ones prefixed by >>)
>> tests/block/032: 2:27 Invalid License ID: GPL-3.0+

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561DBC43334
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiGHJ5q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 05:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiGHJ5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 05:57:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA383F02
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657274263; x=1688810263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zbYmt/fFQgT/JicNRG/a8CdVbrzFwqFCoc3wm1brHI=;
  b=VHdB8V5l6ssUW8DhebNnMU8IUyeGWM7LDQvUsSxjWqjhgULcTSzuRwCt
   Wdf027IVvyMfsVidQ5wxHYJBmeVnBNT8tqfPjjZ1QiwIyXYO9FV6dwi/2
   oRxpPbjxwy3oYVmFTjKYmp+LS42Lqv28vPQzjTBJemafOmMTLLK8LXoFK
   BX45mZJK9kdxiulYyJVbD83IjlQ6nYiUG47M16J9CA6mt7UgD+bxYEg4z
   gN2Rqxq3aI0DtacpmBN5z9KuRm6kTrv5BEZt7iGXpeIUgEnB+l3wgYPaj
   vMObC8lDbmNxR6tVaKHq9KSkhLp/tDvyqmStuBDjEH8yYuwdEpL5bHH0j
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281795280"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="281795280"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 02:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="568885961"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 02:57:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9kk0-000NIo-R3;
        Fri, 08 Jul 2022 09:57:40 +0000
Date:   Fri, 8 Jul 2022 17:57:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Fu <vincent.fu@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     kbuild-all@lists.01.org,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH 1/2] null_blk: add module parameters for 4 options
Message-ID: <202207081753.vlYFn9x2-lkp@intel.com>
References: <20220707205401.81664-2-vincent.fu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707205401.81664-2-vincent.fu@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Vincent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Fu/null_blk-add-module-parameters-for-4-options/20220708-055453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/block/null_blk.rst:86: WARNING: Malformed table.

vim +86 Documentation/block/null_blk.rst

    29	
    30	queue_mode=[0-2]: Default: 2-Multi-queue
    31	  Selects which block-layer the module should instantiate with.
    32	
    33	  =  ============
    34	  0  Bio-based
    35	  1  Single-queue (deprecated)
    36	  2  Multi-queue
    37	  =  ============
    38	
    39	home_node=[0--nr_nodes]: Default: NUMA_NO_NODE
    40	  Selects what CPU node the data structures are allocated from.
    41	
    42	gb=[Size in GB]: Default: 250GB
    43	  The size of the device reported to the system.
    44	
    45	bs=[Block size (in bytes)]: Default: 512 bytes
    46	  The block size reported to the system.
    47	
    48	nr_devices=[Number of devices]: Default: 1
    49	  Number of block devices instantiated. They are instantiated as /dev/nullb0,
    50	  etc.
    51	
    52	irqmode=[0-2]: Default: 1-Soft-irq
    53	  The completion mode used for completing IOs to the block-layer.
    54	
    55	  =  ===========================================================================
    56	  0  None.
    57	  1  Soft-irq. Uses IPI to complete IOs across CPU nodes. Simulates the overhead
    58	     when IOs are issued from another CPU node than the home the device is
    59	     connected to.
    60	  2  Timer: Waits a specific period (completion_nsec) for each IO before
    61	     completion.
    62	  =  ===========================================================================
    63	
    64	completion_nsec=[ns]: Default: 10,000ns
    65	  Combined with irqmode=2 (timer). The time each completion event must wait.
    66	
    67	submit_queues=[1..nr_cpus]: Default: 1
    68	  The number of submission queues attached to the device driver. If unset, it
    69	  defaults to 1. For multi-queue, it is ignored when use_per_node_hctx module
    70	  parameter is 1.
    71	
    72	hw_queue_depth=[0..qdepth]: Default: 64
    73	  The hardware queue depth of the device.
    74	
    75	memory_backed=[0/1]: Default: 0
    76	  Whether or not to use a memory buffer to respond to IO requests
    77	
    78	  =  =============================================
    79	  0  Transfer no data in response to IO requests
    80	  1  Use a memory buffer to respond to IO requests
    81	  =  =============================================
    82	
    83	discard=[0/1]: Default: 0
    84	  Support discard operations (requires memory-backed null_blk device).
    85	
  > 86	  =  ====================================
    87	  0  Do not support discard operations
    88	  1  Enable support for discard operations
    89	  =  =====================================
    90	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

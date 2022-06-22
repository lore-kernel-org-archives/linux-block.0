Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAAEC43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 11:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357815AbiFVLuc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357760AbiFVLu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 07:50:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB0D3CA74
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655898627; x=1687434627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IC80ONtVSwoqVj2E9gJqGXwkhfDpLEB9kfhguxx9j8=;
  b=DQS+arG+vQbQNLh9nlMZLHAJkvVy+FMxERr3XoOGiNdtbrk2mlVI+dww
   phe81FNsdXs9w/8o81k8zDoISTv7vGSEjk+SkPqRwzG6fgVG4ipf9QmRX
   3Ht90ZnL2t5u9hiaFTGunYx+4HZj2roHXJnYL2bgLvcbgcPF5DbnefjOH
   7MGVKE0AxUKc+t9EN0JtzIPpOvmWJmgi7mrJC837i5hnTQWdsGELY+dFL
   lG3sJi+EwS5bJR7SmBPEtrtUFdmtjnDDulxTaxX6D7VQXPiPDnZfa0rv/
   DhBtrscXFPt1rV/zfEBZ7dEUj1EO2pjgWhmig16pxa3OKrf5ZYt5O2iTp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260215869"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260215869"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="562950717"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2022 04:50:25 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3yrh-0001Dz-2i;
        Wed, 22 Jun 2022 11:49:45 +0000
Date:   Wed, 22 Jun 2022 19:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Message-ID: <202206221920.pxBCy0Di-lkp@intel.com>
References: <20220621102455.13183-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621102455.13183-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.19-rc3 next-20220622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/block-Fix-IO-priority-mess/20220621-183235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220622/202206221920.pxBCy0Di-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/intel-lab-lkp/linux/commit/8421c851d4fe5f4b9d9d6870ada8ccd0b48a4012
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/block-Fix-IO-priority-mess/20220621-183235
        git checkout 8421c851d4fe5f4b9d9d6870ada8ccd0b48a4012
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/read_write.c: note: in included file (through include/linux/fs.h, include/linux/fsnotify_backend.h, include/linux/fsnotify.h):
   include/linux/ioprio.h:60:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int ioprio @@     got struct task_struct * @@
   include/linux/ioprio.h:60:34: sparse:     expected int ioprio
   include/linux/ioprio.h:60:34: sparse:     got struct task_struct *
   fs/read_write.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
>> arch/x86/include/asm/current.h:15:16: sparse: sparse: non size-preserving pointer to integer cast
   fs/read_write.c: note: in included file (through include/linux/fs.h, include/linux/fsnotify_backend.h, include/linux/fsnotify.h):
   include/linux/ioprio.h:60:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int ioprio @@     got struct task_struct * @@
   include/linux/ioprio.h:60:34: sparse:     expected int ioprio
   include/linux/ioprio.h:60:34: sparse:     got struct task_struct *
   fs/read_write.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
>> arch/x86/include/asm/current.h:15:16: sparse: sparse: non size-preserving pointer to integer cast
   fs/read_write.c: note: in included file (through include/linux/fs.h, include/linux/fsnotify_backend.h, include/linux/fsnotify.h):
   include/linux/ioprio.h:60:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int ioprio @@     got struct task_struct * @@
   include/linux/ioprio.h:60:34: sparse:     expected int ioprio
   include/linux/ioprio.h:60:34: sparse:     got struct task_struct *
   fs/read_write.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
>> arch/x86/include/asm/current.h:15:16: sparse: sparse: non size-preserving pointer to integer cast
   fs/read_write.c: note: in included file (through include/linux/fs.h, include/linux/fsnotify_backend.h, include/linux/fsnotify.h):
   include/linux/ioprio.h:60:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int ioprio @@     got struct task_struct * @@
   include/linux/ioprio.h:60:34: sparse:     expected int ioprio
   include/linux/ioprio.h:60:34: sparse:     got struct task_struct *
   fs/read_write.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
>> arch/x86/include/asm/current.h:15:16: sparse: sparse: non size-preserving pointer to integer cast
   fs/read_write.c: note: in included file (through include/linux/fs.h, include/linux/fsnotify_backend.h, include/linux/fsnotify.h):
   include/linux/ioprio.h:60:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int ioprio @@     got struct task_struct * @@
   include/linux/ioprio.h:60:34: sparse:     expected int ioprio
   include/linux/ioprio.h:60:34: sparse:     got struct task_struct *
   fs/read_write.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
>> arch/x86/include/asm/current.h:15:16: sparse: sparse: non size-preserving pointer to integer cast
--
   fs/seq_file.c:938:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:938:9: sparse:    struct list_head [noderef] __rcu *
   fs/seq_file.c:938:9: sparse:    struct list_head *
   fs/seq_file.c:938:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:938:9: sparse:    struct list_head [noderef] __rcu *
   fs/seq_file.c:938:9: sparse:    struct list_head *
   fs/seq_file.c:960:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct list_head *lh @@     got struct list_head [noderef] __rcu * @@
   fs/seq_file.c:960:12: sparse:     expected struct list_head *lh
   fs/seq_file.c:960:12: sparse:     got struct list_head [noderef] __rcu *
   fs/seq_file.c:1087:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:1087:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/seq_file.c:1087:24: sparse:    struct hlist_node *
   fs/seq_file.c:1089:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:1089:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/seq_file.c:1089:24: sparse:    struct hlist_node *
   fs/seq_file.c: note: in included file (through include/linux/fs.h):
   include/linux/ioprio.h:60:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int ioprio @@     got struct task_struct * @@
   include/linux/ioprio.h:60:34: sparse:     expected int ioprio
   include/linux/ioprio.h:60:34: sparse:     got struct task_struct *
   fs/seq_file.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
>> arch/x86/include/asm/current.h:15:16: sparse: sparse: non size-preserving pointer to integer cast
--
   fs/splice.c: note: in included file (through include/linux/fs.h, include/linux/highmem.h, include/linux/bvec.h):
   include/linux/ioprio.h:60:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int ioprio @@     got struct task_struct * @@
   include/linux/ioprio.h:60:34: sparse:     expected int ioprio
   include/linux/ioprio.h:60:34: sparse:     got struct task_struct *
   fs/splice.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
>> arch/x86/include/asm/current.h:15:16: sparse: sparse: non size-preserving pointer to integer cast

vim +15 arch/x86/include/asm/current.h

f0766440dda7ace include/asm-x86/current.h      Christoph Lameter 2008-05-09  12  
f0766440dda7ace include/asm-x86/current.h      Christoph Lameter 2008-05-09  13  static __always_inline struct task_struct *get_current(void)
f0766440dda7ace include/asm-x86/current.h      Christoph Lameter 2008-05-09  14  {
c6ae41e7d469f00 arch/x86/include/asm/current.h Alex Shi          2012-05-11 @15  	return this_cpu_read_stable(current_task);
f0766440dda7ace include/asm-x86/current.h      Christoph Lameter 2008-05-09  16  }
f0766440dda7ace include/asm-x86/current.h      Christoph Lameter 2008-05-09  17  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

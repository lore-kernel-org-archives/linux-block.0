Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDBFC6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 04:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCVEjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 00:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVEjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 00:39:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8AB761
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679459960; x=1710995960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EUtBxfQNkr4Y9oF+6OQUVDoIGsoEayRjCUVAXz8EPbk=;
  b=iYZXLvlpw7H21+n1IwQsr31LlBuYZEPmihSXi+d0yLCGgmUp9o1/9Kmy
   tNE357fAF6Mn3RSAAbmbYQ/gVuFfIY7gOnQeQBZPDBMETQCN0Rep1iz6N
   y9CopyXoDTu/l596OYojBEtJwiD5AMeZzHG342yivLe4C2dL9inWCUL+l
   xtaAkF3L5E/B6HN7yxwWr+rQdIwkIXY7Qa5zeL03RgjpGVS4pfvPYatZj
   0+fl4o7NRgGtUjLxknPywkdbi9uLq/gq/Wsq1wA3DaUHPGdz1IT7XzXTb
   62nG9rS64/8N11U+2+16L1uuhDNGPL6Q353pyQqqZK9tTpCRiqGzdvP4A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="404009690"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="404009690"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 21:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="714280809"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="714280809"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2023 21:39:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peqFo-000Csc-2X;
        Wed, 22 Mar 2023 04:39:16 +0000
Date:   Wed, 22 Mar 2023 12:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me
Cc:     oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Message-ID: <202303221244.KMWQNHnu-lkp@intel.com>
References: <20230322002350.4038048-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-2-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/nvme-fabrics-add-queue-setup-helpers/20230322-082537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230322002350.4038048-2-kbusch%40meta.com
patch subject: [PATCH 1/3] nvme-fabrics: add queue setup helpers
config: arm-randconfig-r046-20230321 (https://download.01.org/0day-ci/archive/20230322/202303221244.KMWQNHnu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0acb3964621b925db18ebec1a6c57bc3c3446859
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keith-Busch/nvme-fabrics-add-queue-setup-helpers/20230322-082537
        git checkout 0acb3964621b925db18ebec1a6c57bc3c3446859
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/nvme/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221244.KMWQNHnu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/core.c:26:
>> drivers/nvme/host/fabrics.h:222:29: warning: 'struct ib_device' declared inside parameter list will not be visible outside of this definition or declaration
     222 |                      struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES]);
         |                             ^~~~~~~~~
--
   In file included from drivers/nvme/host/core.c:26:
>> drivers/nvme/host/fabrics.h:222:29: warning: 'struct ib_device' declared inside parameter list will not be visible outside of this definition or declaration
     222 |                      struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES]);
         |                             ^~~~~~~~~
   In file included from drivers/nvme/host/trace.h:175,
                    from drivers/nvme/host/core.c:30:
   include/trace/define_trace.h:95:42: fatal error: ./trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.


vim +222 drivers/nvme/host/fabrics.h

   205	
   206	int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
   207	int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
   208	int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
   209	int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
   210	int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
   211	int nvmf_register_transport(struct nvmf_transport_ops *ops);
   212	void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
   213	void nvmf_free_options(struct nvmf_ctrl_options *opts);
   214	int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
   215	bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
   216	bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
   217			struct nvmf_ctrl_options *opts);
   218	void nvme_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
   219				u32 io_queues[HCTX_MAX_TYPES]);
   220	unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts);
   221	void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
 > 222			     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES]);
   223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

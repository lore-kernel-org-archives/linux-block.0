Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C2AEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 21:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjG0V4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjG0V4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 17:56:35 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FBC3A8C
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690494993; x=1722030993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wpk82ysSeFnyUZUShNNBYpi2DaVb+3JvFAnuf4G1l+4=;
  b=E/gR1Wwb93aoL7bD7wd9ZCPjhjfVc94EotpcTDNmcbDWi0jug6HdHBhR
   unJ64Pp2QBPkToD99asTbNotf7SXQtxqSOWRa1zjikID3K83Ffglo4I11
   Torf9ea4MvyoTG0TsrUNfAMVKXpAT452RDn8QNGKWOT8ikcSsbVaDuyRO
   KgYy/Z8//O2hefQXIp5tcOdJzqgEi706p55m9VnV+IHQzmL4hRPrSMYUP
   L3M3IGuDou+Aif9d4gVYNK4KKj7qlduJKpS5EwIJOXQYYrGzaly+axl7g
   us5oNdn2AxyK40LGgv83JiSgxxrjc4seTzl36Coop1sOhyagUoyStpNrH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353350484"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="353350484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 14:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="900995018"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="900995018"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 14:56:25 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qP8y8-0002ct-2W;
        Thu, 27 Jul 2023 21:56:24 +0000
Date:   Fri, 28 Jul 2023 05:55:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: Re: [PATCH v4 6/7] scsi: ufs: Disable zone write locking
Message-ID: <202307280537.bj45anmo-lkp@intel.com>
References: <20230726193440.1655149-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726193440.1655149-7-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.5-rc3]
[cannot apply to mkp-scsi/for-next jejb-scsi/for-next next-20230727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bart-Van-Assche/block-Introduce-the-flag-QUEUE_FLAG_NO_ZONE_WRITE_LOCK/20230727-033820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230726193440.1655149-7-bvanassche%40acm.org
patch subject: [PATCH v4 6/7] scsi: ufs: Disable zone write locking
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230728/202307280537.bj45anmo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280537.bj45anmo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307280537.bj45anmo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ufs/core/ufshcd.c:4340:6: warning: no previous prototype for 'ufshcd_update_no_zone_write_lock' [-Wmissing-prototypes]
    4340 | void ufshcd_update_no_zone_write_lock(struct ufs_hba *hba,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ufshcd_update_no_zone_write_lock +4340 drivers/ufs/core/ufshcd.c

  4339	
> 4340	void ufshcd_update_no_zone_write_lock(struct ufs_hba *hba,
  4341					      bool set_no_zone_write_lock)
  4342	{
  4343		struct scsi_device *sdev;
  4344	
  4345		shost_for_each_device(sdev, hba->host)
  4346			blk_freeze_queue_start(sdev->request_queue);
  4347		shost_for_each_device(sdev, hba->host) {
  4348			struct request_queue *q = sdev->request_queue;
  4349	
  4350			blk_mq_freeze_queue_wait(q);
  4351			if (set_no_zone_write_lock)
  4352				blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
  4353			else
  4354				blk_queue_flag_clear(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
  4355			blk_mq_unfreeze_queue(q);
  4356		}
  4357	}
  4358	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

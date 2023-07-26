Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F69C001B0
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 12:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjGZMF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZMFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 08:05:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B4AA
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690373122; x=1721909122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JypNTHKchRWkHuhYdcEKYuqTkgiIMEsGqiZwAWUNiWY=;
  b=HFXosi613uPrkwntOum0whbmvHpEUKB0X+KSQG3rMuzwsgqpehXz9UQP
   WBNOqkjf0WCCiWPQt4AkjSkn8X0Ty9f0FTtRyTfeUqov6+s36H6tuWSb4
   et0foND+70tgfys1sifqX4y7eNT1OBqQokt0bGdnGmti9HYp3l4MqES3S
   iDeDMTGEKmVzQKZFY/IJBEEgJrhsBd3Isk9v9fwA5HqWlikoSfTOaqMPB
   PjB6bQO8ji+WXccDtBz7ToeKDQZG17qASE38QjcDfCGeH68gyKfxQSUkP
   MuThShOPe4P/uQvRHwvP59UkT5lV4kM9BVZVJJWccKNiPfhXvqI5JVk9Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431801502"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="431801502"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791828965"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="791828965"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 05:05:17 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOdGW-0000wJ-3A;
        Wed, 26 Jul 2023 12:05:16 +0000
Date:   Wed, 26 Jul 2023 20:04:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: Re: [PATCH v3 5/6] scsi: ufs: Disable zone write locking
Message-ID: <202307261940.mazVXKtc-lkp@intel.com>
References: <20230726005742.303865-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726005742.303865-6-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v6.5-rc3]
[cannot apply to mkp-scsi/for-next next-20230726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bart-Van-Assche/block-Introduce-the-flag-REQ_NO_WRITE_LOCK/20230726-085936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230726005742.303865-6-bvanassche%40acm.org
patch subject: [PATCH v3 5/6] scsi: ufs: Disable zone write locking
config: s390-randconfig-r044-20230726 (https://download.01.org/0day-ci/archive/20230726/202307261940.mazVXKtc-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307261940.mazVXKtc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307261940.mazVXKtc-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/ufs/core/ufshcd.c:25:
   In file included from include/scsi/scsi_cmnd.h:5:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/ufs/core/ufshcd.c:25:
   In file included from include/scsi/scsi_cmnd.h:5:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/ufs/core/ufshcd.c:25:
   In file included from include/scsi/scsi_cmnd.h:5:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/ufs/core/ufshcd.c:4352:23: error: use of undeclared identifier 'QUEUE_FLAG_NO_ZONE_WRITE_LOCK'; did you mean '__REQ_NO_ZONE_WRITE_LOCK'?
    4352 |                         blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            __REQ_NO_ZONE_WRITE_LOCK
   include/linux/blk_types.h:424:2: note: '__REQ_NO_ZONE_WRITE_LOCK' declared here
     424 |         __REQ_NO_ZONE_WRITE_LOCK,
         |         ^
   drivers/ufs/core/ufshcd.c:4354:25: error: use of undeclared identifier 'QUEUE_FLAG_NO_ZONE_WRITE_LOCK'; did you mean '__REQ_NO_ZONE_WRITE_LOCK'?
    4354 |                         blk_queue_flag_clear(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              __REQ_NO_ZONE_WRITE_LOCK
   include/linux/blk_types.h:424:2: note: '__REQ_NO_ZONE_WRITE_LOCK' declared here
     424 |         __REQ_NO_ZONE_WRITE_LOCK,
         |         ^
>> drivers/ufs/core/ufshcd.c:4340:6: warning: no previous prototype for function 'ufshcd_update_no_zone_write_lock' [-Wmissing-prototypes]
    4340 | void ufshcd_update_no_zone_write_lock(struct ufs_hba *hba,
         |      ^
   drivers/ufs/core/ufshcd.c:4340:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    4340 | void ufshcd_update_no_zone_write_lock(struct ufs_hba *hba,
         | ^
         | static 
   drivers/ufs/core/ufshcd.c:5180:21: error: use of undeclared identifier 'QUEUE_FLAG_NO_ZONE_WRITE_LOCK'; did you mean '__REQ_NO_ZONE_WRITE_LOCK'?
    5180 |         blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                            __REQ_NO_ZONE_WRITE_LOCK
   include/linux/blk_types.h:424:2: note: '__REQ_NO_ZONE_WRITE_LOCK' declared here
     424 |         __REQ_NO_ZONE_WRITE_LOCK,
         |         ^
   drivers/ufs/core/ufshcd.c:10277:44: warning: shift count >= width of type [-Wshift-count-overflow]
    10277 |                 if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
          |                                                          ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   14 warnings and 3 errors generated.


vim +4352 drivers/ufs/core/ufshcd.c

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
> 4352				blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
  4353			else
  4354				blk_queue_flag_clear(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
  4355			blk_mq_unfreeze_queue(q);
  4356		}
  4357	}
  4358	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

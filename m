Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD0BC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 05:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E97611F2
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 05:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhDLFC5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 01:02:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:6518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhDLFC4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 01:02:56 -0400
IronPort-SDR: 1EU9iwnD6LIAZyhP1GwT15RrYs8cSBsL05+1a8syK4Uh5dSKb4PEGUCPeNVYgdQ8KlandOaCUQ
 qNDGNY4+Cbcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="214571641"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="gz'50?scan'50,208,50";a="214571641"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 22:02:39 -0700
IronPort-SDR: 3oMC1NetggP+7QrMY9UF1FMhEU8sNaSsC+/h4EGk+/08rXRyNz63CMyWNm+OgmnfAlVwu+5Yni
 UAURutqneNdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="gz'50?scan'50,208,50";a="449857631"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2021 22:02:36 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVoiZ-00008G-J9; Mon, 12 Apr 2021 05:02:35 +0000
Date:   Mon, 12 Apr 2021 13:01:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Changheun Lee <nanich.lee@samsung.com>, damien.lemoal@wdc.com,
        bvanassche@acm.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v6 1/3] bio: limit bio max size
Message-ID: <202104121203.DF2XI4YC-lkp@intel.com>
References: <20210412025831.31498-2-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20210412025831.31498-2-nanich.lee@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Changheun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on scsi/for-next linus/master v5.12-rc7]
[cannot apply to block/for-next next-20210409]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Changheun-Lee/bio-limit-bio-max-size/20210412-115922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5d00aa42f58575968c4a7a4b374addaf4f9a5624
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Changheun-Lee/bio-limit-bio-max-size/20210412-115922
        git checkout 5d00aa42f58575968c4a7a4b374addaf4f9a5624
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/blkdev.h:19,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from block/bio.c:6:
   include/linux/bio.h: In function 'bio_full':
   include/linux/bio.h:122:29: error: implicit declaration of function 'bio_max_size'; did you mean 'bio_max_segs'? [-Werror=implicit-function-declaration]
     122 |  if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
         |                             ^~~~~~~~~~~~
         |                             bio_max_segs
   block/bio.c: At top level:
>> block/bio.c:258:14: warning: no previous prototype for 'bio_max_size' [-Wmissing-prototypes]
     258 | unsigned int bio_max_size(struct bio *bio)
         |              ^~~~~~~~~~~~
>> block/bio.c:258:14: error: conflicting types for 'bio_max_size'
   In file included from include/linux/blkdev.h:19,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from block/bio.c:6:
   include/linux/bio.h:122:29: note: previous implicit declaration of 'bio_max_size' was here
     122 |  if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
         |                             ^~~~~~~~~~~~
   block/bio.c: In function 'bio_max_size':
>> block/bio.c:260:31: error: 'struct bio' has no member named 'bi_disk'
     260 |  struct request_queue *q = bio->bi_disk->queue;
         |                               ^~
   cc1: some warnings being treated as errors


vim +/bio_max_size +258 block/bio.c

   257	
 > 258	unsigned int bio_max_size(struct bio *bio)
   259	{
 > 260		struct request_queue *q = bio->bi_disk->queue;
   261	
   262		if (blk_queue_limit_bio_size(q))
   263			return blk_queue_get_max_sectors(q, bio_op(bio))
   264				<< SECTOR_SHIFT;
   265	
   266		return UINT_MAX;
   267	}
   268	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
cJzA/q//AY1Vqu8hmQAA

--XsQoSWH+UP9D9v3l--

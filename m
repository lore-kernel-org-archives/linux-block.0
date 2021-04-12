Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFCFC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 04:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90014610CA
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 04:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhDLEt6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 00:49:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:44018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhDLEt5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 00:49:57 -0400
IronPort-SDR: lIyKi8LR/yV0tIElwfiChnBmqU9BzcSASSs2scxV+fWdx3R4pz/dsIX1wJE8b0XF/+4pNqpDGm
 T4cpCD+lI/zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="174204226"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="gz'50?scan'50,208,50";a="174204226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 21:49:38 -0700
IronPort-SDR: NgB1XpCd1YgeoyXC6896pHW4YJr3f/ZQmK1ij3eCfwKYPOcZHEmNvsYMixUgY9DsXdyo/S7+fL
 SuMsREAiszCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="gz'50?scan'50,208,50";a="442919939"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2021 21:49:35 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVoVy-000087-BI; Mon, 12 Apr 2021 04:49:34 +0000
Date:   Mon, 12 Apr 2021 12:48:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Changheun Lee <nanich.lee@samsung.com>, damien.lemoal@wdc.com,
        bvanassche@acm.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v6 1/3] bio: limit bio max size
Message-ID: <202104121255.wrSGURpZ-lkp@intel.com>
References: <20210412025831.31498-2-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20210412025831.31498-2-nanich.lee@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--cNdxnHkX5QqsyA0e
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
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/5d00aa42f58575968c4a7a4b374addaf4f9a5624
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Changheun-Lee/bio-limit-bio-max-size/20210412-115922
        git checkout 5d00aa42f58575968c4a7a4b374addaf4f9a5624
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/blkdev.h:19,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/bio.h: In function 'bio_full':
>> include/linux/bio.h:122:29: error: implicit declaration of function 'bio_max_size'; did you mean 'bio_max_segs'? [-Werror=implicit-function-declaration]
     122 |  if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
         |                             ^~~~~~~~~~~~
         |                             bio_max_segs
   cc1: some warnings being treated as errors
--
   In file included from include/linux/blkdev.h:19,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/bio.h: In function 'bio_full':
>> include/linux/bio.h:122:29: error: implicit declaration of function 'bio_max_size'; did you mean 'bio_max_segs'? [-Werror=implicit-function-declaration]
     122 |  if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
         |                             ^~~~~~~~~~~~
         |                             bio_max_segs
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:116: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1233: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +122 include/linux/bio.h

   108	
   109	/**
   110	 * bio_full - check if the bio is full
   111	 * @bio:	bio to check
   112	 * @len:	length of one segment to be added
   113	 *
   114	 * Return true if @bio is full and one segment with @len bytes can't be
   115	 * added to the bio, otherwise return false
   116	 */
   117	static inline bool bio_full(struct bio *bio, unsigned len)
   118	{
   119		if (bio->bi_vcnt >= bio->bi_max_vecs)
   120			return true;
   121	
 > 122		if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
   123			return true;
   124	
   125		return false;
   126	}
   127	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--cNdxnHkX5QqsyA0e--

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D2C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF04615A0
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 13:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhF3N0W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 09:26:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:55013 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhF3N0V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 09:26:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="188031683"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="gz'50?scan'50,208,50";a="188031683"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 06:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="gz'50?scan'50,208,50";a="457234950"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2021 06:23:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyaBv-0009mJ-0I; Wed, 30 Jun 2021 13:23:47 +0000
Date:   Wed, 30 Jun 2021 21:23:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: Re: [PATCH] block: Removed a warning while compiling with a cross
 compiler for parisc
Message-ID: <202106302125.t2j51PET-lkp@intel.com>
References: <20210630081028.161284-1-abd.masalkhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20210630081028.161284-1-abd.masalkhi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Abd-Alrhman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on v5.13 next-20210630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Abd-Alrhman-Masalkhi/block-Removed-a-warning-while-compiling-with-a-cross-compiler-for-parisc/20210630-161407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/749f487a31d6818dadc37ba729475d0486daf81c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Abd-Alrhman-Masalkhi/block-Removed-a-warning-while-compiling-with-a-cross-compiler-for-parisc/20210630-161407
        git checkout 749f487a31d6818dadc37ba729475d0486daf81c
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/genhd.c:1110:6: warning: no previous prototype for 'print_disk_stats' [-Wmissing-prototypes]
    1110 | void print_disk_stats(struct seq_file *seqf,
         |      ^~~~~~~~~~~~~~~~


vim +/print_disk_stats +1110 block/genhd.c

  1109	
> 1110	void print_disk_stats(struct seq_file *seqf,
  1111			      unsigned int inflight, struct disk_stats *stat)
  1112	{
  1113		seq_printf(seqf, "%lu %lu %lu %u "
  1114			   "%lu %lu %lu %u "
  1115			   "%u %u %u "
  1116			   "%lu %lu %lu %u "
  1117			   "%lu %u"
  1118			   "\n",
  1119			   stat->ios[STAT_READ],
  1120			   stat->merges[STAT_READ],
  1121			   stat->sectors[STAT_READ],
  1122			   (unsigned int)div_u64(stat->nsecs[STAT_READ],
  1123						 NSEC_PER_MSEC),
  1124			   stat->ios[STAT_WRITE],
  1125			   stat->merges[STAT_WRITE],
  1126			   stat->sectors[STAT_WRITE],
  1127			   (unsigned int)div_u64(stat->nsecs[STAT_WRITE],
  1128						 NSEC_PER_MSEC),
  1129			   inflight,
  1130			   jiffies_to_msecs(stat->io_ticks),
  1131			   (unsigned int)div_u64(stat->nsecs[STAT_READ] +
  1132						 stat->nsecs[STAT_WRITE] +
  1133						 stat->nsecs[STAT_DISCARD] +
  1134						 stat->nsecs[STAT_FLUSH],
  1135						 NSEC_PER_MSEC),
  1136			   stat->ios[STAT_DISCARD],
  1137			   stat->merges[STAT_DISCARD],
  1138			   stat->sectors[STAT_DISCARD],
  1139			   (unsigned int)div_u64(stat->nsecs[STAT_DISCARD],
  1140						 NSEC_PER_MSEC),
  1141			   stat->ios[STAT_FLUSH],
  1142			   (unsigned int)div_u64(stat->nsecs[STAT_FLUSH],
  1143						 NSEC_PER_MSEC)
  1144			);
  1145	}
  1146	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ewK0HOe0Dfh/vnRQAXmGAAA=

--AqsLC8rIMeq19msA--

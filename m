Return-Path: <lkp@intel.com>
Date: Fri, 10 Aug 2018 06:33:16 +0800
From: kbuild test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
	boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/5] xen/blkback: don't keep persistent grants too long
Message-ID: <201808100636.B2N6Mzlj%fengguang.wu@intel.com>
References: <20180808142528.31029-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180808142528.31029-2-jgross@suse.com>
List-ID: <linux-block@vger.kernel.org>

Hi Juergen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.18-rc8 next-20180809]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Juergen-Gross/xen-blk-persistent-grant-rework/20180810-003229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/block/xen-blkback/blkback.c:91:14: sparse: symbol 'xen_blkif_pgrant_timeout' was not declared. Should it be static?
   drivers/block/xen-blkback/blkback.c:1368:41: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/blkback.c:409:29: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/blkback.c:409:29: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/blkback.c:791:38: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/common.h:434:21: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/common.h:482:21: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

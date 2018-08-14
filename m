Return-Path: <lkp@intel.com>
Date: Wed, 15 Aug 2018 05:53:12 +0800
From: kbuild test robot <lkp@intel.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kbuild-all@01.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	Bart van Assche <bart.vanassche@wdc.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Message-ID: <201808150550.wKf5lVlA%fengguang.wu@intel.com>
References: <20180814073305.87255-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi Hannes,

I love your patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on next-20180814]
[cannot apply to v4.18]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hannes-Reinecke/genhd-register-default-groups-with-device_add_disk/20180815-034942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/uapi/linux/perf_event.h:147:56: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   drivers/nvme/host/core.c:506:28: sparse: expression using sizeof(void)
   include/linux/blkdev.h:1269:16: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   drivers/nvme/host/core.c:1062:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1062:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1063:26: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1063:26: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1844:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1844:32: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:1846:43: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2406:17: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2406:17: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:2417:42: sparse: expression using sizeof(void)
>> drivers/nvme/host/core.c:2732:30: sparse: symbol 'nvme_ns_id_attr_group' was not declared. Should it be static?
   drivers/nvme/host/core.c:3203:33: sparse: expression using sizeof(void)
   drivers/nvme/host/core.c:3566:17: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: call with no type!
   drivers/nvme/host/core.c:1264:23: sparse: context imbalance in 'nvme_get_ns_from_disk' - wrong count at exit
   drivers/nvme/host/core.c:1282:33: sparse: context imbalance in 'nvme_put_ns_from_disk' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

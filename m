Return-Path: <fengguang.wu@intel.com>
Date: Mon, 21 May 2018 06:14:12 +0800
From: kbuild test robot <lkp@intel.com>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: kbuild-all@01.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Swapnil Ingle <swapnil.ingle@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>,
	Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: [PATCH v2 24/26] ibnbd: include client and server modules into
 kernel compilation
Message-ID: <201805210400.TGQsDPlN%fengguang.wu@intel.com>
References: <20180518130413.16997-25-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518130413.16997-25-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

Hi Roman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc5 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roman-Pen/InfiniBand-Transport-IBTRS-and-Network-Block-Device-IBNBD/20180520-222445
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/block/ibnbd/ibnbd-clt.c:133:39: sparse: expression using sizeof(void)
>> drivers/block/ibnbd/ibnbd-clt.c:133:39: sparse: expression using sizeof(void)
   drivers/block/ibnbd/ibnbd-clt.c:135:37: sparse: expression using sizeof(void)
   drivers/block/ibnbd/ibnbd-clt.c:135:37: sparse: expression using sizeof(void)
   drivers/block/ibnbd/ibnbd-clt.c:592:29: sparse: expression using sizeof(void)
--
>> drivers/block/ibnbd/ibnbd-srv.c:357:48: sparse: incorrect type in argument 1 (different base types) @@    expected int [signed] dev_id @@    got restricted __le32 consint [signed] dev_id @@
   drivers/block/ibnbd/ibnbd-srv.c:357:48:    expected int [signed] dev_id
   drivers/block/ibnbd/ibnbd-srv.c:357:48:    got restricted __le32 const [usertype] device_id
>> drivers/block/ibnbd/ibnbd-srv.c:696:25: sparse: expression using sizeof(void)
   include/linux/blkdev.h:1105:24: sparse: expression using sizeof(void)

vim +133 drivers/block/ibnbd/ibnbd-clt.c

563b98df Roman Pen 2018-05-18  108  
563b98df Roman Pen 2018-05-18  109  static int ibnbd_clt_set_dev_attr(struct ibnbd_clt_dev *dev,
563b98df Roman Pen 2018-05-18  110  				  const struct ibnbd_msg_open_rsp *rsp)
563b98df Roman Pen 2018-05-18  111  {
563b98df Roman Pen 2018-05-18  112  	struct ibnbd_clt_session *sess = dev->sess;
563b98df Roman Pen 2018-05-18  113  
563b98df Roman Pen 2018-05-18  114  	if (unlikely(!rsp->logical_block_size))
563b98df Roman Pen 2018-05-18  115  		return -EINVAL;
563b98df Roman Pen 2018-05-18  116  
563b98df Roman Pen 2018-05-18  117  	dev->device_id		    = le32_to_cpu(rsp->device_id);
563b98df Roman Pen 2018-05-18  118  	dev->nsectors		    = le64_to_cpu(rsp->nsectors);
563b98df Roman Pen 2018-05-18  119  	dev->logical_block_size	    = le16_to_cpu(rsp->logical_block_size);
563b98df Roman Pen 2018-05-18  120  	dev->physical_block_size    = le16_to_cpu(rsp->physical_block_size);
563b98df Roman Pen 2018-05-18  121  	dev->max_write_same_sectors = le32_to_cpu(rsp->max_write_same_sectors);
563b98df Roman Pen 2018-05-18  122  	dev->max_discard_sectors    = le32_to_cpu(rsp->max_discard_sectors);
563b98df Roman Pen 2018-05-18  123  	dev->discard_granularity    = le32_to_cpu(rsp->discard_granularity);
563b98df Roman Pen 2018-05-18  124  	dev->discard_alignment	    = le32_to_cpu(rsp->discard_alignment);
563b98df Roman Pen 2018-05-18  125  	dev->secure_discard	    = le16_to_cpu(rsp->secure_discard);
563b98df Roman Pen 2018-05-18  126  	dev->rotational		    = rsp->rotational;
563b98df Roman Pen 2018-05-18  127  	dev->remote_io_mode	    = rsp->io_mode;
563b98df Roman Pen 2018-05-18  128  
563b98df Roman Pen 2018-05-18  129  	dev->max_hw_sectors = sess->max_io_size / dev->logical_block_size;
563b98df Roman Pen 2018-05-18  130  	dev->max_segments = BMAX_SEGMENTS;
563b98df Roman Pen 2018-05-18  131  
563b98df Roman Pen 2018-05-18  132  	if (dev->remote_io_mode == IBNBD_BLOCKIO) {
563b98df Roman Pen 2018-05-18 @133  		dev->max_hw_sectors = min_t(u32, dev->max_hw_sectors,
563b98df Roman Pen 2018-05-18  134  					    le32_to_cpu(rsp->max_hw_sectors));
563b98df Roman Pen 2018-05-18  135  		dev->max_segments = min_t(u16, dev->max_segments,
563b98df Roman Pen 2018-05-18  136  					  le16_to_cpu(rsp->max_segments));
563b98df Roman Pen 2018-05-18  137  	}
563b98df Roman Pen 2018-05-18  138  
563b98df Roman Pen 2018-05-18  139  	return 0;
563b98df Roman Pen 2018-05-18  140  }
563b98df Roman Pen 2018-05-18  141  

:::::: The code at line 133 was first introduced by commit
:::::: 563b98df79220ea51ec7d61fa671c810eef1db6b ibnbd: client: main functionality

:::::: TO: Roman Pen <roman.penyaev@profitbricks.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37009 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935566AbdDTDa0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 23:30:26 -0400
Date: Thu, 20 Apr 2017 11:29:49 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kbuild-all@01.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v3] dcssblk: add dax_operations support
Message-ID: <201704201130.JVRSEa6Y%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <149264113824.36586.1220609927071019352.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc7 next-20170419]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/dcssblk-add-dax_operations-support/20170420-090408
config: s390-defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All error/warnings (new ones prefixed by >>):

>> drivers/s390/block/dcssblk.c:36:46: warning: 'struct dax_device' declared inside parameter list will not be visible outside of this definition or declaration
    static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
                                                 ^~~~~~~~~~
>> drivers/s390/block/dcssblk.c:49:21: error: variable 'dcssblk_dax_ops' has initializer but incomplete type
    static const struct dax_operations dcssblk_dax_ops = {
                        ^~~~~~~~~~~~~~
>> drivers/s390/block/dcssblk.c:50:2: error: unknown field 'direct_access' specified in initializer
     .direct_access = dcssblk_dax_direct_access,
     ^
>> drivers/s390/block/dcssblk.c:50:19: warning: excess elements in struct initializer
     .direct_access = dcssblk_dax_direct_access,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/s390/block/dcssblk.c:50:19: note: (near initialization for 'dcssblk_dax_ops')
   drivers/s390/block/dcssblk.c: In function 'dcssblk_shared_store':
>> drivers/s390/block/dcssblk.c:400:2: error: implicit declaration of function 'kill_dax' [-Werror=implicit-function-declaration]
     kill_dax(dev_info->dax_dev);
     ^~~~~~~~
>> drivers/s390/block/dcssblk.c:401:2: error: implicit declaration of function 'put_dax' [-Werror=implicit-function-declaration]
     put_dax(dev_info->dax_dev);
     ^~~~~~~
   drivers/s390/block/dcssblk.c: In function 'dcssblk_add_store':
>> drivers/s390/block/dcssblk.c:667:22: error: implicit declaration of function 'alloc_dax' [-Werror=implicit-function-declaration]
     dev_info->dax_dev = alloc_dax(dev_info, dev_info->gd->disk_name,
                         ^~~~~~~~~
>> drivers/s390/block/dcssblk.c:667:20: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     dev_info->dax_dev = alloc_dax(dev_info, dev_info->gd->disk_name,
                       ^
   drivers/s390/block/dcssblk.c: At top level:
   drivers/s390/block/dcssblk.c:932:1: error: conflicting types for 'dcssblk_dax_direct_access'
    dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/s390/block/dcssblk.c:36:13: note: previous declaration of 'dcssblk_dax_direct_access' was here
    static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
                ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/s390/block/dcssblk.c: In function 'dcssblk_dax_direct_access':
>> drivers/s390/block/dcssblk.c:935:38: error: implicit declaration of function 'dax_get_private' [-Werror=implicit-function-declaration]
     struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
                                         ^~~~~~~~~~~~~~~
>> drivers/s390/block/dcssblk.c:935:38: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/s390/block/dcssblk.c: At top level:
>> drivers/s390/block/dcssblk.c:49:36: error: storage size of 'dcssblk_dax_ops' isn't known
    static const struct dax_operations dcssblk_dax_ops = {
                                       ^~~~~~~~~~~~~~~
   drivers/s390/block/dcssblk.c:36:13: warning: 'dcssblk_dax_direct_access' used but never defined
    static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
                ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/s390/block/dcssblk.c:932:1: warning: 'dcssblk_dax_direct_access' defined but not used [-Wunused-function]
    dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
    ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/dcssblk_dax_ops +49 drivers/s390/block/dcssblk.c

    30	static int dcssblk_open(struct block_device *bdev, fmode_t mode);
    31	static void dcssblk_release(struct gendisk *disk, fmode_t mode);
    32	static blk_qc_t dcssblk_make_request(struct request_queue *q,
    33							struct bio *bio);
    34	static long dcssblk_blk_direct_access(struct block_device *bdev, sector_t secnum,
    35				 void **kaddr, pfn_t *pfn, long size);
  > 36	static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
    37			long nr_pages, void **kaddr, pfn_t *pfn);
    38	
    39	static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
    40	
    41	static int dcssblk_major;
    42	static const struct block_device_operations dcssblk_devops = {
    43		.owner   	= THIS_MODULE,
    44		.open    	= dcssblk_open,
    45		.release 	= dcssblk_release,
    46		.direct_access 	= dcssblk_blk_direct_access,
    47	};
    48	
  > 49	static const struct dax_operations dcssblk_dax_ops = {
  > 50		.direct_access = dcssblk_dax_direct_access,
    51	};
    52	
    53	struct dcssblk_dev_info {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
kt43FqUAAA==

--C7zPtVaVf+AK4Oqc--

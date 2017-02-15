Return-Path: <fengguang.wu@intel.com>
Date: Wed, 15 Feb 2017 20:19:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: kbuild-all@01.org, linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: make block layer non-optional
Message-ID: <201702152014.pxIi5Oze%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <20170215095353.23888-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc8 next-20170215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Linus-Walleij/mmc-core-make-block-layer-non-optional/20170215-181952
config: i386-randconfig-h1-02151737 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/mmc/core/block.c:48:0:
   drivers/mmc/core/queue.h: In function 'mmc_req_is_special':
   drivers/mmc/core/queue.h:7:4: error: implicit declaration of function 'req_op' [-Werror=implicit-function-declaration]
      (req_op(req) == REQ_OP_FLUSH ||
       ^~~~~~
   drivers/mmc/core/queue.h:7:19: error: 'REQ_OP_FLUSH' undeclared (first use in this function)
      (req_op(req) == REQ_OP_FLUSH ||
                      ^~~~~~~~~~~~
   drivers/mmc/core/queue.h:7:19: note: each undeclared identifier is reported only once for each function it appears in
   drivers/mmc/core/queue.h:8:19: error: 'REQ_OP_DISCARD' undeclared (first use in this function)
       req_op(req) == REQ_OP_DISCARD ||
                      ^~~~~~~~~~~~~~
   drivers/mmc/core/queue.h:9:19: error: 'REQ_OP_SECURE_ERASE' undeclared (first use in this function)
       req_op(req) == REQ_OP_SECURE_ERASE);
                      ^~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_get':
>> drivers/mmc/core/block.c:137:11: error: dereferencing pointer to incomplete type 'struct gendisk'
     md = disk->private_data;
              ^~
   drivers/mmc/core/block.c: In function 'mmc_blk_put':
   drivers/mmc/core/block.c:159:3: error: implicit declaration of function 'blk_cleanup_queue' [-Werror=implicit-function-declaration]
      blk_cleanup_queue(md->queue.queue);
      ^~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:165:3: error: implicit declaration of function 'put_disk' [-Werror=implicit-function-declaration]
      put_disk(md->disk);
      ^~~~~~~~
   drivers/mmc/core/block.c: In function 'power_ro_lock_show':
   drivers/mmc/core/block.c:175:40: error: implicit declaration of function 'dev_to_disk' [-Werror=implicit-function-declaration]
     struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
                                           ^~~~~~~~~~~
   drivers/mmc/core/block.c:175:40: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast [-Wint-conversion]
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'power_ro_lock_store':
   drivers/mmc/core/block.c:205:19: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast [-Wint-conversion]
     md = mmc_blk_get(dev_to_disk(dev));
                      ^~~~~~~~~~~
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^~~~~~~~~~~
   drivers/mmc/core/block.c:224:3: error: implicit declaration of function 'set_disk_ro' [-Werror=implicit-function-declaration]
      set_disk_ro(md->disk, 1);
      ^~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'force_ro_show':
   drivers/mmc/core/block.c:241:40: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast [-Wint-conversion]
     struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
                                           ^~~~~~~~~~~
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^~~~~~~~~~~
   drivers/mmc/core/block.c:244:10: error: implicit declaration of function 'get_disk_ro' [-Werror=implicit-function-declaration]
             get_disk_ro(dev_to_disk(dev)) ^
             ^~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'force_ro_store':
   drivers/mmc/core/block.c:255:40: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast [-Wint-conversion]
     struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
                                           ^~~~~~~~~~~
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_open':
   drivers/mmc/core/block.c:277:4: error: implicit declaration of function 'check_disk_change' [-Werror=implicit-function-declaration]
       check_disk_change(bdev);
       ^~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_getgeo':
   drivers/mmc/core/block.c:302:19: error: implicit declaration of function 'get_capacity' [-Werror=implicit-function-declaration]
     geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
                      ^~~~~~~~~~~~
   In file included from include/asm-generic/ioctl.h:4:0,
                    from arch/x86/include/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:4,
                    from arch/x86/include/uapi/asm/msr.h:7,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:25,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from drivers/mmc/core/block.c:21:
   drivers/mmc/core/block.c: In function 'mmc_blk_ioctl':
   include/uapi/linux/mmc/ioctl.h:59:27: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
    #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
                              ^
   include/uapi/asm-generic/ioctl.h:67:5: note: in definition of macro '_IOC'
      ((type) << _IOC_TYPESHIFT) | \
        ^~~~
   include/uapi/linux/mmc/ioctl.h:59:21: note: in expansion of macro '_IOWR'
    #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
                        ^~~~~
   drivers/mmc/core/block.c:698:7: note: in expansion of macro 'MMC_IOC_CMD'
     case MMC_IOC_CMD:
          ^~~~~~~~~~~
   drivers/mmc/core/block.c: At top level:
   drivers/mmc/core/block.c:717:21: error: variable 'mmc_bdops' has initializer but incomplete type
    static const struct block_device_operations mmc_bdops = {
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:718:2: error: unknown field 'open' specified in initializer
     .open   = mmc_blk_open,
     ^
   drivers/mmc/core/block.c:718:12: warning: excess elements in struct initializer
     .open   = mmc_blk_open,
               ^~~~~~~~~~~~
   drivers/mmc/core/block.c:718:12: note: (near initialization for 'mmc_bdops')
   drivers/mmc/core/block.c:719:2: error: unknown field 'release' specified in initializer
     .release  = mmc_blk_release,
     ^
   drivers/mmc/core/block.c:719:14: warning: excess elements in struct initializer
     .release  = mmc_blk_release,
                 ^~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:719:14: note: (near initialization for 'mmc_bdops')
   drivers/mmc/core/block.c:720:2: error: unknown field 'getgeo' specified in initializer
     .getgeo   = mmc_blk_getgeo,
     ^
   drivers/mmc/core/block.c:720:14: warning: excess elements in struct initializer
     .getgeo   = mmc_blk_getgeo,
                 ^~~~~~~~~~~~~~
   drivers/mmc/core/block.c:720:14: note: (near initialization for 'mmc_bdops')
   drivers/mmc/core/block.c:721:2: error: unknown field 'owner' specified in initializer
     .owner   = THIS_MODULE,
     ^
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/moduleparam.h:6,
                    from drivers/mmc/core/block.c:20:
   include/linux/export.h:37:21: warning: excess elements in struct initializer
    #define THIS_MODULE ((struct module *)0)
                        ^
   drivers/mmc/core/block.c:721:13: note: in expansion of macro 'THIS_MODULE'
     .owner   = THIS_MODULE,
                ^~~~~~~~~~~
   include/linux/export.h:37:21: note: (near initialization for 'mmc_bdops')
    #define THIS_MODULE ((struct module *)0)
                        ^
   drivers/mmc/core/block.c:721:13: note: in expansion of macro 'THIS_MODULE'
     .owner   = THIS_MODULE,
                ^~~~~~~~~~~
   drivers/mmc/core/block.c:722:2: error: unknown field 'ioctl' specified in initializer
     .ioctl   = mmc_blk_ioctl,
     ^
   drivers/mmc/core/block.c:722:13: warning: excess elements in struct initializer
     .ioctl   = mmc_blk_ioctl,
                ^~~~~~~~~~~~~
   drivers/mmc/core/block.c:722:13: note: (near initialization for 'mmc_bdops')
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/moduleparam.h:6,
                    from drivers/mmc/core/block.c:20:
   drivers/mmc/core/block.c: In function 'card_busy_detect':
>> drivers/mmc/core/block.c:846:14: error: dereferencing pointer to incomplete type 'struct request'
              req->rq_disk->disk_name, err);
                 ^
   include/linux/printk.h:292:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'send_stop':
   drivers/mmc/core/block.c:889:22: error: implicit declaration of function 'rq_data_dir' [-Werror=implicit-function-declaration]
     bool use_r1b_resp = rq_data_dir(req) == WRITE;
                         ^~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_issue_discard_rq':
   drivers/mmc/core/block.c:1158:9: error: implicit declaration of function 'blk_rq_pos' [-Werror=implicit-function-declaration]
     from = blk_rq_pos(req);
            ^~~~~~~~~~
   drivers/mmc/core/block.c:1159:7: error: implicit declaration of function 'blk_rq_sectors' [-Werror=implicit-function-declaration]
     nr = blk_rq_sectors(req);
          ^~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1184:2: error: implicit declaration of function 'blk_end_request' [-Werror=implicit-function-declaration]
     blk_end_request(req, err, blk_rq_bytes(req));
     ^~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1184:28: error: implicit declaration of function 'blk_rq_bytes' [-Werror=implicit-function-declaration]
     blk_end_request(req, err, blk_rq_bytes(req));
                               ^~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_issue_flush':
   drivers/mmc/core/block.c:1266:2: error: implicit declaration of function 'blk_end_request_all' [-Werror=implicit-function-declaration]
     blk_end_request_all(req, ret);
     ^~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_rw_rq_prep':
   drivers/mmc/core/block.c:1423:37: error: 'REQ_FUA' undeclared (first use in this function)
     bool do_rel_wr = (req->cmd_flags & REQ_FUA) &&
                                        ^~~~~~~
   drivers/mmc/core/block.c:1504:21: error: 'REQ_META' undeclared (first use in this function)
      (req->cmd_flags & REQ_META) &&
                        ^~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_issue_rw_rq':
   drivers/mmc/core/block.c:1736:20: error: 'RQF_QUIET' undeclared (first use in this function)
      req->rq_flags |= RQF_QUIET;
                       ^~~~~~~~~
   drivers/mmc/core/block.c:1739:5: error: implicit declaration of function 'blk_rq_cur_bytes' [-Werror=implicit-function-declaration]
        blk_rq_cur_bytes(req));
        ^~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_issue_rq':
   drivers/mmc/core/block.c:1777:28: error: 'REQ_OP_DISCARD' undeclared (first use in this function)
     if (req && req_op(req) == REQ_OP_DISCARD) {
                               ^~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1782:35: error: 'REQ_OP_SECURE_ERASE' undeclared (first use in this function)
     } else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {
                                      ^~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1787:35: error: 'REQ_OP_FLUSH' undeclared (first use in this function)
     } else if (req && req_op(req) == REQ_OP_FLUSH) {
                                      ^~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_alloc_req':
   drivers/mmc/core/block.c:1856:13: error: implicit declaration of function 'alloc_disk' [-Werror=implicit-function-declaration]
     md->disk = alloc_disk(perdev_minors);
                ^~~~~~~~~~
   drivers/mmc/core/block.c:1856:11: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     md->disk = alloc_disk(perdev_minors);
              ^
   drivers/mmc/core/block.c:1872:20: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
     md->disk->major = MMC_BLOCK_MAJOR;
                       ^~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1879:20: error: 'GENHD_FL_EXT_DEVT' undeclared (first use in this function)
     md->disk->flags = GENHD_FL_EXT_DEVT;
                       ^~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1881:22: error: 'GENHD_FL_NO_PART_SCAN' undeclared (first use in this function)
      md->disk->flags |= GENHD_FL_NO_PART_SCAN;
                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1899:3: error: implicit declaration of function 'blk_queue_logical_block_size' [-Werror=implicit-function-declaration]
      blk_queue_logical_block_size(md->queue.queue,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1904:2: error: implicit declaration of function 'set_capacity' [-Werror=implicit-function-declaration]
     set_capacity(md->disk, size);
     ^~~~~~~~~~~~
   drivers/mmc/core/block.c:1919:3: error: implicit declaration of function 'blk_queue_write_cache' [-Werror=implicit-function-declaration]
      blk_queue_write_cache(md->queue.queue, true, true);
      ^~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_alloc_part':
   drivers/mmc/core/block.c:1969:36: error: implicit declaration of function 'disk_to_dev' [-Werror=implicit-function-declaration]
     part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
                                       ^~~~~~~~~~~
   drivers/mmc/core/block.c:1969:36: warning: passing argument 2 of 'mmc_blk_alloc_req' makes pointer from integer without a cast [-Wint-conversion]
   drivers/mmc/core/block.c:1814:29: note: expected 'struct device *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
                                ^~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_remove_req':
   drivers/mmc/core/block.c:2025:25: error: 'GENHD_FL_UP' undeclared (first use in this function)
      if (md->disk->flags & GENHD_FL_UP) {
                            ^~~~~~~~~~~
   drivers/mmc/core/block.c:2026:23: warning: passing argument 1 of 'device_remove_file' makes pointer from integer without a cast [-Wint-conversion]
       device_remove_file(disk_to_dev(md->disk), &md->force_ro);
                          ^~~~~~~~~~~
   In file included from include/linux/pm_runtime.h:12:0,
                    from drivers/mmc/core/block.c:37:
   include/linux/device.h:602:13: note: expected 'struct device *' but argument is of type 'int'
    extern void device_remove_file(struct device *dev,
                ^~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:2029:24: warning: passing argument 1 of 'device_remove_file' makes pointer from integer without a cast [-Wint-conversion]
        device_remove_file(disk_to_dev(md->disk),
                           ^~~~~~~~~~~
   In file included from include/linux/pm_runtime.h:12:0,
                    from drivers/mmc/core/block.c:37:
   include/linux/device.h:602:13: note: expected 'struct device *' but argument is of type 'int'
    extern void device_remove_file(struct device *dev,
                ^~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:2032:4: error: implicit declaration of function 'del_gendisk' [-Werror=implicit-function-declaration]
       del_gendisk(md->disk);
       ^~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_add_disk':
   drivers/mmc/core/block.c:2056:2: error: implicit declaration of function 'device_add_disk' [-Werror=implicit-function-declaration]
     device_add_disk(md->parent, md->disk);
     ^~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:2062:27: warning: passing argument 1 of 'device_create_file' makes pointer from integer without a cast [-Wint-conversion]
     ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
                              ^~~~~~~~~~~
   In file included from include/linux/pm_runtime.h:12:0,
                    from drivers/mmc/core/block.c:37:
   include/linux/device.h:600:12: note: expected 'struct device *' but argument is of type 'int'
    extern int device_create_file(struct device *device,
               ^~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:2081:28: warning: passing argument 1 of 'device_create_file' makes pointer from integer without a cast [-Wint-conversion]
      ret = device_create_file(disk_to_dev(md->disk),
                               ^~~~~~~~~~~
   In file included from include/linux/pm_runtime.h:12:0,
                    from drivers/mmc/core/block.c:37:
   include/linux/device.h:600:12: note: expected 'struct device *' but argument is of type 'int'
    extern int device_create_file(struct device *device,
               ^~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:2089:21: warning: passing argument 1 of 'device_remove_file' makes pointer from integer without a cast [-Wint-conversion]
     device_remove_file(disk_to_dev(md->disk), &md->force_ro);
                        ^~~~~~~~~~~
   In file included from include/linux/pm_runtime.h:12:0,
                    from drivers/mmc/core/block.c:37:
   include/linux/device.h:602:13: note: expected 'struct device *' but argument is of type 'int'
    extern void device_remove_file(struct device *dev,
                ^~~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_init':
   drivers/mmc/core/block.c:2310:8: error: implicit declaration of function 'register_blkdev' [-Werror=implicit-function-declaration]
     res = register_blkdev(MMC_BLOCK_MAJOR, "mmc");
           ^~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:2310:24: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
     res = register_blkdev(MMC_BLOCK_MAJOR, "mmc");
                           ^~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:2320:2: error: implicit declaration of function 'unregister_blkdev' [-Werror=implicit-function-declaration]
     unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
     ^~~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: In function 'mmc_blk_exit':
   drivers/mmc/core/block.c:2328:20: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
     unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
                       ^~~~~~~~~~~~~~~
   drivers/mmc/core/block.c: At top level:
>> drivers/mmc/core/block.c:717:45: error: storage size of 'mmc_bdops' isn't known
    static const struct block_device_operations mmc_bdops = {
                                                ^~~~~~~~~
   In file included from drivers/mmc/core/block.c:48:0:
   drivers/mmc/core/queue.h: In function 'mmc_req_is_special':
   drivers/mmc/core/queue.h:10:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors
..

vim +137 drivers/mmc/core/block.c

^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  121  };
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  122  
a621aaed drivers/mmc/mmc_block.c  Arjan van de Ven 2006-01-12  123  static DEFINE_MUTEX(open_lock);
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  124  
5e71b7a6 drivers/mmc/card/block.c Olof Johansson   2010-09-17  125  module_param(perdev_minors, int, 0444);
5e71b7a6 drivers/mmc/card/block.c Olof Johansson   2010-09-17  126  MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
5e71b7a6 drivers/mmc/card/block.c Olof Johansson   2010-09-17  127  
8d1e977d drivers/mmc/card/block.c Loic Pallardy    2012-08-06  128  static inline int mmc_blk_part_switch(struct mmc_card *card,
8d1e977d drivers/mmc/card/block.c Loic Pallardy    2012-08-06  129  				      struct mmc_blk_data *md);
8d1e977d drivers/mmc/card/block.c Loic Pallardy    2012-08-06  130  static int get_card_status(struct mmc_card *card, u32 *status, int retries);
8d1e977d drivers/mmc/card/block.c Loic Pallardy    2012-08-06  131  
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  132  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  133  {
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  134  	struct mmc_blk_data *md;
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  135  
a621aaed drivers/mmc/mmc_block.c  Arjan van de Ven 2006-01-12  136  	mutex_lock(&open_lock);
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16 @137  	md = disk->private_data;
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  138  	if (md && md->usage == 0)
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  139  		md = NULL;
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  140  	if (md)
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  141  		md->usage++;
a621aaed drivers/mmc/mmc_block.c  Arjan van de Ven 2006-01-12  142  	mutex_unlock(&open_lock);
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  143  
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  144  	return md;
^1da177e drivers/mmc/mmc_block.c  Linus Torvalds   2005-04-16  145  }

:::::: The code at line 137 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cWoXeonUoKmBZSoM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aAEA

--cWoXeonUoKmBZSoM--

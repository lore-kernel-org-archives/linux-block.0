Return-Path: <fengguang.wu@intel.com>
Date: Wed, 15 Feb 2017 20:03:49 +0800
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
Message-ID: <201702152035.gTCswI0S%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <20170215095353.23888-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc8 next-20170215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Linus-Walleij/mmc-core-make-block-layer-non-optional/20170215-181952
config: i386-randconfig-c0-02151724 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/mmc/core/block.c:48:0:
   drivers/mmc/core/queue.h: In function 'mmc_req_is_special':
>> drivers/mmc/core/queue.h:7:3: error: implicit declaration of function 'req_op' [-Werror=implicit-function-declaration]
      (req_op(req) == REQ_OP_FLUSH ||
      ^
>> drivers/mmc/core/queue.h:7:19: error: 'REQ_OP_FLUSH' undeclared (first use in this function)
      (req_op(req) == REQ_OP_FLUSH ||
                      ^
   drivers/mmc/core/queue.h:7:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/mmc/core/queue.h:8:19: error: 'REQ_OP_DISCARD' undeclared (first use in this function)
       req_op(req) == REQ_OP_DISCARD ||
                      ^
>> drivers/mmc/core/queue.h:9:19: error: 'REQ_OP_SECURE_ERASE' undeclared (first use in this function)
       req_op(req) == REQ_OP_SECURE_ERASE);
                      ^
   drivers/mmc/core/block.c: In function 'mmc_blk_get':
>> drivers/mmc/core/block.c:137:11: error: dereferencing pointer to incomplete type
     md = disk->private_data;
              ^
   drivers/mmc/core/block.c: In function 'mmc_get_devidx':
   drivers/mmc/core/block.c:149:19: error: dereferencing pointer to incomplete type
     int devidx = disk->first_minor / perdev_minors;
                      ^
   drivers/mmc/core/block.c: In function 'mmc_blk_put':
>> drivers/mmc/core/block.c:159:3: error: implicit declaration of function 'blk_cleanup_queue' [-Werror=implicit-function-declaration]
      blk_cleanup_queue(md->queue.queue);
      ^
>> drivers/mmc/core/block.c:165:3: error: implicit declaration of function 'put_disk' [-Werror=implicit-function-declaration]
      put_disk(md->disk);
      ^
   drivers/mmc/core/block.c: In function 'power_ro_lock_show':
>> drivers/mmc/core/block.c:175:9: error: implicit declaration of function 'dev_to_disk' [-Werror=implicit-function-declaration]
     struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
            ^
>> drivers/mmc/core/block.c:175:40: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast
     struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
                                           ^
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^
   drivers/mmc/core/block.c: In function 'power_ro_lock_store':
   drivers/mmc/core/block.c:205:19: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast
     md = mmc_blk_get(dev_to_disk(dev));
                      ^
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/moduleparam.h:6,
                    from drivers/mmc/core/block.c:20:
   drivers/mmc/core/block.c:215:84: error: dereferencing pointer to incomplete type
      pr_err("%s: Locking boot partition ro until next power on failed: %d\n", md->disk->disk_name, ret);
                                                                                       ^
   include/linux/printk.h:292:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^
   drivers/mmc/core/block.c:223:12: error: dereferencing pointer to incomplete type
       md->disk->disk_name);
               ^
   include/linux/printk.h:299:34: note: in definition of macro 'pr_info'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                     ^
>> drivers/mmc/core/block.c:224:3: error: implicit declaration of function 'set_disk_ro' [-Werror=implicit-function-declaration]
      set_disk_ro(md->disk, 1);
      ^
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/moduleparam.h:6,
                    from drivers/mmc/core/block.c:20:
   drivers/mmc/core/block.c:228:81: error: dereferencing pointer to incomplete type
        pr_info("%s: Locking boot partition ro until next power on\n", part_md->disk->disk_name);
                                                                                    ^
   include/linux/printk.h:299:34: note: in definition of macro 'pr_info'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                     ^
   drivers/mmc/core/block.c: In function 'force_ro_show':
   drivers/mmc/core/block.c:241:40: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast
     struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
                                           ^
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^
>> drivers/mmc/core/block.c:244:10: error: implicit declaration of function 'get_disk_ro' [-Werror=implicit-function-declaration]
             get_disk_ro(dev_to_disk(dev)) ^
             ^
   drivers/mmc/core/block.c: In function 'force_ro_store':
   drivers/mmc/core/block.c:255:40: warning: passing argument 1 of 'mmc_blk_get' makes pointer from integer without a cast
     struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
                                           ^
   drivers/mmc/core/block.c:132:29: note: expected 'struct gendisk *' but argument is of type 'int'
    static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
                                ^
   drivers/mmc/core/block.c: In function 'mmc_blk_open':
>> drivers/mmc/core/block.c:277:4: error: implicit declaration of function 'check_disk_change' [-Werror=implicit-function-declaration]
       check_disk_change(bdev);
       ^
   drivers/mmc/core/block.c: In function 'mmc_blk_release':
   drivers/mmc/core/block.c:292:32: error: dereferencing pointer to incomplete type
     struct mmc_blk_data *md = disk->private_data;
                                   ^
   drivers/mmc/core/block.c: In function 'mmc_blk_getgeo':
>> drivers/mmc/core/block.c:302:2: error: implicit declaration of function 'get_capacity' [-Werror=implicit-function-declaration]
     geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
     ^
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
>> include/uapi/linux/mmc/ioctl.h:59:27: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
    #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
                              ^
   include/uapi/asm-generic/ioctl.h:67:5: note: in definition of macro '_IOC'
      ((type) << _IOC_TYPESHIFT) | \
        ^
>> include/uapi/linux/mmc/ioctl.h:59:21: note: in expansion of macro '_IOWR'
    #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
                        ^
>> drivers/mmc/core/block.c:698:7: note: in expansion of macro 'MMC_IOC_CMD'
     case MMC_IOC_CMD:
          ^
   drivers/mmc/core/block.c: At top level:
>> drivers/mmc/core/block.c:717:21: error: variable 'mmc_bdops' has initializer but incomplete type
    static const struct block_device_operations mmc_bdops = {
                        ^
>> drivers/mmc/core/block.c:718:2: error: unknown field 'open' specified in initializer
     .open   = mmc_blk_open,
     ^
>> drivers/mmc/core/block.c:718:2: warning: excess elements in struct initializer
   drivers/mmc/core/block.c:718:2: warning: (near initialization for 'mmc_bdops')
>> drivers/mmc/core/block.c:719:2: error: unknown field 'release' specified in initializer
     .release  = mmc_blk_release,
     ^
   drivers/mmc/core/block.c:719:2: warning: excess elements in struct initializer
   drivers/mmc/core/block.c:719:2: warning: (near initialization for 'mmc_bdops')
--
   In file included from drivers/mmc/core/queue.c:21:0:
   drivers/mmc/core/queue.h: In function 'mmc_req_is_special':
>> drivers/mmc/core/queue.h:7:3: error: implicit declaration of function 'req_op' [-Werror=implicit-function-declaration]
      (req_op(req) == REQ_OP_FLUSH ||
      ^
>> drivers/mmc/core/queue.h:7:19: error: 'REQ_OP_FLUSH' undeclared (first use in this function)
      (req_op(req) == REQ_OP_FLUSH ||
                      ^
   drivers/mmc/core/queue.h:7:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/mmc/core/queue.h:8:19: error: 'REQ_OP_DISCARD' undeclared (first use in this function)
       req_op(req) == REQ_OP_DISCARD ||
                      ^
>> drivers/mmc/core/queue.h:9:19: error: 'REQ_OP_SECURE_ERASE' undeclared (first use in this function)
       req_op(req) == REQ_OP_SECURE_ERASE);
                      ^
   drivers/mmc/core/queue.h: At top level:
>> drivers/mmc/core/queue.h:38:19: error: field 'thread_sem' has incomplete type
     struct semaphore thread_sem;
                      ^
   drivers/mmc/core/queue.c: In function 'mmc_prep_request':
>> drivers/mmc/core/queue.c:31:26: error: dereferencing pointer to incomplete type
     struct mmc_queue *mq = q->queuedata;
                             ^
   drivers/mmc/core/queue.c:36:9: error: dereferencing pointer to incomplete type
     if (req->cmd_type != REQ_TYPE_FS && req_op(req) != REQ_OP_DISCARD &&
            ^
>> drivers/mmc/core/queue.c:36:23: error: 'REQ_TYPE_FS' undeclared (first use in this function)
     if (req->cmd_type != REQ_TYPE_FS && req_op(req) != REQ_OP_DISCARD &&
                          ^
>> drivers/mmc/core/queue.c:36:53: error: 'REQ_OP_DISCARD' undeclared (first use in this function)
     if (req->cmd_type != REQ_TYPE_FS && req_op(req) != REQ_OP_DISCARD &&
                                                        ^
>> drivers/mmc/core/queue.c:37:21: error: 'REQ_OP_SECURE_ERASE' undeclared (first use in this function)
         req_op(req) != REQ_OP_SECURE_ERASE) {
                        ^
>> drivers/mmc/core/queue.c:38:3: error: implicit declaration of function 'blk_dump_rq_flags' [-Werror=implicit-function-declaration]
      blk_dump_rq_flags(req, "MMC bad request");
      ^
>> drivers/mmc/core/queue.c:39:10: error: 'BLKPREP_KILL' undeclared (first use in this function)
      return BLKPREP_KILL;
             ^
   drivers/mmc/core/queue.c:45:5: error: dereferencing pointer to incomplete type
     req->rq_flags |= RQF_DONTPREP;
        ^
>> drivers/mmc/core/queue.c:45:19: error: 'RQF_DONTPREP' undeclared (first use in this function)
     req->rq_flags |= RQF_DONTPREP;
                      ^
>> drivers/mmc/core/queue.c:47:9: error: 'BLKPREP_OK' undeclared (first use in this function)
     return BLKPREP_OK;
            ^
   drivers/mmc/core/queue.c: In function 'mmc_queue_thread':
>> drivers/mmc/core/queue.c:58:2: error: implicit declaration of function 'down' [-Werror=implicit-function-declaration]
     down(&mq->thread_sem);
     ^
   drivers/mmc/core/queue.c:62:18: error: dereferencing pointer to incomplete type
      spin_lock_irq(q->queue_lock);
                     ^
>> drivers/mmc/core/queue.c:64:3: error: implicit declaration of function 'blk_fetch_request' [-Werror=implicit-function-declaration]
      req = blk_fetch_request(q);
      ^
>> drivers/mmc/core/queue.c:64:7: warning: assignment makes pointer from integer without a cast
      req = blk_fetch_request(q);
          ^
   drivers/mmc/core/queue.c:79:20: error: dereferencing pointer to incomplete type
      spin_unlock_irq(q->queue_lock);
                       ^
>> drivers/mmc/core/queue.c:110:4: error: implicit declaration of function 'up' [-Werror=implicit-function-declaration]
       up(&mq->thread_sem);
       ^
   drivers/mmc/core/queue.c: In function 'mmc_request_fn':
   drivers/mmc/core/queue.c:128:26: error: dereferencing pointer to incomplete type
     struct mmc_queue *mq = q->queuedata;
                             ^
   drivers/mmc/core/queue.c:133:15: warning: assignment makes pointer from integer without a cast
      while ((req = blk_fetch_request(q)) != NULL) {
                  ^
   drivers/mmc/core/queue.c:134:7: error: dereferencing pointer to incomplete type
       req->rq_flags |= RQF_QUIET;
          ^
>> drivers/mmc/core/queue.c:134:21: error: 'RQF_QUIET' undeclared (first use in this function)
       req->rq_flags |= RQF_QUIET;
                        ^
>> drivers/mmc/core/queue.c:135:4: error: implicit declaration of function '__blk_end_request_all' [-Werror=implicit-function-declaration]
       __blk_end_request_all(req, -EIO);
       ^
   drivers/mmc/core/queue.c: In function 'mmc_queue_setup_discard':
>> drivers/mmc/core/queue.c:175:2: error: implicit declaration of function 'queue_flag_set_unlocked' [-Werror=implicit-function-declaration]
     queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
     ^

vim +/req_op +7 drivers/mmc/core/queue.h

^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16   1  #ifndef MMC_QUEUE_H
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16   2  #define MMC_QUEUE_H
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16   3  
c2df40dfb drivers/mmc/card/queue.h Mike Christie      2016-06-05   4  static inline bool mmc_req_is_special(struct request *req)
c2df40dfb drivers/mmc/card/queue.h Mike Christie      2016-06-05   5  {
3a5e02ced drivers/mmc/card/queue.h Mike Christie      2016-06-05   6  	return req &&
7afafc8a4 drivers/mmc/card/queue.h Adrian Hunter      2016-08-16  @7  		(req_op(req) == REQ_OP_FLUSH ||
7afafc8a4 drivers/mmc/card/queue.h Adrian Hunter      2016-08-16  @8  		 req_op(req) == REQ_OP_DISCARD ||
7afafc8a4 drivers/mmc/card/queue.h Adrian Hunter      2016-08-16  @9  		 req_op(req) == REQ_OP_SECURE_ERASE);
c2df40dfb drivers/mmc/card/queue.h Mike Christie      2016-06-05 @10  }
ef3a69c7a drivers/mmc/card/queue.h Seungwon Jeon      2013-03-14  11  
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16  12  struct request;
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16  13  struct task_struct;
7db3028e0 drivers/mmc/card/queue.h Linus Walleij      2016-11-18  14  struct mmc_blk_data;
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16  15  
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  16  struct mmc_blk_request {
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  17  	struct mmc_request	mrq;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  18  	struct mmc_command	sbc;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  19  	struct mmc_command	cmd;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  20  	struct mmc_command	stop;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  21  	struct mmc_data		data;
b8360a494 drivers/mmc/card/queue.h Adrian Hunter      2015-05-07  22  	int			retune_retry_done;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  23  };
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  24  
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  25  struct mmc_queue_req {
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  26  	struct request		*req;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  27  	struct mmc_blk_request	brq;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  28  	struct scatterlist	*sg;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  29  	char			*bounce_buf;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  30  	struct scatterlist	*bounce_sg;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  31  	unsigned int		bounce_sg_len;
ee8a43a51 drivers/mmc/card/queue.h Per Forlin         2011-07-01  32  	struct mmc_async_req	mmc_active;
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  33  };
97868a2bd drivers/mmc/card/queue.h Per Forlin         2011-07-09  34  
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16  35  struct mmc_queue {
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16  36  	struct mmc_card		*card;
87598a2bd drivers/mmc/mmc_queue.h  Christoph Hellwig  2006-11-13  37  	struct task_struct	*thread;
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16 @38  	struct semaphore	thread_sem;
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds     2005-04-16  39  	unsigned int		flags;
2220eedfd drivers/mmc/card/queue.h Konstantin Dorfman 2013-01-14  40  #define MMC_QUEUE_SUSPENDED	(1 << 0)
2220eedfd drivers/mmc/card/queue.h Konstantin Dorfman 2013-01-14  41  #define MMC_QUEUE_NEW_REQUEST	(1 << 1)

:::::: The code at line 7 was first introduced by commit
:::::: 7afafc8a44bf0ab841b17d450b02aedb3a138985 block: Fix secure erase

:::::: TO: Adrian Hunter <adrian.hunter@intel.com>
:::::: CC: Jens Axboe <axboe@fb.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--YiEDa0DAkWCtVeE4--

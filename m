Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CEC48BE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 03:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBA360FF1
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 03:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhFSD1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 23:27:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:10102 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234943AbhFSD1A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 23:27:00 -0400
IronPort-SDR: 2xBnr+S3WhgVbCTf9slWRg39K7w3bHfv9T46p8CK18hrDgODAvYuoRSNxHhA8RBgmjG2+GIFhj
 se7sq2WjkLGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193962056"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="gz'50?scan'50,208,50";a="193962056"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 20:24:49 -0700
IronPort-SDR: JkVv66ILyKSgfUrsB6QQVizJdwn4uoWQrG3HPLsphuax0X6eMHtgWDXPqE6VdzKHSLHR1p8ZpJ
 rHucolcFrVHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="gz'50?scan'50,208,50";a="479991708"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2021 20:24:46 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luRbA-0003IH-Uf; Sat, 19 Jun 2021 03:24:44 +0000
Date:   Sat, 19 Jun 2021 11:24:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        hch@infradead.org
Cc:     kbuild-all@lists.01.org, axboe@kernel.dk,
        desmondcheongzx@gmail.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v2] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <202106191108.uQpahFsN-lkp@intel.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Tetsuo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.13-rc6]
[cannot apply to block/for-next next-20210618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tetsuo-Handa/block-genhd-don-t-call-probe-function-with-major_names_lock-held/20210619-090731
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1de14b707f1a3e49fa4412b1eb8391f09747a005
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tetsuo-Handa/block-genhd-don-t-call-probe-function-with-major_names_lock-held/20210619-090731
        git checkout 1de14b707f1a3e49fa4412b1eb8391f09747a005
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/genhd.c:223: warning: expecting prototype for __register_blkdev(). Prototype was for ____register_blkdev() instead


vim +223 block/genhd.c

^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  196  
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  197  /**
e2b6b301871719 block/genhd.c         Christoph Hellwig     2020-11-14  198   * __register_blkdev - register a new block device
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  199   *
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  200   * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  201   *         @major = 0, try to allocate any unused major number.
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  202   * @name: the name of the new block device as a zero terminated string
1de14b707f1a3e block/genhd.c         Tetsuo Handa          2021-06-19  203   * @probe: callback that is called on access to any minor number of @major
1de14b707f1a3e block/genhd.c         Tetsuo Handa          2021-06-19  204   * @owner: the owner of @probe function (i.e. THIS_MODULE or NULL).
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  205   *
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  206   * The @name must be unique within the system.
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  207   *
0e056eb5530da8 block/genhd.c         Mauro Carvalho Chehab 2017-03-30  208   * The return value depends on the @major input parameter:
0e056eb5530da8 block/genhd.c         Mauro Carvalho Chehab 2017-03-30  209   *
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  210   *  - if a major device number was requested in range [1..BLKDEV_MAJOR_MAX-1]
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  211   *    then the function returns zero on success, or a negative error code
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  212   *  - if any unused major number was requested with @major = 0 parameter
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  213   *    then the return value is the allocated major number in range
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  214   *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  215   *
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  216   * See Documentation/admin-guide/devices.txt for the list of allocated
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  217   * major numbers.
e2b6b301871719 block/genhd.c         Christoph Hellwig     2020-11-14  218   *
e2b6b301871719 block/genhd.c         Christoph Hellwig     2020-11-14  219   * Use register_blkdev instead for any new code.
9e8c0bccdc944b block/genhd.c         Márton Németh         2009-02-20  220   */
1de14b707f1a3e block/genhd.c         Tetsuo Handa          2021-06-19  221  int ____register_blkdev(unsigned int major, const char *name,
1de14b707f1a3e block/genhd.c         Tetsuo Handa          2021-06-19  222  			void (*probe)(dev_t devt), struct module *owner)
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16 @223  {
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  224  	struct blk_major_name **n, *p;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  225  	int index, ret = 0;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  226  
e49fbbbf0aa14f block/genhd.c         Christoph Hellwig     2020-10-29  227  	mutex_lock(&major_names_lock);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  228  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  229  	/* temporary */
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  230  	if (major == 0) {
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  231  		for (index = ARRAY_SIZE(major_names)-1; index > 0; index--) {
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  232  			if (major_names[index] == NULL)
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  233  				break;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  234  		}
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  235  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  236  		if (index == 0) {
dfc76d11dd455a block/genhd.c         Keyur Patel           2019-02-17  237  			printk("%s: failed to get major for %s\n",
dfc76d11dd455a block/genhd.c         Keyur Patel           2019-02-17  238  			       __func__, name);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  239  			ret = -EBUSY;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  240  			goto out;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  241  		}
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  242  		major = index;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  243  		ret = major;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  244  	}
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  245  
133d55cdb2f1f9 block/genhd.c         Logan Gunthorpe       2017-06-16  246  	if (major >= BLKDEV_MAJOR_MAX) {
dfc76d11dd455a block/genhd.c         Keyur Patel           2019-02-17  247  		pr_err("%s: major requested (%u) is greater than the maximum (%u) for %s\n",
dfc76d11dd455a block/genhd.c         Keyur Patel           2019-02-17  248  		       __func__, major, BLKDEV_MAJOR_MAX-1, name);
133d55cdb2f1f9 block/genhd.c         Logan Gunthorpe       2017-06-16  249  
133d55cdb2f1f9 block/genhd.c         Logan Gunthorpe       2017-06-16  250  		ret = -EINVAL;
133d55cdb2f1f9 block/genhd.c         Logan Gunthorpe       2017-06-16  251  		goto out;
133d55cdb2f1f9 block/genhd.c         Logan Gunthorpe       2017-06-16  252  	}
133d55cdb2f1f9 block/genhd.c         Logan Gunthorpe       2017-06-16  253  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  254  	p = kmalloc(sizeof(struct blk_major_name), GFP_KERNEL);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  255  	if (p == NULL) {
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  256  		ret = -ENOMEM;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  257  		goto out;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  258  	}
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  259  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  260  	p->major = major;
a160c6159d4a0c block/genhd.c         Christoph Hellwig     2020-10-29  261  	p->probe = probe;
1de14b707f1a3e block/genhd.c         Tetsuo Handa          2021-06-19  262  	p->owner = owner;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  263  	strlcpy(p->name, name, sizeof(p->name));
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  264  	p->next = NULL;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  265  	index = major_to_index(major);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  266  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  267  	for (n = &major_names[index]; *n; n = &(*n)->next) {
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  268  		if ((*n)->major == major)
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  269  			break;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  270  	}
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  271  	if (!*n)
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  272  		*n = p;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  273  	else
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  274  		ret = -EBUSY;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  275  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  276  	if (ret < 0) {
f33ff110ef31bd block/genhd.c         Srivatsa S. Bhat      2018-02-05  277  		printk("register_blkdev: cannot get major %u for %s\n",
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  278  		       major, name);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  279  		kfree(p);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  280  	}
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  281  out:
e49fbbbf0aa14f block/genhd.c         Christoph Hellwig     2020-10-29  282  	mutex_unlock(&major_names_lock);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  283  	return ret;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  284  }
1de14b707f1a3e block/genhd.c         Tetsuo Handa          2021-06-19  285  EXPORT_SYMBOL(____register_blkdev);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  286  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--DocE+STaALJfprDB--

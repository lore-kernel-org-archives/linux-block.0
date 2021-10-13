Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D17C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A48360E8B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 14:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhJMOHV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 10:07:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:41413 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhJMOHV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 10:07:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="288305050"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="288305050"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="480812949"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Oct 2021 07:04:15 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1maere-0004fs-LF; Wed, 13 Oct 2021 14:04:14 +0000
Date:   Wed, 13 Oct 2021 22:03:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Christoph Hellwig <hch@infradead.org>,
        asml.silence@gmail.com
Subject: Re: [PATCH v2 2/3] block: don't hide inode from block_device users
Message-ID: <202110132240.XIPsx2L5-lkp@intel.com>
References: <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pavel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v5.15-rc5]
[cannot apply to axboe-block/for-next next-20211013]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Pavel-Begunkov/on-top-of-for-5-16-block/20211013-165953
base:    64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/9e538de87cc869bd26a3ca78da49d1437ec8688c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Pavel-Begunkov/on-top-of-for-5-16-block/20211013-165953
        git checkout 9e538de87cc869bd26a3ca78da49d1437ec8688c
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/fops.c: In function 'block_ioctl':
   block/fops.c:460:37: error: implicit declaration of function 'bdev_file_inode'; did you mean 'file_inode'? [-Werror=implicit-function-declaration]
     460 |  struct block_device *bdev = I_BDEV(bdev_file_inode(file));
         |                                     ^~~~~~~~~~~~~~~
         |                                     file_inode
>> block/fops.c:460:37: warning: passing argument 1 of 'I_BDEV' makes pointer from integer without a cast [-Wint-conversion]
     460 |  struct block_device *bdev = I_BDEV(bdev_file_inode(file));
         |                                     ^~~~~~~~~~~~~~~~~~~~~
         |                                     |
         |                                     int
   In file included from block/fops.c:9:
   include/linux/blkdev.h:1990:57: note: expected 'struct inode *' but argument is of type 'int'
    1990 | static inline struct block_device *I_BDEV(struct inode *inode)
         |                                           ~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors


vim +/I_BDEV +460 block/fops.c

cd82cca7ebfe9c Christoph Hellwig 2021-09-07  457  
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  458  static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  459  {
cd82cca7ebfe9c Christoph Hellwig 2021-09-07 @460  	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  461  	fmode_t mode = file->f_mode;
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  462  
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  463  	/*
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  464  	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  465  	 * to updated it before every ioctl.
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  466  	 */
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  467  	if (file->f_flags & O_NDELAY)
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  468  		mode |= FMODE_NDELAY;
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  469  	else
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  470  		mode &= ~FMODE_NDELAY;
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  471  
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  472  	return blkdev_ioctl(bdev, mode, cmd, arg);
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  473  }
cd82cca7ebfe9c Christoph Hellwig 2021-09-07  474  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+QahgC5+KEYLbs62
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+QahgC5+KEYLbs62--

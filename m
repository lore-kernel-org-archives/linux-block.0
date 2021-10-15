Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D00C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 00:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB3C610A0
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 00:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJOAnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 20:43:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:44456 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhJOAnE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 20:43:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="226593930"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="226593930"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:40:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="442330839"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.173.238]) ([10.249.173.238])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:40:54 -0700
Subject: Re: [kbuild-all] Re: [PATCH v2 2/3] block: don't hide inode from
 block_device users
To:     Pavel Begunkov <asml.silence@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christoph Hellwig <hch@infradead.org>
References: <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
 <202110132327.Ohu5ObDj-lkp@intel.com>
 <ebe92ed4-6847-0ec0-d5e7-e3485ba7e049@gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <46559402-1d69-455d-ad09-27f43f6c0a3a@intel.com>
Date:   Fri, 15 Oct 2021 08:40:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ebe92ed4-6847-0ec0-d5e7-e3485ba7e049@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/13/2021 11:12 PM, Pavel Begunkov wrote:
> On 10/13/21 16:03, kernel test robot wrote:
>> Hi Pavel,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on v5.15-rc5]
> 
> It's against for-5.16/block and there is no more block_ioctl() in
> fops.c, should be fine

Hi Pavel,

Thanks for the feedback, we'll take a look.

Best Regards,
Rong Chen

> 
> 
>> [cannot apply to axboe-block/for-next next-20211013]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    
>> https://github.com/0day-ci/linux/commits/Pavel-Begunkov/on-top-of-for-5-16-block/20211013-165953 
>>
>> base:    64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
>> config: hexagon-randconfig-r045-20211013 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 
>> b6a8c695542b2987eb9a203d5663a0740cb4725f)
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://github.com/0day-ci/linux/commit/9e538de87cc869bd26a3ca78da49d1437ec8688c 
>>
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> Pavel-Begunkov/on-top-of-for-5-16-block/20211013-165953
>>          git checkout 9e538de87cc869bd26a3ca78da49d1437ec8688c
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
>> W=1 ARCH=hexagon
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>>> block/fops.c:460:37: error: implicit declaration of function 
>>>> 'bdev_file_inode' [-Werror,-Wimplicit-function-declaration]
>>             struct block_device *bdev = I_BDEV(bdev_file_inode(file));
>>                                                ^
>>     block/fops.c:460:37: note: did you mean 'file_inode'?
>>     include/linux/fs.h:1348:29: note: 'file_inode' declared here
>>     static inline struct inode *file_inode(const struct file *f)
>>                                 ^
>>>> block/fops.c:460:37: warning: incompatible integer to pointer 
>>>> conversion passing 'int' to parameter of type 'struct inode *' 
>>>> [-Wint-conversion]
>>             struct block_device *bdev = I_BDEV(bdev_file_inode(file));
>>                                                ^~~~~~~~~~~~~~~~~~~~~
>>     include/linux/blkdev.h:1990:57: note: passing argument to 
>> parameter 'inode' here
>>     static inline struct block_device *I_BDEV(struct inode *inode)
>>                                                             ^
>>     1 warning and 1 error generated.
>>
>>
>> vim +/bdev_file_inode +460 block/fops.c
>>
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  457
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  458  static long 
>> block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  459  {
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07 @460      struct 
>> block_device *bdev = I_BDEV(bdev_file_inode(file));
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  461      fmode_t mode = 
>> file->f_mode;
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  462
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  463      /*
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  464       * O_NDELAY can 
>> be altered using fcntl(.., F_SETFL, ..), so we have
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  465       * to updated it 
>> before every ioctl.
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  466       */
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  467      if 
>> (file->f_flags & O_NDELAY)
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  468          mode |= 
>> FMODE_NDELAY;
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  469      else
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  470          mode &= 
>> ~FMODE_NDELAY;
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  471
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  472      return 
>> blkdev_ioctl(bdev, mode, cmd, arg);
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  473  }
>> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  474
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 

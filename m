Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0F461139
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhJMPPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhJMPPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:15:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D069C061570;
        Wed, 13 Oct 2021 08:13:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g25so9571979wrb.2;
        Wed, 13 Oct 2021 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ypf4UB4jLNFC7rjiZtJ7uugz3uCxfjD/BIFYl8wDcNc=;
        b=e2pvKsW9RKgjGMPzIHjlXeUqADY9uRK/Ju6eMXeG4y4TM0IE2t5S0xe5SrkHJZQRVR
         vxxKqMSy0fx2tM9h1yY1FTDTdcFeAnRz28grmPWYW9Z+CE9k1xXhoWl8g6ZHaiH7fmbN
         uCTvlbEZruWvXFejHkZT7mXMnvgkytXdMOU0qXXBDvQVQpq198GmokZ4kAqpc1lVT6Po
         6F1rPqig15tTsG61k4IpB9i5zC+1x/k/Ikpk0bm1na0PE+MZeIs0NPIDnnKi5BY8/Osu
         KrK/jbbNdN49sY4poPb7TXI2BagijvSCyS3ziDI9M2Ujf3vqEEWC9rQEYZaLM0M6JdRb
         mzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ypf4UB4jLNFC7rjiZtJ7uugz3uCxfjD/BIFYl8wDcNc=;
        b=TZ3eSrBm8EuCiYgYXvRo3wOu7ggnEsfWFXTbGla/b75ooFAYTJss8j+JHHjRe6oCTJ
         AjvO/IAg+ZHxOiWnBuBxuaURZ3KTvqPpnoZyPXGbjaVHjuYxL9hBpvsGl6FHIZMWGMPi
         Ih81g2CpvD7AmhMJ5KvuMMgCeE3rRMvdL4Irsvt5HHj3wwG0gnNaDW/+R98e1ORvGVm7
         DOK3mG5lrJ32YK4SSMUUr4vQo2bHar+nfsZ7+SAu9hJNnvGuDEcn3vY98RgDNoxeCI5q
         vMM3RI+fuNwQsWM1+In6xuanMJIHCSioCG4MrtoD8ETi7mKkyx3x/ZRM6A3kdAfmg6PG
         lHDg==
X-Gm-Message-State: AOAM532t8E/eJPZGSXg54J4aW8rhROtiwXeB2SGWBt44YDrGvR1FXuOl
        zNXOcV7x6FLvMmvbxZF0r2E=
X-Google-Smtp-Source: ABdhPJz3QyWUVtbZeSH6EMftGgGvG7WpSoa13clr3xwd1pDkYF2eKx4vxn4Kcq1/02w/JHsZFFxY6w==
X-Received: by 2002:a05:600c:2111:: with SMTP id u17mr13249189wml.162.1634138006941;
        Wed, 13 Oct 2021 08:13:26 -0700 (PDT)
Received: from [192.168.8.197] ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id p17sm13592457wro.34.2021.10.13.08.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:13:26 -0700 (PDT)
Message-ID: <ebe92ed4-6847-0ec0-d5e7-e3485ba7e049@gmail.com>
Date:   Wed, 13 Oct 2021 16:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 2/3] block: don't hide inode from block_device users
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christoph Hellwig <hch@infradead.org>
References: <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
 <202110132327.Ohu5ObDj-lkp@intel.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <202110132327.Ohu5ObDj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 16:03, kernel test robot wrote:
> Hi Pavel,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on v5.15-rc5]

It's against for-5.16/block and there is no more block_ioctl() in
fops.c, should be fine


> [cannot apply to axboe-block/for-next next-20211013]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Pavel-Begunkov/on-top-of-for-5-16-block/20211013-165953
> base:    64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
> config: hexagon-randconfig-r045-20211013 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a8c695542b2987eb9a203d5663a0740cb4725f)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/9e538de87cc869bd26a3ca78da49d1437ec8688c
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Pavel-Begunkov/on-top-of-for-5-16-block/20211013-165953
>          git checkout 9e538de87cc869bd26a3ca78da49d1437ec8688c
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>>> block/fops.c:460:37: error: implicit declaration of function 'bdev_file_inode' [-Werror,-Wimplicit-function-declaration]
>             struct block_device *bdev = I_BDEV(bdev_file_inode(file));
>                                                ^
>     block/fops.c:460:37: note: did you mean 'file_inode'?
>     include/linux/fs.h:1348:29: note: 'file_inode' declared here
>     static inline struct inode *file_inode(const struct file *f)
>                                 ^
>>> block/fops.c:460:37: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct inode *' [-Wint-conversion]
>             struct block_device *bdev = I_BDEV(bdev_file_inode(file));
>                                                ^~~~~~~~~~~~~~~~~~~~~
>     include/linux/blkdev.h:1990:57: note: passing argument to parameter 'inode' here
>     static inline struct block_device *I_BDEV(struct inode *inode)
>                                                             ^
>     1 warning and 1 error generated.
> 
> 
> vim +/bdev_file_inode +460 block/fops.c
> 
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  457
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  458  static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  459  {
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07 @460  	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  461  	fmode_t mode = file->f_mode;
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  462
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  463  	/*
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  464  	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  465  	 * to updated it before every ioctl.
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  466  	 */
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  467  	if (file->f_flags & O_NDELAY)
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  468  		mode |= FMODE_NDELAY;
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  469  	else
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  470  		mode &= ~FMODE_NDELAY;
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  471
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  472  	return blkdev_ioctl(bdev, mode, cmd, arg);
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  473  }
> cd82cca7ebfe9c Christoph Hellwig 2021-09-07  474
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

-- 
Pavel Begunkov

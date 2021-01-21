Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207E6C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11802245C
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbhAUNax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:30:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:64208 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbhAUNaD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 08:30:03 -0500
IronPort-SDR: vdottU3rK3av7lwRwssASgiGYPdkbAfbPjROVKH0/zQWFEGyghKCDBQddxoYntTHFBL2Wioz9e
 BRf0cAGqGXzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="179417710"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="gz'50?scan'50,208,50";a="179417710"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 05:29:18 -0800
IronPort-SDR: UA+z8c4//8jzg29mXszJXVfvVGhTmxDH3CCK8sb//A0b81G4GXqUBqnOpNiQblggRrbznwpN8Z
 YTOMdIrsS7eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="gz'50?scan'50,208,50";a="407275343"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jan 2021 05:29:15 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2a1T-0006XY-1U; Thu, 21 Jan 2021 13:29:15 +0000
Date:   Thu, 21 Jan 2021 21:28:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Kosina <jikos@kernel.org>, Denis Efremov <efremov@linux.com>
Cc:     kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: [PATCH] floppy: reintroduce O_NDELAY fix
Message-ID: <202101212136.UDIlSh1F-lkp@intel.com>
References: <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiri,

I love your patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on linux/master linus/master v5.11-rc4 next-20210121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiri-Kosina/floppy-reintroduce-O_NDELAY-fix/20210121-182951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: sparc64-randconfig-r033-20210121 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/605da67173ab7c362845b2f74c2914bfcec6db2e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiri-Kosina/floppy-reintroduce-O_NDELAY-fix/20210121-182951
        git checkout 605da67173ab7c362845b2f74c2914bfcec6db2e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/floppy.h:5,
                    from drivers/block/floppy.c:251:
   arch/sparc/include/asm/floppy_64.h:200:13: warning: no previous prototype for 'sparc_floppy_irq' [-Wmissing-prototypes]
     200 | irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie)
         |             ^~~~~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/floppy.h:5,
                    from drivers/block/floppy.c:251:
   arch/sparc/include/asm/floppy_64.h:437:6: warning: no previous prototype for 'sun_pci_fd_dma_callback' [-Wmissing-prototypes]
     437 | void sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event, void *cookie)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/floppy.c: In function 'floppy_open':
>> drivers/block/floppy.c:4125:3: error: 'UDRS' undeclared (first use in this function)
    4125 |   UDRS->last_checked = 0;
         |   ^~~~
   drivers/block/floppy.c:4125:3: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/block/floppy.c:4127:3: error: implicit declaration of function 'check_disk_change'; did you mean 'bdev_disk_changed'? [-Werror=implicit-function-declaration]
    4127 |   check_disk_change(bdev);
         |   ^~~~~~~~~~~~~~~~~
         |   bdev_disk_changed
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
   Depends on COMPAT && BINFMT_ELF
   Selected by
   - COMPAT && SPARC64
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS || MCOUNT
   Selected by
   - LOCKDEP && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


vim +/UDRS +4125 drivers/block/floppy.c

  4052	
  4053	/*
  4054	 * floppy_open check for aliasing (/dev/fd0 can be the same as
  4055	 * /dev/PS0 etc), and disallows simultaneous access to the same
  4056	 * drive with different device numbers.
  4057	 */
  4058	static int floppy_open(struct block_device *bdev, fmode_t mode)
  4059	{
  4060		int drive = (long)bdev->bd_disk->private_data;
  4061		int old_dev, new_dev;
  4062		int try;
  4063		int res = -EBUSY;
  4064		char *tmp;
  4065	
  4066		mutex_lock(&floppy_mutex);
  4067		mutex_lock(&open_lock);
  4068		old_dev = drive_state[drive].fd_device;
  4069		if (opened_bdev[drive] && opened_bdev[drive] != bdev)
  4070			goto out2;
  4071	
  4072		if (!drive_state[drive].fd_ref && (drive_params[drive].flags & FD_BROKEN_DCL)) {
  4073			set_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags);
  4074			set_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
  4075		}
  4076	
  4077		drive_state[drive].fd_ref++;
  4078	
  4079		opened_bdev[drive] = bdev;
  4080	
  4081		res = -ENXIO;
  4082	
  4083		if (!floppy_track_buffer) {
  4084			/* if opening an ED drive, reserve a big buffer,
  4085			 * else reserve a small one */
  4086			if ((drive_params[drive].cmos == 6) || (drive_params[drive].cmos == 5))
  4087				try = 64;	/* Only 48 actually useful */
  4088			else
  4089				try = 32;	/* Only 24 actually useful */
  4090	
  4091			tmp = (char *)fd_dma_mem_alloc(1024 * try);
  4092			if (!tmp && !floppy_track_buffer) {
  4093				try >>= 1;	/* buffer only one side */
  4094				INFBOUND(try, 16);
  4095				tmp = (char *)fd_dma_mem_alloc(1024 * try);
  4096			}
  4097			if (!tmp && !floppy_track_buffer)
  4098				fallback_on_nodma_alloc(&tmp, 2048 * try);
  4099			if (!tmp && !floppy_track_buffer) {
  4100				DPRINT("Unable to allocate DMA memory\n");
  4101				goto out;
  4102			}
  4103			if (floppy_track_buffer) {
  4104				if (tmp)
  4105					fd_dma_mem_free((unsigned long)tmp, try * 1024);
  4106			} else {
  4107				buffer_min = buffer_max = -1;
  4108				floppy_track_buffer = tmp;
  4109				max_buffer_sectors = try;
  4110			}
  4111		}
  4112	
  4113		new_dev = MINOR(bdev->bd_dev);
  4114		drive_state[drive].fd_device = new_dev;
  4115		set_capacity(disks[drive][ITYPE(new_dev)], floppy_sizes[new_dev]);
  4116		if (old_dev != -1 && old_dev != new_dev) {
  4117			if (buffer_drive == drive)
  4118				buffer_track = -1;
  4119		}
  4120	
  4121		if (fdc_state[FDC(drive)].rawcmd == 1)
  4122			fdc_state[FDC(drive)].rawcmd = 2;
  4123	
  4124		if (mode & (FMODE_READ|FMODE_WRITE)) {
> 4125			UDRS->last_checked = 0;
  4126			clear_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags);
> 4127			check_disk_change(bdev);
  4128			if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
  4129				goto out;
  4130			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
  4131				goto out;
  4132		}
  4133	
  4134		res = -EROFS;
  4135	
  4136		if ((mode & FMODE_WRITE) &&
  4137				!test_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags))
  4138			goto out;
  4139	
  4140		mutex_unlock(&open_lock);
  4141		mutex_unlock(&floppy_mutex);
  4142		return 0;
  4143	out:
  4144		drive_state[drive].fd_ref--;
  4145	
  4146		if (!drive_state[drive].fd_ref)
  4147			opened_bdev[drive] = NULL;
  4148	out2:
  4149		mutex_unlock(&open_lock);
  4150		mutex_unlock(&floppy_mutex);
  4151		return res;
  4152	}
  4153	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--

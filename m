Return-Path: <SRS0=3zrn=Z6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3431C43603
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 19:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC380205F4
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 19:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLHTBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Dec 2019 14:01:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:55725 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfLHTBu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Dec 2019 14:01:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 11:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,292,1571727600"; 
   d="gz'50?scan'50,208,50";a="237531918"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2019 11:01:46 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ie1oQ-0009LP-9u; Mon, 09 Dec 2019 03:01:46 +0800
Date:   Mon, 9 Dec 2019 03:01:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Moritz =?iso-8859-1?Q?M=FCller?= <moritzm.mueller@posteo.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Moritz =?iso-8859-1?Q?M=FCller?= <moritzm.mueller@posteo.de>,
        "Philip K ." <philip@warpmail.net>
Subject: Re: [PATCH] floppy: hide invalid floppy disk types
Message-ID: <201912090250.2GA18ReD%lkp@intel.com>
References: <20191208165900.25588-1-moritzm.mueller@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h4s7o4xsit75xqkr"
Content-Disposition: inline
In-Reply-To: <20191208165900.25588-1-moritzm.mueller@posteo.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--h4s7o4xsit75xqkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Moritz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on linux/master linus/master v5.4 next-20191208]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Moritz-M-ller/floppy-hide-invalid-floppy-disk-types/20191209-010317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: alpha-defconfig (attached as .config)
compiler: alpha-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/block/floppy.c: In function 'config_types':
>> drivers/block/floppy.c:3954:0: error: unterminated #ifdef
    #ifdef
    
   drivers/block/floppy.c:3952:0: error: unterminated #ifdef
    #ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
    
>> drivers/block/floppy.c:3951:3: error: expected declaration or statement at end of input
      } else {
      ^
>> drivers/block/floppy.c:3951:3: error: expected declaration or statement at end of input
   drivers/block/floppy.c:3942:8: warning: unused variable 'temparea' [-Wunused-variable]
      char temparea[32];
           ^~~~~~~~
>> drivers/block/floppy.c:3951:3: error: expected declaration or statement at end of input
      } else {
      ^
   drivers/block/floppy.c:3925:7: warning: unused variable 'has_drive' [-Wunused-variable]
     bool has_drive = false;
          ^~~~~~~~~
   drivers/block/floppy.c: At top level:
   drivers/block/floppy.c:563:12: warning: 'floppy_request_regions' declared 'static' but never defined [-Wunused-function]
    static int floppy_request_regions(int);
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/block/floppy.c:564:13: warning: 'floppy_release_regions' declared 'static' but never defined [-Wunused-function]
    static void floppy_release_regions(int);
                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/block/floppy.c:565:12: warning: 'floppy_grab_irq_and_dma' declared 'static' but never defined [-Wunused-function]
    static int floppy_grab_irq_and_dma(void);
               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/floppy.c:566:13: warning: 'floppy_release_irq_and_dma' declared 'static' but never defined [-Wunused-function]
    static void floppy_release_irq_and_dma(void);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/floppy.c:3923:20: warning: 'config_types' defined but not used [-Wunused-function]
    static void __init config_types(void)
                       ^~~~~~~~~~~~
   drivers/block/floppy.c:3585:12: warning: 'fd_ioctl' defined but not used [-Wunused-function]
    static int fd_ioctl(struct block_device *bdev, fmode_t mode,
               ^~~~~~~~
   drivers/block/floppy.c:3368:12: warning: 'fd_getgeo' defined but not used [-Wunused-function]
    static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
               ^~~~~~~~~
   drivers/block/floppy.c:2887:21: warning: 'floppy_queue_rq' defined but not used [-Wunused-function]
    static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
                        ^~~~~~~~~~~~~~~
   drivers/block/floppy.c:505:13: warning: 'floppy_device_name' defined but not used [-Wunused-variable]
    static char floppy_device_name[] = "floppy";
                ^~~~~~~~~~~~~~~~~~
   drivers/block/floppy.c:418:30: warning: 'tag_sets' defined but not used [-Wunused-variable]
    static struct blk_mq_tag_set tag_sets[N_DRIVE];
                                 ^~~~~~~~
   drivers/block/floppy.c:417:24: warning: 'disks' defined but not used [-Wunused-variable]
    static struct gendisk *disks[N_DRIVE];
                           ^~~~~
   drivers/block/floppy.c:254:12: warning: 'irqdma_allocated' defined but not used [-Wunused-variable]
    static int irqdma_allocated;
               ^~~~~~~~~~~~~~~~
   In file included from drivers/block/floppy.c:252:0:
   arch/alpha/include/asm/floppy.h:81:12: warning: 'FDC2' defined but not used [-Wunused-variable]
    static int FDC2 = -1;
               ^~~~
   arch/alpha/include/asm/floppy.h:80:12: warning: 'FDC1' defined but not used [-Wunused-variable]
    static int FDC1 = 0x3f0;
               ^~~~
   drivers/block/floppy.c:211:12: warning: 'can_use_virtual_dma' defined but not used [-Wunused-variable]
    static int can_use_virtual_dma = 2;
               ^~~~~~~~~~~~~~~~~~~
   drivers/block/floppy.c:209:12: warning: 'FLOPPY_IRQ' defined but not used [-Wunused-variable]
    static int FLOPPY_IRQ = 6;
               ^~~~~~~~~~

vim +3954 drivers/block/floppy.c

  3922	
  3923	static void __init config_types(void)
  3924	{
  3925		bool has_drive = false;
  3926		int drive;
  3927	
  3928		/* read drive info out of physical CMOS */
  3929		drive = 0;
  3930		if (!UDP->cmos)
  3931			UDP->cmos = FLOPPY0_TYPE;
  3932		drive = 1;
  3933		if (!UDP->cmos)
  3934			UDP->cmos = FLOPPY1_TYPE;
  3935	
  3936		/* FIXME: additional physical CMOS drive detection should go here */
  3937	
  3938		for (drive = 0; drive < N_DRIVE; drive++) {
  3939			unsigned int type = UDP->cmos;
  3940			struct floppy_drive_params *params;
  3941			const char *name = NULL;
  3942			char temparea[32];
  3943	
  3944			if (type < ARRAY_SIZE(default_drive_params)) {
  3945				params = &default_drive_params[type].params;
  3946				if (type) {
  3947					name = default_drive_params[type].name;
  3948					allowed_drive_mask |= 1 << drive;
  3949				} else
  3950					allowed_drive_mask &= ~(1 << drive);
> 3951			} else {
  3952	#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
  3953				params = &default_drive_params[0].params;
> 3954	#ifdef
  3955				snprintf(temparea, sizeof(temparea),
  3956					 "unknown type %d (usb?)", type);
  3957				name = temparea;
  3958			}
  3959			if (name) {
  3960				const char *prepend;
  3961				if (!has_drive) {
  3962					prepend = "";
  3963					has_drive = true;
  3964					pr_info("Floppy drive(s):");
  3965				} else {
  3966					prepend = ",";
  3967				}
  3968	
  3969				pr_cont("%s fd%d is %s", prepend, drive, name);
  3970			}
  3971			*UDP = *params;
  3972		}
  3973	
  3974		if (has_drive)
  3975			pr_cont("\n");
  3976	}
  3977	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--h4s7o4xsit75xqkr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9i/yzcFzs0zlptk8F/LiL6AKDSZfq7y97Q8n/ZrHWWwlDsft191yc1DA0s3lw8ZGYc1BtXns
zbzI7vltv92dOkfpwCkSe+qBglEZdio2TR3/2p6evpk51V3aZWUMBMHW9u2t6Y1hxCxPHlBK
e4q3vZy1far2mpM0p1dNzay8oj0jYWrx5MA6iSj1TYlS0IKxh8LORaiUlS36lEVLxEj5vq02
Sf728PqXXMOXPQjHQTvPXaoLNnq2m6wEQ0075RWgPrp8mDIy+hZpvvdSrUF/XO09RXkRRl4D
6RxiN6yBPZ17jC6svFMAsmCW858SIN8SVs2A5x+B1jT7wBKG+DrGNVi9iTMp5PpSeJrliyyE
D+TSkApa3W/Sb1INxUOtlPt+dJ6Vpu48RtKLNUOUgGXAthvwQWy7bSTM4pz4hjmVN0DlNdLm
DmgKYQyo6e7pK+tnhmpKrF0JgI+K9xGIBApIc9ibHvan/dP+RTNMYII6laubQaZbR3EWhvLD
0H8N8Tu3xPwwSdN1JWdZPI+TZZzLxI9pv2GPJZGpW2mwOPeAoTS9nq7MzkcNziJi8p1qcpgk
aXuuqJeqGwrqYuPDx2GzmK1TkUjcaO8ec+23qRQLz9D5/Ax9Zb46W9MZMgeMirnSKcbewtwD
BFe59GhyYsmXNl2cmQLj3SUqvfVFRDqGr8+XhS2HBIS87+zV/rreaHm3Znt86mzsWhOpy73y
5aw5GESxsDybEdSPlHo0UkmMw4RnYAhAUy8otijCWZqDu2gkcduK6ZZ78B67DXzl4xtw0j2/
b3/rhZ/2NUZ5WYuAdo06fk09JUXJ76/x6s7I9V5VrSv3w9VkwKvyCXLx9+bo0N3xdHh/VY+q
jt/AID07p8Nmd5TtOC/bXeE8w/pt3+Sfulr+f9RW1ZHM8GwcPw2Q86W2gc/7v3bSDlbHm87P
h+K/79tDAR1M8S+1J0h3p+LFiSh2/sc5FC/qtwgMzFqA3hj40XWeaaQJzXyQePloES48M8uM
vIlWvjfq+7hdCBN8ZUXMkItilCPzk+bORurEJdTT/KHyozQtL8XmWEArEPzsn9Q6qZza79vn
Qv732+F4UoHnt+Ll7fft7sve2e8c+QJFOYO6RfJIvvJBE0VJry+ZaqZxwLuFoLnUnfGBUpFE
3nvOo9ULvG47gSeb6lz6aEpTUzyk9YO9gQUti5sHFISxhHHLMKEDS7pTThrxOYRJ2JxwBYB8
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
jsXWO/KNjKtWYAnvMqRX5IkL4T8HGgNVRtUAAA==

--h4s7o4xsit75xqkr--

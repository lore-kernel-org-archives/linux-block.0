Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936926ACD;
	Thu,  9 May 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253849; cv=none; b=Fe7/jhMFWHMf25IP4c0/RyvAqk6FzEj2AaPI6K12S2yz9qDvnfVP2H0b9MCkaIA3GA5Qavri98qHV9jaRDCNmEjHYOdgqkkfYIrDwKupCctCjguIeU1oiN/9gsNUUgkCKA2tEP+HX3enAMEeP13g7d+yVJvdLL/SpGppSz/2Q7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253849; c=relaxed/simple;
	bh=tLMPuK2Ly0RBsmWYYg9cOjP/3RZQ19gOk8kWcXXHoFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq4wvmjQVkHvEWaMXjGWlg6ZmwjgiwFshAutKQfFuuJBRXigoiqjxZdZCgwapyF4GmD+MBCHiXQFE81BrFG2cuE8/+sRdgI+xETu3PlYeMoYARwxyqjPEEjpzGEXH1EkT1IXssypu75KuyN8S15+jnL6OtZ0d2gAwo8yKGvBUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhAowGzz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhAowGzz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715253847; x=1746789847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tLMPuK2Ly0RBsmWYYg9cOjP/3RZQ19gOk8kWcXXHoFA=;
  b=LhAowGzzqmFj5R/IT1RXDb8duTAm+3AH+2Rd8XKPFHQpplF2wWcHv7Nk
   BbH6PXbT1qFDoS+L4i0idLa1+PmunxYl3QE8kEvZBHZNo0be0cV5KIvic
   vSVRhR0IQDj93X7b4Hf7BPDJUrleKJQxgjvmR6MtfUjb2ezg1TjXTav65
   laQN7DNBDcU5bctQC1gxpkP4RQy7vdh2C9T/Han0NhJ3JG+qcmdgdDBv6
   goNYO30QVB7uSJ9K5lw2H9KBDseXb1Rskdobi1Lr7R810mDQwnkFqiIo9
   lL6pNnVoidoylpz1MR51PJicACbWN9ZDrJhbgbL03SDzzVhzB67SrGfq9
   A==;
X-CSE-ConnectionGUID: RQpotY0oSLq1sr9yOFZmxQ==
X-CSE-MsgGUID: 9qbDQ3zxTzqhbRyAxaWCag==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21838608"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="21838608"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 04:24:07 -0700
X-CSE-ConnectionGUID: TDrF/mY/TVCfXE0QIr001A==
X-CSE-MsgGUID: wwK+3fd5SpSj0LfYkrLsCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="33680718"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 May 2024 04:24:04 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s51sY-0004pA-0c;
	Thu, 09 May 2024 11:24:02 +0000
Date: Thu, 9 May 2024 19:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv3 02/19] zram: add lzo and lzorle compression backends
 support
Message-ID: <202405091921.320BxOyE-lkp@intel.com>
References: <20240508074223.652784-3-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508074223.652784-3-senozhatsky@chromium.org>

Hi Sergey,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.9-rc7 next-20240509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Senozhatsky/zram-move-from-crypto-API-to-custom-comp-backends-API/20240508-154917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240508074223.652784-3-senozhatsky%40chromium.org
patch subject: [PATCHv3 02/19] zram: add lzo and lzorle compression backends support
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240509/202405091921.320BxOyE-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405091921.320BxOyE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405091921.320BxOyE-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_dma_buf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-evtchn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-privcmd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_hdlc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_gsm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/intel-gtt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/lp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/ppdev.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/tlclk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/bochs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/cirrus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/i915/kvmgt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/brd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/loop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/hmem/dax_hmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/device_dax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/kmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/dax_pmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/isci/isci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/au8522_decoder.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/mb86a16.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/asus_atk0110.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/intel_soc_dts_iosf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/mmc_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/sdio_uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-a4tech.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-apple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-aureal.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-belkin.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cherry.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-chicony.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cypress.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-dr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-elecom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ezkey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gyration.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ite.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensington.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-keytouch.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kye.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lcpower.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lenovo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-logitech.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lg-g15.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-logitech-dj.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-logitech-hidpp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-microsoft.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-monterey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ortek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-pl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-petalynx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-primax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-saitek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-samsung.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sjoy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-speedlink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-steelseries.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gaff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tmff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tivo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-topseed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-twinhan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-xinmo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zpff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zydacron.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-waltop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/intel-ish-hid/intel-ishtp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-vbtn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-rst.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/amilo-rfkill.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ras/amd/atl/amd_atl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/libnvdimm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_pmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_btt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_e820.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_cif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_aec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dca/dca.o
>> ERROR: modpost: "backend_lzorle" [drivers/block/zram/zram.ko] undefined!
>> ERROR: modpost: "backend_lzo" [drivers/block/zram/zram.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

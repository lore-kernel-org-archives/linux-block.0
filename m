Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322512;
	b=Ar50zVDJWdUSHUDKRQZItXndZ5MJ59sOpj1OYUOCZiEBsMPdDh0U7zG/xlkJIuG0emi+
	 mGAE/Cj/lh6jj2E1g3i8psU6RmmUWCCr263WwvXtPGFo1tpAWLIQKG2q85vjaDWR+zCQ6
	 gUFbjszeZ2LRTSGBKjnxCQFt4z0L+ZNAyaXOEtgOWUJFYftOx6USRtwmHQdMRAm1k0yQE
	 5R+dG1vrUjXDA3du9dd2OdytJHtW8eUYbF3rM3yvWcTWXBu3iLtwhoKJlGAWZlc3oNXs0
	 nQIW6Qljjn/8+tfTahJ2EDcoC/YuETwRm33UKA1yCE8GJK03b/XCh0VyM9o+l16ODjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322512;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1B0jHfPMPRZ62CirrzvLJZkEODLPD+5eeWn2nBfOIhs=;
	b=H8gR3mhZgldSFQO1cQ0uj27pBj+nLzUN/Ooifg4blZ4VRj/aPxgoQsWeIrHFMdAKFBFj
	 bBarSsigPwxOtmt3jY4qytjYLrPNE0MnkDnAkco4TMqGCCaqH7dwjcI1rbQh6R07uRRJE
	 lVmdrzWYQu962Ign1ICFIo6+G2NukB5tRp9lw8vL39/Y0WgOUxAGLaPL7uM/GIkyuXuAl
	 Gf6U6dp1trFLIN5oy6H45V9Fj7ZEWgU6bPv8jO1+WHWo+9brNi7N2QtiY+gZAgigpxCNu
	 iOrcNSfVF3gcl+VIzFxbKnqYFvEIuesE7imaHm2XvEa8MksGdWTRQRBaZI0D43+/mSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rf+Ja+Ah;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E71606A31C
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rf+Ja+Ah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793322511; x=1824858511;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=BQciK/2oCEkdbtbnIXAYM4Zt4tCgCiv7fHDlEIqdxeo=;
  b=Rf+Ja+AhyanyIGmrsf8EsYVTY62MJ/UhByQmfc9BMkh61KSundRRFzPY
   a2Or/arl67K4s2gEA/ufdf9pNK1Qkly+q6Pc1vC+hrCgecVOHrhimD0F7
   8eMdDOv/6cElL9bcZ5NGBYbdofsQJjBZrONZUDeuyXp9wnqlxZTum3+90
   zT3EeVf4AaQhEk1JJLyDIKP2bZhL7pOtWy4C4f5Ut+nzLpcCnGWT2RFHf
   nR6YMx31UHUP7DedYde9QC7Kqk0q4LrFav9/WBRplBGPjnTnO4R68DjzZ
   8ODFYWpnRzebh8cY51evdJ5ikTbfKVVcVp+l2pHmoilhUYPllAEt/MwDG
   Q==;
X-CSE-ConnectionGUID: D7a7vXiDRZSRMtlcMh5H6w==
X-CSE-MsgGUID: AdKjvE4yREyHbaGK4Y0D+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2184698"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2184698"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:08:30 -0700
X-CSE-ConnectionGUID: iWmivEeeRse+B+PfpvCX9w==
X-CSE-MsgGUID: PvM8eMDdRCOhRp5NVbumuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5212027"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:08:27 -0700
Date: Fri, 30 Oct 2026 09:08:23 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Bart Van Assche <bvanassche@acm.org>, yi1.lai@intel.com
Subject: Re: [PATCH] block: Wait for inflight requests in bdev_release()
Message-ID: <202610300858.1721b701-lkp@intel.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53c3ccf7-1a5e-4861-afc0-7cbfd3284655@I-love.SAKURA.ne.jp>


Hello,

kernel test robot noticed "blktests.loop/003.fail" on:

commit: 7ec8033abf279c978b0e9ffcc03367e24fd6205b ("[PATCH] block: Wait for inflight requests in bdev_release()")
url: https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/block-Wait-for-inflight-requests-in-bdev_release/20261012-172605
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-next patch link: https://lore.kernel.org/all/53c3ccf7-1a5e-4861-afc0-7cbfd3284655@I-love.SAKURA.ne.jp/
patch subject: [PATCH] block: Wait for inflight requests in bdev_release()

in testcase: blktests
version: blktests-x86_64-0027abd-1_20261027
with following parameters:

	test: loop-group-00


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610300858.1721b701-lkp@intel.com


2026-10-29 13:18:00 cd /lkp/benchmarks/blktests
2026-10-29 13:18:01 sed "s:^:loop/:" /lkp/benchmarks/blktests/tests/loop-group-00
2026-10-29 13:18:01 ./check loop/001 loop/002 loop/003 loop/004 loop/005 loop/006 loop/007 loop/008 loop/009 loop/010 loop/011 loop/012 loop/013
loop/001 (scan loop device partitions)                      
loop/001 (scan loop device partitions)                       [passed]
    runtime    ...  0.439s
loop/002 (try various loop device block sizes)              
loop/002 (try various loop device block sizes)               [passed]
    runtime    ...  0.332s
loop/003 (time opening and closing an unbound loop device)  
loop/003 (time opening and closing an unbound loop device)   [failed]
    runtime    ...  8.584s
    --- tests/loop/003.out	2026-10-27 23:51:50.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/loop/003.out.bad	2026-10-29 13:18:10.921226342 +0000
    @@ -1,3 +1,3 @@
     Running loop/003
    -Test took 0 seconds
    +Test took 8 seconds
     Test complete
loop/004 (combine loop direct I/O mode and a custom block size)
loop/004 (combine loop direct I/O mode and a custom block size) [passed]
    runtime    ...  14.512s
loop/005 (call LOOP_GET_STATUS{,64} with a NULL arg)        
loop/005 (call LOOP_GET_STATUS{,64} with a NULL arg)         [passed]
    runtime    ...  0.057s
loop/006 (change loop backing file while creating/removing another loop device)
loop/006 (change loop backing file while creating/removing another loop device) [failed]
    runtime    ...  89.048s
    --- tests/loop/006.out	2026-10-27 23:51:50.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/loop/006.out.bad	2026-10-29 13:19:54.981232346 +0000
    @@ -1,2 +1,3 @@
     Running loop/006
    +ioctl: Operation not supported
     Test complete
loop/007 (update loop device capacity with filesystem)      
loop/007 (update loop device capacity with filesystem)       [passed]
    runtime    ...  0.223s
loop/008 (setup GPT and ESP on a raw disk image)            
loop/008 (setup GPT and ESP on a raw disk image)             [passed]
    runtime    ...  0.497s
loop/009 (check that LOOP_CONFIGURE sends uevents for partitions)
loop/009 (check that LOOP_CONFIGURE sends uevents for partitions) [passed]
    runtime    ...  0.442s
loop/010 (check stale loop partition)                       
loop/010 (check stale loop partition)                        [passed]
    runtime    ...  92.316s
loop/011 (Make sure unsupported backing file fallocate does not fill dmesg with errors)
loop/011 (Make sure unsupported backing file fallocate does not fill dmesg with errors) [passed]
    runtime    ...  0.276s
loop/012 (check for spurious partition removal when partscan is enabled)
loop/012 (check for spurious partition removal when partscan is enabled) [not run]
    systemd version is older than 259
loop/013 (remove manually added partitions before loop device reuse)
loop/013 (remove manually added partitions before loop device reuse) [passed]
    runtime    ...  0.740s



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261030/202610300858.1721b701-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



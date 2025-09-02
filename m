Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AEC2E11B0
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794012; cv=none; b=E35ZSoZNM4CzOxuyqedL+j2ZYL6aJ/4J6JctSvPzg+vS+3OApaOKT/7kmnm4AHwulglvottD/Bo7wutxesNT0ZRDKvw73eKPKtM9vCaJJ9ihZE98S8afWnkBJwnoVtW1gHsqfi4k8YEzSBx4HKHh7RGsTWe8BAEJ6YrBHr+okaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794012; c=relaxed/simple;
	bh=NT1ttR5EgNfHEK6YgGDTK/2lGmsZiCOZNcfgI9sFHTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/E+ZPuWweXIGm0xrnjfuGW9BNgv2IuYNUT34XMNm8XUeP9O4weyjYVU5K3dynmPONHQ6fWTXcKLVvx/CzMDvH4SiA+VzdM3ybud9HHQFcMR7AV5vFAhcmdN5TdCR1HkDpMA/QCZ8t1cjLZSHFFePCdWwuZ8jlMpxJmgOJCZSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxT4nl0/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxT4nl0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756794011; x=1788330011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NT1ttR5EgNfHEK6YgGDTK/2lGmsZiCOZNcfgI9sFHTI=;
  b=IxT4nl0/hvbEBijuL5RJjfy0k+0yB9Jhrzgpvbl1mwOgdiSyTHF6SU9H
   0Y1ADmJtfTn/+tLdNWYJsrT1MTcHyMGzkJVQlxzQIAH9qQB0M/TgDUCbv
   s83jbVuSerIMAhrnq1iX09ICPc0AqJEbEQOMzMXZ2Tcr4LCf1/RcGF3+T
   tsTqzf4zHqbdyrQa79h6oSjzMsPckri1nqfnF3SwWCnRZeEgmV19wT3Gp
   j+u8NZawpQ2J+UQXE0WvOXdQK4e+f+aulb1zQfAF6xnGGFSS9OXJ4rGfI
   FXqcldIlJ692tkGn+rSv5G22eHUPxz2J0koBW8naRAhvPtsxFtCQIGUJ6
   A==;
X-CSE-ConnectionGUID: BTddzWnpTXKazDWV5THqTg==
X-CSE-MsgGUID: E7BCapnrSLuYwiYczdvnfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58907138"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58907138"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:20:10 -0700
X-CSE-ConnectionGUID: CPNpn/ijSL6JuAr7TeaBWA==
X-CSE-MsgGUID: TCrgNW2ATAeh18FvpouQ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="202113603"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 01 Sep 2025 23:20:09 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utKNB-0001VH-39;
	Tue, 02 Sep 2025 06:20:05 +0000
Date: Tue, 2 Sep 2025 14:19:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 09/23] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
Message-ID: <202509021316.7z4i5qbA-lkp@intel.com>
References: <20250901100242.3231000-10-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901100242.3231000-10-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes axboe-block/for-next linus/master v6.17-rc4 next-20250901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/ublk-add-parameter-struct-io_uring_cmd-to-ublk_prep_auto_buf_reg/20250901-181042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20250901100242.3231000-10-ming.lei%40redhat.com
patch subject: [PATCH 09/23] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
config: i386-buildonly-randconfig-004-20250902 (https://download.01.org/0day-ci/archive/20250902/202509021316.7z4i5qbA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250902/202509021316.7z4i5qbA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509021316.7z4i5qbA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/ublk_drv.c:2803:4: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
    2801 |                 pr_warn("%s: dev %u queue %u io %ld: commit failure %d\n",
         |                                                 ~~~
         |                                                 %d
    2802 |                         __func__, ubq->dev->dev_info.dev_id, ubq->q_id,
    2803 |                         io - ubq->ios, ret);
         |                         ^~~~~~~~~~~~~
   include/linux/printk.h:567:37: note: expanded from macro 'pr_warn'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                    ~~~     ^~~~~~~~~~~
   include/linux/printk.h:514:60: note: expanded from macro 'printk'
     514 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:486:19: note: expanded from macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +2803 drivers/block/ublk_drv.c

  2768	
  2769	static int ublk_batch_commit_io(struct ublk_io *io,
  2770					const struct ublk_batch_io_data *data)
  2771	{
  2772		const struct ublk_batch_io *uc = io_uring_sqe_cmd(data->cmd->sqe);
  2773		struct ublk_queue *ubq = data->ubq;
  2774		u16 buf_idx = UBLK_INVALID_BUF_IDX;
  2775		union ublk_io_buf buf = { 0 };
  2776		struct request *req = NULL;
  2777		bool auto_reg = false;
  2778		bool compl = false;
  2779		int ret;
  2780	
  2781		if (ublk_support_auto_buf_reg(data->ubq)) {
  2782			buf.auto_reg = ublk_batch_auto_buf_reg(uc, data->elem);
  2783			auto_reg = true;
  2784		} else if (ublk_need_map_io(data->ubq))
  2785			buf.addr = ublk_batch_buf_addr(uc, data->elem);
  2786	
  2787		ublk_io_lock(io);
  2788		ret = ublk_batch_commit_io_check(ubq, io, &buf);
  2789		if (!ret) {
  2790			io->res = data->elem->result;
  2791			io->buf = buf;
  2792			req = ublk_fill_io_cmd(io, data->cmd);
  2793	
  2794			if (auto_reg)
  2795				__ublk_handle_auto_buf_reg(io, data->cmd, &buf_idx);
  2796			compl = ublk_need_complete_req(ubq, io);
  2797		}
  2798		ublk_io_unlock(io);
  2799	
  2800		if (unlikely(ret)) {
  2801			pr_warn("%s: dev %u queue %u io %ld: commit failure %d\n",
  2802				__func__, ubq->dev->dev_info.dev_id, ubq->q_id,
> 2803				io - ubq->ios, ret);
  2804			return ret;
  2805		}
  2806	
  2807		/* can't touch 'ublk_io' any more */
  2808		if (buf_idx != UBLK_INVALID_BUF_IDX)
  2809			io_buffer_unregister_bvec(data->cmd, buf_idx, data->issue_flags);
  2810		if (req_op(req) == REQ_OP_ZONE_APPEND)
  2811			req->__sector = ublk_batch_zone_lba(uc, data->elem);
  2812		if (compl)
  2813			__ublk_complete_rq(req);
  2814		return 0;
  2815	}
  2816	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

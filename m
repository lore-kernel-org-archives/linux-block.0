Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157D35977
	for <linux-block@vger.kernel.org>; Sun,  9 Mar 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741505462; cv=none; b=iGGAEk1C+nun0etuluXjO6p3y+WswrDI6tHY65zN3i1em/zio0+8r5bUw0w0YzIn1c7Svvp6HrgjqgtcdVZcej9zn3crP5by3l736m6T0tsFNnhNh56kCF4qJsFfiZ5G83wByCuLj1U/kuv/Z2csW6WN4p4DoJDYHSOh6VkecP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741505462; c=relaxed/simple;
	bh=Cia6lT6xUuA8H+EcDTSFlbST4ImZJf631HXUGKhZ9l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1Aoz2Ss4hbpXzk710tayvh4IeeOzLk7moFrUUKRI7zo6TrB3rPHMy00iC8AWXfv3xFHo/rbr0cPbXiNHmLzH/vuaVQtmeuOL8HS8ENFVPyl9GPJSHo1v4QumlhGjz4lU5JyiVwfTVMc2Wkm0s98OgvTWEgqXJ+o3ouqtcYJsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdIJcUrb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdIJcUrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741505461; x=1773041461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cia6lT6xUuA8H+EcDTSFlbST4ImZJf631HXUGKhZ9l8=;
  b=KdIJcUrbthxGWSp5zyLvQtntnTT1R2DMYl/fUHZ0vYlr/1g9tT/YRbPY
   TTbQeY4XUKAN5mg6FQ0lsJUUDoZsd9ezhTRCICGZzX+b+yE/WHn0Vgjmo
   oknEDvoyz5KuxhLx2qDmDznxGHzn72nrFJIEFWmq3HcWjhenX8LBXjVay
   eecxiS9c7Mpq3Bmzqgb6UeT09EctkAmJGKQcaJQKxDMjowtBjmH9BfFfB
   nzV/ckWGKvhcp06monkg34Ph2DxZGhYVNrEyvyqQqeU4dQ4enl2U2s/J4
   Rmwt2BwBs2OAd/+IEwYqJqJwQ0+XYCyZXmfaKlMp9XG9xpCVzijMCI++Q
   w==;
X-CSE-ConnectionGUID: dOkFb8IaTOiPHpeePmAbew==
X-CSE-MsgGUID: LKpaQeNYQWGLzBcSNHJQUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42220752"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42220752"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 23:31:01 -0800
X-CSE-ConnectionGUID: o3HKVD3qRWWVoApFr60eQw==
X-CSE-MsgGUID: +IVWokshRQyfvp/KfwUA2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156906600"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 08 Mar 2025 23:30:59 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trB7d-0002nk-3C;
	Sun, 09 Mar 2025 07:30:54 +0000
Date: Sun, 9 Mar 2025 15:30:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [RESEND PATCH 1/5] loop: remove 'rw' parameter from lo_rw_aio()
Message-ID: <202503091516.7U64QwvF-lkp@intel.com>
References: <20250308162312.1640828-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308162312.1640828-2-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/loop-remove-rw-parameter-from-lo_rw_aio/20250309-002548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250308162312.1640828-2-ming.lei%40redhat.com
patch subject: [RESEND PATCH 1/5] loop: remove 'rw' parameter from lo_rw_aio()
config: arm-randconfig-001-20250309 (https://download.01.org/0day-ci/archive/20250309/202503091516.7U64QwvF-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503091516.7U64QwvF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503091516.7U64QwvF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/loop.c:250:3: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     250 |                 rq_for_each_segment(bvec, rq, iter) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1043:2: note: expanded from macro 'rq_for_each_segment'
    1043 |         __rq_for_each_bio(_iter.bio, _rq)                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1039:6: note: expanded from macro '__rq_for_each_bio'
    1039 |         if ((rq->bio))                  \
         |             ^~~~~~~~~
   drivers/block/loop.c:256:10: note: uninitialized use occurs here
     256 |                 return ret;
         |                        ^~~
   drivers/block/loop.c:250:3: note: remove the 'if' if its condition is always true
     250 |                 rq_for_each_segment(bvec, rq, iter) {
         |                 ^
   include/linux/blk-mq.h:1043:2: note: expanded from macro 'rq_for_each_segment'
    1043 |         __rq_for_each_bio(_iter.bio, _rq)                       \
         |         ^
   include/linux/blk-mq.h:1039:2: note: expanded from macro '__rq_for_each_bio'
    1039 |         if ((rq->bio))                  \
         |         ^
   drivers/block/loop.c:248:10: note: initialize the variable 'ret' to silence this warning
     248 |                 int ret;
         |                        ^
         |                         = 0
   1 warning generated.


vim +250 drivers/block/loop.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  239  
e1d39dbf4716cd Ming Lei          2025-03-09  240  static int lo_rw_simple(struct loop_device *lo, struct request *rq, loff_t pos)
^1da177e4c3f41 Linus Torvalds    2005-04-16  241  {
aa4d86163e4e91 Christoph Hellwig 2015-04-07  242  	struct bio_vec bvec;
aa4d86163e4e91 Christoph Hellwig 2015-04-07  243  	struct req_iterator iter;
e1d39dbf4716cd Ming Lei          2025-03-09  244  	struct iov_iter i;
e1d39dbf4716cd Ming Lei          2025-03-09  245  	ssize_t len;
e1d39dbf4716cd Ming Lei          2025-03-09  246  
e1d39dbf4716cd Ming Lei          2025-03-09  247  	if (req_op(rq) == REQ_OP_WRITE) {
e1d39dbf4716cd Ming Lei          2025-03-09  248  		int ret;
aa4d86163e4e91 Christoph Hellwig 2015-04-07  249  
aa4d86163e4e91 Christoph Hellwig 2015-04-07 @250  		rq_for_each_segment(bvec, rq, iter) {
aa4d86163e4e91 Christoph Hellwig 2015-04-07  251  			ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos);
aa4d86163e4e91 Christoph Hellwig 2015-04-07  252  			if (ret < 0)
aa4d86163e4e91 Christoph Hellwig 2015-04-07  253  				break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  254  			cond_resched();
^1da177e4c3f41 Linus Torvalds    2005-04-16  255  		}
aa4d86163e4e91 Christoph Hellwig 2015-04-07  256  		return ret;
aa4d86163e4e91 Christoph Hellwig 2015-04-07  257  	}
aa4d86163e4e91 Christoph Hellwig 2015-04-07  258  
aa4d86163e4e91 Christoph Hellwig 2015-04-07  259  	rq_for_each_segment(bvec, rq, iter) {
de4eda9de2d957 Al Viro           2022-09-15  260  		iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
18e9710ee59ce3 Christoph Hellwig 2017-05-27  261  		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
aa4d86163e4e91 Christoph Hellwig 2015-04-07  262  		if (len < 0)
aa4d86163e4e91 Christoph Hellwig 2015-04-07  263  			return len;
aa4d86163e4e91 Christoph Hellwig 2015-04-07  264  
aa4d86163e4e91 Christoph Hellwig 2015-04-07  265  		flush_dcache_page(bvec.bv_page);
^1da177e4c3f41 Linus Torvalds    2005-04-16  266  
aa4d86163e4e91 Christoph Hellwig 2015-04-07  267  		if (len != bvec.bv_len) {
aa4d86163e4e91 Christoph Hellwig 2015-04-07  268  			struct bio *bio;
fd5821404e6823 Jens Axboe        2007-06-12  269  
aa4d86163e4e91 Christoph Hellwig 2015-04-07  270  			__rq_for_each_bio(bio, rq)
aa4d86163e4e91 Christoph Hellwig 2015-04-07  271  				zero_fill_bio(bio);
aa4d86163e4e91 Christoph Hellwig 2015-04-07  272  			break;
aa4d86163e4e91 Christoph Hellwig 2015-04-07  273  		}
aa4d86163e4e91 Christoph Hellwig 2015-04-07  274  		cond_resched();
^1da177e4c3f41 Linus Torvalds    2005-04-16  275  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  276  
aa4d86163e4e91 Christoph Hellwig 2015-04-07  277  	return 0;
fd5821404e6823 Jens Axboe        2007-06-12  278  }
fd5821404e6823 Jens Axboe        2007-06-12  279  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

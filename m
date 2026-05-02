Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEA35966;
	Sat,  2 May 2026 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681201; cv=none; b=tfQpChWIDhen8vVnX74IwOdHZVTfi/EbQ3OtXIxW4XvOlkuVvAGkIWszAJ60dzhmtaw67uo9+PEXARu1yfRkgmv3cuLPBQyUzkrAsD9gbDrz2Ac2IwltSh4cS99lacHJGovook+NreLPbsiMt2OrW9pdkc3la69Ph2wvrtnOdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681201; c=relaxed/simple;
	bh=DnJ+AUeWDrpxVFt3u5FS73OmVGN5OykFZeheU5M8iI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5RosYfNMbIGDUUsC6oNka894LTJqcLwOmFukVttvb6l3tVFX3W9Rs7c6Ef7gZBu0i7tm5PbEZL7WKExBg1DhlVBs3ZBEsugs4zl8Kl3NQvDP8bcCcomUCsGAQyfc250Df8CotX1UGeon2wcjrZrlByeCy0E5u8i4OJgz+jY0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcDHiN3o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcDHiN3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777681198; x=1809217198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DnJ+AUeWDrpxVFt3u5FS73OmVGN5OykFZeheU5M8iI4=;
  b=BcDHiN3o100xGW0IfSVa+1/CNzNCO3g3us7asLtbk6DUBq2JGXJcZO4H
   hsGhgb+ZWKezuL9gxo+9DI9pS4zYzwxJDf28SyrimtXru+MN4VcYeWPQ6
   fM2Fo3voYqURMu7kSllIEOfJeXmGlW0TQnOBlo+dRwuz8TfCzj1EO8tPj
   zff+gCyEzIVtCSbgnZAKTq7tU/TAapVkO+NRva83ngfs7qCytmdPCkatr
   jw4hjt4bfGze8zFlY72gGs5Y7/waO2BhnCHL6f8fPq23v+ajoh5sbBhep
   2zcBPpQtgWM3O5Tu2/IurBUfI97gIwEVa+bR13u4Y+qvsywY27M4DdN2i
   g==;
X-CSE-ConnectionGUID: LQqkk1mVRoedd9v4CtdEeA==
X-CSE-MsgGUID: kufUWuGGT8ibw2pd9LQ6Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="82493980"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="82493980"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 17:19:58 -0700
X-CSE-ConnectionGUID: 71vDT+awT6mzwbvNCQ5nVg==
X-CSE-MsgGUID: rwN+HL4RTleSYBG5+lLa2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="258606626"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 01 May 2026 17:19:56 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIy5J-0000000059F-23CW;
	Sat, 02 May 2026 00:19:53 +0000
Date: Sat, 2 May 2026 02:19:00 +0200
From: kernel test robot <lkp@intel.com>
To: Li kunyu <likunyu10@163.com>, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li kunyu <likunyu10@163.com>
Subject: Re: [PATCH] block/blk-iolatency: Add the processing flow of the
 chained bio in the QoS and define the related types to solve the problem of
 incorrect inflight processing in the QoS. The usage of the done_split_bio
 abstract function in the blk-iolatency project.
Message-ID: <202605020222.x7HELUvP-lkp@intel.com>
References: <20260429092920.2124-1-likunyu10@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429092920.2124-1-likunyu10@163.com>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on next-20260430]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-kunyu/block-blk-iolatency-Add-the-processing-flow-of-the-chained-bio-in-the-QoS-and-define-the-related-types-to-solve-the-prob/20260501-153918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260429092920.2124-1-likunyu10%40163.com
patch subject: [PATCH] block/blk-iolatency: Add the processing flow of the chained bio in the QoS and define the related types to solve the problem of incorrect inflight processing in the QoS. The usage of the done_split_bio abstract function in the blk-iolatency project.
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260502/202605020222.x7HELUvP-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260502/202605020222.x7HELUvP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605020222.x7HELUvP-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/blk-merge.c: In function 'bio_submit_split':
>> block/blk-merge.c:159:38: error: 'split' undeclared (first use in this function); did you mean 'sg_split'?
     159 |                         bio_set_flag(split, BIO_QOS_CHAIN_CHILD);
         |                                      ^~~~~
         |                                      sg_split
   block/blk-merge.c:159:38: note: each undeclared identifier is reported only once for each function it appears in
>> block/blk-merge.c:165:20: error: invalid storage class for function '__bio_split_discard'
     165 | static struct bio *__bio_split_discard(struct bio *bio,
         |                    ^~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:214:28: error: invalid storage class for function 'blk_boundary_sectors'
     214 | static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
         |                            ^~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:235:24: error: invalid storage class for function 'get_max_io_size'
     235 | static inline unsigned get_max_io_size(struct bio *bio,
         |                        ^~~~~~~~~~~~~~~
>> block/blk-merge.c:288:13: error: invalid storage class for function 'bvec_split_segs'
     288 | static bool bvec_split_segs(const struct queue_limits *lim,
         |             ^~~~~~~~~~~~~~~
>> block/blk-merge.c:314:21: error: invalid storage class for function 'bio_split_alignment'
     314 | static unsigned int bio_split_alignment(struct bio *bio,
         |                     ^~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:322:28: error: invalid storage class for function 'bvec_seg_gap'
     322 | static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
         |                            ^~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from block/blk-merge.c:5:
>> block/blk-merge.c:425:19: error: non-static declaration of 'bio_split_io_at' follows static declaration
     425 | EXPORT_SYMBOL_GPL(bio_split_io_at);
         |                   ^~~~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:90:41: note: in expansion of macro '_EXPORT_SYMBOL'
      90 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   block/blk-merge.c:425:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     425 | EXPORT_SYMBOL_GPL(bio_split_io_at);
         | ^~~~~~~~~~~~~~~~~
   block/blk-merge.c:341:5: note: previous definition of 'bio_split_io_at' with type 'int(struct bio *, const struct queue_limits *, unsigned int *, unsigned int,  unsigned int)'
     341 | int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
         |     ^~~~~~~~~~~~~~~
>> block/blk-merge.c:491:15: error: non-static declaration of 'bio_split_to_limits' follows static declaration
     491 | EXPORT_SYMBOL(bio_split_to_limits);
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:89:41: note: in expansion of macro '_EXPORT_SYMBOL'
      89 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   block/blk-merge.c:491:1: note: in expansion of macro 'EXPORT_SYMBOL'
     491 | EXPORT_SYMBOL(bio_split_to_limits);
         | ^~~~~~~~~~~~~
   block/blk-merge.c:485:13: note: previous definition of 'bio_split_to_limits' with type 'struct bio *(struct bio *)'
     485 | struct bio *bio_split_to_limits(struct bio *bio)
         |             ^~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:526:28: error: invalid storage class for function 'blk_rq_get_max_sectors'
     526 | static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
         |                            ^~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:548:19: error: invalid storage class for function 'll_new_hw_segment'
     548 | static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
         |                   ^~~~~~~~~~~~~~~~~
>> block/blk-merge.c:597:12: error: invalid storage class for function 'll_front_merge_fn'
     597 | static int ll_front_merge_fn(struct request *req, struct bio *bio,
         |            ^~~~~~~~~~~~~~~~~
>> block/blk-merge.c:616:13: error: invalid storage class for function 'req_attempt_discard_merge'
     616 | static bool req_attempt_discard_merge(struct request_queue *q, struct request *req,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:634:12: error: invalid storage class for function 'll_merge_requests_fn'
     634 | static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
         |            ^~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:677:13: error: invalid storage class for function 'blk_rq_set_mixed_merge'
     677 | static void blk_rq_set_mixed_merge(struct request *rq)
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:698:25: error: invalid storage class for function 'bio_failfast'
     698 | static inline blk_opf_t bio_failfast(const struct bio *bio)
         |                         ^~~~~~~~~~~~
>> block/blk-merge.c:711:20: error: invalid storage class for function 'blk_update_mixed_merge'
     711 | static inline void blk_update_mixed_merge(struct request *req,
         |                    ^~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:725:13: error: invalid storage class for function 'blk_account_io_merge_request'
     725 | static void blk_account_io_merge_request(struct request *req)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:736:23: error: invalid storage class for function 'blk_try_req_merge'
     736 | static enum elv_merge blk_try_req_merge(struct request *req,
         |                       ^~~~~~~~~~~~~~~~~
>> block/blk-merge.c:747:13: error: invalid storage class for function 'blk_atomic_write_mergeable_rq_bio'
     747 | static bool blk_atomic_write_mergeable_rq_bio(struct request *rq,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:753:13: error: invalid storage class for function 'blk_atomic_write_mergeable_rqs'
     753 | static bool blk_atomic_write_mergeable_rqs(struct request *rq,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:781:24: error: invalid storage class for function 'attempt_merge'
     781 | static struct request *attempt_merge(struct request_queue *q,
         |                        ^~~~~~~~~~~~~
   block/blk-merge.c:869:24: error: invalid storage class for function 'attempt_back_merge'
     869 | static struct request *attempt_back_merge(struct request_queue *q,
         |                        ^~~~~~~~~~~~~~~~~~
   block/blk-merge.c:880:24: error: invalid storage class for function 'attempt_front_merge'
     880 | static struct request *attempt_front_merge(struct request_queue *q,
         |                        ^~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:939:13: error: invalid storage class for function 'blk_account_io_merge_bio'
     939 | static void blk_account_io_merge_bio(struct request *req)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:979:30: error: invalid storage class for function 'bio_attempt_front_merge'
     979 | static enum bio_merge_status bio_attempt_front_merge(struct request *req,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:1017:30: error: invalid storage class for function 'bio_attempt_discard_merge'
    1017 | static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:1042:30: error: invalid storage class for function 'blk_attempt_bio_merge'
    1042 | static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
         |                              ^~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:1143:19: error: non-static declaration of 'blk_bio_list_merge' follows static declaration
    1143 | EXPORT_SYMBOL_GPL(blk_bio_list_merge);
         |                   ^~~~~~~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:90:41: note: in expansion of macro '_EXPORT_SYMBOL'
      90 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   block/blk-merge.c:1143:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1143 | EXPORT_SYMBOL_GPL(blk_bio_list_merge);
         | ^~~~~~~~~~~~~~~~~
   block/blk-merge.c:1120:6: note: previous definition of 'blk_bio_list_merge' with type 'bool(struct request_queue *, struct list_head *, struct bio *, unsigned int)' {aka '_Bool(struct request_queue *, struct list_head *, struct bio *, unsigned int)'}
    1120 | bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
         |      ^~~~~~~~~~~~~~~~~~
   block/blk-merge.c:1175:19: error: non-static declaration of 'blk_mq_sched_try_merge' follows static declaration
    1175 | EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:90:41: note: in expansion of macro '_EXPORT_SYMBOL'
      90 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   block/blk-merge.c:1175:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1175 | EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
         | ^~~~~~~~~~~~~~~~~
   block/blk-merge.c:1145:6: note: previous definition of 'blk_mq_sched_try_merge' with type 'bool(struct request_queue *, struct bio *, unsigned int,  struct request **)' {aka '_Bool(struct request_queue *, struct bio *, unsigned int,  struct request **)'}
    1145 | bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
         |      ^~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:1175:1: error: expected declaration or statement at end of input
    1175 | EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
         | ^~~~~~~~~~~~~~~~~
   block/blk-merge.c: At top level:
   block/blk-merge.c:1089:6: warning: 'blk_attempt_plug_merge' defined but not used [-Wunused-function]
    1089 | bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
         |      ^~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:896:6: warning: 'blk_attempt_req_merge' defined but not used [-Wunused-function]
     896 | bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
         |      ^~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:493:14: warning: 'blk_recalc_rq_segments' defined but not used [-Wunused-function]
     493 | unsigned int blk_recalc_rq_segments(struct request *rq)
         |              ^~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:454:13: warning: 'bio_split_write_zeroes' defined but not used [-Wunused-function]
     454 | struct bio *bio_split_write_zeroes(struct bio *bio,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:442:13: warning: 'bio_split_zone_append' defined but not used [-Wunused-function]
     442 | struct bio *bio_split_zone_append(struct bio *bio,
         |             ^~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:427:13: warning: 'bio_split_rw' defined but not used [-Wunused-function]
     427 | struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
         |             ^~~~~~~~~~~~
   block/blk-merge.c:201:13: warning: 'bio_split_discard' defined but not used [-Wunused-function]
     201 | struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
         |             ^~~~~~~~~~~~~~~~~


vim +159 block/blk-merge.c

   142	
   143	static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
   144	{
   145		if (unlikely(split_sectors < 0)) {
   146			bio->bi_status = errno_to_blk_status(split_sectors);
   147			bio_endio(bio);
   148			return NULL;
   149		}
   150	
   151		if (split_sectors) {
   152			bio = bio_submit_split_bioset(bio, split_sectors,
   153					&bio->bi_bdev->bd_disk->bio_split);
   154			if (bio) {
   155				bio->bi_opf |= REQ_NOMERGE;
   156				/* Fix the issue where the inflight statistics
   157				 * of the chained bio in the QoS are incorrect.
   158				 */
 > 159				bio_set_flag(split, BIO_QOS_CHAIN_CHILD);
   160		}
   161	
   162		return bio;
   163	}
   164	
 > 165	static struct bio *__bio_split_discard(struct bio *bio,
   166			const struct queue_limits *lim, unsigned *nsegs,
   167			unsigned int max_sectors)
   168	{
   169		unsigned int max_discard_sectors, granularity;
   170		sector_t tmp;
   171		unsigned split_sectors;
   172	
   173		*nsegs = 1;
   174	
   175		granularity = max(lim->discard_granularity >> 9, 1U);
   176	
   177		max_discard_sectors = min(max_sectors, bio_allowed_max_sectors(lim));
   178		max_discard_sectors -= max_discard_sectors % granularity;
   179		if (unlikely(!max_discard_sectors))
   180			return bio;
   181	
   182		if (bio_sectors(bio) <= max_discard_sectors)
   183			return bio;
   184	
   185		split_sectors = max_discard_sectors;
   186	
   187		/*
   188		 * If the next starting sector would be misaligned, stop the discard at
   189		 * the previous aligned sector.
   190		 */
   191		tmp = bio->bi_iter.bi_sector + split_sectors -
   192			((lim->discard_alignment >> 9) % granularity);
   193		tmp = sector_div(tmp, granularity);
   194	
   195		if (split_sectors > tmp)
   196			split_sectors -= tmp;
   197	
   198		return bio_submit_split(bio, split_sectors);
   199	}
   200	
   201	struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
   202			unsigned *nsegs)
   203	{
   204		unsigned int max_sectors;
   205	
   206		if (bio_op(bio) == REQ_OP_SECURE_ERASE)
   207			max_sectors = lim->max_secure_erase_sectors;
   208		else
   209			max_sectors = lim->max_discard_sectors;
   210	
   211		return __bio_split_discard(bio, lim, nsegs, max_sectors);
   212	}
   213	
 > 214	static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
   215							bool is_atomic)
   216	{
   217		/*
   218		 * chunk_sectors must be a multiple of atomic_write_boundary_sectors if
   219		 * both non-zero.
   220		 */
   221		if (is_atomic && lim->atomic_write_boundary_sectors)
   222			return lim->atomic_write_boundary_sectors;
   223	
   224		return lim->chunk_sectors;
   225	}
   226	
   227	/*
   228	 * Return the maximum number of sectors from the start of a bio that may be
   229	 * submitted as a single request to a block device. If enough sectors remain,
   230	 * align the end to the physical block size. Otherwise align the end to the
   231	 * logical block size. This approach minimizes the number of non-aligned
   232	 * requests that are submitted to a block device if the start of a bio is not
   233	 * aligned to a physical block boundary.
   234	 */
 > 235	static inline unsigned get_max_io_size(struct bio *bio,
   236					       const struct queue_limits *lim)
   237	{
   238		unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
   239		unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
   240		bool is_atomic = bio->bi_opf & REQ_ATOMIC;
   241		unsigned boundary_sectors = blk_boundary_sectors(lim, is_atomic);
   242		unsigned max_sectors, start, end;
   243	
   244		/*
   245		 * We ignore lim->max_sectors for atomic writes because it may less
   246		 * than the actual bio size, which we cannot tolerate.
   247		 */
   248		if (bio_op(bio) == REQ_OP_WRITE_ZEROES)
   249			max_sectors = lim->max_write_zeroes_sectors;
   250		else if (is_atomic)
   251			max_sectors = lim->atomic_write_max_sectors;
   252		else
   253			max_sectors = lim->max_sectors;
   254	
   255		if (boundary_sectors) {
   256			max_sectors = min(max_sectors,
   257				blk_boundary_sectors_left(bio->bi_iter.bi_sector,
   258						      boundary_sectors));
   259		}
   260	
   261		start = bio->bi_iter.bi_sector & (pbs - 1);
   262		end = (start + max_sectors) & ~(pbs - 1);
   263		if (end > start)
   264			return end - start;
   265		return max_sectors & ~(lbs - 1);
   266	}
   267	
   268	/**
   269	 * bvec_split_segs - verify whether or not a bvec should be split in the middle
   270	 * @lim:      [in] queue limits to split based on
   271	 * @bv:       [in] bvec to examine
   272	 * @nsegs:    [in,out] Number of segments in the bio being built. Incremented
   273	 *            by the number of segments from @bv that may be appended to that
   274	 *            bio without exceeding @max_segs
   275	 * @bytes:    [in,out] Number of bytes in the bio being built. Incremented
   276	 *            by the number of bytes from @bv that may be appended to that
   277	 *            bio without exceeding @max_bytes
   278	 * @max_segs: [in] upper bound for *@nsegs
   279	 * @max_bytes: [in] upper bound for *@bytes
   280	 *
   281	 * When splitting a bio, it can happen that a bvec is encountered that is too
   282	 * big to fit in a single segment and hence that it has to be split in the
   283	 * middle. This function verifies whether or not that should happen. The value
   284	 * %true is returned if and only if appending the entire @bv to a bio with
   285	 * *@nsegs segments and *@sectors sectors would make that bio unacceptable for
   286	 * the block driver.
   287	 */
 > 288	static bool bvec_split_segs(const struct queue_limits *lim,
   289			const struct bio_vec *bv, unsigned *nsegs, unsigned *bytes,
   290			unsigned max_segs, unsigned max_bytes)
   291	{
   292		unsigned max_len = max_bytes - *bytes;
   293		unsigned len = min(bv->bv_len, max_len);
   294		unsigned total_len = 0;
   295		unsigned seg_size = 0;
   296	
   297		while (len && *nsegs < max_segs) {
   298			seg_size = get_max_segment_size(lim, bvec_phys(bv) + total_len, len);
   299	
   300			(*nsegs)++;
   301			total_len += seg_size;
   302			len -= seg_size;
   303	
   304			if ((bv->bv_offset + total_len) & lim->virt_boundary_mask)
   305				break;
   306		}
   307	
   308		*bytes += total_len;
   309	
   310		/* tell the caller to split the bvec if it is too big to fit */
   311		return len > 0 || bv->bv_len > max_len;
   312	}
   313	
 > 314	static unsigned int bio_split_alignment(struct bio *bio,
   315			const struct queue_limits *lim)
   316	{
   317		if (op_is_write(bio_op(bio)) && lim->zone_write_granularity)
   318			return lim->zone_write_granularity;
   319		return lim->logical_block_size;
   320	}
   321	
 > 322	static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
   323						struct bio_vec *bv)
   324	{
   325		return bv->bv_offset | (bvprv->bv_offset + bvprv->bv_len);
   326	}
   327	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

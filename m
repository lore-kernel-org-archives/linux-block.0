Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804232DEA94;
	Fri,  1 May 2026 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777672079; cv=none; b=artRnyKfEu6LPagjwwnE8E4E6FAZRsIRYFIlLnEesoeB+kI4PiA3kSslJwZgxWtZRZQIztM0mqwkJ6ia35yA2ktLi318HpSG8gZwj+OUAPV1L9dSa/A6O3nrWKS2dNXYgnx8LqKMD53hu+Zy/jJBjGUYUHSM7dVUYbVFYaafjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777672079; c=relaxed/simple;
	bh=nUdPWQWboyy3WSzUhG++xz3CdgGlWN/UuQnot+YHmzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYGz/Zu7zo0lUukxCBaRw+HKu+HbPom+FcVI1U2XwkCHZI2WTdaORwTXJOihHLsRGZAAwo6hyl9UQLpmYfruNLLFKA2a+o6OnawsmThpFU4qbzIf7bvo3fom6BwZ4Y6qI1Zm0y8I/As18VHwRZrRSv0ExQ4zclv1PHYJeuWGNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXpgNG4s; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXpgNG4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777672076; x=1809208076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nUdPWQWboyy3WSzUhG++xz3CdgGlWN/UuQnot+YHmzw=;
  b=bXpgNG4st4bdrHDals/7V1h42ojZSYMZUpB6sEhAVyjsO5kOF9zeh3qT
   jpMU3zRYT2Dnsbsmnr1ONqZKo817/YRp7FI5n0n3qWzUfAI6TmkdRzmyw
   yms6YY1k3By8gj5Cu2TuX6JjYmlvQNT9G/hYDjl19WGcZwTAYzVg7e81H
   4yo92KjxJSWRaOSx73KumLuG8WxBz9wcfJ0V/1GoCzJi2/3auKGU06p2c
   065E9UDliyfkfcqI76n/ZTpd8Op46MRNL5uEX54oTRhj3LLaaoXtqLTZR
   yTqZjKTz0np7JGDWM9dYQtJZdMq6I3uuAW16bxaBX5Ib6tL/h1r/fmWnC
   Q==;
X-CSE-ConnectionGUID: uRs76vpyQwuCh2CLx1Ibtw==
X-CSE-MsgGUID: JwND7GtZSNSPtYDdYHUPqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="96201296"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="96201296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 14:47:56 -0700
X-CSE-ConnectionGUID: XmIU69e3Ssy90AzuQnNl6w==
X-CSE-MsgGUID: WWsC2erQTia2axjNEsgLTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="230374202"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 01 May 2026 14:47:53 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIviB-00000000577-1nFo;
	Fri, 01 May 2026 21:47:51 +0000
Date: Fri, 1 May 2026 23:47:17 +0200
From: kernel test robot <lkp@intel.com>
To: Li kunyu <likunyu10@163.com>, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li kunyu <likunyu10@163.com>
Subject: Re: [PATCH] block/blk-iolatency: Add the processing flow of the
 chained bio in the QoS and define the related types to solve the problem of
 incorrect inflight processing in the QoS. The usage of the done_split_bio
 abstract function in the blk-iolatency project.
Message-ID: <202605012326.wuozpBQs-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe/for-next]
[also build test WARNING on next-20260430]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-kunyu/block-blk-iolatency-Add-the-processing-flow-of-the-chained-bio-in-the-QoS-and-define-the-related-types-to-solve-the-prob/20260501-153918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260429092920.2124-1-likunyu10%40163.com
patch subject: [PATCH] block/blk-iolatency: Add the processing flow of the chained bio in the QoS and define the related types to solve the problem of incorrect inflight processing in the QoS. The usage of the done_split_bio abstract function in the blk-iolatency project.
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260501/202605012326.wuozpBQs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260501/202605012326.wuozpBQs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605012326.wuozpBQs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   include/linux/export.h:89:41: note: in expansion of macro '_EXPORT_SYMBOL'
      89 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   block/blk-merge.c:491:1: note: in expansion of macro 'EXPORT_SYMBOL'
     491 | EXPORT_SYMBOL(bio_split_to_limits);
         | ^~~~~~~~~~~~~
   block/blk-merge.c:485:13: note: previous definition of 'bio_split_to_limits' with type 'struct bio *(struct bio *)'
     485 | struct bio *bio_split_to_limits(struct bio *bio)
         |             ^~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:526:28: error: invalid storage class for function 'blk_rq_get_max_sectors'
     526 | static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:548:19: error: invalid storage class for function 'll_new_hw_segment'
     548 | static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
         |                   ^~~~~~~~~~~~~~~~~
   block/blk-merge.c:597:12: error: invalid storage class for function 'll_front_merge_fn'
     597 | static int ll_front_merge_fn(struct request *req, struct bio *bio,
         |            ^~~~~~~~~~~~~~~~~
   block/blk-merge.c:616:13: error: invalid storage class for function 'req_attempt_discard_merge'
     616 | static bool req_attempt_discard_merge(struct request_queue *q, struct request *req,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:634:12: error: invalid storage class for function 'll_merge_requests_fn'
     634 | static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
         |            ^~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:677:13: error: invalid storage class for function 'blk_rq_set_mixed_merge'
     677 | static void blk_rq_set_mixed_merge(struct request *rq)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:698:25: error: invalid storage class for function 'bio_failfast'
     698 | static inline blk_opf_t bio_failfast(const struct bio *bio)
         |                         ^~~~~~~~~~~~
   block/blk-merge.c:711:20: error: invalid storage class for function 'blk_update_mixed_merge'
     711 | static inline void blk_update_mixed_merge(struct request *req,
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:725:13: error: invalid storage class for function 'blk_account_io_merge_request'
     725 | static void blk_account_io_merge_request(struct request *req)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c:736:23: error: invalid storage class for function 'blk_try_req_merge'
     736 | static enum elv_merge blk_try_req_merge(struct request *req,
         |                       ^~~~~~~~~~~~~~~~~
   block/blk-merge.c:747:13: error: invalid storage class for function 'blk_atomic_write_mergeable_rq_bio'
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
>> block/blk-merge.c:1089:6: warning: 'blk_attempt_plug_merge' defined but not used [-Wunused-function]
    1089 | bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:896:6: warning: 'blk_attempt_req_merge' defined but not used [-Wunused-function]
     896 | bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
         |      ^~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:493:14: warning: 'blk_recalc_rq_segments' defined but not used [-Wunused-function]
     493 | unsigned int blk_recalc_rq_segments(struct request *rq)
         |              ^~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:454:13: warning: 'bio_split_write_zeroes' defined but not used [-Wunused-function]
     454 | struct bio *bio_split_write_zeroes(struct bio *bio,
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:442:13: warning: 'bio_split_zone_append' defined but not used [-Wunused-function]
     442 | struct bio *bio_split_zone_append(struct bio *bio,
         |             ^~~~~~~~~~~~~~~~~~~~~
>> block/blk-merge.c:427:13: warning: 'bio_split_rw' defined but not used [-Wunused-function]
     427 | struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
         |             ^~~~~~~~~~~~
>> block/blk-merge.c:201:13: warning: 'bio_split_discard' defined but not used [-Wunused-function]
     201 | struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
         |             ^~~~~~~~~~~~~~~~~


vim +/blk_attempt_plug_merge +1089 block/blk-merge.c

5e84ea3a9c662d Jens Axboe         2011-03-21   890  
fd2ef39cc9a6b9 Jan Kara           2021-06-23   891  /*
fd2ef39cc9a6b9 Jan Kara           2021-06-23   892   * Try to merge 'next' into 'rq'. Return true if the merge happened, false
fd2ef39cc9a6b9 Jan Kara           2021-06-23   893   * otherwise. The caller is responsible for freeing 'next' if the merge
fd2ef39cc9a6b9 Jan Kara           2021-06-23   894   * happened.
fd2ef39cc9a6b9 Jan Kara           2021-06-23   895   */
fd2ef39cc9a6b9 Jan Kara           2021-06-23  @896  bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
5e84ea3a9c662d Jens Axboe         2011-03-21   897  			   struct request *next)
5e84ea3a9c662d Jens Axboe         2011-03-21   898  {
fd2ef39cc9a6b9 Jan Kara           2021-06-23   899  	return attempt_merge(q, rq, next);
5e84ea3a9c662d Jens Axboe         2011-03-21   900  }
050c8ea80e3e90 Tejun Heo          2012-02-08   901  
050c8ea80e3e90 Tejun Heo          2012-02-08   902  bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
050c8ea80e3e90 Tejun Heo          2012-02-08   903  {
e2a60da74fc821 Martin K. Petersen 2012-09-18   904  	if (!rq_mergeable(rq) || !bio_mergeable(bio))
050c8ea80e3e90 Tejun Heo          2012-02-08   905  		return false;
050c8ea80e3e90 Tejun Heo          2012-02-08   906  
288dab8a35a0bd Christoph Hellwig  2016-06-09   907  	if (req_op(rq) != bio_op(bio))
f31dc1cd490539 Martin K. Petersen 2012-09-18   908  		return false;
f31dc1cd490539 Martin K. Petersen 2012-09-18   909  
6b2b04590b51aa Tejun Heo          2022-03-14   910  	if (!blk_cgroup_mergeable(rq, bio))
6b2b04590b51aa Tejun Heo          2022-03-14   911  		return false;
4eaf99beadcefb Martin K. Petersen 2014-09-26   912  	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
050c8ea80e3e90 Tejun Heo          2012-02-08   913  		return false;
a892c8d52c0228 Satya Tangirala    2020-05-14   914  	if (!bio_crypt_rq_ctx_compatible(rq, bio))
a892c8d52c0228 Satya Tangirala    2020-05-14   915  		return false;
61952bb73486ff Christoph Hellwig  2024-11-12   916  	if (rq->bio->bi_write_hint != bio->bi_write_hint)
449813515d3e5e Bart Van Assche    2024-02-02   917  		return false;
5006f85ea23ea0 Christoph Hellwig  2025-05-06   918  	if (rq->bio->bi_write_stream != bio->bi_write_stream)
5006f85ea23ea0 Christoph Hellwig  2025-05-06   919  		return false;
6975c1a486a404 Christoph Hellwig  2024-11-12   920  	if (rq->bio->bi_ioprio != bio->bi_ioprio)
668ffc03418bc7 Damien Le Moal     2018-11-20   921  		return false;
9da3d1e912f395 John Garry         2024-06-20   922  	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
9da3d1e912f395 John Garry         2024-06-20   923  		return false;
9da3d1e912f395 John Garry         2024-06-20   924  
050c8ea80e3e90 Tejun Heo          2012-02-08   925  	return true;
050c8ea80e3e90 Tejun Heo          2012-02-08   926  }
050c8ea80e3e90 Tejun Heo          2012-02-08   927  
34fe7c05400663 Christoph Hellwig  2017-02-08   928  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
050c8ea80e3e90 Tejun Heo          2012-02-08   929  {
caebce24f6a7f8 Jens Axboe         2025-11-18   930  	if (blk_discard_mergable(rq))
caebce24f6a7f8 Jens Axboe         2025-11-18   931  		return ELEVATOR_DISCARD_MERGE;
caebce24f6a7f8 Jens Axboe         2025-11-18   932  	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
050c8ea80e3e90 Tejun Heo          2012-02-08   933  		return ELEVATOR_BACK_MERGE;
4f024f3797c43c Kent Overstreet    2013-10-11   934  	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
050c8ea80e3e90 Tejun Heo          2012-02-08   935  		return ELEVATOR_FRONT_MERGE;
050c8ea80e3e90 Tejun Heo          2012-02-08   936  	return ELEVATOR_NO_MERGE;
050c8ea80e3e90 Tejun Heo          2012-02-08   937  }
8e756373d7c8eb Baolin Wang        2020-08-28   938  
8e756373d7c8eb Baolin Wang        2020-08-28   939  static void blk_account_io_merge_bio(struct request *req)
8e756373d7c8eb Baolin Wang        2020-08-28   940  {
e3569ecae44daa Jens Axboe         2024-10-03   941  	if (req->rq_flags & RQF_IO_STAT) {
8e756373d7c8eb Baolin Wang        2020-08-28   942  		part_stat_lock();
8e756373d7c8eb Baolin Wang        2020-08-28   943  		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
8e756373d7c8eb Baolin Wang        2020-08-28   944  		part_stat_unlock();
8e756373d7c8eb Baolin Wang        2020-08-28   945  	}
e3569ecae44daa Jens Axboe         2024-10-03   946  }
8e756373d7c8eb Baolin Wang        2020-08-28   947  
dd850ff3eee428 Damien Le Moal     2024-04-08   948  enum bio_merge_status bio_attempt_back_merge(struct request *req,
eda5cc997abd21 Christoph Hellwig  2020-10-06   949  		struct bio *bio, unsigned int nr_segs)
8e756373d7c8eb Baolin Wang        2020-08-28   950  {
3ce6a115980c01 Ming Lei           2023-02-09   951  	const blk_opf_t ff = bio_failfast(bio);
8e756373d7c8eb Baolin Wang        2020-08-28   952  
8e756373d7c8eb Baolin Wang        2020-08-28   953  	if (!ll_back_merge_fn(req, bio, nr_segs))
7d7ca7c5269bec Baolin Wang        2020-08-28   954  		return BIO_MERGE_FAILED;
8e756373d7c8eb Baolin Wang        2020-08-28   955  
e8a676d61c07ec Christoph Hellwig  2020-12-03   956  	trace_block_bio_backmerge(bio);
8e756373d7c8eb Baolin Wang        2020-08-28   957  	rq_qos_merge(req->q, req, bio);
8e756373d7c8eb Baolin Wang        2020-08-28   958  
8e756373d7c8eb Baolin Wang        2020-08-28   959  	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
8e756373d7c8eb Baolin Wang        2020-08-28   960  		blk_rq_set_mixed_merge(req);
8e756373d7c8eb Baolin Wang        2020-08-28   961  
3ce6a115980c01 Ming Lei           2023-02-09   962  	blk_update_mixed_merge(req, bio, false);
3ce6a115980c01 Ming Lei           2023-02-09   963  
dd291d77cc90eb Damien Le Moal     2024-04-08   964  	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
dd291d77cc90eb Damien Le Moal     2024-04-08   965  		blk_zone_write_plug_bio_merged(bio);
dd291d77cc90eb Damien Le Moal     2024-04-08   966  
2f6b2565d43cdb Keith Busch        2025-10-14   967  	req->phys_gap_bit = bio_seg_gap(req->q, req->biotail, bio,
2f6b2565d43cdb Keith Busch        2025-10-14   968  					req->phys_gap_bit);
8e756373d7c8eb Baolin Wang        2020-08-28   969  	req->biotail->bi_next = bio;
8e756373d7c8eb Baolin Wang        2020-08-28   970  	req->biotail = bio;
8e756373d7c8eb Baolin Wang        2020-08-28   971  	req->__data_len += bio->bi_iter.bi_size;
8e756373d7c8eb Baolin Wang        2020-08-28   972  
8e756373d7c8eb Baolin Wang        2020-08-28   973  	bio_crypt_free_ctx(bio);
8e756373d7c8eb Baolin Wang        2020-08-28   974  
8e756373d7c8eb Baolin Wang        2020-08-28   975  	blk_account_io_merge_bio(req);
7d7ca7c5269bec Baolin Wang        2020-08-28   976  	return BIO_MERGE_OK;
8e756373d7c8eb Baolin Wang        2020-08-28   977  }
8e756373d7c8eb Baolin Wang        2020-08-28   978  
eda5cc997abd21 Christoph Hellwig  2020-10-06   979  static enum bio_merge_status bio_attempt_front_merge(struct request *req,
eda5cc997abd21 Christoph Hellwig  2020-10-06   980  		struct bio *bio, unsigned int nr_segs)
8e756373d7c8eb Baolin Wang        2020-08-28   981  {
3ce6a115980c01 Ming Lei           2023-02-09   982  	const blk_opf_t ff = bio_failfast(bio);
8e756373d7c8eb Baolin Wang        2020-08-28   983  
dd291d77cc90eb Damien Le Moal     2024-04-08   984  	/*
dd291d77cc90eb Damien Le Moal     2024-04-08   985  	 * A front merge for writes to sequential zones of a zoned block device
dd291d77cc90eb Damien Le Moal     2024-04-08   986  	 * can happen only if the user submitted writes out of order. Do not
dd291d77cc90eb Damien Le Moal     2024-04-08   987  	 * merge such write to let it fail.
dd291d77cc90eb Damien Le Moal     2024-04-08   988  	 */
dd291d77cc90eb Damien Le Moal     2024-04-08   989  	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
dd291d77cc90eb Damien Le Moal     2024-04-08   990  		return BIO_MERGE_FAILED;
dd291d77cc90eb Damien Le Moal     2024-04-08   991  
8e756373d7c8eb Baolin Wang        2020-08-28   992  	if (!ll_front_merge_fn(req, bio, nr_segs))
7d7ca7c5269bec Baolin Wang        2020-08-28   993  		return BIO_MERGE_FAILED;
8e756373d7c8eb Baolin Wang        2020-08-28   994  
e8a676d61c07ec Christoph Hellwig  2020-12-03   995  	trace_block_bio_frontmerge(bio);
8e756373d7c8eb Baolin Wang        2020-08-28   996  	rq_qos_merge(req->q, req, bio);
8e756373d7c8eb Baolin Wang        2020-08-28   997  
8e756373d7c8eb Baolin Wang        2020-08-28   998  	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
8e756373d7c8eb Baolin Wang        2020-08-28   999  		blk_rq_set_mixed_merge(req);
8e756373d7c8eb Baolin Wang        2020-08-28  1000  
3ce6a115980c01 Ming Lei           2023-02-09  1001  	blk_update_mixed_merge(req, bio, true);
3ce6a115980c01 Ming Lei           2023-02-09  1002  
2f6b2565d43cdb Keith Busch        2025-10-14  1003  	req->phys_gap_bit = bio_seg_gap(req->q, bio, req->bio,
2f6b2565d43cdb Keith Busch        2025-10-14  1004  					req->phys_gap_bit);
8e756373d7c8eb Baolin Wang        2020-08-28  1005  	bio->bi_next = req->bio;
8e756373d7c8eb Baolin Wang        2020-08-28  1006  	req->bio = bio;
8e756373d7c8eb Baolin Wang        2020-08-28  1007  
8e756373d7c8eb Baolin Wang        2020-08-28  1008  	req->__sector = bio->bi_iter.bi_sector;
8e756373d7c8eb Baolin Wang        2020-08-28  1009  	req->__data_len += bio->bi_iter.bi_size;
8e756373d7c8eb Baolin Wang        2020-08-28  1010  
8e756373d7c8eb Baolin Wang        2020-08-28  1011  	bio_crypt_do_front_merge(req, bio);
8e756373d7c8eb Baolin Wang        2020-08-28  1012  
8e756373d7c8eb Baolin Wang        2020-08-28  1013  	blk_account_io_merge_bio(req);
7d7ca7c5269bec Baolin Wang        2020-08-28  1014  	return BIO_MERGE_OK;
8e756373d7c8eb Baolin Wang        2020-08-28  1015  }
8e756373d7c8eb Baolin Wang        2020-08-28  1016  
eda5cc997abd21 Christoph Hellwig  2020-10-06  1017  static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
eda5cc997abd21 Christoph Hellwig  2020-10-06  1018  		struct request *req, struct bio *bio)
8e756373d7c8eb Baolin Wang        2020-08-28  1019  {
8e756373d7c8eb Baolin Wang        2020-08-28  1020  	unsigned short segments = blk_rq_nr_discard_segments(req);
8e756373d7c8eb Baolin Wang        2020-08-28  1021  
8e756373d7c8eb Baolin Wang        2020-08-28  1022  	if (segments >= queue_max_discard_segments(q))
8e756373d7c8eb Baolin Wang        2020-08-28  1023  		goto no_merge;
8e756373d7c8eb Baolin Wang        2020-08-28  1024  	if (blk_rq_sectors(req) + bio_sectors(bio) >
8e756373d7c8eb Baolin Wang        2020-08-28  1025  	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
8e756373d7c8eb Baolin Wang        2020-08-28  1026  		goto no_merge;
8e756373d7c8eb Baolin Wang        2020-08-28  1027  
8e756373d7c8eb Baolin Wang        2020-08-28  1028  	rq_qos_merge(q, req, bio);
8e756373d7c8eb Baolin Wang        2020-08-28  1029  
8e756373d7c8eb Baolin Wang        2020-08-28  1030  	req->biotail->bi_next = bio;
8e756373d7c8eb Baolin Wang        2020-08-28  1031  	req->biotail = bio;
8e756373d7c8eb Baolin Wang        2020-08-28  1032  	req->__data_len += bio->bi_iter.bi_size;
8e756373d7c8eb Baolin Wang        2020-08-28  1033  	req->nr_phys_segments = segments + 1;
8e756373d7c8eb Baolin Wang        2020-08-28  1034  
8e756373d7c8eb Baolin Wang        2020-08-28  1035  	blk_account_io_merge_bio(req);
7d7ca7c5269bec Baolin Wang        2020-08-28  1036  	return BIO_MERGE_OK;
8e756373d7c8eb Baolin Wang        2020-08-28  1037  no_merge:
8e756373d7c8eb Baolin Wang        2020-08-28  1038  	req_set_nomerge(q, req);
7d7ca7c5269bec Baolin Wang        2020-08-28  1039  	return BIO_MERGE_FAILED;
7d7ca7c5269bec Baolin Wang        2020-08-28  1040  }
7d7ca7c5269bec Baolin Wang        2020-08-28  1041  
7d7ca7c5269bec Baolin Wang        2020-08-28  1042  static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
7d7ca7c5269bec Baolin Wang        2020-08-28  1043  						   struct request *rq,
7d7ca7c5269bec Baolin Wang        2020-08-28  1044  						   struct bio *bio,
7d7ca7c5269bec Baolin Wang        2020-08-28  1045  						   unsigned int nr_segs,
7d7ca7c5269bec Baolin Wang        2020-08-28  1046  						   bool sched_allow_merge)
7d7ca7c5269bec Baolin Wang        2020-08-28  1047  {
7d7ca7c5269bec Baolin Wang        2020-08-28  1048  	if (!blk_rq_merge_ok(rq, bio))
7d7ca7c5269bec Baolin Wang        2020-08-28  1049  		return BIO_MERGE_NONE;
7d7ca7c5269bec Baolin Wang        2020-08-28  1050  
7d7ca7c5269bec Baolin Wang        2020-08-28  1051  	switch (blk_try_merge(rq, bio)) {
7d7ca7c5269bec Baolin Wang        2020-08-28  1052  	case ELEVATOR_BACK_MERGE:
265600b7b6e88f Baolin Wang        2020-09-02  1053  		if (!sched_allow_merge || blk_mq_sched_allow_merge(q, rq, bio))
7d7ca7c5269bec Baolin Wang        2020-08-28  1054  			return bio_attempt_back_merge(rq, bio, nr_segs);
7d7ca7c5269bec Baolin Wang        2020-08-28  1055  		break;
7d7ca7c5269bec Baolin Wang        2020-08-28  1056  	case ELEVATOR_FRONT_MERGE:
265600b7b6e88f Baolin Wang        2020-09-02  1057  		if (!sched_allow_merge || blk_mq_sched_allow_merge(q, rq, bio))
7d7ca7c5269bec Baolin Wang        2020-08-28  1058  			return bio_attempt_front_merge(rq, bio, nr_segs);
7d7ca7c5269bec Baolin Wang        2020-08-28  1059  		break;
7d7ca7c5269bec Baolin Wang        2020-08-28  1060  	case ELEVATOR_DISCARD_MERGE:
7d7ca7c5269bec Baolin Wang        2020-08-28  1061  		return bio_attempt_discard_merge(q, rq, bio);
7d7ca7c5269bec Baolin Wang        2020-08-28  1062  	default:
7d7ca7c5269bec Baolin Wang        2020-08-28  1063  		return BIO_MERGE_NONE;
7d7ca7c5269bec Baolin Wang        2020-08-28  1064  	}
7d7ca7c5269bec Baolin Wang        2020-08-28  1065  
7d7ca7c5269bec Baolin Wang        2020-08-28  1066  	return BIO_MERGE_FAILED;
8e756373d7c8eb Baolin Wang        2020-08-28  1067  }
8e756373d7c8eb Baolin Wang        2020-08-28  1068  
8e756373d7c8eb Baolin Wang        2020-08-28  1069  /**
8e756373d7c8eb Baolin Wang        2020-08-28  1070   * blk_attempt_plug_merge - try to merge with %current's plugged list
8e756373d7c8eb Baolin Wang        2020-08-28  1071   * @q: request_queue new bio is being queued at
8e756373d7c8eb Baolin Wang        2020-08-28  1072   * @bio: new bio being queued
8e756373d7c8eb Baolin Wang        2020-08-28  1073   * @nr_segs: number of segments in @bio
87c037d11b83b9 Jens Axboe         2021-10-18  1074   * from the passed in @q already in the plug list
8e756373d7c8eb Baolin Wang        2020-08-28  1075   *
d38a9c04c0d563 Jens Axboe         2021-10-14  1076   * Determine whether @bio being queued on @q can be merged with the previous
d38a9c04c0d563 Jens Axboe         2021-10-14  1077   * request on %current's plugged list.  Returns %true if merge was successful,
8e756373d7c8eb Baolin Wang        2020-08-28  1078   * otherwise %false.
8e756373d7c8eb Baolin Wang        2020-08-28  1079   *
8e756373d7c8eb Baolin Wang        2020-08-28  1080   * Plugging coalesces IOs from the same issuer for the same purpose without
8e756373d7c8eb Baolin Wang        2020-08-28  1081   * going through @q->queue_lock.  As such it's more of an issuing mechanism
8e756373d7c8eb Baolin Wang        2020-08-28  1082   * than scheduling, and the request, while may have elvpriv data, is not
8e756373d7c8eb Baolin Wang        2020-08-28  1083   * added on the elevator at this point.  In addition, we don't have
8e756373d7c8eb Baolin Wang        2020-08-28  1084   * reliable access to the elevator outside queue lock.  Only check basic
8e756373d7c8eb Baolin Wang        2020-08-28  1085   * merging parameters without querying the elevator.
8e756373d7c8eb Baolin Wang        2020-08-28  1086   *
8e756373d7c8eb Baolin Wang        2020-08-28  1087   * Caller must ensure !blk_queue_nomerges(q) beforehand.
8e756373d7c8eb Baolin Wang        2020-08-28  1088   */
8e756373d7c8eb Baolin Wang        2020-08-28 @1089  bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
0c5bcc92d94a8f Christoph Hellwig  2021-11-23  1090  		unsigned int nr_segs)
8e756373d7c8eb Baolin Wang        2020-08-28  1091  {
99a9476b27e895 Damien Le Moal     2024-04-08  1092  	struct blk_plug *plug = current->plug;
8e756373d7c8eb Baolin Wang        2020-08-28  1093  	struct request *rq;
8e756373d7c8eb Baolin Wang        2020-08-28  1094  
a3396b99990d8b Christoph Hellwig  2024-11-13  1095  	if (!plug || rq_list_empty(&plug->mq_list))
8e756373d7c8eb Baolin Wang        2020-08-28  1096  		return false;
8e756373d7c8eb Baolin Wang        2020-08-28  1097  
961296e89dc380 Jens Axboe         2025-06-11  1098  	rq = plug->mq_list.tail;
961296e89dc380 Jens Axboe         2025-06-11  1099  	if (rq->q == q)
961296e89dc380 Jens Axboe         2025-06-11  1100  		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
961296e89dc380 Jens Axboe         2025-06-11  1101  			BIO_MERGE_OK;
961296e89dc380 Jens Axboe         2025-06-11  1102  	else if (!plug->multiple_queues)
961296e89dc380 Jens Axboe         2025-06-11  1103  		return false;
961296e89dc380 Jens Axboe         2025-06-11  1104  
5b2050718d095c Jens Axboe         2022-03-11  1105  	rq_list_for_each(&plug->mq_list, rq) {
961296e89dc380 Jens Axboe         2025-06-11  1106  		if (rq->q != q)
961296e89dc380 Jens Axboe         2025-06-11  1107  			continue;
a1cb65377e7075 Ming Lei           2021-11-02  1108  		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
a1cb65377e7075 Ming Lei           2021-11-02  1109  		    BIO_MERGE_OK)
8e756373d7c8eb Baolin Wang        2020-08-28  1110  			return true;
5b2050718d095c Jens Axboe         2022-03-11  1111  		break;
5b2050718d095c Jens Axboe         2022-03-11  1112  	}
8e756373d7c8eb Baolin Wang        2020-08-28  1113  	return false;
8e756373d7c8eb Baolin Wang        2020-08-28  1114  }
bdc6a287bc98e8 Baolin Wang        2020-08-28  1115  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0A40DFD5
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807817; cv=none; b=op+zYfIqQol7klomtvnMGRAL0mRmPw11xAFbUt4Oq63f0xl9lAWU+O5jY5s/CoEtIQEROlnkux0+XBvZmVTZqvPyXAeBAXTAMEN8aPyhfU0qqvT5Ws90FGIZT4voVS1IpH8emE2pPZ9YpFOy1iCUGDaBM60vZMyLfP9ASdl5R58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807817; c=relaxed/simple;
	bh=0a6HnbTZ2RV59J72sSa2ET/4+5I6oh6zRZ7Rz7fcaeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/2QntMwrhk655fB0AzuBmtlkAoe3hcUXk6Jf9Qes6PwIOf46QSqaHSlUGMlEoTVmwG9W5D3Sdi9UynUzFvNXr2p2V4Mu8oPHyS5jD1Ak1mM/XjP4NyodK8jGY+yfO1PIJlzygVKylBwsKIi2kz2T8WQOGq8AxTLLNS4kBAMsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RH4ETnc7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH4ETnc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779807816; x=1811343816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0a6HnbTZ2RV59J72sSa2ET/4+5I6oh6zRZ7Rz7fcaeo=;
  b=RH4ETnc7RKsSuPzHZU+Nafhv4GFKiDxHe/VTdwqURNOATvPEH4aFhm3z
   kAX8IBRpV09cAS8WMDWhJbRPHwSjkJQFsfINkEInwoxdSccwOWJp9zYum
   KI+e9GmOQogu/G5PxUVxulwsQLkZaUyJPIn9aYnIUwM5g6QCtgfPTN2zW
   6orzBLLvSAgVGFWjOzxE2AdN1n27mIhSF2m8g4NJBG52KlRUYjAaehdnz
   HrTRzAG8yGA0CdwV/KZwMHh8LC0omheC80FXqnq3jFOfbJrfSUL7kC8V4
   nQKa1svNVFsuVzsr7iH6GTWgFs746jrx0yZm5DQkSLGsU+GQ/+rCHaiB5
   Q==;
X-CSE-ConnectionGUID: ax5wPqlwTtKAwkeJZjjlSA==
X-CSE-MsgGUID: DpFo7i7sRlG+OXSDpMAVFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="98047350"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="98047350"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:03:36 -0700
X-CSE-ConnectionGUID: hEQK080AQNOkzkp93f49Kg==
X-CSE-MsgGUID: FVU9B0qvTRa1hf3dNzIjNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="240895113"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 26 May 2026 08:03:34 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wRtJb-00000000CQV-06iV;
	Tue, 26 May 2026 15:03:31 +0000
Date: Tue, 26 May 2026 17:02:51 +0200
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: reinsert cached request to the list
Message-ID: <202605261716.TITwjvlB-lkp@intel.com>
References: <20260525160744.896047-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525160744.896047-1-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on next-20260525]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-reinsert-cached-request-to-the-list/20260526-000916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260525160744.896047-1-kbusch%40meta.com
patch subject: [PATCH] blk-mq: reinsert cached request to the list
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260526/202605261716.TITwjvlB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260526/202605261716.TITwjvlB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605261716.TITwjvlB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-mq.c:3249:3: error: call to undeclared function 'rq_list_push'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3249 |                 rq_list_push(&plug->cached_rqs, rq);
         |                 ^
   1 error generated.


vim +/rq_list_push +3249 block/blk-mq.c

  3110	
  3111	/**
  3112	 * blk_mq_submit_bio - Create and send a request to block device.
  3113	 * @bio: Bio pointer.
  3114	 *
  3115	 * Builds up a request structure from @q and @bio and send to the device. The
  3116	 * request may not be queued directly to hardware if:
  3117	 * * This request can be merged with another one
  3118	 * * We want to place request at plug queue for possible future merging
  3119	 * * There is an IO scheduler active at this queue
  3120	 *
  3121	 * It will not queue the request if there is an error with the bio, or at the
  3122	 * request creation.
  3123	 */
  3124	void blk_mq_submit_bio(struct bio *bio)
  3125	{
  3126		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
  3127		struct blk_plug *plug = current->plug;
  3128		const int is_sync = op_is_sync(bio->bi_opf);
  3129		unsigned int integrity_action;
  3130		struct blk_mq_hw_ctx *hctx;
  3131		unsigned int nr_segs;
  3132		struct request *rq;
  3133		blk_status_t ret;
  3134	
  3135		/*
  3136		 * If the plug has a cached request for this queue, try to use it.
  3137		 */
  3138		rq = blk_mq_get_cached_request(plug, q, bio->bi_opf);
  3139	
  3140		/*
  3141		 * A BIO that was released from a zone write plug has already been
  3142		 * through the preparation in this function, already holds a reference
  3143		 * on the queue usage counter, and is the only write BIO in-flight for
  3144		 * the target zone. Go straight to preparing a request for it.
  3145		 */
  3146		if (bio_zone_write_plugging(bio)) {
  3147			nr_segs = bio->__bi_nr_segments;
  3148			if (rq)
  3149				blk_queue_exit(q);
  3150			goto new_request;
  3151		}
  3152	
  3153		/*
  3154		 * The cached request already holds a q_usage_counter reference and we
  3155		 * don't have to acquire a new one if we use it.
  3156		 */
  3157		if (!rq) {
  3158			if (unlikely(bio_queue_enter(bio)))
  3159				return;
  3160		}
  3161	
  3162		/*
  3163		 * Device reconfiguration may change logical block size or reduce the
  3164		 * number of poll queues, so the checks for alignment and poll support
  3165		 * have to be done with queue usage counter held.
  3166		 */
  3167		if (unlikely(bio_unaligned(bio, q))) {
  3168			bio_io_error(bio);
  3169			goto queue_exit;
  3170		}
  3171	
  3172		if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
  3173			bio->bi_status = BLK_STS_NOTSUPP;
  3174			bio_endio(bio);
  3175			goto queue_exit;
  3176		}
  3177	
  3178		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
  3179		if (!bio)
  3180			goto queue_exit;
  3181	
  3182		integrity_action = bio_integrity_action(bio);
  3183		if (integrity_action)
  3184			bio_integrity_prep(bio, integrity_action);
  3185	
  3186		blk_mq_bio_issue_init(q, bio);
  3187		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
  3188			goto queue_exit;
  3189	
  3190		if (bio_needs_zone_write_plugging(bio)) {
  3191			if (blk_zone_plug_bio(bio, nr_segs))
  3192				goto queue_exit;
  3193		}
  3194	
  3195	new_request:
  3196		if (rq) {
  3197			rq_qos_throttle(rq->q, bio);
  3198			blk_mq_rq_time_init(rq, blk_time_get_ns());
  3199			rq->cmd_flags = bio->bi_opf;
  3200			INIT_LIST_HEAD(&rq->queuelist);
  3201		} else {
  3202			rq = blk_mq_get_new_requests(q, plug, bio);
  3203			if (unlikely(!rq)) {
  3204				if (bio->bi_opf & REQ_NOWAIT)
  3205					bio_wouldblock_error(bio);
  3206				goto queue_exit;
  3207			}
  3208		}
  3209	
  3210		trace_block_getrq(bio);
  3211	
  3212		rq_qos_track(q, rq, bio);
  3213	
  3214		blk_mq_bio_to_request(rq, bio, nr_segs);
  3215	
  3216		ret = blk_crypto_rq_get_keyslot(rq);
  3217		if (ret != BLK_STS_OK) {
  3218			bio->bi_status = ret;
  3219			bio_endio(bio);
  3220			blk_mq_free_request(rq);
  3221			return;
  3222		}
  3223	
  3224		if (bio_zone_write_plugging(bio))
  3225			blk_zone_write_plug_init_request(rq);
  3226	
  3227		if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
  3228			return;
  3229	
  3230		if (plug) {
  3231			blk_add_rq_to_plug(plug, rq);
  3232			return;
  3233		}
  3234	
  3235		hctx = rq->mq_hctx;
  3236		if ((rq->rq_flags & RQF_USE_SCHED) ||
  3237		    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
  3238			blk_mq_insert_request(rq, 0);
  3239			blk_mq_run_hw_queue(hctx, true);
  3240		} else {
  3241			blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
  3242		}
  3243		return;
  3244	
  3245	queue_exit:
  3246		if (!rq)
  3247			blk_queue_exit(q);
  3248		else
> 3249			rq_list_push(&plug->cached_rqs, rq);
  3250	}
  3251	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

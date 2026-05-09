Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45E1C2AA;
	Sat,  9 May 2026 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778285546; cv=none; b=Y++t6W/H0r8Zf3oiuPfLYFlto1E+kiMLmqsyom+YrqfmaTLW/lNRrfsIZJiK8S5SP7Qb/UYNol2QFKTRWBZxEyfREo1Tn8MvQZU4DtW61pZ/DEPq9FKu5YOk9NMJjT2qootynJn9OotJQg8Yei7/bys8u+NTxofnTjjnRue6+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778285546; c=relaxed/simple;
	bh=qke3f3D7b1NsB39qkjoZwvjiIPgWaN5TkkzYFykOXAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCDjZwke1wqsBRl6XO+tyFLR3ApGqVZosG5+WbRev3B89A/4G4HwZWzH6vO/1Xa3VeMdpg7B+medu2X86HtHlkv6HWRurEpY8kNdq3c/HtL7gX+YD6S2FZFyJJZeKOxhRZJdJvth0hEAu6XV6ygegzaqqxnECNSBbBEtL5fDUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEZRO/9B; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEZRO/9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778285544; x=1809821544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qke3f3D7b1NsB39qkjoZwvjiIPgWaN5TkkzYFykOXAo=;
  b=jEZRO/9BQfT20ReQ31OlmKmBLDdluz8VxzMMhJiwFEfG8fjbZ79dmSul
   7j3Q5XylCL8xg1iUMqGkEMOcYY1Njs22kskQb98HZTEDiSWZBJ9THmNZ/
   KL8T8V8BfQLAqAVG/IbAbiWNX5aNpQJKKre/oWS89gGFwTJJpaASRPKkP
   FmTk1QonsNoVtp8MPS0LIX0tbjaZiiedDckwv0kKHDH+qzQLmn0jwCdCb
   Nf4ADNjGDp1vTj2ZYjadp8fpUlAPufztB8x3TcneCBFzqDgiLSKawp3vF
   OpYbV8tUlhKCnoqMkp2qXiml89h8LlJEJ1IB7Yoskkk+i76gRx6dgOf7J
   A==;
X-CSE-ConnectionGUID: oDLJ8mHOSle0B/tIfii/sg==
X-CSE-MsgGUID: Ikdtkx6FRB6daAjDVDnLcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="96832995"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="96832995"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 17:12:24 -0700
X-CSE-ConnectionGUID: drqFRWufQGuIyMk/hTFLBQ==
X-CSE-MsgGUID: HAyrpZyyRBOOxCA6BWxJ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="238701147"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 08 May 2026 17:12:19 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLVIn-000000007KL-0MZp;
	Sat, 09 May 2026 00:12:17 +0000
Date: Sat, 9 May 2026 02:12:15 +0200
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bvanassche@acm.org,
	johannes.thumshirn@wdc.com, kch@nvidia.com, dlemoal@kernel.org,
	ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com,
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] blk-mq: expose tag starvation counts via debugfs
Message-ID: <202605090233.BZVa3x9s-lkp@intel.com>
References: <20260427020142.358912-3-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427020142.358912-3-atomlin@atomlin.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on trace/for-next linus/master v7.1-rc2 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/blk-mq-add-tracepoint-block_rq_tag_wait/20260428-013259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260427020142.358912-3-atomlin%40atomlin.com
patch subject: [PATCH v5 2/2] blk-mq: expose tag starvation counts via debugfs
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260509/202605090233.BZVa3x9s-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260509/202605090233.BZVa3x9s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605090233.BZVa3x9s-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/blk-core.c:45:
   In file included from include/trace/events/block.h:726:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:468:
>> include/trace/events/block.h:255:47: error: expected ':'
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                                       ^
         |                                                                       : 
   include/trace/stages/stage6_event_callback.h:133:33: note: expanded from macro 'TP_fast_assign'
     133 | #define TP_fast_assign(args...) args
         |                                 ^
   include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
      44 |                              PARAMS(assign),                   \
         |                                     ^
   include/linux/tracepoint.h:160:25: note: expanded from macro 'PARAMS'
     160 | #define PARAMS(args...) args
         |                         ^
   include/trace/trace_events.h:435:16: note: expanded from macro 'DECLARE_EVENT_CLASS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                              ^
   include/linux/tracepoint.h:160:25: note: expanded from macro 'PARAMS'
     160 | #define PARAMS(args...) args
         |                         ^
   include/trace/trace_events.h:427:4: note: expanded from macro '\
   __DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^
   include/trace/events/block.h:255:27: note: to match this '?'
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                   ^
>> include/trace/events/block.h:255:47: error: expected expression
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                                       ^
   In file included from block/blk-core.c:45:
   In file included from include/trace/events/block.h:726:
   In file included from include/trace/define_trace.h:133:
   In file included from include/trace/perf.h:110:
>> include/trace/events/block.h:255:47: error: expected ':'
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                                       ^
         |                                                                       : 
   include/trace/stages/stage6_event_callback.h:133:33: note: expanded from macro 'TP_fast_assign'
     133 | #define TP_fast_assign(args...) args
         |                                 ^
   include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
      44 |                              PARAMS(assign),                   \
         |                                     ^
   include/linux/tracepoint.h:160:25: note: expanded from macro 'PARAMS'
     160 | #define PARAMS(args...) args
         |                         ^
   include/trace/perf.h:67:16: note: expanded from macro 'DECLARE_EVENT_CLASS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                              ^
   include/linux/tracepoint.h:160:25: note: expanded from macro 'PARAMS'
     160 | #define PARAMS(args...) args
         |                         ^
   include/trace/perf.h:51:4: note: expanded from macro '\
   __DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^
   include/trace/events/block.h:255:27: note: to match this '?'
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                   ^
>> include/trace/events/block.h:255:47: error: expected expression
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                                       ^
   4 errors generated.


vim +255 include/trace/events/block.h

   242	
   243		TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx, bool is_sched_tag),
   244	
   245		TP_ARGS(q, hctx, is_sched_tag),
   246	
   247		TP_STRUCT__entry(
   248			__field( dev_t,		dev			)
   249			__field( u32,		hctx_id			)
   250			__field( u32,		nr_tags			)
   251			__field( bool,		is_sched_tag		)
   252		),
   253	
   254		TP_fast_assign(
 > 255			__entry->dev		= q->disk ? disk_devt(q->disk);
   256			__entry->hctx_id	= hctx->queue_num;
   257			__entry->is_sched_tag	= is_sched_tag;
   258	
   259			if (is_sched_tag)
   260				__entry->nr_tags = hctx->sched_tags->nr_tags;
   261			else
   262				__entry->nr_tags = hctx->tags->nr_tags;
   263		),
   264	
   265		TP_printk("%d,%d hctx=%u starved on %s tags (depth=%u)",
   266			  MAJOR(__entry->dev), MINOR(__entry->dev),
   267			  __entry->hctx_id,
   268			  __entry->is_sched_tag ? "scheduler" : "hardware",
   269			  __entry->nr_tags)
   270	);
   271	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

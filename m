Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD611A680F;
	Fri,  1 May 2026 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609493; cv=none; b=t3I6e0ZQk0pWyN93ffHAeM7gsTLnMJmiE1CNAU149lqpKaiHyBJ1fHQGnQSIFXbCsiSHgwqEmMBPhVZXXLeIyXPE0fbdfkxVjduYAimKDfQ72xiERnVr2D07oEHU20/4KSqOl9Q2i6ugNeMJjUluKRRttZW1MtJS4DuQ/anHcZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609493; c=relaxed/simple;
	bh=0qm63Tji5HFhsr4GeAfstyaO3e38YZSWTBq5ykVwRZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1e+HHtnSaanB+FPD3cZ0hx7Cg4t9c+rkHflDZX2BiYePGTuFDj/lY0aRzbK5FQ4JudOCgBnj8TjxacILRvmNis5KEtRqvMyeFzjg1zczv2THMkieobC357O47eCsY7pDodmPjZUK7TqHdhzlSVCLtC09pQWVbLI5CM36kD1DPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLpMmKO2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLpMmKO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777609490; x=1809145490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0qm63Tji5HFhsr4GeAfstyaO3e38YZSWTBq5ykVwRZ0=;
  b=JLpMmKO2DXxwzlhPyM4JzhFfOxqOVqhdDNtOVoOvYE8sak4g2BHsgHoq
   hzSkegy3gY1eCkrVjhcYCGj/hwgd5xbGAl9kKWgkhGpFy+SQdTSH2370u
   ZC+pwi7nqt4INRRwZIUZeEmzBKJ4XNEWuUmLHctL7zwFNBYQXZc1A+9Lt
   LxEO6YJtm4mn6/Ly+xGX6khBaTz+O1LJ6NHGS48+A36VKdmgN586nO1mX
   jvPYZEdVG8vEj4yOPjhZPTd03M/CQqUNdQLimh+d+YOpi5xh/azMAvHpY
   xKrJzsKrtSYPQBvOSDXiw7dAZGAu1WWGveztIf49Tv3E0SrobwQbLWrDr
   g==;
X-CSE-ConnectionGUID: NhGSVUwiR7SAbieVtg0VGg==
X-CSE-MsgGUID: WdGvn6Z3QcGCoWsBPc90Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78770775"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="78770775"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 21:24:49 -0700
X-CSE-ConnectionGUID: z8YWSLMRTF+bGmopC5dLWA==
X-CSE-MsgGUID: nITaaxZ7R/Ca+LZ/J3/cwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233912378"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 30 Apr 2026 21:24:45 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIfQg-000000004yP-2jay;
	Fri, 01 May 2026 04:24:42 +0000
Date: Fri, 1 May 2026 06:24:41 +0200
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: oe-kbuild-all@lists.linux.dev, bvanassche@acm.org,
	johannes.thumshirn@wdc.com, kch@nvidia.com, dlemoal@kernel.org,
	ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com,
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] blk-mq: expose tag starvation counts via debugfs
Message-ID: <202605010658.UrX2ImE9-lkp@intel.com>
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
[also build test ERROR on trace/for-next riteshharjani/for-next linus/master v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/blk-mq-add-tracepoint-block_rq_tag_wait/20260428-013259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260427020142.358912-3-atomlin%40atomlin.com
patch subject: [PATCH v5 2/2] blk-mq: expose tag starvation counts via debugfs
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260501/202605010658.UrX2ImE9-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260501/202605010658.UrX2ImE9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605010658.UrX2ImE9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./include/trace/define_trace.h:132,
                    from ./include/trace/events/block.h:726,
                    from block/blk-core.c:45:
   ./include/trace/events/block.h: In function 'do_trace_event_raw_event_block_rq_tag_wait':
>> ./include/trace/events/block.h:255:71: error: expected ':' before ';' token
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                                       ^
   ./include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   ./include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   ./include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   ./include/trace/events/block.h:241:1: note: in expansion of macro 'TRACE_EVENT'
     241 | TRACE_EVENT(block_rq_tag_wait,
         | ^~~~~~~~~~~
   ./include/trace/events/block.h:254:9: note: in expansion of macro 'TP_fast_assign'
     254 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   In file included from ./include/trace/define_trace.h:133:
   ./include/trace/events/block.h: In function 'do_perf_trace_block_rq_tag_wait':
>> ./include/trace/events/block.h:255:71: error: expected ':' before ';' token
     255 |                 __entry->dev            = q->disk ? disk_devt(q->disk);
         |                                                                       ^
   ./include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   ./include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   ./include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   ./include/trace/events/block.h:241:1: note: in expansion of macro 'TRACE_EVENT'
     241 | TRACE_EVENT(block_rq_tag_wait,
         | ^~~~~~~~~~~
   ./include/trace/events/block.h:254:9: note: in expansion of macro 'TP_fast_assign'
     254 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~


vim +255 ./include/trace/events/block.h

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

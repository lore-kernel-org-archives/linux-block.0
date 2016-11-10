Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40959 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbcKJMzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 07:55:52 -0500
Date: Thu, 10 Nov 2016 15:55:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: dan.j.williams@intel.com
Cc: linux-block@vger.kernel.org
Subject: [bug report] block: generic request_queue reference counting
Message-ID: <20161110125538.GD18664@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[ For some reason, I suddenly started paying attention to these?  Maybe
  I have been grepping XXX out of my warning messages for the past year?
  - dan ]

Hello Dan Williams,

The patch 3ef28e83ab15: "block: generic request_queue reference
counting" from Oct 21, 2015, leads to the following static checker
warning:

	block/blk-core.c:757 blk_alloc_queue_node()
	warn: use 'gfp_mask' here instead of GFP_XXX?

block/blk-core.c
   692  struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
                                                         ^^^^^^^^
   693  {
   694          struct request_queue *q;
   695          int err;
   696  
   697          q = kmem_cache_alloc_node(blk_requestq_cachep,
   698                                  gfp_mask | __GFP_ZERO, node_id);
                                        ^^^^^^^^
   699          if (!q)
   700                  return NULL;
   701  
   702          q->id = ida_simple_get(&blk_queue_ida, 0, 0, gfp_mask);
                                                             ^^^^^^^^
We use this earlier.


   703          if (q->id < 0)
   704                  goto fail_q;
   705  
   706          q->bio_split = bioset_create(BIO_POOL_SIZE, 0);
   707          if (!q->bio_split)
   708                  goto fail_id;
   709  
   710          q->backing_dev_info.ra_pages =
   711                          (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
   712          q->backing_dev_info.capabilities = BDI_CAP_CGROUP_WRITEBACK;
   713          q->backing_dev_info.name = "block";
   714          q->node = node_id;
   715  
   716          err = bdi_init(&q->backing_dev_info);
   717          if (err)
   718                  goto fail_split;
   719  
   720          setup_timer(&q->backing_dev_info.laptop_mode_wb_timer,
   721                      laptop_mode_timer_fn, (unsigned long) q);
   722          setup_timer(&q->timeout, blk_rq_timed_out_timer, (unsigned long) q);
   723          INIT_LIST_HEAD(&q->queue_head);
   724          INIT_LIST_HEAD(&q->timeout_list);
   725          INIT_LIST_HEAD(&q->icq_list);
   726  #ifdef CONFIG_BLK_CGROUP
   727          INIT_LIST_HEAD(&q->blkg_list);
   728  #endif
   729          INIT_DELAYED_WORK(&q->delay_work, blk_delay_work);
   730  
   731          kobject_init(&q->kobj, &blk_queue_ktype);
   732  
   733          mutex_init(&q->sysfs_lock);
   734          spin_lock_init(&q->__queue_lock);
   735  
   736          /*
   737           * By default initialize queue_lock to internal lock and driver can
   738           * override it later if need be.
   739           */
   740          q->queue_lock = &q->__queue_lock;
   741  
   742          /*
   743           * A queue starts its life with bypass turned on to avoid
   744           * unnecessary bypass on/off overhead and nasty surprises during
   745           * init.  The initial bypass will be finished when the queue is
   746           * registered by blk_register_queue().
   747           */
   748          q->bypass_depth = 1;
   749          __set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
   750  
   751          init_waitqueue_head(&q->mq_freeze_wq);
   752  
   753          /*
   754           * Init percpu_ref in atomic mode so that it's faster to shutdown.
   755           * See blk_register_queue() for details.
   756           */
   757          if (percpu_ref_init(&q->q_usage_counter,
   758                                  blk_queue_usage_counter_release,
   759                                  PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
                                                                ^^^^^^^^^^
Should probably use it here too.

   760                  goto fail_bdi;
   761  
   762          if (blkcg_init_queue(q))
   763                  goto fail_ref;
   764  
   765          return q;
   766  
   767  fail_ref:
   768          percpu_ref_exit(&q->q_usage_counter);
   769  fail_bdi:
   770          bdi_destroy(&q->backing_dev_info);
   771  fail_split:

regards,
dan carpenter

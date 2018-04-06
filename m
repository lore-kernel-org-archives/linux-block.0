Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60186 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbeDFXZB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Apr 2018 19:25:01 -0400
Date: Sat, 7 Apr 2018 07:24:44 +0800
From: kbuild test robot <lkp@intel.com>
To: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: kbuild-all@01.org, axboe@kernel.dk, tj@kernel.org, shli@fb.com,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        joseph.qi@linux.alibaba.com, nborisov@suse.com, arnd@arndb.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <201804070510.11shEgxW%fengguang.wu@intel.com>
References: <20180406150648.GA6378@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <20180406150648.GA6378@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexandru,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.16 next-20180406]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandru-Moise/blk-cgroup-remove-entries-in-blkg_tree-before-queue-release/20180407-035957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=c6x 

All errors (new ones prefixed by >>):

   block/blk-sysfs.c: In function '__blk_release_queue':
>> block/blk-sysfs.c:820:2: error: implicit declaration of function 'blkg_destroy_all'; did you mean 'irq_destroy_ipi'? [-Werror=implicit-function-declaration]
     blkg_destroy_all(q);
     ^~~~~~~~~~~~~~~~
     irq_destroy_ipi
   cc1: some warnings being treated as errors

vim +820 block/blk-sysfs.c

   770	
   771	/**
   772	 * __blk_release_queue - release a request queue when it is no longer needed
   773	 * @work: pointer to the release_work member of the request queue to be released
   774	 *
   775	 * Description:
   776	 *     blk_release_queue is the counterpart of blk_init_queue(). It should be
   777	 *     called when a request queue is being released; typically when a block
   778	 *     device is being de-registered. Its primary task it to free the queue
   779	 *     itself.
   780	 *
   781	 * Notes:
   782	 *     The low level driver must have finished any outstanding requests first
   783	 *     via blk_cleanup_queue().
   784	 *
   785	 *     Although blk_release_queue() may be called with preemption disabled,
   786	 *     __blk_release_queue() may sleep.
   787	 */
   788	static void __blk_release_queue(struct work_struct *work)
   789	{
   790		struct request_queue *q = container_of(work, typeof(*q), release_work);
   791	
   792		if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
   793			blk_stat_remove_callback(q, q->poll_cb);
   794		blk_stat_free_callback(q->poll_cb);
   795	
   796		blk_free_queue_stats(q->stats);
   797	
   798		blk_exit_rl(q, &q->root_rl);
   799	
   800		if (q->queue_tags)
   801			__blk_queue_free_tags(q);
   802	
   803		if (!q->mq_ops) {
   804			if (q->exit_rq_fn)
   805				q->exit_rq_fn(q, q->fq->flush_rq);
   806			blk_free_flush_queue(q->fq);
   807		} else {
   808			blk_mq_release(q);
   809		}
   810	
   811		blk_trace_shutdown(q);
   812	
   813		if (q->mq_ops)
   814			blk_mq_debugfs_unregister(q);
   815	
   816		if (q->bio_split)
   817			bioset_free(q->bio_split);
   818	
   819		spin_lock_irq(q->queue_lock);
 > 820		blkg_destroy_all(q);
   821		spin_unlock_irq(q->queue_lock);
   822	
   823		ida_simple_remove(&blk_queue_ida, q->id);
   824		call_rcu(&q->rcu_head, blk_free_queue_rcu);
   825	}
   826	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
umKCE7L+P+1GtJvkSwAA

--0OAP2g/MAC+5xKAE--

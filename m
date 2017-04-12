Return-Path: <xiaolong.ye@intel.com>
Date: Wed, 12 Apr 2017 16:39:48 +0800
From: Ye Xiaolong <xiaolong.ye@intel.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: kbuild test robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, Fabio Checconi <fchecconi@gmail.com>,
	broonie@kernel.org, kbuild-all@01.org,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [kbuild-all] [PATCH V2 16/16] block, bfq: split bfq-iosched.c
 into multiple source files
Message-ID: <20170412083948.GF31394@yexl-desktop>
References: <201704021757.C1wjX07L%fengguang.wu@intel.com>
 <C9AEA3F6-14A1-4D81-A33C-1C38FD1E1F45@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C9AEA3F6-14A1-4D81-A33C-1C38FD1E1F45@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On 04/11, Paolo Valente wrote:
>
>> Il giorno 02 apr 2017, alle ore 12:02, kbuild test robot <lkp@intel.com> ha scritto:
>> 
>> Hi Paolo,
>> 
>> [auto build test ERROR on block/for-next]
>> [also build test ERROR on v4.11-rc4 next-20170331]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> 
>
>Hi,
>this seems to be a false positive.  Build is correct with the tested
>tree and the .config.
>

Hmm, this error is reproducible in 0day side, and you patches were applied on
top of 803e16d "Merge branch 'for-4.12/block' into for-next", is it the same as
yours?

Thanks,
Xiaolong

>Thanks,
>Paolo
>
>> url:    https://github.com/0day-ci/linux/commits/Paolo-Valente/block-bfq-introduce-the-BFQ-v0-I-O-scheduler-as-an-extra-scheduler/20170402-100622
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
>> config: i386-allmodconfig (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>        # save the attached .config to linux build tree
>>        make ARCH=i386 
>> 
>> All errors (new ones prefixed by >>):
>> 
>>>> ERROR: "bfq_mark_bfqq_busy" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfqg_stats_update_dequeue" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_clear_bfqq_busy" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_clear_bfqq_non_blocking_wait_rq" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_bfqq_non_blocking_wait_rq" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_clear_bfqq_wait_request" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_timeout" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfqg_stats_set_start_empty_time" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_weights_tree_add" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_put_queue" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_bfqq_sync" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfqg_to_blkg" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfqq_group" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_weights_tree_remove" [block/bfq-wf2q.ko] undefined!
>>>> ERROR: "bfq_bic_update_cgroup" [block/bfq-iosched.ko] undefined!
>>>> ERROR: "bfqg_stats_set_start_idle_time" [block/bfq-iosched.ko] undefined!
>>>> ERROR: "bfqg_stats_update_completion" [block/bfq-iosched.ko] undefined!
>>>> ERROR: "bfq_bfqq_move" [block/bfq-iosched.ko] undefined!
>>>> ERROR: "bfqg_put" [block/bfq-iosched.ko] undefined!
>>>> ERROR: "next_queue_may_preempt" [block/bfq-iosched.ko] undefined!
>> 
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>> <.config.gz>
>
>_______________________________________________
>kbuild-all mailing list
>kbuild-all@lists.01.org
>https://lists.01.org/mailman/listinfo/kbuild-all

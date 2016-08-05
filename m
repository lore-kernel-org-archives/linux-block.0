Return-Path: <fengguang.wu@intel.com>
Date: Sat, 6 Aug 2016 02:19:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: kbuild-all@01.org, Roman Pen <roman.penyaev@profitbricks.com>,
	Akinobu Mita <akinobu.mita@gmail.com>, Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] blk-mq: fix hang caused by freeze/unfreeze sequence
Message-ID: <201608060213.I8ZlNrQC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <20160805174131.22043-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roman,

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.7 next-20160805]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roman-Pen/blk-mq-fix-hang-caused-by-freeze-unfreeze-sequence/20160806-014441
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: x86_64-randconfig-x012-201631 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from block/blk-core.c:14:
   block/blk-core.c: In function 'blk_queue_enter':
   block/blk-core.c:661:18: error: passing argument 1 of 'atomic_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
        !atomic_read(&q->mq_freeze_depth) ||
                     ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> include/linux/wait.h:473:2: note: in expansion of macro 'if'
     if (!(condition))      \
     ^~
   block/blk-core.c:660:9: note: in expansion of macro 'wait_event_interruptible'
      ret = wait_event_interruptible(q->mq_freeze_wq,
            ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/msr.h:66:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from block/blk-core.c:15:
   arch/x86/include/asm/atomic.h:24:28: note: expected 'const atomic_t * {aka const struct <anonymous> *}' but argument is of type 'int *'
    static __always_inline int atomic_read(const atomic_t *v)
                               ^~~~~~~~~~~
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from block/blk-core.c:14:
   block/blk-core.c:661:18: error: passing argument 1 of 'atomic_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
        !atomic_read(&q->mq_freeze_depth) ||
                     ^
   include/linux/compiler.h:151:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> include/linux/wait.h:473:2: note: in expansion of macro 'if'
     if (!(condition))      \
     ^~
   block/blk-core.c:660:9: note: in expansion of macro 'wait_event_interruptible'
      ret = wait_event_interruptible(q->mq_freeze_wq,
            ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/msr.h:66:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from block/blk-core.c:15:
   arch/x86/include/asm/atomic.h:24:28: note: expected 'const atomic_t * {aka const struct <anonymous> *}' but argument is of type 'int *'
    static __always_inline int atomic_read(const atomic_t *v)
                               ^~~~~~~~~~~
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from block/blk-core.c:14:
   block/blk-core.c:661:18: error: passing argument 1 of 'atomic_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
        !atomic_read(&q->mq_freeze_depth) ||
                     ^
   include/linux/compiler.h:162:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> include/linux/wait.h:473:2: note: in expansion of macro 'if'
     if (!(condition))      \
     ^~
   block/blk-core.c:660:9: note: in expansion of macro 'wait_event_interruptible'
      ret = wait_event_interruptible(q->mq_freeze_wq,
            ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/msr.h:66:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from block/blk-core.c:15:
   arch/x86/include/asm/atomic.h:24:28: note: expected 'const atomic_t * {aka const struct <anonymous> *}' but argument is of type 'int *'
    static __always_inline int atomic_read(const atomic_t *v)
                               ^~~~~~~~~~~
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from block/blk-core.c:14:
   block/blk-core.c:661:18: error: passing argument 1 of 'atomic_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
        !atomic_read(&q->mq_freeze_depth) ||
                     ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   include/linux/wait.h:278:3: note: in expansion of macro 'if'
      if (condition)      \
      ^~
>> include/linux/wait.h:451:2: note: in expansion of macro '___wait_event'
     ___wait_event(wq, condition, TASK_INTERRUPTIBLE, 0, 0,  \
     ^~~~~~~~~~~~~
   include/linux/wait.h:474:11: note: in expansion of macro '__wait_event_interruptible'
      __ret = __wait_event_interruptible(wq, condition); \
              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-core.c:660:9: note: in expansion of macro 'wait_event_interruptible'
      ret = wait_event_interruptible(q->mq_freeze_wq,
            ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/msr.h:66:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from block/blk-core.c:15:
   arch/x86/include/asm/atomic.h:24:28: note: expected 'const atomic_t * {aka const struct <anonymous> *}' but argument is of type 'int *'
    static __always_inline int atomic_read(const atomic_t *v)
                               ^~~~~~~~~~~
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from block/blk-core.c:14:
   block/blk-core.c:661:18: error: passing argument 1 of 'atomic_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
        !atomic_read(&q->mq_freeze_depth) ||
                     ^
   include/linux/compiler.h:151:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   include/linux/wait.h:278:3: note: in expansion of macro 'if'
      if (condition)      \
      ^~
>> include/linux/wait.h:451:2: note: in expansion of macro '___wait_event'
     ___wait_event(wq, condition, TASK_INTERRUPTIBLE, 0, 0,  \
     ^~~~~~~~~~~~~
   include/linux/wait.h:474:11: note: in expansion of macro '__wait_event_interruptible'
      __ret = __wait_event_interruptible(wq, condition); \
              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-core.c:660:9: note: in expansion of macro 'wait_event_interruptible'
      ret = wait_event_interruptible(q->mq_freeze_wq,
            ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/msr.h:66:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from block/blk-core.c:15:
   arch/x86/include/asm/atomic.h:24:28: note: expected 'const atomic_t * {aka const struct <anonymous> *}' but argument is of type 'int *'
    static __always_inline int atomic_read(const atomic_t *v)
                               ^~~~~~~~~~~
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from block/blk-core.c:14:
   block/blk-core.c:661:18: error: passing argument 1 of 'atomic_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
        !atomic_read(&q->mq_freeze_depth) ||
                     ^
   include/linux/compiler.h:162:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   include/linux/wait.h:278:3: note: in expansion of macro 'if'
      if (condition)      \
      ^~
>> include/linux/wait.h:451:2: note: in expansion of macro '___wait_event'
     ___wait_event(wq, condition, TASK_INTERRUPTIBLE, 0, 0,  \
     ^~~~~~~~~~~~~
   include/linux/wait.h:474:11: note: in expansion of macro '__wait_event_interruptible'
      __ret = __wait_event_interruptible(wq, condition); \
              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-core.c:660:9: note: in expansion of macro 'wait_event_interruptible'
      ret = wait_event_interruptible(q->mq_freeze_wq,
            ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/msr.h:66:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from block/blk-core.c:15:
   arch/x86/include/asm/atomic.h:24:28: note: expected 'const atomic_t * {aka const struct <anonymous> *}' but argument is of type 'int *'
    static __always_inline int atomic_read(const atomic_t *v)
                               ^~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/if +473 include/linux/wait.h

41a1431b1 Peter Zijlstra 2013-10-02  272  	else								\
c2d816443 Oleg Nesterov  2013-10-07  273  		__wait.flags = 0;					\
c2d816443 Oleg Nesterov  2013-10-07  274  									\
c2d816443 Oleg Nesterov  2013-10-07  275  	for (;;) {							\
c2d816443 Oleg Nesterov  2013-10-07  276  		long __int = prepare_to_wait_event(&wq, &__wait, state);\
41a1431b1 Peter Zijlstra 2013-10-02  277  									\
41a1431b1 Peter Zijlstra 2013-10-02 @278  		if (condition)						\
41a1431b1 Peter Zijlstra 2013-10-02  279  			break;						\
41a1431b1 Peter Zijlstra 2013-10-02  280  									\
c2d816443 Oleg Nesterov  2013-10-07  281  		if (___wait_is_interruptible(state) && __int) {		\
c2d816443 Oleg Nesterov  2013-10-07  282  			__ret = __int;					\
41a1431b1 Peter Zijlstra 2013-10-02  283  			if (exclusive) {				\
41a1431b1 Peter Zijlstra 2013-10-02  284  				abort_exclusive_wait(&wq, &__wait,	\
41a1431b1 Peter Zijlstra 2013-10-02  285  						     state, NULL);	\
41a1431b1 Peter Zijlstra 2013-10-02  286  				goto __out;				\
41a1431b1 Peter Zijlstra 2013-10-02  287  			}						\
41a1431b1 Peter Zijlstra 2013-10-02  288  			break;						\
41a1431b1 Peter Zijlstra 2013-10-02  289  		}							\
41a1431b1 Peter Zijlstra 2013-10-02  290  									\
41a1431b1 Peter Zijlstra 2013-10-02  291  		cmd;							\
41a1431b1 Peter Zijlstra 2013-10-02  292  	}								\
41a1431b1 Peter Zijlstra 2013-10-02  293  	finish_wait(&wq, &__wait);					\
35a2af94c Peter Zijlstra 2013-10-02  294  __out:	__ret;								\
35a2af94c Peter Zijlstra 2013-10-02  295  })
41a1431b1 Peter Zijlstra 2013-10-02  296  
^1da177e4 Linus Torvalds 2005-04-16  297  #define __wait_event(wq, condition)					\
35a2af94c Peter Zijlstra 2013-10-02  298  	(void)___wait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
35a2af94c Peter Zijlstra 2013-10-02  299  			    schedule())
^1da177e4 Linus Torvalds 2005-04-16  300  
^1da177e4 Linus Torvalds 2005-04-16  301  /**
^1da177e4 Linus Torvalds 2005-04-16  302   * wait_event - sleep until a condition gets true
^1da177e4 Linus Torvalds 2005-04-16  303   * @wq: the waitqueue to wait on
^1da177e4 Linus Torvalds 2005-04-16  304   * @condition: a C expression for the event to wait for
^1da177e4 Linus Torvalds 2005-04-16  305   *
^1da177e4 Linus Torvalds 2005-04-16  306   * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
^1da177e4 Linus Torvalds 2005-04-16  307   * @condition evaluates to true. The @condition is checked each time
^1da177e4 Linus Torvalds 2005-04-16  308   * the waitqueue @wq is woken up.
^1da177e4 Linus Torvalds 2005-04-16  309   *
^1da177e4 Linus Torvalds 2005-04-16  310   * wake_up() has to be called after changing any variable that could
^1da177e4 Linus Torvalds 2005-04-16  311   * change the result of the wait condition.
^1da177e4 Linus Torvalds 2005-04-16  312   */
^1da177e4 Linus Torvalds 2005-04-16  313  #define wait_event(wq, condition)					\
^1da177e4 Linus Torvalds 2005-04-16  314  do {									\
e22b886a8 Peter Zijlstra 2014-09-24  315  	might_sleep();							\
^1da177e4 Linus Torvalds 2005-04-16  316  	if (condition)							\
^1da177e4 Linus Torvalds 2005-04-16  317  		break;							\
^1da177e4 Linus Torvalds 2005-04-16  318  	__wait_event(wq, condition);					\
^1da177e4 Linus Torvalds 2005-04-16  319  } while (0)
^1da177e4 Linus Torvalds 2005-04-16  320  
2c5612465 Peter Zijlstra 2015-02-03  321  #define __io_wait_event(wq, condition)					\
2c5612465 Peter Zijlstra 2015-02-03  322  	(void)___wait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
2c5612465 Peter Zijlstra 2015-02-03  323  			    io_schedule())
2c5612465 Peter Zijlstra 2015-02-03  324  
2c5612465 Peter Zijlstra 2015-02-03  325  /*
2c5612465 Peter Zijlstra 2015-02-03  326   * io_wait_event() -- like wait_event() but with io_schedule()
2c5612465 Peter Zijlstra 2015-02-03  327   */
2c5612465 Peter Zijlstra 2015-02-03  328  #define io_wait_event(wq, condition)					\
2c5612465 Peter Zijlstra 2015-02-03  329  do {									\
2c5612465 Peter Zijlstra 2015-02-03  330  	might_sleep();							\
2c5612465 Peter Zijlstra 2015-02-03  331  	if (condition)							\
2c5612465 Peter Zijlstra 2015-02-03  332  		break;							\
2c5612465 Peter Zijlstra 2015-02-03  333  	__io_wait_event(wq, condition);					\
2c5612465 Peter Zijlstra 2015-02-03  334  } while (0)
2c5612465 Peter Zijlstra 2015-02-03  335  
36df04bc5 Peter Zijlstra 2014-10-29  336  #define __wait_event_freezable(wq, condition)				\
36df04bc5 Peter Zijlstra 2014-10-29  337  	___wait_event(wq, condition, TASK_INTERRUPTIBLE, 0, 0,		\
36df04bc5 Peter Zijlstra 2014-10-29  338  			    schedule(); try_to_freeze())
36df04bc5 Peter Zijlstra 2014-10-29  339  
36df04bc5 Peter Zijlstra 2014-10-29  340  /**
f4bcfa1da Stafford Horne 2016-02-23  341   * wait_event_freezable - sleep (or freeze) until a condition gets true
36df04bc5 Peter Zijlstra 2014-10-29  342   * @wq: the waitqueue to wait on
36df04bc5 Peter Zijlstra 2014-10-29  343   * @condition: a C expression for the event to wait for
36df04bc5 Peter Zijlstra 2014-10-29  344   *
36df04bc5 Peter Zijlstra 2014-10-29  345   * The process is put to sleep (TASK_INTERRUPTIBLE -- so as not to contribute
36df04bc5 Peter Zijlstra 2014-10-29  346   * to system load) until the @condition evaluates to true. The
36df04bc5 Peter Zijlstra 2014-10-29  347   * @condition is checked each time the waitqueue @wq is woken up.
36df04bc5 Peter Zijlstra 2014-10-29  348   *
36df04bc5 Peter Zijlstra 2014-10-29  349   * wake_up() has to be called after changing any variable that could
36df04bc5 Peter Zijlstra 2014-10-29  350   * change the result of the wait condition.
36df04bc5 Peter Zijlstra 2014-10-29  351   */
36df04bc5 Peter Zijlstra 2014-10-29  352  #define wait_event_freezable(wq, condition)				\
36df04bc5 Peter Zijlstra 2014-10-29  353  ({									\
36df04bc5 Peter Zijlstra 2014-10-29  354  	int __ret = 0;							\
36df04bc5 Peter Zijlstra 2014-10-29  355  	might_sleep();							\
36df04bc5 Peter Zijlstra 2014-10-29  356  	if (!(condition))						\
36df04bc5 Peter Zijlstra 2014-10-29  357  		__ret = __wait_event_freezable(wq, condition);		\
36df04bc5 Peter Zijlstra 2014-10-29  358  	__ret;								\
36df04bc5 Peter Zijlstra 2014-10-29  359  })
36df04bc5 Peter Zijlstra 2014-10-29  360  
35a2af94c Peter Zijlstra 2013-10-02  361  #define __wait_event_timeout(wq, condition, timeout)			\
35a2af94c Peter Zijlstra 2013-10-02  362  	___wait_event(wq, ___wait_cond_timeout(condition),		\
35a2af94c Peter Zijlstra 2013-10-02  363  		      TASK_UNINTERRUPTIBLE, 0, timeout,			\
35a2af94c Peter Zijlstra 2013-10-02  364  		      __ret = schedule_timeout(__ret))
^1da177e4 Linus Torvalds 2005-04-16  365  
^1da177e4 Linus Torvalds 2005-04-16  366  /**
^1da177e4 Linus Torvalds 2005-04-16  367   * wait_event_timeout - sleep until a condition gets true or a timeout elapses
^1da177e4 Linus Torvalds 2005-04-16  368   * @wq: the waitqueue to wait on
^1da177e4 Linus Torvalds 2005-04-16  369   * @condition: a C expression for the event to wait for
^1da177e4 Linus Torvalds 2005-04-16  370   * @timeout: timeout, in jiffies
^1da177e4 Linus Torvalds 2005-04-16  371   *
^1da177e4 Linus Torvalds 2005-04-16  372   * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
^1da177e4 Linus Torvalds 2005-04-16  373   * @condition evaluates to true. The @condition is checked each time
^1da177e4 Linus Torvalds 2005-04-16  374   * the waitqueue @wq is woken up.
^1da177e4 Linus Torvalds 2005-04-16  375   *
^1da177e4 Linus Torvalds 2005-04-16  376   * wake_up() has to be called after changing any variable that could
^1da177e4 Linus Torvalds 2005-04-16  377   * change the result of the wait condition.
^1da177e4 Linus Torvalds 2005-04-16  378   *
6b44f5190 Scot Doyle     2014-08-24  379   * Returns:
6b44f5190 Scot Doyle     2014-08-24  380   * 0 if the @condition evaluated to %false after the @timeout elapsed,
6b44f5190 Scot Doyle     2014-08-24  381   * 1 if the @condition evaluated to %true after the @timeout elapsed,
6b44f5190 Scot Doyle     2014-08-24  382   * or the remaining jiffies (at least 1) if the @condition evaluated
6b44f5190 Scot Doyle     2014-08-24  383   * to %true before the @timeout elapsed.
^1da177e4 Linus Torvalds 2005-04-16  384   */
^1da177e4 Linus Torvalds 2005-04-16  385  #define wait_event_timeout(wq, condition, timeout)			\
^1da177e4 Linus Torvalds 2005-04-16  386  ({									\
^1da177e4 Linus Torvalds 2005-04-16  387  	long __ret = timeout;						\
e22b886a8 Peter Zijlstra 2014-09-24  388  	might_sleep();							\
8922915b3 Oleg Nesterov  2013-10-07  389  	if (!___wait_cond_timeout(condition))				\
35a2af94c Peter Zijlstra 2013-10-02  390  		__ret = __wait_event_timeout(wq, condition, timeout);	\
^1da177e4 Linus Torvalds 2005-04-16  391  	__ret;								\
^1da177e4 Linus Torvalds 2005-04-16  392  })
^1da177e4 Linus Torvalds 2005-04-16  393  
36df04bc5 Peter Zijlstra 2014-10-29  394  #define __wait_event_freezable_timeout(wq, condition, timeout)		\
36df04bc5 Peter Zijlstra 2014-10-29  395  	___wait_event(wq, ___wait_cond_timeout(condition),		\
36df04bc5 Peter Zijlstra 2014-10-29  396  		      TASK_INTERRUPTIBLE, 0, timeout,			\
36df04bc5 Peter Zijlstra 2014-10-29  397  		      __ret = schedule_timeout(__ret); try_to_freeze())
36df04bc5 Peter Zijlstra 2014-10-29  398  
36df04bc5 Peter Zijlstra 2014-10-29  399  /*
36df04bc5 Peter Zijlstra 2014-10-29  400   * like wait_event_timeout() -- except it uses TASK_INTERRUPTIBLE to avoid
36df04bc5 Peter Zijlstra 2014-10-29  401   * increasing load and is freezable.
36df04bc5 Peter Zijlstra 2014-10-29  402   */
36df04bc5 Peter Zijlstra 2014-10-29  403  #define wait_event_freezable_timeout(wq, condition, timeout)		\
36df04bc5 Peter Zijlstra 2014-10-29  404  ({									\
36df04bc5 Peter Zijlstra 2014-10-29  405  	long __ret = timeout;						\
36df04bc5 Peter Zijlstra 2014-10-29  406  	might_sleep();							\
36df04bc5 Peter Zijlstra 2014-10-29  407  	if (!___wait_cond_timeout(condition))				\
36df04bc5 Peter Zijlstra 2014-10-29  408  		__ret = __wait_event_freezable_timeout(wq, condition, timeout);	\
36df04bc5 Peter Zijlstra 2014-10-29  409  	__ret;								\
36df04bc5 Peter Zijlstra 2014-10-29  410  })
36df04bc5 Peter Zijlstra 2014-10-29  411  
9f3520c31 Yuanhan Liu    2015-05-08  412  #define __wait_event_exclusive_cmd(wq, condition, cmd1, cmd2)		\
9f3520c31 Yuanhan Liu    2015-05-08  413  	(void)___wait_event(wq, condition, TASK_UNINTERRUPTIBLE, 1, 0,	\
9f3520c31 Yuanhan Liu    2015-05-08  414  			    cmd1; schedule(); cmd2)
9f3520c31 Yuanhan Liu    2015-05-08  415  /*
9f3520c31 Yuanhan Liu    2015-05-08  416   * Just like wait_event_cmd(), except it sets exclusive flag
9f3520c31 Yuanhan Liu    2015-05-08  417   */
9f3520c31 Yuanhan Liu    2015-05-08  418  #define wait_event_exclusive_cmd(wq, condition, cmd1, cmd2)		\
9f3520c31 Yuanhan Liu    2015-05-08  419  do {									\
9f3520c31 Yuanhan Liu    2015-05-08  420  	if (condition)							\
9f3520c31 Yuanhan Liu    2015-05-08  421  		break;							\
9f3520c31 Yuanhan Liu    2015-05-08  422  	__wait_event_exclusive_cmd(wq, condition, cmd1, cmd2);		\
9f3520c31 Yuanhan Liu    2015-05-08  423  } while (0)
9f3520c31 Yuanhan Liu    2015-05-08  424  
82e06c811 Shaohua Li     2013-11-14  425  #define __wait_event_cmd(wq, condition, cmd1, cmd2)			\
82e06c811 Shaohua Li     2013-11-14  426  	(void)___wait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
82e06c811 Shaohua Li     2013-11-14  427  			    cmd1; schedule(); cmd2)
82e06c811 Shaohua Li     2013-11-14  428  
82e06c811 Shaohua Li     2013-11-14  429  /**
82e06c811 Shaohua Li     2013-11-14  430   * wait_event_cmd - sleep until a condition gets true
82e06c811 Shaohua Li     2013-11-14  431   * @wq: the waitqueue to wait on
82e06c811 Shaohua Li     2013-11-14  432   * @condition: a C expression for the event to wait for
f434f7afa Masanari Iida  2014-01-22  433   * @cmd1: the command will be executed before sleep
f434f7afa Masanari Iida  2014-01-22  434   * @cmd2: the command will be executed after sleep
82e06c811 Shaohua Li     2013-11-14  435   *
82e06c811 Shaohua Li     2013-11-14  436   * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
82e06c811 Shaohua Li     2013-11-14  437   * @condition evaluates to true. The @condition is checked each time
82e06c811 Shaohua Li     2013-11-14  438   * the waitqueue @wq is woken up.
82e06c811 Shaohua Li     2013-11-14  439   *
82e06c811 Shaohua Li     2013-11-14  440   * wake_up() has to be called after changing any variable that could
82e06c811 Shaohua Li     2013-11-14  441   * change the result of the wait condition.
82e06c811 Shaohua Li     2013-11-14  442   */
82e06c811 Shaohua Li     2013-11-14  443  #define wait_event_cmd(wq, condition, cmd1, cmd2)			\
82e06c811 Shaohua Li     2013-11-14  444  do {									\
82e06c811 Shaohua Li     2013-11-14  445  	if (condition)							\
82e06c811 Shaohua Li     2013-11-14  446  		break;							\
82e06c811 Shaohua Li     2013-11-14  447  	__wait_event_cmd(wq, condition, cmd1, cmd2);			\
82e06c811 Shaohua Li     2013-11-14  448  } while (0)
82e06c811 Shaohua Li     2013-11-14  449  
35a2af94c Peter Zijlstra 2013-10-02  450  #define __wait_event_interruptible(wq, condition)			\
35a2af94c Peter Zijlstra 2013-10-02 @451  	___wait_event(wq, condition, TASK_INTERRUPTIBLE, 0, 0,		\
f13f4c41c Peter Zijlstra 2013-10-02  452  		      schedule())
^1da177e4 Linus Torvalds 2005-04-16  453  
^1da177e4 Linus Torvalds 2005-04-16  454  /**
^1da177e4 Linus Torvalds 2005-04-16  455   * wait_event_interruptible - sleep until a condition gets true
^1da177e4 Linus Torvalds 2005-04-16  456   * @wq: the waitqueue to wait on
^1da177e4 Linus Torvalds 2005-04-16  457   * @condition: a C expression for the event to wait for
^1da177e4 Linus Torvalds 2005-04-16  458   *
^1da177e4 Linus Torvalds 2005-04-16  459   * The process is put to sleep (TASK_INTERRUPTIBLE) until the
^1da177e4 Linus Torvalds 2005-04-16  460   * @condition evaluates to true or a signal is received.
^1da177e4 Linus Torvalds 2005-04-16  461   * The @condition is checked each time the waitqueue @wq is woken up.
^1da177e4 Linus Torvalds 2005-04-16  462   *
^1da177e4 Linus Torvalds 2005-04-16  463   * wake_up() has to be called after changing any variable that could
^1da177e4 Linus Torvalds 2005-04-16  464   * change the result of the wait condition.
^1da177e4 Linus Torvalds 2005-04-16  465   *
^1da177e4 Linus Torvalds 2005-04-16  466   * The function will return -ERESTARTSYS if it was interrupted by a
^1da177e4 Linus Torvalds 2005-04-16  467   * signal and 0 if @condition evaluated to true.
^1da177e4 Linus Torvalds 2005-04-16  468   */
^1da177e4 Linus Torvalds 2005-04-16  469  #define wait_event_interruptible(wq, condition)				\
^1da177e4 Linus Torvalds 2005-04-16  470  ({									\
^1da177e4 Linus Torvalds 2005-04-16  471  	int __ret = 0;							\
e22b886a8 Peter Zijlstra 2014-09-24  472  	might_sleep();							\
^1da177e4 Linus Torvalds 2005-04-16 @473  	if (!(condition))						\
35a2af94c Peter Zijlstra 2013-10-02  474  		__ret = __wait_event_interruptible(wq, condition);	\
^1da177e4 Linus Torvalds 2005-04-16  475  	__ret;								\
^1da177e4 Linus Torvalds 2005-04-16  476  })

:::::: The code at line 473 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cNdxnHkX5QqsyA0e
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
fMe8MqHAdjyM9uf/AhYTqFBZaAEA

--cNdxnHkX5QqsyA0e--

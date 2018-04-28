Return-Path: <axboe@kernel.dk>
Subject: Re: ed74ae0342 ("blk-mq: Avoid that a completion can be ignored .."):
 BUG: kernel hang in test stage
To: kernel test robot <lkp@intel.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, wfg@linux.intel.com
References: <5adf9ada.EgNO094GdvSdHQ3v%lkp@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <07256b82-12b1-9ccf-c660-9dfbedfd3cac@kernel.dk>
Date: Fri, 27 Apr 2018 18:52:58 -0600
MIME-Version: 1.0
In-Reply-To: <5adf9ada.EgNO094GdvSdHQ3v%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 4/24/18 3:00 PM, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-linus
> 
> commit ed74ae03424684a6ad8a973c3fa727c6b4162432
> Author:     Bart Van Assche <bart.vanassche@wdc.com>
> AuthorDate: Thu Apr 19 09:43:53 2018 -0700
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Thu Apr 19 14:21:47 2018 -0600
> 
>     blk-mq: Avoid that a completion can be ignored for BLK_EH_RESET_TIMER
>     
>     The blk-mq timeout handling code ignores completions that occur after
>     blk_mq_check_expired() has been called and before blk_mq_rq_timed_out()
>     has reset rq->aborted_gstate. If a block driver timeout handler always
>     returns BLK_EH_RESET_TIMER then the result will be that the request
>     never terminates.
>     
>     Fix this race as follows:
>     - Use the deadline instead of the request generation to detect whether
>       or not a request timer fired after reinitialization of a request.
>     - Store the request state in the lowest two bits of the deadline instead
>       of the lowest two bits of 'gstate'.
>     - Rename MQ_RQ_STATE_MASK into RQ_STATE_MASK and change it from an
>       enumeration member into a #define such that its type can be changed
>       into unsigned long. That allows to write & ~RQ_STATE_MASK instead of
>       ~(unsigned long)RQ_STATE_MASK.
>     - Remove all request member variables that became superfluous due to
>       this change: gstate, gstate_seq and aborted_gstate_sync.
>     - Remove the request state information that became superfluous due to this
>       patch, namely RQF_MQ_TIMEOUT_EXPIRED.
>     - Remove the code that became superfluous due to this change, namely
>       the RCU lock and unlock statements in blk_mq_complete_request() and
>       also the synchronize_rcu() call in the timeout handler.

Any chance you can try with the newer version?

https://github.com/bvanassche/linux/commit/4acd555fa13087

-- 
Jens Axboe

Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f6fcc94b-412c-1552-477e-ba0b0927006c@oracle.com>
Date: Tue, 10 Apr 2018 15:59:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180410013455.7448-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 04/10/2018 09:34 AM, Bart Van Assche wrote:
> If a completion occurs after blk_mq_rq_timed_out() has reset
> rq->aborted_gstate and the request is again in flight when the timeout
> expires then a request will be completed twice: a first time by the
> timeout handler and a second time when the regular completion occurs

Would you please detail more here about why the request could be completed twice ?

Is it the scenario you described as below in https://marc.info/?l=linux-block&m=151796816127318

The following race can occur between the code that resets the timer
and completion handling:
- The code that handles BLK_EH_RESET_TIMER resets aborted_gstate.
- A completion occurs and blk_mq_complete_request() calls
  __blk_mq_complete_request().
- The timeout code calls blk_add_timer() and that function sets the
  request deadline and adjusts the timer.
- __blk_mq_complete_request() frees the request tag.
- The timer fires and the timeout handler gets called for a freed
  request.
If yes, how does the timeout handler get the freed request when the tag has been freed ?

Thanks
Jianchao

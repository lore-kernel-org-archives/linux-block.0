Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
 Sebastian Ott <sebott@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk>
Date: Tue, 22 May 2018 10:44:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180522162515.20650-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


On 5/22/18 10:25 AM, Bart Van Assche wrote:
> Recently the blk-mq timeout handling code was reworked. See also Tejun
> Heo, "[PATCHSET v4] blk-mq: reimplement timeout handling", 08 Jan 2018
> (https://www.mail-archive.com/linux-block@vger.kernel.org/msg16985.html).
> This patch reworks the blk-mq timeout handling code again. The timeout
> handling code is simplified by introducing a state machine per request.
> This change avoids that the blk-mq timeout handling code ignores
> completions that occur after blk_mq_check_expired() has been called and
> before blk_mq_rq_timed_out() has been called.

I'll take a look at this again, getting rid of cmpxchg64 makes me
much more comfortable.

-- 
Jens Axboe

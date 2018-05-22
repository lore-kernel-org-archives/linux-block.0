Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>,
 Bart Van Assche <bart.vanassche@wdc.com>, linux-block@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Jianchao Wang <jianchao.w.wang@oracle.com>,
 Ming Lei <ming.lei@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>,
 Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
 <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk>
 <fee466b8-8e39-adc6-efa4-e50ffa60a663@kernel.dk>
 <448d63e9-cfcd-0bc8-abf3-30296590f1d6@kernel.dk>
 <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk>
 <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk>
 <20180522202657.GA8961@localhost.localdomain>
 <ae9b2c1e-c132-3f0c-b63b-1867d28d14c3@kernel.dk>
 <20180522210208.GA25444@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <89111f16-e0dc-f556-43a1-9251c1d7bc05@kernel.dk>
Date: Tue, 22 May 2018 15:02:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180522210208.GA25444@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/22/18 3:02 PM, Christoph Hellwig wrote:
> On Tue, May 22, 2018 at 02:29:21PM -0600, Jens Axboe wrote:
>>> of BLK_EH_HANDLED. Is the driver supposed to return BLK_EH_NOT_HANDLED
>>> when the driver actually knows the request has been completed before
>>> returning the status?
>>
>> If the driver knows it's completed, it'd have to return BLK_EH_NOT_HANDLED.
>> Or BLK_EH_HANDLED would work too, since the above state transition would
>> then fail.
> 
> Btw, I think we should just kill off BLK_EH_HANDLED.  WIP totally
> untested progress toward that is here:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-eh-ret
> 
> The only real missing bit is SCSI overloading the value for internal
> use.

I think that's a great idea, the use cases aren't clear at all, driver
writers will get this wrong.

-- 
Jens Axboe

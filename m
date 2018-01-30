Return-Path: <axboe@kernel.dk>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
To: Keith Busch <keith.busch@intel.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <20180130203011.GE27205@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d09416a0-e9c8-a921-26f4-2b9da559da90@kernel.dk>
Date: Tue, 30 Jan 2018 13:32:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180130203011.GE27205@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/30/18 1:30 PM, Keith Busch wrote:
> On Tue, Jan 30, 2018 at 08:57:49AM -0700, Jens Axboe wrote:
>>
>> Looking at the disassembly, 'n' is 2 and 'segments' is 0xffff.
> 
> Is this still a problem if you don't use an IO scheduler? With deadline,
> I'm not finding any path to bio_attempt_discard_merge which is where the
> nr_phys_segments is supposed to get it set to 2. Not sure how it could
> becmoe 0xffff, though.

blk_mq_make_request() -> blk_mq_sched_bio_merge() -> __blk_mq_sched_bio_merge()
	-> blk_mq_attempt_merge() -> bio_attempt_discard_merge()

Doesn't matter what IO scheduler you use.

I don't know if it triggers without a scheduler. I've been running this code
continually on the laptop (always do), and haven't seen it before today.


-- 
Jens Axboe

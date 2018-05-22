Return-Path: <axboe@kernel.dk>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <34ba4583-25be-acf7-8407-755e920def6b@kernel.dk>
Date: Mon, 21 May 2018 21:16:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180522024910.GD20430@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/21/18 8:49 PM, Ming Lei wrote:
> On Mon, May 21, 2018 at 05:11:31PM -0600, Keith Busch wrote:
>> This patch simplifies the timeout handling by relying on the request
>> reference counting to ensure the iterator is operating on an inflight
> 
> The reference counting isn't free, what is the real benefit in this way?

Neither is the current scheme and locking, and this is a hell of a lot
simpler. I'd get rid of the kref stuff and just do a simple
atomic_dec_and_test(). Most of the time we should be uncontended on
that, which would make it pretty darn cheap. I'd be surprised if it
wasn't better than the current alternatives.


-- 
Jens Axboe

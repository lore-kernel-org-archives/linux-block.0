Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
Subject: Re: [PATCH] block: Fix cloning of requests with a special payload
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20180627195518.13958-1-bart.vanassche@wdc.com>
 <20180627234154.GD7583@ming.t460p>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <1298ed24-e1a4-d141-21f1-68e2b8bb7f04@wdc.com>
Date: Wed, 27 Jun 2018 16:43:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180627234154.GD7583@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/27/18 16:42, Ming Lei wrote:
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> BTW, if possible, could you please make a block test to catch this issue?

Hello Ming,

Thanks for the review.

I ran into this while testing the blktests port of the SRP tests scripts.

Bart.

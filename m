Return-Path: <prvs=710a02b92=bart.vanassche@wdc.com>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <20180627235005.GE7583@ming.t460p>
 <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
 <20180628003007.GG7583@ming.t460p>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <5e78949d-6169-5a5a-869b-731a3468e2de@wdc.com>
Date: Thu, 28 Jun 2018 08:21:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180628003007.GG7583@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/27/18 17:30, Ming Lei wrote:
> One core idea of immutable bvec is to use bio->bi_iter and the original
> bvec table to iterate over anywhere in the bio. That is why .bi_io_vec
> needs to copy, but not see any reason why .bi_vcnt needs to do.
> 
> Do you have use cases on .bi_vcnt for cloned bio?

So far this is only a theoretical concern. There are many functions in 
the block layer that use .bi_vcnt, and it is a lot of work to figure out 
all the callers of all these functions.

Bart.

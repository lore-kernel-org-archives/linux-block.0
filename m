Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
Subject: Re: [PATCH] block: Simplify the bio cloning implementation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20180626222624.11739-1-bart.vanassche@wdc.com>
 <20180627011259.GC9970@ming.t460p>
 <5766ea06-4016-6ad1-a18a-b2c9f31788cf@wdc.com>
 <20180627232039.GA7583@ming.t460p>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <6d9bb0d0-52fd-8f16-6443-dcd8867bdb7c@wdc.com>
Date: Wed, 27 Jun 2018 16:55:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180627232039.GA7583@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/27/18 16:21, Ming Lei wrote:
> What we need to do is to only copy the 1st bvec for WRITE_SAME, your patch
> changes to copy (bio->bi_iter.bi_size / block size) bvecs, then memory corruption
> may be triggered. So bio_for_each_segment() can't be used here.

Has it been considered to use memcpy() to copy the bi_vcnt bio_vecs 
instead of using bio_for_each_segment() in bio_clone_bioset()? That will 
in this context probably be even faster than using bio_for_each_segment().

Bart.

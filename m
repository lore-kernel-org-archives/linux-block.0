Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0581d9cb-87c7-9ef9-1c65-33b0742b3dcf@kernel.dk>
Date: Thu, 28 Jun 2018 09:53:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180627201231.15641-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/27/18 2:12 PM, Bart Van Assche wrote:
> Although __bio_clone_fast() copies bi_io_vec, it does not copy bi_vcnt,
> the number of elements in bi_io_vec[] that contains data. Copy bi_vcnt
> such that code that needs this member behaves identically for original
> and for cloned requests.

Applied - it's correct for the current base.

-- 
Jens Axboe

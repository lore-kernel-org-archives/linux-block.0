Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Tue, 19 Jun 2018 14:16:18 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
Message-ID: <20180619181618.GA19298@kmo-pixel>
References: <20180619172640.15246-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180619172640.15246-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 19, 2018 at 10:26:40AM -0700, Bart Van Assche wrote:
> Commit 0ba99ca4838b ("block: Add warning for bi_next not NULL in
> bio_endio()") breaks the dm driver. end_clone_bio() detects whether
> or not a bio is the last bio associated with a request by checking
> the .bi_next field. Commit 0ba99ca4838b clears that field before
> end_clone_bio() has had a chance to inspect that field. Hence revert
> commit 0ba99ca4838b.
> 
> This patch avoids that KASAN reports the following complaint when
> running the srp-test software (srp-test/run_tests -c -d -r 10 -t 02-mq):

Thanks for debugging this

I take it if we had a test for request based dm in blktests or somewhere that
probably would have caught this much easier :/

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Mike Snitzer <snitzer@redhat.com>
References: <20180619172640.15246-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <50636b75-ad6f-8345-27d3-b85cbe0578f3@kernel.dk>
Date: Tue, 19 Jun 2018 12:00:06 -0600
MIME-Version: 1.0
In-Reply-To: <20180619172640.15246-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/19/18 11:26 AM, Bart Van Assche wrote:
> Commit 0ba99ca4838b ("block: Add warning for bi_next not NULL in
> bio_endio()") breaks the dm driver. end_clone_bio() detects whether
> or not a bio is the last bio associated with a request by checking
> the .bi_next field. Commit 0ba99ca4838b clears that field before
> end_clone_bio() has had a chance to inspect that field. Hence revert
> commit 0ba99ca4838b.

Applied, thanks Bart.

-- 
Jens Axboe

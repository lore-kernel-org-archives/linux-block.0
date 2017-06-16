Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 16 Jun 2017 10:59:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca, hch@infradead.org
Subject: Re: [PATCH 05/12] fs: add fcntl() interface for setting/getting
 write life time hints
Message-ID: <20170616175918.GA27996@infradead.org>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
 <1497544930-19174-6-git-send-email-axboe@kernel.dk>
 <yq1efujq3vq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1efujq3vq.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 16, 2017 at 12:44:09PM -0400, Martin K. Petersen wrote:
> It seems like an overkill to have different fcntls for different
> hints. And since we are expecting more, maybe these should be
> F_{GET,SET}_HINT and then the individual flags can be
> WRITE_LIFETIME_FOOBAR?

That's what I was trying to explain earlier - have
F_{GET,SET}_HINT ake a u16 (or maybe even a u32 or u64 with the
remainder reserved) and then take 3 bits for the write lifetime.
Which btw means we'd have another 3 possible values left if
we encode is as a value instead of as bits.

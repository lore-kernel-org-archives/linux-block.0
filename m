Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Tue, 22 May 2018 21:30:20 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
Message-ID: <20180523013020.GA12391@kmo-pixel>
References: <20180522235505.20937-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522235505.20937-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 04:55:05PM -0700, Bart Van Assche wrote:
> This patch avoids that KASAN reports the following complaint when
> running the srp-test software:

I made a real attempt to get your test suite working. It would be nice if you
could make an attempt at tracking it down instead of just reverting, and holding
up improvements to the whole block layer, since you seem to have an easy repro
for it.

This is a real looming issue - we have other code which assumes things about
bi_next and this isn't a practical thing to grep/audit for.

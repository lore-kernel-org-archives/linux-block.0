Return-Path: <jack@suse.cz>
Date: Tue, 2 May 2017 18:29:22 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Treat REQ_FUA and REQ_PREFLUSH as synchronous
Message-ID: <20170502162922.GN13916@quack2.suse.cz>
References: <20170502102123.GE13916@quack2.suse.cz>
 <20170502144505.GA29623@infradead.org>
 <f4bedc20-7b27-bfa9-76c6-c34c8c3e816b@kernel.dk>
 <20170502151558.GL13916@quack2.suse.cz>
 <20170502151815.GA24317@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170502151815.GA24317@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Tue 02-05-17 08:18:15, Christoph Hellwig wrote:
> On Tue, May 02, 2017 at 05:15:58PM +0200, Jan Kara wrote:
> > in generic_make_request_checks()? Or just set it unconditionally in that
> > function if we see REQ_FUA | REQ_PREFLUSH set?
> 
> Just add REQ_FUA and REQ_PREFLUSH to the test in op_is_sync.

It is there. The problem happens when REQ_FUA and REQ_PREFLUSH get stripped
from bio because the underlying storage doesn't have volatile cache, the
bio suddently becomes treated as async which regresses performance.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

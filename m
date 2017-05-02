Return-Path: <BATV+0ce91e3c8ec9178008cb+5000+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 2 May 2017 08:18:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Treat REQ_FUA and REQ_PREFLUSH as synchronous
Message-ID: <20170502151815.GA24317@infradead.org>
References: <20170502102123.GE13916@quack2.suse.cz>
 <20170502144505.GA29623@infradead.org>
 <f4bedc20-7b27-bfa9-76c6-c34c8c3e816b@kernel.dk>
 <20170502151558.GL13916@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170502151558.GL13916@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 02, 2017 at 05:15:58PM +0200, Jan Kara wrote:
> in generic_make_request_checks()? Or just set it unconditionally in that
> function if we see REQ_FUA | REQ_PREFLUSH set?

Just add REQ_FUA and REQ_PREFLUSH to the test in op_is_sync.

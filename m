Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 18 Jun 2017 23:25:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
Message-ID: <20170619062557.GA2311@infradead.org>
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
 <20170617122106.GB8320@infradead.org>
 <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
 <20170617150303.GA15290@infradead.org>
 <b159f6cb-a272-cd06-207a-4cce8336c86d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b159f6cb-a272-cd06-207a-4cce8336c86d@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 17, 2017 at 09:11:30AM -0600, Jens Axboe wrote:
> I have two samples here, and I just tested, and both of them want it
> assigned with nsid=0xffffffff or they will fail the writes... So I'd say
> we're better off ensuring we do allocate them globally.

That's clearly against the spec.  I'd say go to your vendor and get
a refund, as we Linux folks (Martin and I) fought for this so that
we would not have to do the explicit allocations.

Another quote for from the spec:

"Streams are opened by the controller when the host issues a write
 command that specifies a stream identifier that is not currently open.
 While a stream is open the controller maintains context for that stream
 (e.g., buffers for associated data). The host may determine the streams 
 that are open using the Get Status operation."

And I think this is very important - otherwise you need to either
allocate the stremas beforehand as your earlier patches (and we take
away the resources from the 99% of the users not using write life
hints), or we need the lazy allocation scheme.  And for that to be
efficient it probably needs to be lazy per-stream allocation.  That's
why we got the implicit open in after all.

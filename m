Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 16 Jun 2017 11:02:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170616180249.GC27996@infradead.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
 <20170616073339.GC8682@infradead.org>
 <0ac0bb7e-ce8d-cb63-985c-ab2d1f3402f1@kernel.dk>
 <20170616155206.GB27209@infradead.org>
 <ed334779-20b6-3fef-d66d-cd63a493a92f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed334779-20b6-3fef-d66d-cd63a493a92f@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 16, 2017 at 09:59:38AM -0600, Jens Axboe wrote:
> >> Did you see v5? It adds enum write_hint and passes it all the way down,
> >> until we transform them into rq/bio flags.
> > 
> > Yes.  But with all the way down I mean all the way down to the driver :)
> 
> Only missing part is the request flags. And why make that any different
> than the flags we already have now? It'd be trivial to pack the value
> into the request flags as well, but I'm struggling to see the point of
> that, honestly.
> 
> Please expand on why you think changing the request flags to also
> carry that value would be useful, as opposed to just mapping it when
> we setup the request. If you have a valid concern I don't mind making
> the change, but I just don't see one right now.

Mostly so that we can pass the value down in one form through the whole
stack.

> How so? It's pretty straight forward. The only downside I see is that
> we'll have a delay between seeing the first valid write hint and to
> the time when nvme has it enabled. But that's so short, and in the
> grander scheme of things, doesn't matter one bit.

I'll take your word for that.  To be honest I hope future standards
won't make the mistake to come up with something as ugly as streams
and just take something like our hints on a per-I/O basis..

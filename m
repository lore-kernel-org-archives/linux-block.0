Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60D114
	for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 00:57:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D02468B05; Thu, 14 Dec 2023 09:57:29 +0100 (CET)
Date: Thu, 14 Dec 2023 09:57:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231214085729.GA9099@lst.de>
References: <20231212171846.GA28682@lst.de> <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org> <20231212174802.GA30659@lst.de> <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org> <20231212181304.GA32666@lst.de> <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org> <20231212182613.GA1216@lst.de> <ZXiual-UkUY4OWY2@google.com> <20231213155606.GA8748@lst.de> <ZXnevBo4eIZEXbhK@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnevBo4eIZEXbhK@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 13, 2023 at 08:41:32AM -0800, Jaegeuk Kim wrote:
> I don't have any
> concern to keep the same ioprio on writes, since handheld devices are mostly
> sensitive to reads. So, if you have other use-cases using zoned writes which
> require different ioprio on writes, I think you can suggest a knob to control
> it by users.

Get out of your little handheld world.  In Linux we need a generally usable
I/O stack, and any feature exposed by the kernel and will be used quite
differently than you imagine.

Just like people will add reordering to the I/O stack that's not there
right now (in addition to the ones your testing doesn't hit).  That
doensn't mean we should avoid them - you genereally get better performance
by not reordering without a good reason (like thotting), but especially
in error handling paths or resource constrained environment they will
hapen all over.  We've had this whole discussion with the I/O barriers
that did not work for exactly the same reasons.

> 
> > 
> > > it is essential to place the data per file to get better bandwidth. And for
> > > NAND-based storage, filesystem is the right place to deal with the more efficient
> > > garbage collecion based on the known data locations.
> > 
> > And that works perfectly fine match for zone append.
> 
> How that works, if the device gives random LBAs back to the adjacent data in
> a file? And, how to make the LBAs into the sequential ones back?

Why would your device pick random LBAs?  If you send a zone append to
zone it will be written at the write pointer, which is absolutely not
random.  All I/O written in a single write is going to be sequential,
so just like for all other devices doing large sequential writes is
important.  Multiple writes can get reordered, but if you havily hit
the same zone you'd get the same effect in the file system allocator
too.

> Sorry, I needed to stop reading here, as you're totally biased. This is not
> the case in JEDEC, as Bart spent multiple years to synchronize the technical
> benefitcs that we've seen across UFS vendors as well as OEMs.

*lol*  There is no more fucked up corporate pressure standard committee
than the storage standards in JEDEC.  That's why not one actually takes
them seriously.


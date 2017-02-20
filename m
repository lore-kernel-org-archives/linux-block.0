Return-Path: <hch@lst.de>
Date: Mon, 20 Feb 2017 08:35:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
Message-ID: <20170220073539.GA17687@lst.de>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk> <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com> <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Feb 19, 2017 at 06:15:41PM -0700, Jens Axboe wrote:
> I don't think that's a regression in this series, it just triggers more easily
> with this series. The BLOCK_PC removal fixes aren't touching device life times
> at all.

Yes.

> That said, we will look into this again, of course. Christoph, any idea?

No idea really - this seems so far away from the code touched, and there
are no obvious signs for a memory scamble from another object touched
that I think if it really bisects down to that issue it must be a timing
issue.

But reading Bart's message again:  Did you actually bisect it down
to the is commit?  Or just test the whole tree?  Between the 4.10-rc5
merge and all the block tree there might a few more likely suspects
like the scsi bdi lifetime fixes that James mentioned.

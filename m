Return-Path: <hch@lst.de>
Date: Sat, 25 Feb 2017 19:17:04 +0100
From: "hch@lst.de" <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"snitzer@redhat.com" <snitzer@redhat.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
Message-ID: <20170225181704.GB27774@lst.de>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk> <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com> <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk> <20170220073539.GA17687@lst.de> <1D08B61A9CF0974AA09887BE32D889DA0A8CBD@ULS-OP-MBXIP03.sdcorp.global.sandisk.com> <f9b3b2ca-b19b-7c4a-52bb-789c3e2b39e5@kernel.dk> <1487957968.2575.6.camel@sandisk.com> <CA+55aFw7T8hsZpMfWuo5e=DnsuRjp8cfQzGb8Qeng=RRR61fYA@mail.gmail.com> <0af4ed69-a9d0-44be-701c-ced76b84bfef@kernel.dk> <0dc039e5-58c5-d328-0b81-bf9e7d782675@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0dc039e5-58c5-d328-0b81-bf9e7d782675@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 24, 2017 at 01:22:42PM -0700, Jens Axboe wrote:
> Bart, I pushed a fix here:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=61febef40bfe8ab68259d8545257686e8a0d91d1

Yeah, this looks fine to me.  It was broken on blk-mq before, but
basically impossible to hit.  I wonder if we should have a debug mode
where we set requests to a known pattern after they are freed to catch
these sort of bugs.

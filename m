Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Sun, 20 May 2018 18:17:33 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Message-ID: <20180520221733.GA11495@kmo-pixel>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
 <20180518090636.GA14738@kmo-pixel>
 <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 03:12:27PM +0000, Bart Van Assche wrote:
> On Fri, 2018-05-18 at 05:06 -0400, Kent Overstreet wrote:
> > On Thu, May 17, 2018 at 08:54:57PM +0000, Bart Van Assche wrote:
> > > With Jens' latest for-next branch I hit the kernel warning shown below. Can
> > > you have a look?
> > 
> > Any hints on how to reproduce it?
> 
> Sure. This is how I triggered it:
> * Clone https://github.com/bvanassche/srp-test.
> * Follow the instructions in README.md.
> * Run srp-test/run_tests -c -r 10

Can you bisect it? I don't have infiniband hardware handy...

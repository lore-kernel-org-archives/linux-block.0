Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Fri, 13 Apr 2018 12:21:33 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"alex@iss-integration.com" <alex@iss-integration.com>,
	"jbacik@fb.com" <jbacik@fb.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] nbd: del_gendisk after we cleanup the queue
Message-ID: <20180413162132.xudowhvxyijbzqqa@destiny>
References: <20180413160334.5496-1-josef@toxicpanda.com>
 <0a8b3a85910e7bbe0103120e85844e96341d73ec.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0a8b3a85910e7bbe0103120e85844e96341d73ec.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 13, 2018 at 04:16:18PM +0000, Bart Van Assche wrote:
> On Fri, 2018-04-13 at 12:03 -0400, Josef Bacik wrote:
> > This fixes a use after free bug, we need to do the del_gendisk after we
> > cleanup the queue on the device.
> 
> Hello Josef,
> 
> Which use-after-free bug does this patch fix? Are you aware that most block
> drivers call blk_cleanup_queue() before calling del_gendisk()? Why do you
> think that the nbd driver should use the opposite order?
> 

I'm confused, that's what this patch does.  Before I had del_gendisk() first and
then the blk_cleanup_queue(), which was bugging out when I was testing stuff
with a null pointer deref whenever I rmmod'ed the nbd.  Swapping it to the way
everybody else did it fixed the problem.  Thanks,

Josef

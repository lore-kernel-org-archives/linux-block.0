Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 8 Dec 2016 12:02:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>, linux-block@vger.kernel.org
Subject: Re: [RFC 06/10] block: use tida as small id allocator
Message-ID: <20161208110229.GA28572@kroah.com>
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
 <1481160187-9652-7-git-send-email-linux@rasmusvillemoes.dk>
 <b422a160-3d04-324c-e142-1099bc0380c0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b422a160-3d04-324c-e142-1099bc0380c0@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 07, 2016 at 08:56:27PM -0700, Jens Axboe wrote:
> On 12/07/2016 06:23 PM, Rasmus Villemoes wrote:
> > A struct ida ends up costing > 16 KB of runtime memory, which is quite
> > a lot for something which on my laptop as of this writing has handed
> > out 27 ids in its lifetime. So use the simpler and lighter-weight
> > struct tida.
> 
> I'm worried that your example of your laptop isn't an all encompassing
> test case. How well does the simplified ida allocator work for tens of
> thousands of disks, at scan time? SCSI is notorious for setting up and
> tearing down a ton of queues at probe time.
> 
> Unless we have more testing than 'it works on my laptop and saves 16k',
> I'm not super intereted in the patch.

Rasmus, you can create 30k virtual scsi devices on your laptop to test
if this really does work or saves any real time or memory.  I'd
recommend doing that if you want to get patches like this ever accepted.

good luck!

greg k-h

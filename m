Return-Path: <axboe@kernel.dk>
Subject: Re: [RFC 06/10] block: use tida as small id allocator
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
 <1481160187-9652-7-git-send-email-linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b422a160-3d04-324c-e142-1099bc0380c0@kernel.dk>
Date: Wed, 7 Dec 2016 20:56:27 -0700
MIME-Version: 1.0
In-Reply-To: <1481160187-9652-7-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/07/2016 06:23 PM, Rasmus Villemoes wrote:
> A struct ida ends up costing > 16 KB of runtime memory, which is quite
> a lot for something which on my laptop as of this writing has handed
> out 27 ids in its lifetime. So use the simpler and lighter-weight
> struct tida.

I'm worried that your example of your laptop isn't an all encompassing
test case. How well does the simplified ida allocator work for tens of
thousands of disks, at scan time? SCSI is notorious for setting up and
tearing down a ton of queues at probe time.

Unless we have more testing than 'it works on my laptop and saves 16k',
I'm not super intereted in the patch.


-- 
Jens Axboe

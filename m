Return-Path: <axboe@kernel.dk>
Subject: Re: [linux-next][bock] WARNING: CPU: 22 PID: 0 at
 block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linux-block <linux-block@vger.kernel.org>
References: <1493965539.7355.44.camel@abdul.in.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, sachinp <sachinp@linux.vnet.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
Date: Fri, 5 May 2017 08:02:25 -0600
MIME-Version: 1.0
In-Reply-To: <1493965539.7355.44.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/05/2017 12:25 AM, Abdul Haleem wrote:
> Hi,
> 
> 4.11.0 Linus mainline booted with Warnings on PowerPC.
> 
> We did not see this on next-20170407 but on next-20170410 and later.

Have you tried current Linus -git? Both of the -next versions you list
are rather old.

-- 
Jens Axboe

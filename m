Return-Path: <axboe@kernel.dk>
Subject: Re: [patch] nbd: blk_mq_init_queue returns an error code on failure,
 not NULL
To: Omar Sandoval <osandov@osandov.com>, Jeff Moyer <jmoyer@redhat.com>
References: <x49vatogf3k.fsf@segfault.boston.devel.redhat.com>
 <20170109202707.GA29762@vader.DHCP.thefacebook.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, linux-block@vger.kernel.org,
 nbd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Josef Bacik <jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dc596214-08a4-32b5-aa30-38ddecdf1b48@kernel.dk>
Date: Mon, 9 Jan 2017 13:41:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170109202707.GA29762@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/09/2017 01:27 PM, Omar Sandoval wrote:
> On Mon, Jan 09, 2017 at 03:20:31PM -0500, Jeff Moyer wrote:
>> Additionally, don't assign directly to disk->queue, otherwise
>> blk_put_queue (called via put_disk) will choke (panic) on the errno
>> stored there.
>>
>> Bug found by code inspection after Omar found a similar issue in
>> virtio_blk.  Compile-tested only.
>>
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> Compile-reviewed only :) Josef can probably test it if he cares enough,
> but it looks right.

Looks good to me, too. Josef, you want me to queue this up directly?

-- 
Jens Axboe

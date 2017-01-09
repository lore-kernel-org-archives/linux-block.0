Return-Path: <prvs=21826f0111=jbacik@fb.com>
Date: Mon, 9 Jan 2017 15:44:20 -0500
From: Josef Bacik <jbacik@fb.com>
Subject: Re: [patch] nbd: blk_mq_init_queue returns an error code on
 failure, not NULL
To: Jens Axboe <axboe@kernel.dk>
CC: Omar Sandoval <osandov@osandov.com>, Jeff Moyer <jmoyer@redhat.com>,
        Markus Pargmann <mpa@pengutronix.de>, <linux-block@vger.kernel.org>,
        <nbd-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Message-ID: <1483994660.22708.3@smtp.office365.com>
In-Reply-To: <dc596214-08a4-32b5-aa30-38ddecdf1b48@kernel.dk>
References: <x49vatogf3k.fsf@segfault.boston.devel.redhat.com>
	<20170109202707.GA29762@vader.DHCP.thefacebook.com>
	<dc596214-08a4-32b5-aa30-38ddecdf1b48@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 9, 2017 at 3:41 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 01/09/2017 01:27 PM, Omar Sandoval wrote:
>>  On Mon, Jan 09, 2017 at 03:20:31PM -0500, Jeff Moyer wrote:
>>>  Additionally, don't assign directly to disk->queue, otherwise
>>>  blk_put_queue (called via put_disk) will choke (panic) on the errno
>>>  stored there.
>>> 
>>>  Bug found by code inspection after Omar found a similar issue in
>>>  virtio_blk.  Compile-tested only.
>>> 
>>>  Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> 
>>  Reviewed-by: Omar Sandoval <osandov@fb.com>
>> 
>>  Compile-reviewed only :) Josef can probably test it if he cares 
>> enough,
>>  but it looks right.
> 
> Looks good to me, too. Josef, you want me to queue this up directly?

Y'all are hilarious.

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef

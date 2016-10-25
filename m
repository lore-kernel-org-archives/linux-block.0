Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: zoned: fix harmless maybe-uninitialized warning
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20161021154242.3707589-1-arnd@arndb.de>
 <yq11sz5b5tk.fsf@sermon.lab.mkp.net>
Cc: Shaun Tancheff <shaun@tancheff.com>,
 Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <804d9f6b-22fa-ded3-301e-b7b3643c72d8@kernel.dk>
Date: Mon, 24 Oct 2016 20:51:36 -0600
MIME-Version: 1.0
In-Reply-To: <yq11sz5b5tk.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/24/2016 07:00 PM, Martin K. Petersen wrote:
>>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:
>
> Arnd> The blkdev_report_zones produces a harmless warning when
> Arnd> -Wmaybe-uninitialized is set, after gcc gets a little confused
> Arnd> about the multiple 'goto' here:
>
> Arnd> block/blk-zoned.c: In function 'blkdev_report_zones':
> Arnd> block/blk-zoned.c:188:13: error: 'nz' may be used uninitialized in
> Arnd> this function [-Werror=maybe-uninitialized]
>
> Arnd> Moving the assignment to nr_zones makes this a little simpler
> Arnd> while also avoiding the warning reliably. I'm removing the
> Arnd> extraneous initialization of 'int ret' in the same patch, as that
> Arnd> is semi-related and could cause an uninitialized use of that
> Arnd> variable to not produce a warning.
>
> Jens: Are you picking up Arnd's two fixes for the zoned code?

Yep, adding them now. Thanks Arnd.

-- 
Jens Axboe

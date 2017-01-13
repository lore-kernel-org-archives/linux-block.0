Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] Rename blk_queue_zone_size and bdev_zone_size
To: Jens Axboe <axboe@kernel.dk>
References: <20170112024253.5814-1-damien.lemoal@wdc.com>
 <20170112035214.GA27546@kernel.dk>
 <884ea9c8-6191-2630-78fd-ffed62a81f16@wdc.com>
 <36f3cd82-93f3-06ce-df75-f3c7d98322c3@kernel.dk>
 <9cdcae8c-ad41-bd22-1e0d-0facdae52a71@kernel.dk>
CC: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-block@vger.kernel.org>, Shaun
 Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <ea96698d-5821-e90a-a3da-a642e8784e35@wdc.com>
Date: Fri, 13 Jan 2017 09:10:27 +0900
MIME-Version: 1.0
In-Reply-To: <9cdcae8c-ad41-bd22-1e0d-0facdae52a71@kernel.dk>
Content-Type: text/plain; charset="windows-1252"
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>


Jens,

On 1/13/17 05:49, Jens Axboe wrote:
> Just in case you missed it, I had to fold your two patches. Looking at
> it again, what is going on? You rename a function, and then patch #2
> renames the use of that function in a different spot? How did that ever
> pass your testing? For something intended for the current series, please
> be more careful than that, that's just sloppy.

I created two patches, one for each component/maintainer involved:
block/you and f2fs/Jaegeuk. That was indeed a very stupid idea as the 2
patches must always go together (and that is how I tested). A single
patch was the right way to do things. My apologies for this mistake and
thank you very much for fixing it. I will be more careful in the future.

Best regards.

-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.

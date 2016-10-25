Return-Path: <martin.petersen@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Shaun Tancheff <shaun@tancheff.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: zoned: fix harmless maybe-uninitialized warning
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20161021154242.3707589-1-arnd@arndb.de>
Date: Mon, 24 Oct 2016 21:00:55 -0400
In-Reply-To: <20161021154242.3707589-1-arnd@arndb.de> (Arnd Bergmann's message
	of "Fri, 21 Oct 2016 17:42:33 +0200")
Message-ID: <yq11sz5b5tk.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> The blkdev_report_zones produces a harmless warning when
Arnd> -Wmaybe-uninitialized is set, after gcc gets a little confused
Arnd> about the multiple 'goto' here:

Arnd> block/blk-zoned.c: In function 'blkdev_report_zones':
Arnd> block/blk-zoned.c:188:13: error: 'nz' may be used uninitialized in
Arnd> this function [-Werror=maybe-uninitialized]

Arnd> Moving the assignment to nr_zones makes this a little simpler
Arnd> while also avoiding the warning reliably. I'm removing the
Arnd> extraneous initialization of 'int ret' in the same patch, as that
Arnd> is semi-related and could cause an uninitialized use of that
Arnd> variable to not produce a warning.

Jens: Are you picking up Arnd's two fixes for the zoned code?

-- 
Martin K. Petersen	Oracle Linux Engineering

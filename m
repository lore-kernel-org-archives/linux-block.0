Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/55] Convert skd driver to blk-mq
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Akhil Bhansali <Akhil.Bhansali@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d4f997c8-9e2f-9157-16cb-f20a3df24cb7@kernel.dk>
Date: Thu, 17 Aug 2017 14:44:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2017 02:12 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> As you know all existing single queue block drivers have to be converted
> to blk-mq before the single queue block layer can be removed. Hence this
> patch series that converts the skd (sTec s1120) driver to blk-mq. As the
> following performance numbers show, this patch series does not affect
> performance of the skd driver significantly:

Awesome, thanks Bart!
 
>  MAINTAINERS               |    6 +
>  block/blk-core.c          |    2 +-
>  drivers/block/skd_main.c  | 3196 ++++++++++++---------------------------------
>  drivers/block/skd_s1120.h |   38 +-
>  4 files changed, 846 insertions(+), 2396 deletions(-)

Outside of killing yet another user of the legacy stuff, this right there
is the real win.

-- 
Jens Axboe

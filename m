Return-Path: <axboe@kernel.dk>
Date: Fri, 18 Aug 2017 08:46:33 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>
Subject: Re: [PATCH 00/55] Convert skd driver to blk-mq
Message-ID: <20170818144632.GA21786@kernel.dk>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17 2017, Bart Van Assche wrote:
> Hello Jens,
> 
> As you know all existing single queue block drivers have to be converted
> to blk-mq before the single queue block layer can be removed. Hence this
> patch series that converts the skd (sTec s1120) driver to blk-mq. As the
> following performance numbers show, this patch series does not affect
> performance of the skd driver significantly:

Applied for 4.14. Would still appreciate a followup patch to kill the
versioning nonsense.

-- 
Jens Axboe

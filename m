Return-Path: <hch@lst.de>
Date: Tue, 27 Sep 2016 20:24:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <damien.lemoal@hgst.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 7/7] blk-zoned: implement ioctls
Message-ID: <20160927182423.GA22238@lst.de>
References: <1474888483-29762-1-git-send-email-damien.lemoal@hgst.com> <1474888483-29762-8-git-send-email-damien.lemoal@hgst.com> <20160926163752.GA13876@infradead.org> <CAJVOszCdwMhLyZAJAWDnDBziyAejxdwi5J-X197RXwNuvC82GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJVOszCdwMhLyZAJAWDnDBziyAejxdwi5J-X197RXwNuvC82GA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 26, 2016 at 06:12:24PM -0500, Shaun Tancheff wrote:
> Except our source locations are disjoint (stack and kcalloc'd).

Indeed.

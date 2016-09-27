Return-Path: <BATV+259b03faba90157c3c8a+4783+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 27 Sep 2016 14:23:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaun Tancheff <shaun@tancheff.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@hgst.com>, shaun.tancheff@seagate.com
Subject: Re: [PATCH v3 7/7] blk-zoned: implement ioctls
Message-ID: <20160927212350.GA32067@infradead.org>
References: <1474888209-29445-8-git-send-email-damien.lemoal@hgst.com>
 <20160927185617.19405-1-shaun@tancheff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160927185617.19405-1-shaun@tancheff.com>
List-ID: <linux-block@vger.kernel.org>

Damien, can you do a repost of the whole series with the
header reshuffled included?  Except for that and the trivial
kcalloc bit the series looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

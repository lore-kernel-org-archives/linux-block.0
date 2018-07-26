Return-Path: <jthumshirn@suse.de>
Date: Thu, 26 Jul 2018 13:00:17 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH for v4.18] blk-mq: Rename BLK_EH_DONE into
 BLK_EH_DONT_RESET_TIMER
Message-ID: <20180726110017.27pgvbwheygfnxqi@linux-x5ow.site>
References: <20180724213205.11119-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180724213205.11119-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

I'm OK with the rename in general but not sure about doing it this
late in the cycle.

Anyways,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

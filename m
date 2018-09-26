Return-Path: <jthumshirn@suse.de>
Date: Wed, 26 Sep 2018 09:27:11 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix deadline elevator drain for zoned block
 devices
Message-ID: <20180926072711.GB4238@linux-x5ow.site>
References: <20180926072316.24996-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180926072316.24996-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 26, 2018 at 04:23:16PM +0900, Damien Le Moal wrote:
> When the deadline scheduler is used with a zoned block device, writes
> to a zone will be dispatched one a a time. This causes the warning
                        at a time? ^

Otherwise,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

Return-Path: <jthumshirn@suse.de>
Date: Thu, 1 Mar 2018 16:22:01 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 04/11] block: Protect queue flag changes with the queue
 lock
Message-ID: <20180301152201.hv4zvabamikcnub4@linux-x5ow.site>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
 <20180228192823.5191-5-bart.vanassche@wdc.com>
 <20180301085137.6g3hgobf6kj2bosy@linux-x5ow.site>
 <1519917546.3204.4.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1519917546.3204.4.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 03:19:08PM +0000, Bart Van Assche wrote:
> Hello Johannes,
> 
> Since blk_poll_stats_enable() is called from the hot path (polling code) I
> think we need the optimization of calling test_bit() before calling
> test_and_set_bit(). I will restore the test_bit() call.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

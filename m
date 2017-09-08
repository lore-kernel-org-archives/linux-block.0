Return-Path: <jthumshirn@suse.de>
Date: Fri, 8 Sep 2017 11:50:37 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V2 09/12] scsi: sd_zbc: Limit zone write locking to
 sequential zones
Message-ID: <20170908095036.rn753u6mjdzlfazr@linux-x5ow.site>
References: <20170907161640.30465-1-damien.lemoal@wdc.com>
 <20170907161640.30465-10-damien.lemoal@wdc.com>
 <20170908083925.kw4ungsvxxsgtb4i@linux-x5ow.site>
 <20170908094809.GA27141@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170908094809.GA27141@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 11:48:09AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 08, 2017 at 10:39:25AM +0200, Johannes Thumshirn wrote:
> > It's a shame we have all this overflow checking kcalloc() and
> > kmalloc_array() functions but none of them is taking NUMA nodes into
> > account.
> 
> Something that could be trivially fixed..

I know I'm on it ;-)

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

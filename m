Return-Path: <jthumshirn@suse.de>
Date: Wed, 18 Jul 2018 11:20:15 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Martin Wilck <mwilck@suse.com>, Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	jack@suse.com, kent.overstreet@gmail.com
Subject: Re: Silent data corruption in blkdev_direct_IO()
Message-ID: <20180718092014.65k4dvg2ezrpbnzn@linux-x5ow.site>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
 <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
 <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk>
 <f6f3f16b66622a9b16acd0d8be7ef311e4da807a.camel@suse.com>
 <CACVXFVPV1ckFvvh3m61QSPCtEY19ussRsMtKoptUbY3LLHKz8A@mail.gmail.com>
 <ff0fc8c44f205453a203e88676942507339f6829.camel@suse.com>
 <20180718024758.GB11151@ming.t460p>
 <54436062eee1e10644b536ae3c8c40f94da3ccbd.camel@suse.com>
 <20180718075440.GA15254@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180718075440.GA15254@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 03:54:46PM +0800, Ming Lei wrote:
> Please go ahead and take care of it since you have the test cases.

Speaking of which, do we already know how it is triggered and can we
cook up a blktests testcase for it? This would be more than helpful
for all parties.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

Return-Path: <jthumshirn@suse.de>
Date: Thu, 6 Apr 2017 17:20:02 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
Message-ID: <20170406152000.GF3768@linux-x5ow.site>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
 <20170406144741.GA27776@infradead.org>
 <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 08:51:36AM -0600, Jens Axboe wrote:
> On 04/06/2017 08:47 AM, Christoph Hellwig wrote:
> > On Thu, Apr 06, 2017 at 08:33:55AM -0600, Jens Axboe wrote:
> >> That is exactly what my recommendation was at lsfmm as well - fork
> >> xfstest, prune bits we don't need, and off we go. I'll get around to
> >> it soonish.
> > 
> > So you volunteer to do it?  I was -><- this close to offering it myself,
> > and than thought of all the other backlog I have on my plate :)
> 
> Yeah, I'll get something cobbled together next week.

Yay!

But please keep the dependencies small. It'll suck when we'd have to pull in a
gazillion megabytes for perl/pyhthon/whatever.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

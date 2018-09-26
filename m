Return-Path: <hch@lst.de>
Date: Wed, 26 Sep 2018 16:57:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
Message-ID: <20180926145732.GA9446@lst.de>
References: <20180921203122.49743-1-bvanassche@acm.org> <20180921203122.49743-8-bvanassche@acm.org> <20180926142740.GE8604@lst.de> <20180926144357.GC13588@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180926144357.GC13588@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 26, 2018 at 04:43:57PM +0200, Johannes Thumshirn wrote:
> > assert, so I guess we'll have to live with it..
> 
> How about:
> 			if (IS_ENABLED(CONFIG_PM))
> 			   WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);

I don't think this actually works given that rpm_status only exists
if CONFIG_PM is set.

Return-Path: <ming.lei@redhat.com>
Date: Fri, 22 Sep 2017 08:03:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 4/4] scsi-mq: Reduce suspend latency
Message-ID: <20170922000317.GI6854@ming.t460p>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
 <20170921212255.12788-5-bart.vanassche@wdc.com>
 <20170921220652.GD6854@ming.t460p>
 <1506033805.2521.27.camel@wdc.com>
 <20170921232543.GG6854@ming.t460p>
 <1506036752.2521.32.camel@wdc.com>
 <20170921235327.GH6854@ming.t460p>
 <1506038192.2521.33.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506038192.2521.33.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 11:56:33PM +0000, Bart Van Assche wrote:
> On Fri, 2017-09-22 at 07:53 +0800, Ming Lei wrote:
> > Then that is simply not enough since the issue is that request pool can
> > be used up easily when SCSI device is quiesced, then no request is left
> > for RQF_PREEMPT(PM), and I/O hang is triggered.
> > 
> > It has been discussed for long time, I am sorry you still don't
> > understand it.
> 
> I'm really sorry that you don't understand the intention of this patch series.
> Anyway, let's close the discussion here and continue once the next version of
> this patch series has been posted.

So you mean you don't want to fix Cathy's issue? which was reported from
one production system of our customer.

And definitely belongs to same kind of SCSI quiesce issue.

-- 
Ming

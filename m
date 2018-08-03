Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Aug 2018 09:11:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 8/9] blk-mq: Insert blk_pm_{add,put}_request() calls
Message-ID: <20180803011132.GF16047@ming.t460p>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
 <20180802182944.14442-9-bart.vanassche@wdc.com>
 <20180802235338.GB16047@ming.t460p>
 <51cfe7ab9e54013e278072e91b59b04432488dc7.camel@wdc.com>
 <20180803001142.GD16047@ming.t460p>
 <9223e26eee24d595cde189daa9c121d07c2260e4.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9223e26eee24d595cde189daa9c121d07c2260e4.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 03, 2018 at 01:03:36AM +0000, Bart Van Assche wrote:
> On Fri, 2018-08-03 at 08:11 +0800, Ming Lei wrote:
> > On Fri, Aug 03, 2018 at 12:08:54AM +0000, Bart Van Assche wrote:
> > > On Fri, 2018-08-03 at 07:53 +0800, Ming Lei wrote:
> > > > blk_pm_add_request() calls pm_request_resume() for waking up device, but
> > > > it is wrong because it is async request, which can't guarantee device
> > > > will be ready before calling .queue_rq().
> > > 
> > > That's a longstanding issue and not something that has been introduced by this
> > > patch series. Hence patch 6/9 that issues a warning if pm_request_resume() would
> > > be called.
> > 
> > It is introduced by your patch, please see blk_pm_allow_request().
> 
> Did you perhaps misread my patch? Please have a look at commit c8158819d506
> ("block: implement runtime pm strategy"). I think that commit from 2013
> introduced the pm_request_resume() call in blk_pm_add_request().
> 
> By the way, if you would like to see that call removed, I'm fine with
> removing that call.

pm_request_resume() isn't used wrong now, and the issue is introduced by
removing blk_pm_allow_request(), which is called in elv_next_request() for
avoiding this issue, so that requests can be kept in scheduler queue if
device isn't active.

Thanks,
Ming

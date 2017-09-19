Return-Path: <keith.busch@intel.com>
Date: Tue, 19 Sep 2017 12:39:29 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
Message-ID: <20170919163929.GC6180@localhost.localdomain>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
 <1505772477.12701.6.camel@wdc.com>
 <20170918223900.GA4671@localhost.localdomain>
 <1505775191.12701.20.camel@wdc.com>
 <20170918230803.GB4671@localhost.localdomain>
 <CACVXFVO4joG1zzipABWK4bc5Rwo9bDa4by4_mFOTx10nQPAUpQ@mail.gmail.com>
 <20170919150721.GA6180@localhost.localdomain>
 <1505834324.2671.13.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505834324.2671.13.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 19, 2017 at 03:18:45PM +0000, Bart Van Assche wrote:
> On Tue, 2017-09-19 at 11:07 -0400, Keith Busch wrote:
> > The problem is when blk-mq's timeout handler prevents the request from
> > completing, and doesn't leave any indication the driver requested to
> > complete it. Who is responsible for completing that request now?
> 
> Hello Keith,
> 
> My understanding is that block drivers are responsible for completing timed
> out requests by using one of the following approaches:
> * By returning BLK_EH_HANDLED or BLK_EH_RESET_TIMER from inside the timeout
>   handler.

No problem with BLK_EH_HANDLED when timeout handler completes the
request. That usage at least makes sense.

In NVMe, we use BLK_EH_RESET_TIMER if the driver does an asynchronous
action to reclaim the request. If the request is returned very soon though
(before blk-mq clears ATOM_COMPLETE), blk_mq_complete_request will still
to do nothing.

> * By returning BLK_EH_NOT_HANDLED and by calling blk_mq_end_request() or
>   __blk_mq_end_request() for the request that timed out.

You want to bypass __blk_mq_complete_request? Doesn't that actually do
important things with queue and scheduler stats? If it's not important,
then this sounds like the piece I'm looking for, but this also puts a
burden on the driver to track the state of their requests that blk-mq
could do for all drivers.

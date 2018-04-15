Return-Path: <ming.lei@redhat.com>
Date: Sun, 15 Apr 2018 23:15:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"tj@kernel.org" <tj@kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V3] blk-mq: fix race between complete and
 BLK_EH_RESET_TIMER
Message-ID: <20180415151537.GA2406@ming.t460p>
References: <20180412115956.16207-1-ming.lei@redhat.com>
 <4008f36d-c2c4-25b9-4af5-8efbe9d452c0@kernel.dk>
 <60846d0eea47181049fe77a0b303d7e04348b951.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <60846d0eea47181049fe77a0b303d7e04348b951.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Apr 14, 2018 at 03:22:07PM +0000, Bart Van Assche wrote:
> On Fri, 2018-04-13 at 21:06 -0600, Jens Axboe wrote:
> > I like this approach since it keeps the cost outside of the fast
> > path. And it's fine to reuse the queue lock for this, instead of
> > adding a special lock for something we consider a rare occurrence.
> > 
> > From a quick look this looks sane, but I'll take a closer look
> > tomrrow and add some testing too.

Jens, please hold on, I will post out V4 soon, which will improve V3 a bit.

> 
> Shouldn't we know the root cause of the "RIP: scsi_times_out+0x17" crash reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=199077 before we decide how to proceed?

I will ask Martin to test the V4 once it is posted out.


Thanks,
Ming

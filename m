Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 14 Apr 2017 10:13:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hare@suse.com" <hare@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] blk-mq: Do not invoke queue operations on a dead
 queue
Message-ID: <20170414171305.GA28522@vader.dhcp.thefacebook.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
 <20170411205842.28137-2-bart.vanassche@sandisk.com>
 <20170413230102.GA1550@vader.DHCP.thefacebook.com>
 <1492124731.2723.1.camel@sandisk.com>
 <20170414074023.GA24673@vader>
 <1492186320.2644.7.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492186320.2644.7.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 14, 2017 at 04:12:01PM +0000, Bart Van Assche wrote:
> On Fri, 2017-04-14 at 00:40 -0700, Omar Sandoval wrote:
> > On Thu, Apr 13, 2017 at 11:05:32PM +0000, Bart Van Assche wrote:
> > > On Thu, 2017-04-13 at 16:01 -0700, Omar Sandoval wrote:
> > > > Looking at this, I think we have similar issues with most of the other
> > > > debugfs files. Should we move the debugfs cleanup earlier?
> > > 
> > > That's a good question. However, while I was debugging it was very convenient
> > > to be able to access the queue state after it had reached the "dead" state.
> > > Performing the cleanup earlier would be an alternative solution but would
> > > make debugging a bit harder ...
> > 
> > What useful information were you getting out of debugfs once the queue
> > was already dead? Wasn't the interesting stuff freed at that point?
> 
> Hello Omar,
> 
> I'm currently chasing a stall of dm-rq + dm-mpath that occurs after the
> queues below it have reached the "dead" state. I will look for another
> way to obtain the information I need such that we can remove the block
> layer queue debugfs information before these queues reach the "dead"
> state.
> 
> Bart.

Thanks, Bart. In this case, the absence of the "mq" directory should
tell you that the queue is dead. Will you move the cleanup in v2 or
should I submit a separate patch?

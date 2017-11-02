Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 07:48:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171102234801.GB27370@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
 <20171101014611.GA8200@ming.t460p>
 <59F9FE28-F31A-47FD-A3FD-90CE1DB38FB2@kernel.dk>
 <20171101020312.GA9527@ming.t460p>
 <e6c4aa07-6427-bbee-ba14-fcba5e4f29ac@kernel.dk>
 <1509638224.2484.14.camel@wdc.com>
 <20171102233835.GA27370@ming.t460p>
 <1509666235.2484.23.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509666235.2484.23.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 02, 2017 at 11:43:55PM +0000, Bart Van Assche wrote:
> On Fri, 2017-11-03 at 07:38 +0800, Ming Lei wrote:
> > On Thu, Nov 02, 2017 at 03:57:05PM +0000, Bart Van Assche wrote:
> > > On Wed, 2017-11-01 at 08:21 -0600, Jens Axboe wrote:
> > > > Fixed that up, and applied these two patches as well.
> > > 
> > > Hello Jens,
> > > 
> > > Recently I noticed that a test system sporadically hangs during boot (Dell
> > > PowerEdge R720 that boots from a hard disk connected to a MegaRAID SAS adapter)
> > > and also that srp-tests systematically hangs. Reverting the two patches from
> > > this series fixes both issues. I'm not sure there is another solution than
> > > reverting the two patches from this series.
> > 
> > Then we need to find the root cause, instead of using sort of workaround
> > as before.
> > 
> > For SCSI, the restart is always run from scsi_end_request(), and this
> > kind of restart from all hctx isn't necessary at all.
> 
> Yes, we need to find the root cause, but after these two patches have either
> been reverted or have been removed from the for-4.15 queue. Otherwise if a
> bisect lands in the middle of these two patches and the fix for these patches
> that would be very frustrating for the person who is running the bisect.

Could you please share your srp-tests script? I may find a IB/SRP system
to see if I can reproduce this issue and figure out one solution.

-- 
Ming

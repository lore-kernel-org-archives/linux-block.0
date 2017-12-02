Return-Path: <ming.lei@redhat.com>
Date: Sat, 2 Dec 2017 09:20:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"hare@suse.de" <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/7] blk-mq: Avoid that request processing stalls when
 sharing tags
Message-ID: <20171202012048.GA30469@ming.t460p>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
 <20171201000848.2656-5-bart.vanassche@wdc.com>
 <20171201025803.GA29741@ming.t460p>
 <1512157932.2520.27.camel@wdc.com>
 <20171202003625.GA24521@ming.t460p>
 <1512175730.2520.29.camel@wdc.com>
 <20171202010026.GC24521@ming.t460p>
 <1512176705.2520.32.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512176705.2520.32.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Dec 02, 2017 at 01:05:05AM +0000, Bart Van Assche wrote:
> On Sat, 2017-12-02 at 09:00 +0800, Ming Lei wrote:
> > On Sat, Dec 02, 2017 at 12:48:51AM +0000, Bart Van Assche wrote:
> > > Further tests have shown that the lockup I referred to does not occur before commit
> > > b347689ffbca but that it occurs with b347689ffbca.
> > 
> > Then you need to root cause it, or
> 
> It's not my job to root cause bugs introduced by your patches.

Then show us the debugfs and dmesg log, otherwise how can we make
progress since you are the only reproducer?

Also it is you who posts the patch, you have to provide exact root
cause.

-- 
Ming

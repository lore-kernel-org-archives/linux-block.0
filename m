Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 26 Apr 2017 13:37:58 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
Message-ID: <20170426203758.GA29476@vader.dhcp.thefacebook.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
 <20170425203745.19946-6-bart.vanassche@sandisk.com>
 <20170425213018.GB6361@vader>
 <1493238750.2632.13.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493238750.2632.13.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 26, 2017 at 08:32:31PM +0000, Bart Van Assche wrote:
> On Tue, 2017-04-25 at 14:30 -0700, Omar Sandoval wrote:
> > Jens, could you ack that dropping the lock is okay?
> 
> Hello Omar,
> 
> If you have a look at the block layer history then you will see that the
> current approach for shutting down block layer queues is an approach that
> I had introduced myself. See also commits 3f3299d5c026, 807592a4fafb and
> c246e80d8673.
> 
> Bart.

Thanks for the reference. Jens' suggestion looks the cleanest to me.

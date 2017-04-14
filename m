Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] blk-mq: Do not invoke queue operations on a dead
 queue
Date: Fri, 14 Apr 2017 17:37:12 +0000
Message-ID: <1492191431.2644.10.camel@sandisk.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
	 <20170411205842.28137-2-bart.vanassche@sandisk.com>
	 <20170413230102.GA1550@vader.DHCP.thefacebook.com>
	 <1492124731.2723.1.camel@sandisk.com> <20170414074023.GA24673@vader>
	 <1492186320.2644.7.camel@sandisk.com>
	 <20170414171305.GA28522@vader.dhcp.thefacebook.com>
In-Reply-To: <20170414171305.GA28522@vader.dhcp.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-14 at 10:13 -0700, Omar Sandoval wrote:
> Thanks, Bart. In this case, the absence of the "mq" directory should
> tell you that the queue is dead. Will you move the cleanup in v2 or
> should I submit a separate patch?

Hello Omar,

I will include a patch in v2 of this patch series that unregisters the
debugfs attributes earlier.

Bart.=

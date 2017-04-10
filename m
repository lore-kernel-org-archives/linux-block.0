Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] Export more queue state information through debugfs
Date: Mon, 10 Apr 2017 20:12:00 +0000
Message-ID: <1491855119.4199.21.camel@sandisk.com>
References: <20170330182127.24288-1-bart.vanassche@sandisk.com>
	 <826af944-2316-8352-118c-91887d747eca@kernel.dk>
	 <51f5cd27-4ae4-0a21-63e2-c7a2ec95e257@sandisk.com>
	 <20170410200045.GA18846@vader.DHCP.thefacebook.com>
In-Reply-To: <20170410200045.GA18846@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-04-10 at 13:00 -0700, Omar Sandoval wrote:
> Can you just move blk_queue_flags_fops to blk_mq_debugfs_queue_attrs
> instead of adding blk_queue_attrs?

Hello Omar,

Are you aware that that change will move the "state" attribute one level
down in the hierarchy? blk_mq_debugfs_queue_attrs attributes are created
under "mq" while blk_queue_flags_fops attributes are created at the same
level as the "mq" attribute. I had added blk_queue_flags_fops because the
"state" attribute is not related to blk-mq. That attribute is also relevant
for single-queue block layer queues.

Bart.

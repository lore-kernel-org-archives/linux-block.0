Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] blk-mq: Add blk_mq_ops.show_rq()
Date: Fri, 14 Apr 2017 16:03:02 +0000
Message-ID: <1492185780.2644.5.camel@sandisk.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
	 <20170411205842.28137-6-bart.vanassche@sandisk.com>
	 <20170413232104.GF1550@vader.DHCP.thefacebook.com>
In-Reply-To: <20170413232104.GF1550@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-13 at 16:21 -0700, Omar Sandoval wrote:
> How about passing the seq_file to the callback instead of this
> arbitrarily-sized on-stack buffer?

Hello Omar,

That sounds like a good idea to me. I will make that change.

Bart.=

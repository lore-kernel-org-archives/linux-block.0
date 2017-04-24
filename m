Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 04/10] blk-mq: Check blk_mq_debugfs_register() return
 value
Date: Mon, 24 Apr 2017 17:05:28 +0000
Message-ID: <1493053527.3394.6.camel@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
	 <20170421234026.18970-5-bart.vanassche@sandisk.com>
	 <20170424164935.GB28510@vader.DHCP.thefacebook.com>
In-Reply-To: <20170424164935.GB28510@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-04-24 at 09:49 -0700, Omar Sandoval wrote:
> On Fri, Apr 21, 2017 at 04:40:20PM -0700, Bart Van Assche wrote:
> > Make __blk_mq_register_dev() check the blk_mq_debugfs_register()
> > return value.
>=20
> I intentionally didn't check this. In my opinion, a missing debug
> directory shouldn't be fatal.

OK, I will remove that return value check again.

Bart.=

Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
Date: Tue, 30 May 2017 17:29:25 +0000
Message-ID: <1496165364.2627.17.camel@sandisk.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
	 <20170525233810.23211-5-bart.vanassche@sandisk.com>
	 <20170527005456.GB20421@ming.t460p> <20170527031634.GC20909@ming.t460p>
In-Reply-To: <20170527031634.GC20909@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-05-27 at 11:16 +0800, Ming Lei wrote:
> What is the real motivation for this debug interface, could Bart explain
> a bit?

As mentioned in the description of this patch, the purpose of this patch
is to allow anyone who is working on a block driver to figure out whether
or not a request got stuck in a block driver. This means that .queue_rq()
got called for a request but the block driver did not trigger a call to
.end_io().

Bart.=

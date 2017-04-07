Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.de" <hare@suse.de>,
	"longli@microsoft.com" <longli@microsoft.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "kys@microsoft.com" <kys@microsoft.com>
Subject: Re: [PATCH v3 4/5] blk-mq: Introduce blk_mq_delay_run_hw_queue()
Date: Fri, 7 Apr 2017 15:13:21 +0000
Message-ID: <1491577999.2559.3.camel@sandisk.com>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
	 <20170406181050.12137-5-bart.vanassche@sandisk.com>
	 <20170407102343.GB28554@ming.t460p>
In-Reply-To: <20170407102343.GB28554@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-07 at 18:23 +0800, Ming Lei wrote:
> On Thu, Apr 06, 2017 at 11:10:49AM -0700, Bart Van Assche wrote:
> > Introduce a function that runs a hardware queue unconditionally
>=20
> I appreciate if some background can be provided for this function,
> like fixing some issues?

Hello Ming,

Have you noticed that patch 5/5 in this series uses this function?

Bart.=

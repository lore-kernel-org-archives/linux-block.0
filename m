Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"avanzini.arianna@gmail.com" <avanzini.arianna@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/16] Introduce the BFQ I/O scheduler
Date: Tue, 11 Apr 2017 18:31:53 +0000
Message-ID: <1491935512.2654.16.camel@sandisk.com>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
	 <1491921434.2540.1.camel@sandisk.com>
	 <17A56264-D096-4F6E-8E66-50030A10B331@linaro.org>
In-Reply-To: <17A56264-D096-4F6E-8E66-50030A10B331@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-04-11 at 19:37 +0200, Paolo Valente wrote:
> Just pushed:
> https://github.com/Algodev-github/bfq-mq/tree/add-bfq-mq-logical

Thanks!

But are you aware that the code on that branch doesn't build?

$ make all
[ ... ]
ERROR: "bfq_mark_bfqq_busy" [block/bfq-wf2q.ko] undefined!
ERROR: "bfqg_stats_update_dequeue" [block/bfq-wf2q.ko] undefined!
[ ... ]

$ PAGER=3D git grep bfq_mark_bfqq_busy
block/bfq-wf2q.c: =A0=A0=A0=A0=A0=A0bfq_mark_bfqq_busy(bfqq);

Bart.=

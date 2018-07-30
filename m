Return-Path: <prvs=7421cc28f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "tomi@nomi.cz" <tomi@nomi.cz>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "ps@pks.im"
	<ps@pks.im>, "soprwa@gmail.com" <soprwa@gmail.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: really disable runtime-pm for blk-mq
Date: Mon, 30 Jul 2018 20:43:12 +0000
Message-ID: <08023c404ab13ef6e1ccbf6efdae3dbc6bb484a4.camel@wdc.com>
References: <20180730120219.24164-1-ming.lei@redhat.com>
In-Reply-To: <20180730120219.24164-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-30 at 20:02 +-0800, Ming Lei wrote:
+AD4- Runtime PM isn't ready for blk-mq yet, and commit 765e40b675a9 (+ACI-=
block:
+AD4- disable runtime-pm for blk-mq+ACI-) tried to disable it. Unfortunatel=
y,
+AD4- it can't take effect in that way since user space still can switch
+AD4- it on via 'echo auto +AD4- /sys/block/sdN/device/power/control'.
+AD4-=20
+AD4- This patch disables runtime-pm for blk-mq really by pm+AF8-runtime+AF=
8-disable()
+AD4- and fixes all kinds of PM related kernel crash.

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-

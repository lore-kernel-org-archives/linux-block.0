Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v5 5/9] block: Change the runtime power management
 approach (1/2)
Date: Thu, 9 Aug 2018 17:12:43 +0000
Message-ID: <d13b751866a375f8898ce351c2194f4648fe62f6.camel@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
	 <20180807225133.27221-6-bart.vanassche@wdc.com>
	 <414b8689-f04a-abaa-d659-f29dffed7d3e@oracle.com>
	 <6a1acd11-6e71-ea48-d7fc-1e367d4e4dda@oracle.com>
	 <2c3fa0fddb9118fb7a5584935fa79b19b062abcb.camel@wdc.com>
	 <20180809025204.GC18139@ming.t460p>
In-Reply-To: <20180809025204.GC18139@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-08-09 at 10:52 +-0800, Ming Lei wrote:
+AD4- On Wed, Aug 08, 2018 at 05:28:43PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- Some but not all blk+AF8-queue+AF8-enter() calls are related to=
 request allocation so
+AD4-=20
+AD4- The only one I remember is scsi+AF8-ioctl+AF8-reset(), in which scsi+=
AF8-autopm+AF8-get+AF8-host()
+AD4- is called before allocating this request, that means it is enough to =
put
+AD4- host up for handling RESET. Also this request shouldn't have entered =
the block
+AD4- request queue.
+AD4-=20
+AD4- Or are there other cases in which request allocation isn't related wi=
th
+AD4- blk+AF8-queue+AF8-enter()?

What I was referring to in my e-mail is the q+AF8-usage+AF8-counter manipul=
ations
in blk+AF8-mq+AF8-timeout+AF8-work(). However, blk+AF8-mq+AF8-timeout+AF8-w=
ork() manipulates that
counter directly. So it's only the blk+AF8-queue+AF8-exit() call in that fu=
nction
that is not related to request allocation. All blk+AF8-queue+AF8-enter() ca=
lls I
know of are related to request allocation.

Bart.

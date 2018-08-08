Return-Path: <prvs=75172a298=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v5 5/9] block: Change the runtime power management
 approach (1/2)
Date: Wed, 8 Aug 2018 17:28:43 +0000
Message-ID: <2c3fa0fddb9118fb7a5584935fa79b19b062abcb.camel@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
	 <20180807225133.27221-6-bart.vanassche@wdc.com>
	 <414b8689-f04a-abaa-d659-f29dffed7d3e@oracle.com>
	 <6a1acd11-6e71-ea48-d7fc-1e367d4e4dda@oracle.com>
In-Reply-To: <6a1acd11-6e71-ea48-d7fc-1e367d4e4dda@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 14:43 +-0800, jianchao.wang wrote:
+AD4-=20
+AD4- On 08/08/2018 02:11 PM, jianchao.wang wrote:
+AD4- +AD4- Hi Bart
+AD4- +AD4-=20
+AD4- +AD4- On 08/08/2018 06:51 AM, Bart Van Assche wrote:
+AD4- +AD4- +AD4- +AEAAQA- -391,6 +-393,9 +AEAAQA- static struct request +A=
Co-blk+AF8-mq+AF8-get+AF8-request(struct request+AF8-queue +ACo-q,
+AD4- +AD4- +AD4-  		+AH0-
+AD4- +AD4- +AD4-  	+AH0-
+AD4- +AD4- +AD4-  	data-+AD4-hctx-+AD4-queued+-+-+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-	blk+AF8-pm+AF8-add+AF8-request(q, rq)+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4-  	return rq+ADs-
+AD4- +AD4- +AD4-  +AH0-
+AD4- +AD4-=20
+AD4- +AD4- The request+AF8-queue is in pm+AF8-only mode when suspended, wh=
o can reach here to do the resume ?
+AD4-=20
+AD4- I mean, in the original blk-legacy runtime pm implementation, any new=
 IO could trigger the resume,
+AD4- after your patch set, only the pm request could pass the blk+AF8-queu=
e+AF8-enter while the queue is suspended
+AD4- and in pm-only mode. But if no resume, where does the pm request come=
 from ?
+AD4-=20
+AD4- The blk+AF8-pm+AF8-add+AF8-request should be added to blk+AF8-queue+A=
F8-enter.
+AD4- It looks like as following:
+AD4-    1. when an normal io reaches blk+AF8-queue+AF8-enter, if queue is =
in suspended mode, it invoke blk+AF8-pm+AF8-add+AF8-request
+AD4-       to trigger the resume, then wait here for the pm+AF8-only mode =
to be cleared.
+AD4-    2. the runtime pm core does the resume work and clear the pm+AF8-o=
nly more finally
+AD4-    3. the task blocked in blk+AF8-queue+AF8-enter is waked up and pro=
ceed.

Hello Jianchao,

Some but not all blk+AF8-queue+AF8-enter() calls are related to request all=
ocation so
I'm not sure that that call should be added into blk+AF8-queue+AF8-enter().=
 The reason
my tests passed is probably because of the scsi+AF8-autopm+AF8-get+AF8-devi=
ce() calls in
the sd and sr drivers. However, not all request submission code is protecte=
d by
these calls. I will have a closer look at how to preserve the behavior that
queueing a new request that is not protected by scsi+AF8-autopm+AF8-get+AF8=
AKg-() restores
full power mode.

Bart.

Return-Path: <prvs=750bc9d11=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.de"
	<hare@suse.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v4 0/2] Ensure that a request queue is dissociated from
 the cgroup controller
Date: Tue, 7 Aug 2018 21:50:55 +0000
Message-ID: <fb65d91ee47467a4798ab5b60612d51cf4c68702.camel@wdc.com>
References: <20180730211056.18570-1-bart.vanassche@wdc.com>
In-Reply-To: <20180730211056.18570-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-30 at 14:10 -0700, Bart Van Assche wrote:
+AD4- Several block drivers call alloc+AF8-disk() followed by put+AF8-disk(=
) if something
+AD4- fails before device+AF8-add+AF8-disk() is called without calling blk+=
AF8-cleanup+AF8-queue().
+AD4- Make sure that also for this scenario a request queue is dissociated =
from the
+AD4- cgroup controller. This patch avoids that loading the parport+AF8-pc,=
 paride and
+AD4- pf drivers trigger a kernel crash. Since this patch series fixes a re=
gression,
+AD4- please consider these patches for kernel v4.19.

+AFs- ... +AF0-

Can anyone help with reviewing this patch series? This patch series is seve=
ral
months old and fixes a regression that was reported by a Linux user.

Thanks,

Bart.

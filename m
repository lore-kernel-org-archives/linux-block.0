Return-Path: <prvs=75172a298=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v5 1/9] block: Change the preempt-only flag into a counter
Date: Wed, 8 Aug 2018 15:27:31 +0000
Message-ID: <d5a518ad7777a27d26f718262ca7427d8ea4597b.camel@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
	 <20180807225133.27221-2-bart.vanassche@wdc.com>
	 <20180808082136.GA13518@ming.t460p>
In-Reply-To: <20180808082136.GA13518@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 16:21 +-0800, Ming Lei wrote:
+AD4- On Tue, Aug 07, 2018 at 03:51:25PM -0700, Bart Van Assche wrote:
+AD4- +AD4- The RQF+AF8-PREEMPT flag is used for three purposes:
+AD4- +AD4- - In the SCSI core, for making sure that power management reque=
sts
+AD4- +AD4-   are executed if a device is in the +ACI-quiesced+ACI- state.
+AD4- +AD4- - For domain validation by SCSI drivers that use the parallel p=
ort.
+AD4- +AD4- - In the IDE driver, for IDE preempt requests.
+AD4-=20
+AD4- I think the above description may not be accurate, BLK+AF8-MQ+AF8-REQ=
+AF8-PREEMPT is
+AD4- always set inside scsi+AF8-execute(), that means any scsi+AF8-execute=
() callers
+AD4- can use the flag of RQF+AF8-PREEMPT, of course, not limited to the ab=
ove
+AD4- three cases.

Hello Ming,

What I described is for which cases we really need the RQF+AF8-PREEMPT flag=
 rather
than in which cases the RQF+AF8-PREEMPT flag is set today. I think we shoul=
d split
the RQF+AF8-PREEMPT flag into three flags, one flag per case mentioned abov=
e.

Bart.

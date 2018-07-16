Return-Path: <prvs=72862f5cb=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hare@suse.de"
	<hare@suse.de>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jejb@linux.vnet.ibm.com"
	<jejb@linux.vnet.ibm.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 0/3] blk-mq: support runtime PM
Date: Mon, 16 Jul 2018 16:03:04 +0000
Message-ID: <9acf7af08c9a517d0783277c655fa29a0fc07573.camel@wdc.com>
References: <20180713080602.31602-1-ming.lei@redhat.com>
	 <c4147a47-876f-0ced-6c9d-1c3792d09858@kernel.dk>
	 <20180714023740.GA8402@ming.t460p>
In-Reply-To: <20180714023740.GA8402@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2018-07-14 at 10:37 +-0800, Ming Lei wrote:
+AD4- OK, I am thinking another idea for addressing this issue.
+AD4-=20
+AD4- We may introduce one logical admin(pm) request queue for each scsi+AF=
8-device,
+AD4- and this queue shares tag with IO queue, with NO+AF8-SCHED set, and a=
lways
+AD4- use atomic mode of the queue usage refcounter. Then we may send PM
+AD4- command to device after the IO queue is frozen.
+AD4-=20
+AD4- Also PREEMPT+AF8-ONLY can be removed too in this way.
+AD4-=20
+AD4- Even in future, all pass-through commands may be sent to this admin q=
ueue.
+AD4-=20
+AD4- If no one objects, I will cook patches towards this direction.

Wouldn't it be overkill to introduce a separate admin queue for SCSI device=
s?
Will that new queue be visible under /sys/block as a request queue? If so,
how many scripts will break due to that sysfs change? If the new queue won'=
t
be visible under /sys/block, how many changes will have to be made to the
block layer to avoid that it becomes visible?

Regarding the device+AF8-busy, device+AF8-blocked, cmd+AF8-list and other a=
ttributes in
struct scsi+AF8-device: will the SCSI commands submitted to the admin queue=
 affect
these attributes? If not, which assumptions in the SCSI core will break? An=
d
if SCSI commands submitted to the admin queue will affect these attributes,
how will these attributes be shared between the regular and the admin reque=
st
queues?

Since the power management core guarantees that runtime PM operations do no=
t
occur during suspend nor during resume operations: has it been considered t=
o
drop the RQF+AF8-PM flag and to use the RQF+AF8-PREEMPT flag instead and al=
so to
set and reset QUEUE+AF8-FLAG+AF8-PREEMPT+AF8-ONLY as needed?

Bart.

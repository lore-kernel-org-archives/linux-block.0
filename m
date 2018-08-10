Return-Path: <prvs=753ac577b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 05/12] block, scsi: Rename QUEUE_FLAG_PREEMPT_ONLY into
 DV_ONLY and introduce PM_ONLY
Date: Fri, 10 Aug 2018 15:18:17 +0000
Message-ID: <2ecaa527daa34408053ce91db716c28e8eb9d188.camel@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
	 <20180809194149.15285-6-bart.vanassche@wdc.com>
	 <dacf2f33-f1d7-2708-d2b8-50fd26d768ca@oracle.com>
In-Reply-To: <dacf2f33-f1d7-2708-d2b8-50fd26d768ca@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-10 at 09:39 +-0800, jianchao.wang wrote:
+AD4- On 08/10/2018 03:41 AM, Bart Van Assche wrote:
+AD4- +AD4- +-/+ACo-
+AD4- +AD4- +- +ACo- Whether or not blk+AF8-queue+AF8-enter() should procee=
d. RQF+AF8-PM requests are always
+AD4- +AD4- +- +ACo- allowed. RQF+AF8-DV requests are allowed if the PM+AF8=
-ONLY queue flag has not been
+AD4- +AD4- +- +ACo- set. Other requests are only allowed if neither PM+AF8=
-ONLY nor DV+AF8-ONLY has been
+AD4- +AD4- +- +ACo- set.
+AD4- +AD4- +- +ACo-/
+AD4- +AD4- +-static inline bool blk+AF8-enter+AF8-allowed(struct request+A=
F8-queue +ACo-q,
+AD4- +AD4- +-				     blk+AF8-mq+AF8-req+AF8-flags+AF8-t flags)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-	return flags +ACY- BLK+AF8-MQ+AF8-REQ+AF8-PM +AHwAfA-
+AD4- +AD4- +-		(+ACE-blk+AF8-queue+AF8-pm+AF8-only(q) +ACYAJg-
+AD4- +AD4- +-		 (flags +ACY- BLK+AF8-MQ+AF8-REQ+AF8-DV +AHwAfA- +ACE-blk+A=
F8-queue+AF8-dv+AF8-only(q)))+ADs-
+AD4- +AD4- +-+AH0-
+AD4-=20
+AD4- If a new state is indeed necessary, I think this kind of checking in =
hot path is inefficient.
+AD4- How about introduce a new state into request+AF8-queue, such as reque=
st+AF8-queue-+AD4-gate+AF8-state.
+AD4- Set the PM+AF8-ONLY and DV+AF8-ONLY into this state, then we could ju=
st check request+AF8-queue-+AD4-gate+AF8-state +AD4- 0
+AD4- before do further checking.

Hello Jianchao,

I agree with you that the hot path should be as efficient as possible. But =
I
don't think that the above code adds significantly more overhead to the hot
path. The requests for which we care about performance are the requests tha=
t
read and write data. BLK+AF8-MQ+AF8-REQ+AF8-PM is not set for any of these =
requests.
For the high performance case we care about the pm-only flag won't be set.
If that flag is not set the rest of the boolean expression does not have to
be evaluated (flags +ACY- BLK+AF8-MQ+AF8-REQ+AF8-DV +AHwAfA- +ACE-blk+AF8-q=
ueue+AF8-dv+AF8-only(q)). So I think the
above change only adds one additional boolean test to the hot path. That
shouldn't have a measurable performance impact.

Bart.

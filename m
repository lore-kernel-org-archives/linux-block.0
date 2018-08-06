Return-Path: <prvs=749b68ccf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v4 07/10] block, scsi: Rework runtime power management
Date: Mon, 6 Aug 2018 15:20:11 +0000
Message-ID: <b5548ab1d8523be0a13407e2bfca0071bd340c77.camel@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
	 <20180804000325.3610-8-bart.vanassche@wdc.com>
	 <CACVXFVOSB-r9OYJ+R7a-PfFuie3LCjUxhs2E7igh9vWp2VONkg@mail.gmail.com>
In-Reply-To: 
 <CACVXFVOSB-r9OYJ+R7a-PfFuie3LCjUxhs2E7igh9vWp2VONkg@mail.gmail.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2018-08-04 at 18:01 +-0800, Ming Lei wrote:
+AD4- On Sat, Aug 4, 2018 at 8:03 AM, Bart Van Assche +ADw-bart.vanassche+A=
EA-wdc.com+AD4- wrote:
+AD4- +AD4-=20
+AD4- +AD4- diff --git a/block/blk-pm.c b/block/blk-pm.c
+AD4- +AD4- index 2a4632d0be4b..0708185ead61 100644
+AD4- +AD4- --- a/block/blk-pm.c
+AD4- +AD4- +-+-+- b/block/blk-pm.c
+AD4- +AD4- +AEAAQA- -107,17 +-107,31 +AEAAQA- int blk+AF8-pre+AF8-runtime+=
AF8-suspend(struct request+AF8-queue +ACo-q)
+AD4- +AD4-         if (+ACE-q-+AD4-dev)
+AD4- +AD4-                 return ret+ADs-
+AD4- +AD4-=20
+AD4- +AD4- +-       WARN+AF8-ON+AF8-ONCE(q-+AD4-rpm+AF8-status +ACEAPQ- RP=
M+AF8-ACTIVE)+ADs-
+AD4- +AD4- +-
+AD4- +AD4-         blk+AF8-pm+AF8-runtime+AF8-lock(q)+ADs-
+AD4- +AD4- +-       /+ACo-
+AD4- +AD4- +-        +ACo- Switch to preempt-only mode before calling sync=
hronize+AF8-rcu() such
+AD4- +AD4- +-        +ACo- that later blk+AF8-queue+AF8-enter() calls see =
the preempt-only state. See
+AD4- +AD4- +-        +ACo- also http://lwn.net/Articles/573497/.
+AD4- +AD4- +-        +ACo-/
+AD4- +AD4- +-       blk+AF8-set+AF8-pm+AF8-only(q)+ADs-
+AD4- +AD4- +-       ret +AD0- -EBUSY+ADs-
+AD4- +AD4- +-       if (percpu+AF8-ref+AF8-read(+ACY-q-+AD4-q+AF8-usage+AF=
8-counter) +AD0APQ- 1) +AHs-
+AD4- +AD4- +-               synchronize+AF8-rcu()+ADs-
+AD4- +AD4- +-               if (percpu+AF8-ref+AF8-read(+ACY-q-+AD4-q+AF8-=
usage+AF8-counter) +AD0APQ- 1)
+AD4- +AD4- +-                       ret +AD0- 0+ADs-
+AD4- +AD4- +-       +AH0-
+AD4-=20
+AD4- The above code looks too tricky, and the following issue might exist =
in case
+AD4- of potential WRITEs re-order from blk+AF8-queue+AF8-enter().
+AD4-=20
+AD4- 1) suppose there are one in-flight request not completed yet
+AD4-=20
+AD4- 2) observer is the percpu+AF8-ref+AF8-read() following synchronize+AF=
8-rcu().
+AD4-=20
+AD4- 3) inside blk+AF8-queue+AF8-enter(), WRITE in percpu+AF8-ref+AF8-tryg=
et+AF8-live()/percpu+AF8-ref+AF8-put()
+AD4- can be re-ordered from view of the observer in 2)
+AD4-=20
+AD4- 4) then percpu+AF8-ref+AF8-read() may return 1 even though the only i=
n-flight
+AD4- request isn't completed
+AD4-=20
+AD4- 5) suspend still moves on, and data loss may be triggered
+AD4-=20
+AD4- Cc Paul, and Alan have been CCed already, so we have several memory
+AD4- model experts here, :-), hope they may help to clarify if this reorde=
r case
+AD4- may exist.

Hello Ming,

There are two cases:
(a) The percpu+AF8-ref+AF8-tryget+AF8-live() call in (3) is triggered by a =
runtime power
    state transition (RPM+AF8AKg-).
(b) The percpu+AF8-ref+AF8-tryget+AF8-live() call in (3) is not triggered b=
y a runtime
    power state transition.

In case (b) the driver that submits the request should protect the request
with scsi+AF8-autopm+AF8-get+AF8-device() / scsi+AF8-autopm+AF8-put+AF8-dev=
ice() or by any other
mechanism that prevents runtime power state transitions. Since
scsi+AF8-autopm+AF8-get+AF8-device() is called before blk+AF8-queue+AF8-ent=
er(), since
scsi+AF8-autopm+AF8-get+AF8-device() only returns after it has resumed a de=
vice and since
scsi+AF8-autopm+AF8-get+AF8-device() prevents runtime suspend, the function
blk+AF8-pre+AF8-runtime+AF8-suspend() won't be called concurrently with blk=
+AF8-queue+AF8-enter()
in case (b).

Since the power management serializes power state transitions also for case
(a) the race described above won't happen. blk+AF8-pre+AF8-runtime+AF8-susp=
end() will have
finished before any RQF+AF8-PM requests are submitted.

Bart.

Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mb@lightnvm.io" <mb@lightnvm.io>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"loberman@redhat.com" <loberman@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: Zoned block device support for fio (was: [PATCH 0/2] null_blk:
 zone support)
Date: Thu, 9 Aug 2018 20:51:50 +0000
Message-ID: <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
	 <1530899118.31977.1.camel@redhat.com>
	 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
	 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
	 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
	 <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
	 <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
	 <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
	 <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
	 <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
In-Reply-To: <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-07-10 at 12:51 -0600, Jens Axboe wrote:
+AD4- On 7/10/18 12:49 PM, Bart Van Assche wrote:
+AD4- +AD4- On Tue, 2018-07-10 at 12:45 -0600, Jens Axboe wrote:
+AD4- +AD4- +AD4- The difference between the job file and the
+AD4- +AD4- +AD4- workload run can be huge. Consider something really basic=
:
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- +AFs-randwrites+AF0-
+AD4- +AD4- +AD4- bs+AD0-4k
+AD4- +AD4- +AD4- rw+AD0-randwrite
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- which would be 100+ACU- random 4k writes. If I run this o=
n a zoned device,
+AD4- +AD4- +AD4- then that'd turn into 100+ACU- sequential writes.
+AD4- +AD4-=20
+AD4- +AD4- That's not correct. The ZBD code in the github pull request ser=
ializes writes
+AD4- +AD4- per zone, not globally.
+AD4-=20
+AD4- That's a totally minor detail. If all my random writes fall within a =
single
+AD4- zone, then they'd be 100+ACU- sequential. For N open zones, you'd be =
100+ACU-
+AD4- sequential within the zone. The point is that the workload as defined=
 and
+AD4- the workload as run are two totally different things, and THAT is the
+AD4- problem.

Hello Jens,

What you proposed in a previous e-mail, namely to use the existing fio zone
concept for zoned block devices sounds interesting to me. This is something=
 I
will definitely look further into. This will help to make a given workload
that is suited for zoned block devices to behave (almost) identical when ru=
n
against a regular block device. Since fio users expect that no zones are
reset before e.g. a random write test is started, there will always be a sm=
all
difference in behavior between a workload run against a zoned block device =
and
a workload run against a regular device if some zones already contain data.

It's not clear to me how close you want the behavior of fio to be for zoned
and regular block devices. Do you e.g. want me to introduce a new I/O patte=
rn
(--rw+AD0-...) that causes fio to write sequentially inside a zone and for =
which
zones are selected randomly? I don't see any other approach that allows to
make sure that the same workload definition behaves identically against zon=
ed
and regular block devices.

Thanks,

Bart.

Return-Path: <maier@linux.ibm.com>
Subject: Re: [PATCH blktests] scsi/004: add regression test for false
 BLK_STS_OK with non good SAM status
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "lduncan@suse.com" <lduncan@suse.com>,
        "osandov@fb.com" <osandov@fb.com>
References: <1523955817-15790-1-git-send-email-maier@linux.ibm.com>
 <20180419185330.GA20941@vader> <20180419191320.GB20941@vader>
 <18799c58a6ce27142b46ba6ec471e09f1eefedcf.camel@wdc.com>
 <55fb164b-e4a4-95c8-2382-f7251c4973df@kernel.dk>
 <20180419201855.GD20941@vader>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 23 Apr 2018 14:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180419201855.GD20941@vader>
Content-Type: text/plain; charset=utf-8
Message-Id: <b812247d-2d5f-0ae6-7c02-e3b3c052965e@linux.ibm.com>
List-ID: <linux-block@vger.kernel.org>


On 04/19/2018 10:18 PM, Omar Sandoval wrote:
> On Thu, Apr 19, 2018 at 01:44:41PM -0600, Jens Axboe wrote:
>> On 4/19/18 1:41 PM, Bart Van Assche wrote:
>>> On Thu, 2018-04-19 at 12:13 -0700, Omar Sandoval wrote:
>>>> On Thu, Apr 19, 2018 at 11:53:30AM -0700, Omar Sandoval wrote:
>>>>> Thanks for the test! Applied.
>>>>
>>>> Side note, it's unfortunate that this test takes 180 seconds to run =
only
>>>> because we have to wait for the command timeout. We should be able t=
o
>>>> export request_queue->rq_timeout writeable in sysfs. Would you be
>>>> interested in doing that?
>>>
>>> Hello Omar,
>>>
>>> Is this perhaps what you are looking for?
>>> # ls -l /sys/class/scsi_device/*/*/timeout
>>> -rw-r--r-- 1 root root 4096 Apr 19 08:52 /sys/class/scsi_device/2:0:0=
:0/device/timeout
>>> -rw-r--r-- 1 root root 4096 Apr 19 12:39 /sys/class/scsi_device/8:0:0=
:1/device/timeout
>>
>> We should have it generically available though, not just for SCSI. In
>> retrospect, it should have been under queue/ from the start, now we'll=

>> end up with duplicate entries for SCSI.
>=20
> For the sake of this test, I just decreased the timeout through SCSI.

Great idea.

> 	echo 5 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/timeout"

However, the timeout should be sufficiently larger than scsi_debug/delay,=

in order not to run into the command timeout.
It may be unfortunate that scsi_debug/delay uses jiffies as unit and
can thus differ in a range of an order of magnitude for different kernel =
configs.

> 	# delay to reduce response repetition: around 1..10sec depending on HZ=

> 	echo 1000 > /sys/bus/pseudo/drivers/scsi_debug/delay

On s390, we typically have HZ=3D100, so 1000 jiffies are 10 seconds.

We can increase the sdev cmd timeout or decrease the scsi_debug/delay.
100 instead of 1000 for scsi_debug/delay worked for me;
but for some reason the loop checking for busy did not work (any more?)
causing an unexpected test case error:

> # ./check scsi/004
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out co=
mmand) [failed]
> runtime  31.892s  ...  31.720s
>     --- tests/scsi/004.out	2018-04-16 11:47:19.105931872 +0200
>     +++ results/nodev/scsi/004.out.bad	2018-04-23 14:07:33.615445253 +0=
200
>     @@ -1,3 +1,3 @@
>      Running scsi/004
>     -Input/output error
>     +modprobe: FATAL: Module scsi_debug is in use.
>      Test complete

so I added another sleep hack:

         # dd closing SCSI disk causes implicit TUR also being delayed on=
ce
+        # sleep over time window where READ was done and TUR not yet que=
ued
+        sleep 2
         while grep -q -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI=
_DEBUG_HOSTS[0]}"; do

What do you think?

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

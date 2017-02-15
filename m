Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: "hch@lst.de" <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Bart Van Assche
	<Bart.VanAssche@sandisk.com>, "hare@suse.com" <hare@suse.com>, "hare@suse.de"
	<hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "jth@kernel.org"
	<jth@kernel.org>, Nick Meier <Nick.Meier@microsoft.com>, "Alex Ng (LIS)"
	<alexng@microsoft.com>, Long Li <longli@microsoft.com>, "Adrian Suhov
 (Cloudbase Solutions SRL)" <v-adsuho@microsoft.com>, "Chris Valean (Cloudbase
 Solutions SRL)" <v-chvale@microsoft.com>
Subject: RE: Boot regression (was "Re: [PATCH] genhd: Do not hold event	lock
 when scheduling workqueue elements")
Date: Wed, 15 Feb 2017 13:51:33 +0000
Message-ID: <MWHPR03MB26691FB87F0823E2E62868BABF5B0@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <20170208180314.GA17838@lst.de>
 <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170209130800.GA12057@lst.de>
 <MWHPR03MB2669B4FFC900983C8C357A77BF440@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170214134736.GA19620@lst.de>
 <MWHPR03MB2669C439014CD20B21ED3A69BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170214142837.GB20706@lst.de>
 <MWHPR03MB2669CCE370BC22E648A468F6BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170214145101.GA21427@lst.de>
 <MWHPR03MB266957B2E9075ACDB829FD21BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170214163437.GA23956@lst.de>
In-Reply-To: <20170214163437.GA23956@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> From: hch@lst.de [mailto:hch@lst.de]
> Sent: Wednesday, February 15, 2017 00:35
> > I tested today's linux-next (next-20170214) + the 2 patches just now an=
d
> got
> > a weird result:
> > sometimes the VM stills hung with a new calltrace (BUG: spinlock bad
> > magic) , but sometimes the VM did boot up despite the new calltrace!
> >
> > Attached is the log of a "good" boot.
> >
> > It looks we have a memory corruption issue somewhere...
>
> Yes.
It's due to an uninitialized spinlock. Please see the below.

> > Actually previously I saw the "BUG: spinlock bad magic" message once, b=
ut
> I
> > couldn't repro it later, so I didn't mention it to you.
>
> Interesting.
Ditto.
And probably my memory was inaccurate due to the long period of bisecting.
We should always see the message.

>
> A few questions on the dmesg:
>
> [    6.208794] sd 2:0:0:0: [storvsc] Sense Key : Illegal Request [current=
]
> [    6.209447] sd 2:0:0:0: [storvsc] Add. Sense: Invalid command operatio=
n
> code
> [    6.210043] sd 3:0:0:0: [storvsc] Sense Key : Illegal Request [current=
]
> [    6.210618] sd 3:0:0:0: [storvsc] Add. Sense: Invalid command operatio=
n
> code
> [    6.212272] sd 2:0:0:0: [storvsc] Sense Key : Illegal Request [current=
]
> [    6.212897] sd 2:0:0:0: [storvsc] Add. Sense: Invalid command operatio=
n
> code
> [    6.213474] sd 3:0:0:0: [storvsc] Sense Key : Illegal Request [current=
]
> [    6.214051] sd 3:0:0:0: [storvsc] Add. Sense: Invalid command operatio=
n
> code
>
> I didn't see anything like this in the other logs.  Are these messages
> something usual on HyperV VMs?

The messages should be normal, and I have always seen them for years
at least.

I think they're triggered by "/sbin/hdparm /dev/sda" or
"/lib/udev/ata_id /dev/sda"  in my Ubuntu 16.04 VM: during the VM
boot-up, the 2 programs are executed by the initrd's systemd-udev or other
system init scripts and the 2 programs try to run these 2 SCSI commands,
which are not supported by Hyper-V:

ATA PASS THROUGH (12) -- 0xa1
ATA PASS THROUGH (16) -- 0x85

IMO the commands are used when PATA/SATA devices are connected to
SCSI-to-ATA bridge, so it's understandable that Hyper-V doesn't support
them.

In the case of boot failure (hang), the 2 programs don't have a chance to
run, so we can't see the messages.

IMO we should ignore the messages, which should be harmless.

> [    6.358405] XFS (sdb1): Mounting V5 Filesystem
> [    6.404478] XFS (sdb1): Ending clean mount
> [    7.535174] BUG: spinlock bad magic on CPU#0, swapper/0/0
> [    7.536807]  lock: host_ts+0x30/0xffffffffffffe1a0 [hv_utils], .magic:
> 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    7.538436] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.10.0-rc8-next-
> 20170214+ #1
> [    7.539142] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al
> Machine, BIOS 090006  04/28/2016
> [    7.539142] Call Trace:
> [    7.539142]  <IRQ>
> [    7.539142]  dump_stack+0x63/0x82
> [    7.539142]  spin_dump+0x78/0xc0
> [    7.539142]  do_raw_spin_lock+0xfd/0x160
> [    7.539142]  _raw_spin_lock_irqsave+0x4c/0x60
> [    7.539142]  ? timesync_onchannelcallback+0x153/0x220 [hv_utils]
> [    7.539142]  timesync_onchannelcallback+0x153/0x220 [hv_utils]
>
> Can you resolve this address using gdb to a line of code?  Once inside
> gdb do:
>
> l *(timesync_onchannelcallback+0x153)

(gdb) l *(timesync_onchannelcallback+0x153)
0xffffffffc0104593 is in timesync_onchannelcallback (drivers/hv/hv_util.c:2=
79).
274             } else {
275                     /*
276                      * Save the adjusted time sample from the host and =
the snapshot
277                      * of the current system time for PTP device.
278                      */
279                     spin_lock_irqsave(&host_ts.lock, flags);
280
281                     cur_reftime =3D hyperv_cs->read(hyperv_cs);
282                     host_ts.host_time =3D hosttime;
283                     host_ts.ref_time =3D cur_reftime;

It turns out the "host_ts.lock" isn't initialized with spin_lock_init().
I'll submit a patch for this.

However, the SCSI issue (i.e. *sometimes* the VM fails to boot) is still th=
ere, I think.
We need to continue to debug...

Thanks,
-- Dexuan

Return-Path: <hch@lst.de>
Date: Tue, 14 Feb 2017 17:34:37 +0100
From: "hch@lst.de" <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "hch@lst.de" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"hare@suse.com" <hare@suse.com>, "hare@suse.de" <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jth@kernel.org" <jth@kernel.org>,
	Nick Meier <Nick.Meier@microsoft.com>,
	"Alex Ng (LIS)" <alexng@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Adrian Suhov (Cloudbase Solutions SRL)" <v-adsuho@microsoft.com>,
	"Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>
Subject: Re: Boot regression (was "Re: [PATCH] genhd: Do not hold event
	lock when scheduling workqueue elements")
Message-ID: <20170214163437.GA23956@lst.de>
References: <20170208180314.GA17838@lst.de> <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com> <20170209130800.GA12057@lst.de> <MWHPR03MB2669B4FFC900983C8C357A77BF440@MWHPR03MB2669.namprd03.prod.outlook.com> <20170214134736.GA19620@lst.de> <MWHPR03MB2669C439014CD20B21ED3A69BF580@MWHPR03MB2669.namprd03.prod.outlook.com> <20170214142837.GB20706@lst.de> <MWHPR03MB2669CCE370BC22E648A468F6BF580@MWHPR03MB2669.namprd03.prod.outlook.com> <20170214145101.GA21427@lst.de> <MWHPR03MB266957B2E9075ACDB829FD21BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB266957B2E9075ACDB829FD21BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

> I tested today's linux-next (next-20170214) + the 2 patches just now and got
> a weird result: 
> sometimes the VM stills hung with a new calltrace (BUG: spinlock bad
> magic) , but sometimes the VM did boot up despite the new calltrace!
> 
> Attached is the log of a "good" boot.
> 
> It looks we have a memory corruption issue somewhere...

Yes.

> Actually previously I saw the "BUG: spinlock bad magic" message once, but I
> couldn't repro it later, so I didn't mention it to you.

Interesting.

> 
> The good news is that now I can repro the "spinlock bad magic" message
> every time. 
> I tried to dig into this by enabling Kernel hacking -> Memory debugging,
> but didn't find anything abnormal. 
> Is it possible that the SCSI layer passes a wrong memory address?

It's possible, but this looks like it might be a different issue.

A few questions on the dmesg:

[    6.208794] sd 2:0:0:0: [storvsc] Sense Key : Illegal Request [current] 
[    6.209447] sd 2:0:0:0: [storvsc] Add. Sense: Invalid command operation code
[    6.210043] sd 3:0:0:0: [storvsc] Sense Key : Illegal Request [current] 
[    6.210618] sd 3:0:0:0: [storvsc] Add. Sense: Invalid command operation code
[    6.212272] sd 2:0:0:0: [storvsc] Sense Key : Illegal Request [current] 
[    6.212897] sd 2:0:0:0: [storvsc] Add. Sense: Invalid command operation code
[    6.213474] sd 3:0:0:0: [storvsc] Sense Key : Illegal Request [current] 
[    6.214051] sd 3:0:0:0: [storvsc] Add. Sense: Invalid command operation code

I didn't see anything like this in the other logs.  Are these messages
something usual on HyperV VMs?

[    6.358405] XFS (sdb1): Mounting V5 Filesystem
[    6.404478] XFS (sdb1): Ending clean mount
[    7.535174] BUG: spinlock bad magic on CPU#0, swapper/0/0
[    7.536807]  lock: host_ts+0x30/0xffffffffffffe1a0 [hv_utils], .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    7.538436] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.10.0-rc8-next-20170214+ #1
[    7.539142] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090006  04/28/2016
[    7.539142] Call Trace:
[    7.539142]  <IRQ>
[    7.539142]  dump_stack+0x63/0x82
[    7.539142]  spin_dump+0x78/0xc0
[    7.539142]  do_raw_spin_lock+0xfd/0x160
[    7.539142]  _raw_spin_lock_irqsave+0x4c/0x60
[    7.539142]  ? timesync_onchannelcallback+0x153/0x220 [hv_utils]
[    7.539142]  timesync_onchannelcallback+0x153/0x220 [hv_utils]

Can you resolve this address using gdb to a line of code?  Once inside
gdb do:

l *(timesync_onchannelcallback+0x153)

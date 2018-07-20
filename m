Return-Path: <prvs=73255fbda=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, "keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Date: Fri, 20 Jul 2018 16:45:05 +0000
Message-ID: <797120d19f5d15e7d98a3d2f90ce91ebf60690d7.camel@wdc.com>
References: <20180719212618.2406-1-keith.busch@intel.com>
	 <20180719212618.2406-2-keith.busch@intel.com>
	 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
	 <20180720155646.GE4093@localhost.localdomain>
	 <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
	 <20180720161240.GF4093@localhost.localdomain>
	 <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
	 <20180720162321.GG4093@localhost.localdomain>
In-Reply-To: <20180720162321.GG4093@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-20 at 10:23 -0600, Keith Busch wrote:
+AD4- On Fri, Jul 20, 2018 at 04:20:01PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Fri, 2018-07-20 at 10:12 -0600, Keith Busch wrote:
+AD4- +AD4- +AD4- On Fri, Jul 20, 2018 at 04:03:18PM +-0000, Bart Van Assch=
e wrote:
+AD4- +AD4- +AD4- +AD4- On Fri, 2018-07-20 at 09:56 -0600, Keith Busch wrot=
e:
+AD4- +AD4- +AD4- +AD4- +AD4- SCSI is the only block driver that wants this=
 behavior. Moving it back
+AD4- +AD4- +AD4- +AD4- +AD4- to generic where it used to be breaks other b=
lock drivers.
+AD4- +AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- +AD4- That's new to me. What would break in the NVMe driv=
er if the above change would be
+AD4- +AD4- +AD4- +AD4- present in the block layer?
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- This is what causes the block layer to lose completions, =
and most drivers
+AD4- +AD4- +AD4- don't want the kernel to lose their completions.
+AD4- +AD4-=20
+AD4- +AD4- Hello Keith,
+AD4- +AD4-=20
+AD4- +AD4- Have you considered to introduce a fourth state for block layer=
 requests to
+AD4- +AD4- avoid that completions that occur while a timeout handler is in=
 progress get
+AD4- +AD4- lost? That would avoid that completions get lost not only for t=
he NVMe driver
+AD4- +AD4- but also for SCSI drivers. See e.g. the MQ+AF8-RQ+AF8-TIMED+AF8=
-OUT state in
+AD4- +AD4- https://www.mail-archive.com/linux-block+AEA-vger.kernel.org/ms=
g22196.html
+AD4-=20
+AD4- Yes, I've considered that, and I really want to use it, but scsi may
+AD4- still reference a freed request in scmd+AF8-eh+AF8-abort+AF8-handler =
that way.

I think that's a misunderstanding. If scsi+AF8-times+AF8-out() queues an ab=
ort
asynchronously then it tells the block layer through its return value that =
the
SCSI core still owns the request and hence that the block layer should igno=
re any
completions that occur until the SCSI core calls scsi+AF8-finish+AF8-comman=
d(). That
scsi+AF8-finish+AF8-command() will trigger a call to +AF8AXw-blk+AF8-mq+AF8=
-end+AF8-request(). The
scsi+AF8-times+AF8-out() return value I was referring to is called BLK+AF8-=
EH+AF8-DONE today and
was called BLK+AF8-EH+AF8-NOT+AF8-HANDLED in kernel version v4.17.

This also means that I got the BLK+AF8-EH+AF8-NOT+AF8-HANDLED case wrong in=
 +ACI-blk-mq: Rework
blk-mq timeout handling again+ACI-: in that case concurrent a blk+AF8-mq+AF=
8-complete+AF8-request()
call should be ignored instead of triggering request completion.

Bart.=

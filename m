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
Date: Fri, 20 Jul 2018 16:20:01 +0000
Message-ID: <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
References: <20180719212618.2406-1-keith.busch@intel.com>
	 <20180719212618.2406-2-keith.busch@intel.com>
	 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
	 <20180720155646.GE4093@localhost.localdomain>
	 <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
	 <20180720161240.GF4093@localhost.localdomain>
In-Reply-To: <20180720161240.GF4093@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-20 at 10:12 -0600, Keith Busch wrote:
+AD4- On Fri, Jul 20, 2018 at 04:03:18PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Fri, 2018-07-20 at 09:56 -0600, Keith Busch wrote:
+AD4- +AD4- +AD4- SCSI is the only block driver that wants this behavior. M=
oving it back
+AD4- +AD4- +AD4- to generic where it used to be breaks other block drivers=
.
+AD4- +AD4-=20
+AD4- +AD4- That's new to me. What would break in the NVMe driver if the ab=
ove change would be
+AD4- +AD4- present in the block layer?
+AD4-=20
+AD4- This is what causes the block layer to lose completions, and most dri=
vers
+AD4- don't want the kernel to lose their completions.

Hello Keith,

Have you considered to introduce a fourth state for block layer requests to
avoid that completions that occur while a timeout handler is in progress ge=
t
lost? That would avoid that completions get lost not only for the NVMe driv=
er
but also for SCSI drivers. See e.g. the MQ+AF8-RQ+AF8-TIMED+AF8-OUT state i=
n
https://www.mail-archive.com/linux-block+AEA-vger.kernel.org/msg22196.html

Thanks,

Bart.=

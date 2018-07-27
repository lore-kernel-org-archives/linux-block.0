Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>
CC: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Date: Fri, 27 Jul 2018 17:14:18 +0000
Message-ID: <717d1320da3341988ccaa1995b278e0d645a0178.camel@wdc.com>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
	 <20180727162042.13425-6-bart.vanassche@wdc.com>
	 <20180727164627.GB20829@localhost.localdomain>
	 <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
	 <20180727165718.GC20829@localhost.localdomain>
	 <fca08072e67fc8a8a9c9acfe130753ee7020f4fe.camel@wdc.com>
	 <20180727170433.GD20829@localhost.localdomain>
In-Reply-To: <20180727170433.GD20829@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 11:04 -0600, Keith Busch wrote:
+AD4- On Fri, Jul 27, 2018 at 04:59:34PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Fri, 2018-07-27 at 10:57 -0600, Keith Busch wrote:
+AD4- +AD4- +AD4- You skip that code if the driver returns BLK+AF8-EH+AF8-D=
ONT+AF8-RESET+AF8-TIMER.
+AD4- +AD4-=20
+AD4- +AD4- How about applying the following patch on top of this series?
+AD4-=20
+AD4- That works for me if you, but it breaks scsi again when
+AD4- scmd+AF8-eh+AF8-abort+AF8-handler completes the command a second time=
.

How about introducing a new request queue flag that chooses between the
behavior with or without the patch in my previous e-mail? I don't think tha=
t
it is possible to come up with a single implementation that covers the need=
s
of NVMe and SCSI without introducing such a flag. If a SCSI request times o=
ut
then request ownership is transferred from the LLD to the error handler. Fo=
r
the NVMe driver however there is no such transfer of ownership.

Bart.

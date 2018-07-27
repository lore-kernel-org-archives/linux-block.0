Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Date: Fri, 27 Jul 2018 18:09:55 +0000
Message-ID: <5e0c1fc29e9f6cad45b3492affe39499d41b4df8.camel@wdc.com>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
	 <20180727162042.13425-6-bart.vanassche@wdc.com>
	 <20180727164627.GB20829@localhost.localdomain>
	 <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
	 <20180727165718.GC20829@localhost.localdomain>
	 <fca08072e67fc8a8a9c9acfe130753ee7020f4fe.camel@wdc.com>
	 <20180727170433.GD20829@localhost.localdomain>
	 <717d1320da3341988ccaa1995b278e0d645a0178.camel@wdc.com>
	 <20180727175821.GE20829@localhost.localdomain>
In-Reply-To: <20180727175821.GE20829@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 11:58 -0600, Keith Busch wrote:
+AD4- Instead of PATCH 1/5, how about creating a new timeout return code li=
ke
+AD4- +ACI-BLK+AF8-EH+AF8-DONT+AF8-COMPLETE+ACI-?

That sounds like a good idea to me. I think this approach will avoid that w=
e
have to introduce a request queue flag that chooses between the behavior
needed by the NVMe driver or the behavior needed by the SCSI core.

Bart.

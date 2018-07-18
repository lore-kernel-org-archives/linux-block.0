Return-Path: <prvs=730b8c8b8=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "keith.busch@linux.intel.com"
	<keith.busch@linux.intel.com>
CC: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Date: Wed, 18 Jul 2018 21:05:40 +0000
Message-ID: <7aadef775fe67c3656830a8b9b029ec03cca3d26.camel@wdc.com>
References: <20180521231131.6685-4-keith.busch@intel.com>
	 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
	 <20180712192437.GA16839@localhost.localdomain>
	 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
	 <20180713154346.GA18955@localhost.localdomain>
	 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
	 <20180713184712.GA19419@localhost.localdomain>
	 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
	 <20180713235807.GA19967@localhost.localdomain>
	 <20180718195650.GA20336@lst.de> <20180718203936.GA21011@lst.de>
In-Reply-To: <20180718203936.GA21011@lst.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 22:39 +-0200, hch+AEA-lst.de wrote:
+AD4- On Wed, Jul 18, 2018 at 09:56:50PM +-0200, hch+AEA-lst.de wrote:
+AD4- +AD4- The important bit is that we need to fix this issue quickly.  W=
e are
+AD4- +AD4- past -rc5 so I'm rather concerned about anything too complicate=
d.
+AD4- +AD4-=20
+AD4- +AD4- I'm not even sure SCSI has a problem with multiple completions =
happening
+AD4- +AD4- at the same time, but it certainly has a problem with bypassing
+AD4- +AD4- blk+AF8-mq+AF8-complete+AF8-request from the EH path.
+AD4- +AD4-=20
+AD4- +AD4- I think we can solve this properly, but I also think we are way=
 to late
+AD4- +AD4- in the 4.18 cycle to fix it properly.  For now I fear we'll jus=
t have
+AD4- +AD4- to revert the changes and try again for 4.19 or even 4.20 if we=
 don't
+AD4- +AD4- act quickly enough.
+AD4-=20
+AD4- So here is a quick attempt at the revert while also trying to keep
+AD4- nvme working.  Keith, Bart, Jianchao - does this looks reasonable
+AD4- as a 4.18 band aid?
+AD4-=20
+AD4- http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-=
eh-revert

Hello Christoph,

A patch series that first reverts the following patches:
+ACo- blk-mq: Fix timeout handling in case the timeout handler returns BLK+=
AF8-EH+AF8-DONE
+ACo- block: fix timeout changes for legacy request drivers
+ACo- blk-mq: don't time out requests again that are in the timeout handler
+ACo- blk-mq: simplify blk+AF8-mq+AF8-rq+AF8-timed+AF8-out
+ACo- block: remove BLK+AF8-EH+AF8-HANDLED
+ACo- block: rename BLK+AF8-EH+AF8-NOT+AF8-HANDLED to BLK+AF8-EH+AF8-DONE
+ACo- blk-mq: Remove generation seqeunce

and next renames BLK+AF8-EH+AF8-NOT+AF8-HANDLED again into BLK+AF8-EH+AF8-D=
ONE would probably be
a lot easier to review.

Thanks,

Bart.

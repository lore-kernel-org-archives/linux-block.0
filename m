Return-Path: <prvs=730b8c8b8=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "keith.busch@linux.intel.com"
	<keith.busch@linux.intel.com>
CC: "keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Date: Wed, 18 Jul 2018 20:58:48 +0000
Message-ID: <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
References: <20180521231131.6685-4-keith.busch@intel.com>
	 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
	 <20180712192437.GA16839@localhost.localdomain>
	 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
	 <20180713154346.GA18955@localhost.localdomain>
	 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
	 <20180713184712.GA19419@localhost.localdomain>
	 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
	 <20180713235807.GA19967@localhost.localdomain>
	 <20180718195650.GA20336@lst.de>
	 <20180718205321.GA32160@localhost.localdomain>
In-Reply-To: <20180718205321.GA32160@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 14:53 -0600, Keith Busch wrote:
+AD4- If scsi needs this behavior, why not just put that behavior in scsi? =
It
+AD4- can set the state to complete and then everything can play out as
+AD4- before.
+AD4- +AFs- ... +AF0-

There may be other drivers that need the same protection the SCSI core need=
s
so I think the patch at the end of your previous e-mail is a step in the wr=
ong
direction.

Bart.

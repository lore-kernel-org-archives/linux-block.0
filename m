Return-Path: <hch@lst.de>
Date: Wed, 18 Jul 2018 22:39:36 +0200
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	jianchao.w.wang@oracle.com
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180718203936.GA21011@lst.de>
References: <20180521231131.6685-4-keith.busch@intel.com> <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com> <20180712192437.GA16839@localhost.localdomain> <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com> <20180713154346.GA18955@localhost.localdomain> <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com> <20180713184712.GA19419@localhost.localdomain> <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com> <20180713235807.GA19967@localhost.localdomain> <20180718195650.GA20336@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180718195650.GA20336@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 09:56:50PM +0200, hch@lst.de wrote:
> On Fri, Jul 13, 2018 at 05:58:08PM -0600, Keith Busch wrote:
> > Of the two you mentioned, yours is preferable IMO. While I appreciate
> > Jianchao's detailed analysis, it's hard to take a proposal seriously
> > that so colourfully calls everyone else "dangerous" while advocating
> > for silently losing requests on purpose.
> > 
> > But where's the option that fixes scsi to handle hardware completions
> > concurrently with arbitrary timeout software? Propping up that house of
> > cards can't be the only recourse.
> 
> The important bit is that we need to fix this issue quickly.  We are
> past -rc5 so I'm rather concerned about anything too complicated.
> 
> I'm not even sure SCSI has a problem with multiple completions happening
> at the same time, but it certainly has a problem with bypassing
> blk_mq_complete_request from the EH path.
> 
> I think we can solve this properly, but I also think we are way to late
> in the 4.18 cycle to fix it properly.  For now I fear we'll just have
> to revert the changes and try again for 4.19 or even 4.20 if we don't
> act quickly enough.

So here is a quick attempt at the revert while also trying to keep
nvme working.  Keith, Bart, Jianchao - does this looks reasonable
as a 4.18 band aid?

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-eh-revert

Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 13 Jul 2018 17:58:08 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180713235807.GA19967@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 13, 2018 at 11:03:18PM +0000, Bart Van Assche wrote:
> How do you want to go forward from here? Do you prefer the approach of the
> patch I had posted (https://www.spinics.net/lists/linux-block/msg26489.html), 
> Jianchao's approach (https://marc.info/?l=linux-block&m=152950093831738) or
> perhaps yet another approach? Note: I think Jianchao's patch is a good start
> but also that it needs further improvement.

Of the two you mentioned, yours is preferable IMO. While I appreciate
Jianchao's detailed analysis, it's hard to take a proposal seriously
that so colourfully calls everyone else "dangerous" while advocating
for silently losing requests on purpose.

But where's the option that fixes scsi to handle hardware completions
concurrently with arbitrary timeout software? Propping up that house of
cards can't be the only recourse.

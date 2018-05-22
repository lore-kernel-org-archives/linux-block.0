Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 22 May 2018 10:44:04 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 0/3] blk-mq: Timeout rework
Message-ID: <20180522164403.GB8388@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <9ca27e059fbd12a976e1e2f1ee1aa5c8ca579ad0.camel@wdc.com>
 <20180522140653.GP5528@localhost.localdomain>
 <56564c0694eb3a21dfdcfbc6c3053774f026d371.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56564c0694eb3a21dfdcfbc6c3053774f026d371.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 04:30:41PM +0000, Bart Van Assche wrote:
> 
> Please have a look at v13 of the timeout handling rework patch that I posted.
> That patch should not introduce any new race conditions and should also handle
> the scenario fine in which blk_mq_complete_request() is called while the NVMe
> timeout handling function is in progress.

Thanks for the notice. That sounds very interesting and will be happy
take a look.

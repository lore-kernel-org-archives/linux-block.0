Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 22 May 2018 10:34:03 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522163403.GA8388@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
 <20180522141507.GQ5528@localhost.localdomain>
 <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 04:29:07PM +0000, Bart Van Assche wrote:
> Please have another look at the current code that handles request timeouts
> and completions. The current implementation guarantees that no double
> completions can occur but your patch removes essential aspects of that
> implementation.

How does the current implementation guarantee a double completion doesn't
happen when the request is allocated for a new command?

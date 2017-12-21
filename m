Return-Path: <keith.busch@intel.com>
Date: Thu, 21 Dec 2017 14:02:50 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
Message-ID: <20171221210250.GA2975@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
 <45a16b4c-fbc0-106d-df37-439374c7b5dc@kernel.dk>
 <118beb1f-54eb-c65d-1c9c-4775ebde1fa8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <118beb1f-54eb-c65d-1c9c-4775ebde1fa8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 21, 2017 at 01:53:44PM -0700, Jens Axboe wrote:
> Turns out that wasn't what patch 2 was. And the code is right there
> above as well, and under the q_lock, so I guess that race doesn't
> exist.
> 
> But that does bring up the fact if we should always be doing the
> nvme_process_cq(nvmeq) after IO submission. For direct/hipri IO,
> maybe it's better to make the submission path faster and skip it?

Yes, I am okay to remove the opprotunistic nvme_process_cq in the
submission path. Even under deeply queued IO, I've not seen this provide
any measurable benefit.

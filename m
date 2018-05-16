Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 16 May 2018 09:18:26 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180516151826.GB20223@localhost.localdomain>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <20180511205028.GB7772@localhost.localdomain>
 <20180512002110.GA23631@ming.t460p>
 <20180514151821.GE7772@localhost.localdomain>
 <20180514234701.GA21743@ming.t460p>
 <20180515003335.GB15199@localhost.localdomain>
 <20180516043127.GD17412@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516043127.GD17412@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 16, 2018 at 12:31:28PM +0800, Ming Lei wrote:
> Hi Keith,
> 
> This issue may probably be fixed by Jianchao's patch of 'nvme: pci: set nvmeq->cq_vector
> after alloc cq/sq'[1] and my another patch of 'nvme: pci: unquiesce admin
> queue after controller is shutdown'[2], and both two have been included in the
> posted V6.

No, it's definitely not related to that patch. The link is down in this
test, I can assure you we're bailing out long before we ever even try to
create an IO queue. The failing condition is detected by nvme_pci_enable's
check for all 1's completions at the very beginning.

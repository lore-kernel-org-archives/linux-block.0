Return-Path: <hch@lst.de>
Date: Fri, 29 Dec 2017 11:11:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: axboe@kernel.dk, hch@lst.de, keith.busch@intel.com, emilne@redhat.com,
	james.smart@broadcom.com, hare@suse.de, Bart.VanAssche@wdc.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@redhat.com
Subject: Re: [for-4.16 PATCH v2 2/5] nvme: use request_queue's
	failover_rq_fn callback for multipath failover
Message-ID: <20171229101119.GB25333@lst.de>
References: <20171227032257.8182-1-snitzer@redhat.com> <20171227032257.8182-3-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171227032257.8182-3-snitzer@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Independent on any policy question as raised in reply to the previous
patch:  until the ANA (ALUA equivalent for NVMe) spec has been finalized
and our code for it has landed there is no way we're going to expose
anything from this code based as it will be highly in flux.

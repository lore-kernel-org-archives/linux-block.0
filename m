Return-Path: <hch@lst.de>
Date: Fri, 29 Dec 2017 10:44:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
Message-ID: <20171229094414.GA24043@lst.de>
References: <20171221204636.2924-1-keith.busch@intel.com> <20171221204636.2924-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221204636.2924-2-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine, although I agree a comment on the q_lock exclusion would
be useful.

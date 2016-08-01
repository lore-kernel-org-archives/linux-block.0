Return-Path: <hch@lst.de>
Date: Mon, 1 Aug 2016 12:59:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Brian King <brking@linux.vnet.ibm.com>,
	Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: Allow timeouts to run while queue is
	freezing
Message-ID: <20160801105930.GA16141@lst.de>
References: <1469767356-25193-1-git-send-email-krisman@linux.vnet.ibm.com> <81fa2a75-1da8-aeb6-dcce-3ae245810234@kernel.dk> <8760rogwmp.fsf_-_@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760rogwmp.fsf_-_@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

I think this looks fine, especially with the detailed comment:

Reviewed-by: Christoph Hellwig <hch@lst.de>

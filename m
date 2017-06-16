Return-Path: <hch@lst.de>
Date: Fri, 16 Jun 2017 08:48:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: spread MSI(-X) vectors to all possible CPUs V2
Message-ID: <20170616064802.GA7445@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170603140403.27379-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Thomas,

can you take a look at the generic patches as they are the required
base for the block work?

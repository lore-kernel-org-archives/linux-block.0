Return-Path: <hch@lst.de>
Date: Mon, 13 Jun 2016 10:03:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: general preparation for NVMe over Fabrics support
Message-ID: <20160613080339.GB21597@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de> <20160609163854.GF1696@localhost.localdomain> <20160612133318.GA16543@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160612133318.GA16543@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jun 12, 2016 at 07:33:18AM -0600, Jens Axboe wrote:
> Added 1-8, 9/10 throws a lot of rejects and it's pre-coffee here. What
> is this against?

This was against 4.7-rc2 I think.  But you already merged 9 and 10 in
slightly different versions, so we should be fine.

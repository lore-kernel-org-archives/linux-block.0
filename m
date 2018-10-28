Return-Path: <BATV+f6810342bdcd0158e5a3+5544+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 28 Oct 2018 08:53:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
	Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/28] bsg: provide bsg_remove_queue() helper
Message-ID: <20181028155327.GB1559@infradead.org>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-13-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181025211039.11559-13-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 25, 2018 at 03:10:23PM -0600, Jens Axboe wrote:
> All drivers do unregister + cleanup, provide a helper for that.

Nice cleanup,

Reviewed-by: Christoph Hellwig <hch@lst.de>

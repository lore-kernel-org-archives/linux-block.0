Return-Path: <BATV+f6810342bdcd0158e5a3+5544+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 28 Oct 2018 08:53:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
	Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/28] bsg: pass in desired timeout handler
Message-ID: <20181028155305.GA1559@infradead.org>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181025211039.11559-12-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 25, 2018 at 03:10:22PM -0600, Jens Axboe wrote:
> This will ease in the conversion to blk-mq, where we can't set
> a timeout handler after queue init.

On thing I hoped to archive with the last round of bsg cleanups is
to isolate the users of bsg from even knowing there is a struct
request underneath.  Based on that it would be nice to pass
the struct bsg_job to the actual timeout handlers instead of
struct request.

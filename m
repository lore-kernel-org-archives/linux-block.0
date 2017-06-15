Return-Path: <BATV+bef0da5e94eb3b03931e+5044+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 15 Jun 2017 01:17:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 03/11] fs: add support for an inode to carry stream
 related data
Message-ID: <20170615081733.GC10599@infradead.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-4-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497498312-17704-4-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 09:45:04PM -0600, Jens Axboe wrote:
> No functional changes in this patch, just in preparation for
> allowing applications to pass in hints about data life times
> for writes.
> 
> Pack the i_write_hint field into a 2-byte hole, so we don't grow
> the size of the inode.

A u8 should be plenty.  But talking about the representation -
your write lifetime hints are a 5 option enum basically.  I wonder
if we really should encode it as flags, or if we should have an
enum (which could be packed into a 3-bit bitfield) and then pass
it down the stack in that form instead of changing the representation
N times.

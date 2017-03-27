Return-Path: <BATV+c09a500acd4738b53c4f+4964+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 27 Mar 2017 02:12:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, agk@redhat.com, shli@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 06/23] dm-kcopyd: switch to use REQ_OP_WRITE_ZEROES
Message-ID: <20170327091239.GC6879@infradead.org>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323143341.31549-7-hch@lst.de>
 <20170323145522.GB17127@redhat.com>
 <20170323145651.GA31771@lst.de>
 <20170323151037.GC17127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323151037.GC17127@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 23, 2017 at 11:10:38AM -0400, Mike Snitzer wrote:
> Not sure why you've split out the dm-kcopyd patch, likely best to just
> fold it into the previous dm support patch.

The dm-kcopyd patch switches to using WRITE_ZEROES instead of write
same for dm as user of these interfaces.  The one before just adds
WRITE_ZEROES support to dm.

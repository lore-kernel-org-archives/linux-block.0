Return-Path: <BATV+a67a43e55467fd1c3dfd+4677+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 13 Jun 2016 08:46:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: make sure big bio is splitted into at most 256
 bvecs
Message-ID: <20160613154614.GC23990@infradead.org>
References: <1465556858-30949-1-git-send-email-ming.lei@canonical.com>
 <575AA66D.5010407@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <575AA66D.5010407@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 10, 2016 at 01:37:17PM +0200, Hannes Reinecke wrote:
> Hmm. So everybody is suffering because someone _might_ be using bio_clone?
> Why can't we fixup bio_clone() (or the callers of which) to correctly
> set the queue limits?

The only one suffering is bcache.  Everyone else uses bios below the
block layer arbitrary max size.  The fixup to allow bio_clone support
a larger size is the same one as to allow everyone else submitting
larger bios:  increase BIO_MAX_PAGES and create the required mempools
to back that new larger size.  Or just go for multipage biovecs..

Return-Path: <hch@lst.de>
Date: Thu, 26 Jul 2018 11:21:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 3/3] block: bio_iov_iter_get_pages: pin more pages
	for multi-segment IOs
Message-ID: <20180726092117.GC24335@lst.de>
References: <20180725211509.13592-1-mwilck@suse.com> <20180725211509.13592-4-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725211509.13592-4-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

Both the changelog and the comments should use up all horizontal space
(73 and 80 charcs respectively), but that can be fixed up when applied.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <hch@lst.de>
Date: Fri, 25 Aug 2017 09:36:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	axboe@kernel.dk, Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, mgorman@suse.de,
	Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: support IOCB_NOWAIT in
	generic_file_buffered_read
Message-ID: <20170825073623.GA9548@lst.de>
References: <20170822161712.11716-1-hch@lst.de> <20170822161712.11716-3-hch@lst.de> <20170824143141.GB8969@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170824143141.GB8969@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 24, 2017 at 04:31:41PM +0200, Jan Kara wrote:
> And wait_on_page_locked_killable() above does not seem to be handled in
> your patch. I would just check IOCB_NOWAIT in !PageUptodate(page) branch
> above and bail - which also removes the need for the two checks below...

Yes, that makes sense.

Return-Path: <mgorman@suse.de>
Date: Fri, 7 Jul 2017 11:08:15 +0100
From: Mel Gorman <mgorman@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk,
	Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, Volker.Lendecke@sernet.de,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: pass iocb to do_generic_file_read
Message-ID: <20170707100815.utah3a4v3fki6kys@suse.de>
References: <20170706153019.11645-1-hch@lst.de>
 <20170706153019.11645-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20170706153019.11645-2-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 06, 2017 at 08:30:16AM -0700, Christoph Hellwig wrote:
> And rename it to the more descriptive generic_file_buffered_read while
> at it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Sat, 5 Nov 2016 07:10:49 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xfs@vger.kernel.org, axboe@fb.com,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/5] iomap: implement direct I/O
Message-ID: <20161105151049.ocvrfh6fjsotnpxx@kmo-pixel>
References: <1478276479-10749-1-git-send-email-hch@lst.de>
 <1478276479-10749-5-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478276479-10749-5-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 04, 2016 at 10:21:18AM -0600, Christoph Hellwig wrote:
> This adds a full fledget direct I/O implementation using the iomap
> interface. Full fledged in this case means all features are supported:
> AIO, vectored I/O, any iov_iter type including kernel pointers, bvecs
> and pipes, support for hole filling and async apending writes.  It does
> not mean supporting all the warts of the old generic code.  We expect
> i_rwsem to be held over the duration of the call, and we expect to
> maintain i_dio_count ourselves, and we pass on any kinds of mapping
> to the file system for now.
> 
> The algorithm used is very simple: We use iomap_apply to iterate over
> the range of the I/O, and then we use the new bio_iov_iter_get_pages
> helper to lock down the user range for the size of the extent.
> bio_iov_iter_get_pages can currently lock down twice as many pages as
> the old direct I/O code did, which means that we will have a better
> batch factor for everything but overwrites of badly fragmented files.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

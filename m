Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbcLVS3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2016 13:29:17 -0500
Date: Thu, 22 Dec 2016 10:29:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, loberman@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: add back plugging in __blkdev_direct_IO
Message-ID: <20161222182912.GA22997@infradead.org>
References: <1482430845-28938-1-git-send-email-hch@lst.de>
 <b6c3764a-f43d-dc47-655f-3d38ea8276ff@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b6c3764a-f43d-dc47-655f-3d38ea8276ff@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 22, 2016 at 11:22:25AM -0700, Jens Axboe wrote:
> On 12/22/2016 11:20 AM, Christoph Hellwig wrote:
> > This allows sending larger than 1 MB requess to devices that support
> > large I/O sizes.
> 
> Thanks, I'll queue it up for this series.

btw, s/requess/request/ above as just pointed out off-list.

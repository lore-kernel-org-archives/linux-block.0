Subject: Re: [PATCH] block: add back plugging in __blkdev_direct_IO
To: Christoph Hellwig <hch@lst.de>
References: <1482430845-28938-1-git-send-email-hch@lst.de>
Cc: loberman@redhat.com, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <b6c3764a-f43d-dc47-655f-3d38ea8276ff@fb.com>
Date: Thu, 22 Dec 2016 11:22:25 -0700
MIME-Version: 1.0
In-Reply-To: <1482430845-28938-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/22/2016 11:20 AM, Christoph Hellwig wrote:
> This allows sending larger than 1 MB requess to devices that support
> large I/O sizes.

Thanks, I'll queue it up for this series.

-- 
Jens Axboe

Subject: Re: untange block operations and fs READ/WRITE
To: Christoph Hellwig <hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <ea3bf683-2cbc-8861-1a61-750ac5299915@fb.com>
Date: Tue, 1 Nov 2016 14:01:47 -0600
MIME-Version: 1.0
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/01/2016 07:40 AM, Christoph Hellwig wrote:
> Hi Jens,
>
> this series removes the READ_* and WRITE_* defintions from fs.h and makes
> all bio submitters use the REQ_* flags directly.  To make that easier
> we also change the meaning of some of the flags slightly, so that the
> callers don't have to set half a dozen flags for normal operations.
>
> After that the READ and WRITE defintions are decouple from REQ_OP_READ
> and REQ_OP_WRITE and moved to kernel.h, and last but not least we can
> now stop including blk_types.h from fs.h and avoid the CONFIG_BLOCK
> ifdefs in it.

Looks sane to me, and passes basic testing as well. Applied for 4.10.

-- 
Jens Axboe

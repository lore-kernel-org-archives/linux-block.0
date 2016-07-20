Return-Path: <axboe@kernel.dk>
Subject: Re: resend: a few more fixups for the ops vs flags split
To: Christoph Hellwig <hch@lst.de>
References: <1468920523-3189-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <629c1de3-a9e4-a18e-10ff-bc6a9c5a6a0b@kernel.dk>
Date: Wed, 20 Jul 2016 17:37:22 -0600
MIME-Version: 1.0
In-Reply-To: <1468920523-3189-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/19/2016 03:28 AM, Christoph Hellwig wrote:
> Get rid of the very confusing bio_rw helper, which mixes OPs and flags,
> and shrink the bio back to it's original size.
>
> Btw, I'm not really sure if having bi_rw and bi_flags really is the
> right thing in the long run, it seem rather confusing for users.
>
> Compared to the last posting on June 13 this just adds Reviewed-by tags.

Added for 4.8, thanks.

-- 
Jens Axboe

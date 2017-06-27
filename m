Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
 martin.petersen@oracle.com
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
 <1498491480-16306-2-git-send-email-axboe@kernel.dk>
 <20170627144255.GB2541@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f543046a-c186-da7a-73e1-6510e93118bf@kernel.dk>
Date: Tue, 27 Jun 2017 08:55:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170627144255.GB2541@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 08:42 AM, Christoph Hellwig wrote:
> The API looks ok, but the code could use some cleanups.  What do
> you think about the incremental patch below:
> 
> It refactors various manipulations, and stores the write hint right
> in the iocb as there is a 4 byte hole (this will need some minor
> adjustments in the next patches):

Sigh... Sure, that's how I did it originally as well.

BTW, that patch does not look like an incremental patch, what's
this against?

-- 
Jens Axboe

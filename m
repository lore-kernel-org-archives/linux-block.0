Return-Path: <axboe@kernel.dk>
Subject: Re: mtip32xx: fixes and cleanups
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20181109134902.32057-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <22824d2c-86fc-6105-e056-72c982e40875@kernel.dk>
Date: Fri, 9 Nov 2018 08:39:04 -0700
MIME-Version: 1.0
In-Reply-To: <20181109134902.32057-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 6:48 AM, Christoph Hellwig wrote:
> Various low hanging fruit, kicked of by seeing one of the few remaining
> req->special users.
> 
> Compile tested only.

Looks good to me - as it so happens, I do have a few of these cards.
Tested working fine after the patches.

-- 
Jens Axboe

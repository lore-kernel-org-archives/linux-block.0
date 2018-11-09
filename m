Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove req->timeout_list
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20181109183744.21451-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d4c97d40-ded7-4955-7e20-9d268bb663fb@kernel.dk>
Date: Fri, 9 Nov 2018 11:44:44 -0700
MIME-Version: 1.0
In-Reply-To: <20181109183744.21451-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 11:37 AM, Christoph Hellwig wrote:
> Unused now that the legacy request path is gone.

Great, missed that. Applied, thanks.

-- 
Jens Axboe

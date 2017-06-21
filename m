Return-Path: <axboe@kernel.dk>
Subject: Re: two small cleanups
To: Christoph Hellwig <hch@lst.de>
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org
References: <20170619072441.12835-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <961279e9-0db1-8189-8d69-d1770d768072@kernel.dk>
Date: Tue, 20 Jun 2017 19:22:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170619072441.12835-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 01:24 AM, Christoph Hellwig wrote:
> Stop relying on bio_page and a page_address in the Write Same code
> and remove an unused macro.

Applied, thanks.

-- 
Jens Axboe

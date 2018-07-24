Return-Path: <axboe@kernel.dk>
Subject: Re: two small bio cleanups
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20180724120413.15689-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2e977432-b2ca-87cd-e673-c80d28e249a0@kernel.dk>
Date: Tue, 24 Jul 2018 13:41:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180724120413.15689-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/24/18 5:04 AM, Christoph Hellwig wrote:
> To remove invariants that are odd and in the way of multipage biovecs.

Applied for 4.19, thanks.

-- 
Jens Axboe

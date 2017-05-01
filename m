Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove elevator_change()
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170501155849.5134-1-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Markus Trippelsdorf <markus@trippelsdorf.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <848a2528-7145-2042-9f3a-10b3140d73ba@kernel.dk>
Date: Mon, 1 May 2017 10:02:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170501155849.5134-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/01/2017 09:58 AM, Bart Van Assche wrote:
> Since commit 84253394927c ("remove the mg_disk driver") removed the
> only caller of elevator_change(), also remove the elevator_change()
> function itself.

Nice, thanks Bart. I thought s390 dasd used it as well, but looks like
that got killed a while back.

-- 
Jens Axboe

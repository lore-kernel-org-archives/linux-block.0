Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: reset bi_iter.bi_done after splitting bio
To: Greg Edwards <gedwards@ddn.com>, linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Dmitry Monakhov <dmonakhov@openvz.org>
References: <20180726183937.23814-1-gedwards@ddn.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a7517e17-d4f3-727d-34cc-2e28694bd6f7@kernel.dk>
Date: Fri, 27 Jul 2018 09:12:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180726183937.23814-1-gedwards@ddn.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/26/18 12:39 PM, Greg Edwards wrote:
> After the bio has been updated to represent the remaining sectors, reset
> bi_done so bio_rewind_iter() does not rewind further than it should.
> 
> This resolves a bio_integrity_process() failure on reads where the
> original request was split.

Applied for 4.18, thanks.

-- 
Jens Axboe

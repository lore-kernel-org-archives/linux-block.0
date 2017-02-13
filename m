Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Call bio_io_error if request returned is NULL
To: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-block@vger.kernel.org
References: <20170213160454.30869-1-rgoldwyn@suse.de>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ff68f573-318c-23bc-afb9-ccc7d1c62262@kernel.dk>
Date: Mon, 13 Feb 2017 09:07:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170213160454.30869-1-rgoldwyn@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/13/2017 09:04 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> If blk_mq_map_request returns NULL, bio_endio() function is not
> called. Call bio_io_error() in case request returned is NULL.

That's currently not a possible condition, since the main
request mapper functions block on rq allocation. So we can
never return NULL there.

-- 
Jens Axboe

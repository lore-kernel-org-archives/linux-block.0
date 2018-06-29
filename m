Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] drbd: Do not redefine __must_hold()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20180625225100.4352-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <45765861-eb01-842a-3dac-cd2d606b22a2@kernel.dk>
Date: Fri, 29 Jun 2018 07:58:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180625225100.4352-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/25/18 4:51 PM, Bart Van Assche wrote:
> Since __must_hold() is defined in <linux/compiler_types.h>, do not
> redefine it in DRBD. Compile-tested only.

Applied for 4.19, thanks.

-- 
Jens Axboe

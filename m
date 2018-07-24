Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Rename the null_blk_mod kernel module back into
 null_blk
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Matias Bjorling <matias.bjorling@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <damien.lemoal@wdc.com>
References: <20180723211833.15498-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7bd49706-20b4-15f1-ca3c-389c887b9bb6@kernel.dk>
Date: Tue, 24 Jul 2018 09:54:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180723211833.15498-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/23/18 3:18 PM, Bart Van Assche wrote:
> Commit ca4b2a011948 ("null_blk: add zone support") breaks several
> blktests scripts because it renamed the null_blk kernel module into
> null_blk_mod. Hence rename null_blk_mod back into null_blk.

Thanks Bart, applied.

-- 
Jens Axboe

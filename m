Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: Off by one in blk_mq_rq_state_name()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180620104503.nrwlfak3gyxjg7s2@kili.mountain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5aed29c8-5125-cf15-b4b4-7f2c0057be36@kernel.dk>
Date: Wed, 20 Jun 2018 11:26:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180620104503.nrwlfak3gyxjg7s2@kili.mountain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/20/18 4:45 AM, Dan Carpenter wrote:
> If rq_state == ARRAY_SIZE() then we read one element beyond the end of
> the blk_mq_rq_state_name_array[] array.

Applied, thanks Dan.

-- 
Jens Axboe

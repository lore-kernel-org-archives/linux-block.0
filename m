Return-Path: <axboe@kernel.dk>
Date: Wed, 5 Apr 2017 08:07:22 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Remove blk_mq_queue_data.list
Message-ID: <20170405140722.GA20495@kernel.dk>
References: <CY1PR0401MB15363601FA034CE8627DA41881080@CY1PR0401MB1536.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CY1PR0401MB15363601FA034CE8627DA41881080@CY1PR0401MB1536.namprd04.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 03 2017, Bart Van Assche wrote:
> The block layer core sets blk_mq_queue_data.list but no block
> drivers read that member. Hence remove it and also the code that
> is used to set this member.

Looks fine to me, might as well kill it. Your patch came through mangled
here though, on both my private and corporate email account. Did
something change with the setup at your end? Would be great if you could
resend it.

-- 
Jens Axboe

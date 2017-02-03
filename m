Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] blkcg: fix double free of new_blkg in
 blkcg_init_queue
To: Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
References: <1486113547-43833-1-git-send-email-houtao1@huawei.com>
Cc: tj@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6ee8c902-9c38-d5b3-055f-3dacd2f20c48@kernel.dk>
Date: Fri, 3 Feb 2017 08:25:51 -0700
MIME-Version: 1.0
In-Reply-To: <1486113547-43833-1-git-send-email-houtao1@huawei.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/03/2017 02:19 AM, Hou Tao wrote:
> If blkg_create fails, new_blkg passed as an argument will
> be freed by blkg_create, so there is no need to free it again.

Thanks, looks good to me. Applied.

-- 
Jens Axboe

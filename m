Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: kill unused ret in recv_work
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Josef Bacik <jbacik@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <1499944844-67183-1-git-send-email-wangkefeng.wang@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b5f4ea1e-65bf-4139-0f22-dccf306a93d4@kernel.dk>
Date: Thu, 13 Jul 2017 08:03:44 -0600
MIME-Version: 1.0
In-Reply-To: <1499944844-67183-1-git-send-email-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/13/2017 05:20 AM, Kefeng Wang wrote:
> No need to return value in queue work, kill ret variable.

Applied, thanks.

-- 
Jens Axboe

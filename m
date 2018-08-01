Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/bsg-lib: use PTR_ERR_OR_ZERO to simplify the flow
 path
To: zhong jiang <zhongjiang@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cf7c3f7d-f47d-d077-4c84-ecb4083fe6cf@kernel.dk>
Date: Wed, 1 Aug 2018 09:13:13 -0600
MIME-Version: 1.0
In-Reply-To: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/31/18 10:13 AM, zhong jiang wrote:
> Simplify the code by using the PTR_ERR_OR_ZERO, instead of the
> open code. It is better.

Applied, thanks.

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] fix a few problems in block layer
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>, hch@lst.de,
 Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <29528920-de09-301f-9aa4-0e8b7f25c516@kernel.dk>
Date: Mon, 26 Feb 2018 09:03:59 -0700
MIME-Version: 1.0
In-Reply-To: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/26/18 5:01 AM, Jiufei Xue wrote:
> I have found a few problems while reviewing the patch 74d46992e0d9
> ("block: replace bi_bdev with a gendisk pointer and partitions index"),
> So fix them.

Looks good to me. It's important to include a Fixes line in
the individual patches, though. Otherwise this information
is lost, and it's very useful for folks backporting fixes.

Also, patch 4/4 should have some small sensible commit
message.

Care to resend with these items fixed?

-- 
Jens Axboe

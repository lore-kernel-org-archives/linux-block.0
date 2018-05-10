Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 6/9] sbitmap: warn if using smaller shallow depth than was
 setup
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
 paolo.valente@linaro.org
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-7-git-send-email-axboe@kernel.dk>
 <20180510170232.GF30485@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8b7b8022-13d3-c96a-22ab-04382d63a4b4@kernel.dk>
Date: Thu, 10 May 2018 11:09:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180510170232.GF30485@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/10/18 11:02 AM, Omar Sandoval wrote:
> On Thu, May 10, 2018 at 10:24:24AM -0600, Jens Axboe wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> Make sure the user passed the right value to
>> sbitmap_queue_min_shallow_depth().
> 
> An unlucky bisect that lands between this change and the BFQ/Kyber
> changes is going to trigger this warning. We should have it after the
> BFQ/Kyber changes.

Good point, I'll move it after the kyber/bfq change.

-- 
Jens Axboe

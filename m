Subject: Re: [PATCH] LightNVM fix for 4.9-rc5
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1478777191-10160-1-git-send-email-m@bjorling.me>
Cc: keith.busch@intel.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <37163de8-1e1a-a6d3-56f5-8343c2d3954f@fb.com>
Date: Thu, 10 Nov 2016 08:03:41 -0700
MIME-Version: 1.0
In-Reply-To: <1478777191-10160-1-git-send-email-m@bjorling.me>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/10/2016 04:26 AM, Matias Bjørling wrote:
> Hi Jens,
>
> A small calculation bug sneaked into 4.9, which led to data loss using the rrpc
> FTL.
>
> Can the fix be picked up for next -rc, or should I mark it for stable after the
> 4.9 release?

We can put it in this release, it's a regression fix for a bug
introduced in this cycle. I'll add it.

-- 
Jens Axboe

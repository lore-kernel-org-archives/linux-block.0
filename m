Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 31 Aug 2018 17:35:10 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] blkcg ref count refactor/cleanup + blkcg avg_lat
Message-ID: <20180901003510.GM1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Aug 30, 2018 at 09:53:41PM -0400, Dennis Zhou wrote:
> This is a fairly lengthy patchset that aims to cleanup reference
> counting for blkcgs and blkgs. There are 4 problems that this patchset
> tries to address:
>   1. fix blkcg destruction
>   2. always associate a bio with a blkg
>   3. remove the extra css ref held by bios and utilize the blkg ref
>   4. add average latency tracking to blkcg core in io.stat.

1 is already merged.  Reviewed 2, 3 parts.  Generally looks great.
Let's try to address the found issues and get these two parts merged
first.

Thanks.

-- 
tejun

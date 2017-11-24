Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 RESEND 1/2] blk-throttle: track read and write request
 individually
To: Joseph Qi <jiangqi903@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>, Shaohua Li <shli@fb.com>,
 qijiang.qj@alibaba-inc.com
References: <ce8504cb-d3ad-d8cb-4db0-11788578d1af@gmail.com>
 <ee08d6bf-dea8-2b80-b20d-1229409f3542@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ea069c52-1080-3ff7-1e52-66a9fbea79c1@kernel.dk>
Date: Thu, 23 Nov 2017 22:13:02 -0700
MIME-Version: 1.0
In-Reply-To: <ee08d6bf-dea8-2b80-b20d-1229409f3542@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/23/2017 06:31 PM, Joseph Qi wrote:
> Hi Jens,
> Could you please give your advice for the two patches or pick them up if
> you think they are good?

It looks OK to me, but my preference would be to push this until
4.16.

-- 
Jens Axboe

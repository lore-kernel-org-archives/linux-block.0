Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Followup block pull request for 4.14-rc1
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1f069ba0-19bf-a7b3-3a65-78f7f20ddc65@kernel.dk>
Message-ID: <bb8b83d5-3e38-5445-9ba4-a2627e161cf0@kernel.dk>
Date: Fri, 8 Sep 2017 11:55:40 -0600
MIME-Version: 1.0
In-Reply-To: <1f069ba0-19bf-a7b3-3a65-78f7f20ddc65@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/08/2017 11:34 AM, Jens Axboe wrote:
> Single merge conflict here, for nvme/rdma. Trivial to fixup, see my
> for-next branch here:
> 
> http://git.kernel.dk/cgit/linux-block/log/?h=for-next
> 
> if you want to see how I resolved it. Note that the for-next branch is
> missing one late bcache fixup, so it's not identical to what you will
> end up with after pulling this in.

Actually, I misspoke, I did pull in that last change yesterday. So it's
all merged up.

-- 
Jens Axboe

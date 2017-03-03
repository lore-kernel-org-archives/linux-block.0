Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 3 Mar 2017 11:12:22 -0800
From: Tejun Heo <tj@kernel.org>
To: Hou Tao <houtao1@huawei.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] block: use put_io_context_active() to disassociate bio
 from a task
Message-ID: <20170303191222.GA20854@wtj.duckdns.org>
References: <1488524470-570-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488524470-570-1-git-send-email-houtao1@huawei.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Fri, Mar 03, 2017 at 03:01:10PM +0800, Hou Tao wrote:
> bio_associate_current() invokes get_io_context_active() to tell
> CFQ scheduler that the current io_context is still issuing IOs
> by increasing active_ref. When the bio is done, we also need
> to invoke put_io_context_active() to decrease active_ref else
> the associated io_context will always be active.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Can you please explain how you noticed issue and verified the patch?
Also, the patch will need the following.

 Fixes: 852c788f8365 ("block: implement bio_associate_current()")
 Cc: stable@vger.kernel.org # v3.5+

I think the failure mode isn't severe.  We'll be carrying around ioc's
longer than necessary but that's about it.  I wonder whether the logic
can be simplified in general.  Anyways, please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: jack@suse.cz, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, tj@kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH] bdi: Fix oops in wb_workfn()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180503162626.27753-1-jack@suse.cz>
In-Reply-To: <20180503162626.27753-1-jack@suse.cz>
Message-Id: <201805040735.ADG57320.VFOQOJMOLHFStF@I-love.SAKURA.ne.jp>
Date: Fri, 4 May 2018 07:35:34 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Jan Kara wrote:
> Make wb_workfn() use wakeup_wb() for requeueing the work which takes all
> the necessary precautions against racing with bdi unregistration.

Yes, this patch will solve NULL pointer dereference bug. But is it OK to leave
list_empty(&wb->work_list) == false situation? Who takes over the role of making
list_empty(&wb->work_list) == true?

Just a confirmation, for Fabiano Rosas is facing a problem that "write call
hangs in kernel space after virtio hot-remove" and is thinking that we might
need to go the opposite direction
( http://lkml.kernel.org/r/f0787b79-1e50-5f55-a400-44f715451777@linux.ibm.com ).

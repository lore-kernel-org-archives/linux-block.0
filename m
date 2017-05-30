Return-Path: <krisman@collabora.co.uk>
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,  linux-block@vger.kernel.org,  Bart Van Assche <Bart.VanAssche@sandisk.com>,  linux-nvme@lists.infradead.org
Subject: Re: [PATCH] blk-mq: Take tagset lock when updaing hw queues
References: <1496169551-26868-1-git-send-email-keith.busch@intel.com>
Date: Tue, 30 May 2017 16:52:14 -0300
In-Reply-To: <1496169551-26868-1-git-send-email-keith.busch@intel.com> (Keith
	Busch's message of "Tue, 30 May 2017 14:39:11 -0400")
Message-ID: <87fufmm8b5.fsf@dilma.collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Keith Busch <keith.busch@intel.com> writes:

> The tagset lock needs to be held when iterating the tag_list, so a
> lockdep assert was added when updating number of hardware queues. The
> drivers calling this API, however, were unaware of the new requirement,
> so are failing the assertion.
>
> This patch takes the lock within the blk-mq function so the drivers do
> not have to be modified in order to be safe.
>
> Fixes: 705cda97e ("blk-mq: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list")
>
> Reported-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

I know it is already applied but, FWIW, I can confirm it fixed the issue
in our CI.  Feel free to add:

Tested-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>

Thanks again, Keith.

-- 
Gabriel Krisman Bertazi

Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
Subject: Re: [PATCH] blk-mq-fs: invoke queue_for_each_hw_ctx under sysfs_lock
To: Jianchao Wang <jianchao.w.wang@oracle.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1529907699-2054-1-git-send-email-jianchao.w.wang@oracle.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <d7b196bf-be18-a8f0-29ce-4f705689babe@wdc.com>
Date: Tue, 26 Jun 2018 08:29:33 -0700
MIME-Version: 1.0
In-Reply-To: <1529907699-2054-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/24/18 23:20, Jianchao Wang wrote:
> blk_mq_run_hw_queues and blk_mq_start_stopped_hw_queues in
> queue_state_write will invoke queue_for_each_hw_ctx. It will race
> with blk_mq_realloc_hw_ctxs and incur NULL pointer reference. Put
> them under sysfs_lock to serialize the accessing to queue_hw_ctx
> and nr_hw_queues.

The above looks wrong to me. blk_mq_realloc_hw_ctxs() starts with 
calling blk_mq_unregister_hctx(). That last function uses kobject_del() 
and kobject_del() waits until all pending sysfs callback functions for 
the deleted objects have finished.

Bart.

Return-Path: <prvs=6236fbcb6=bart.vanassche@wdc.com>
Subject: Re: [PATCH 1/2] blk-mq: Factor out [s]rcu synchronization
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <f3ad5e36-11b8-2371-d634-a97280c4407e@wdc.com>
Date: Mon, 2 Apr 2018 13:48:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180402190053.GC388343@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 04/02/18 12:00, Tejun Heo wrote:
> Factor out [s]rcu synchronization in blk_mq_timeout_work() into
> blk_mq_timeout_sync_rcu().  This is to add another user in the future
> and doesn't cause any functional changes.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

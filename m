Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] cfq-iosched: fix the delay of cfq_group's vdisktime
 under iops mode
To: Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
References: <1488975415-40417-1-git-send-email-houtao1@huawei.com>
Cc: jack@suse.cz, jmoyer@redhat.com, stable@vger.kernel.org, vgoyal@redhat.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c5efa1e8-2d05-7631-64ef-29734cb883b7@kernel.dk>
Date: Wed, 8 Mar 2017 10:56:51 -0700
MIME-Version: 1.0
In-Reply-To: <1488975415-40417-1-git-send-email-houtao1@huawei.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/08/2017 05:16 AM, Hou Tao wrote:
> When adding a cfq_group into the cfq service tree, we use CFQ_IDLE_DELAY
> as the delay of cfq_group's vdisktime if there have been other cfq_groups
> already.
> 
> When cfq is under iops mode, commit 9a7f38c42c2b ("cfq-iosched: Convert
> from jiffies to nanoseconds") could result in a large iops delay and
> lead to an abnormal io schedule delay for the added cfq_group. To fix
> it, we just need to revert to the old CFQ_IDLE_DELAY value: HZ / 5
> when iops mode is enabled.
> 
> Despite having the same value, the delay of a cfq_queue in idle class
> and the delay of cfq_queue are different things, so I define two new
> macros for the delay of a cfq_group under time-slice mode and IOPs mode.

Added, thanks.

-- 
Jens Axboe

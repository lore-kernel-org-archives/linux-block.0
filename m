Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: fix device sched directory for default
 scheduler
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
References: <602ca75f1201b062f4f05b79f3c693e30e8bd6b9.1507067772.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3d3d5a14-69df-5d1a-a47b-a33ab4dd0d08@kernel.dk>
Date: Tue, 3 Oct 2017 15:59:47 -0600
MIME-Version: 1.0
In-Reply-To: <602ca75f1201b062f4f05b79f3c693e30e8bd6b9.1507067772.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/03/2017 03:57 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In blk_mq_debugfs_register(), I remembered to set up the per-hctx sched
> directories if a default scheduler was already configured by
> blk_mq_sched_init() from blk_mq_init_allocated_queue(), but I didn't do
> the same for the device-wide sched directory. Fix it.

Good catch, applied for 4.14.

-- 
Jens Axboe

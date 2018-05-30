Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 30 May 2018 09:31:18 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 08/13] blk-stat: export helpers for modifying blk_rq_stat
Message-ID: <20180530163118.GO1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-9-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529211724.4531-9-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 05:17:19PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> We need to use blk_rq_stat in the blkcg qos stuff, so export some of
> these helpers so they can be used by other things.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

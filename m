Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 30 May 2018 08:58:24 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 04/13] blk: introduce REQ_SWAP
Message-ID: <20180530155824.GL1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529211724.4531-5-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 05:17:15PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Just like REQ_META, it's important to know the IO coming down is swap
> in order to guard against potential IO priority inversion issues with
> cgroups.  Add REQ_SWAP and use it for all swap IO, and add it to our
> bio_issue_as_root_blkg helper.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

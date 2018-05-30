Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 30 May 2018 08:53:19 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 02/13] block: introduce bio_issue_as_root_blkg
Message-ID: <20180530155319.GJ1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-3-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529211724.4531-3-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 05:17:13PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Instead of forcing all file systems to get the right context on their
> bio's, simply check for REQ_META to see if we need to issue as the root
> blkg.  We don't want to force all bio's to have the root blkg associated
> with them if REQ_META is set, as some controllers (blk-iolatency) need
> to know who the originating cgroup is so it can backcharge them for the
> work they are doing.  This helper will make sure that the controllers do
> the proper thing wrt the IO priority and backcharging.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

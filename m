Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Fri, 31 Aug 2018 16:19:10 -0400
From: Dennis Zhou <dennisszhou@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiufei Xue <jiufei.xue@linux.alibaba.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 02/15] blkcg: delay blkg destruction until after
 writeback has finished
Message-ID: <20180831201909.GA20194@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-3-dennisszhou@gmail.com>
 <20180831152705.4mjm7xo6jq7ptdqn@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831152705.4mjm7xo6jq7ptdqn@destiny>
List-ID: <linux-block@vger.kernel.org>

Hi Josef,

On Fri, Aug 31, 2018 at 11:27:07AM -0400, Josef Bacik wrote:
> So the general approach is correct, but it's sort of confusing because you are
> using nr_cgwbs as a reference counter, because it's set at 1 at blkg creation
> time regardless of wether or not there's an assocated wb cg.  So instead why not
> just have a refcount_t ref, set it to 1 on creation and make the wb cg take a
> ref when it's attached, and then just do the get/put like normal and cleanup as
> you have below?  What you are doing is a reference counter masquerading as a
> count of the wb cg's, just add full ref counting to the blkcg and call it a day,
> it'll be much less confusing.  Thanks,

Yeah, that makes more sense. I've switched to using refcount_t and
renamed it to wbcg_refcnt. The corresponding actions have been renamed.

I've also fixed the kbuild error in v2.

Thanks,
Dennis

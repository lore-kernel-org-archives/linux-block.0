Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 7 Sep 2018 10:54:46 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] blkcg: remove additional reference to the css
Message-ID: <20180907175446.GC1100574@devbig004.ftw2.facebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-10-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906211045.29055-10-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Sep 06, 2018 at 05:10:42PM -0400, Dennis Zhou wrote:
> +struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
> +					 struct cgroup_subsys *ss)
> +{
> +	struct cgroup_subsys_state *css;
> +
> +	rcu_read_lock();
> +
> +	do {
> +		css = cgroup_css(cgrp, ss);
> +
> +		if (css)
> +			goto out_unlock;
> +		cgrp = cgroup_parent(cgrp);
> +	} while (cgrp);
> +
> +	css = init_css_set.subsys[ss->id];
> +out_unlock:
> +	rcu_read_unlock();

Nothing protects @css here tho.  It can be released before the caller
is done with it.  The caller must ensure that it's holding rcu read
lock to protect the lookup and the subsequent uses.  cgroup_css()
already checks for rcu locking, so if you just drop
rcu_read_lock/unlock(), everything should work fine.

Thanks.

-- 
tejun

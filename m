Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 4 Oct 2017 10:51:49 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, vgoyal@redhat.com, axboe@kernel.dk,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC 1/2] block: record blkcss in request
Message-ID: <20171004175149.GP3301751@devbig577.frc2.facebook.com>
References: <cover.1507138530.git.shli@fb.com>
 <95356f4da3de009464a06c314bf79db672be6adf.1507138530.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95356f4da3de009464a06c314bf79db672be6adf.1507138530.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Shaohua.

On Wed, Oct 04, 2017 at 10:41:19AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Currently we record block css info in bio but not in request. Normally
> we can get a request's css from its bio, but in some situations, we
> can't access request's bio, for example, after blk_update_request. Add
> the css to request, so we can access css through the life cycle of a
> request.

Each request comes from cgroup specific request_list, so given a
request, its blkcg membership can is accessible through

	request->rl->blkg->blkcg

Thanks.

-- 
tejun

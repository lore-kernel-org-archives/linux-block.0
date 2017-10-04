Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 4 Oct 2017 11:05:30 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, vgoyal@redhat.com, axboe@kernel.dk,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC 1/2] block: record blkcss in request
Message-ID: <20171004180530.GR3301751@devbig577.frc2.facebook.com>
References: <cover.1507138530.git.shli@fb.com>
 <95356f4da3de009464a06c314bf79db672be6adf.1507138530.git.shli@fb.com>
 <20171004175149.GP3301751@devbig577.frc2.facebook.com>
 <20171004180246.rmih3yjjwknzm44r@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004180246.rmih3yjjwknzm44r@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 11:02:46AM -0700, Shaohua Li wrote:
> > Each request comes from cgroup specific request_list, so given a
> > request, its blkcg membership can is accessible through
> > 
> > 	request->rl->blkg->blkcg
> 
> Nice. Seems only used for legacy queue though.

Ah, you're right.  rl isn't used for mq at all, so yeah, we probably
should propagate the association through rq.

Thanks.

-- 
tejun

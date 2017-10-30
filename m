Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 30 Oct 2017 07:55:26 -0700
From: Tejun Heo <tj@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] cfq-iosched: add "leaf_weight" setting for the root
 cgroup in cgroups v2
Message-ID: <20171030145526.GB3252168@devbig577.frc2.facebook.com>
References: <a1828795-3f51-9455-9d0b-93f9dcfb6fd4@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1828795-3f51-9455-9d0b-93f9dcfb6fd4@maciej.szmigiero.name>
List-ID: <linux-block@vger.kernel.org>

On Sun, Oct 29, 2017 at 05:36:53PM +0100, Maciej S. Szmigiero wrote:
> CFQ scheduler has a property that processes (or tasks in cgroups v1) that
> aren't assigned to any particular cgroup - that is, which stay in the root
> cgroup - effectively form an implicit leaf child node attached to the root
> cgroup.
> 
> This behavior is documented in blkio-controller.txt for cgroups v1, however
> as far as I know it isn't documented anywhere for cgroups v2 besides a
> generic remark that "How resource consumption in the root cgroup is
> governed is up to each controller" in cgroup-v2.txt.
> 
> By default, this implicit leaf child node has a (CFQ) weight which is two
> times higher that the default weight of a child cgroup.
> 
> cgroups v1 provide a "leaf_weight" setting which allow changing this value.
> However, this setting is missing from cgroups v2 and so the only way to
> tweak how much IO time processes in the root cgroup get is to adapt
> weight settings of all child cgroups accordingly.
> Let's add a "leaf_weight" setting to the root cgroup in cgroups v2, too.
> 
> Note that new kernel threads appear in the root cgroup and there seems to
> be no way to change this since kthreadd cannot be moved to another cgroup
> (for a good reason).
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

I don't think we wanna do this.  It's inconsistent with what other
controllers do and we want to charge the IOs in the root cgroup to the
right cgroup.

Thanks.

-- 
tejun

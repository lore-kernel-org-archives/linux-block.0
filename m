Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "hare@suse.com" <hare@suse.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v5 4/9] percpu-refcount: Introduce percpu_ref_is_in_use()
Date: Thu, 9 Aug 2018 14:32:02 +0000
Message-ID: <37ae788c24551de77c21a86b091c757d65597dac.camel@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
	 <20180807225133.27221-5-bart.vanassche@wdc.com>
	 <20180808152351.GD3978217@devbig004.ftw2.facebook.com>
In-Reply-To: <20180808152351.GD3978217@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 08:23 -0700, Tejun Heo wrote:
+AD4- On Tue, Aug 07, 2018 at 03:51:28PM -0700, Bart Van Assche wrote:
+AD4- +AD4- Introduce a function that allows to determine whether a per-cpu=
 refcount
+AD4- +AD4- is in use. This function will be used in a later patch to deter=
mine
+AD4- +AD4- whether or not any block layer requests are being executed.
+AD4-=20
+AD4- I thought about it a bit and am having a bit of difficulty convincing
+AD4- myself this is necessary.  Switching a percpu+AF8-ref to atomic mode =
isn't
+AD4- expensive - it's one spinlock cycle, a rcu wait and one sweep of the
+AD4- percpu counters.  The most expensive part - the percpu sweep - needs
+AD4- to be there even with optimization, the wait doesn't really matter as
+AD4- all it'll do is slightly delaying timer based PM operation and can be
+AD4- overlayed with the propagation of set+AF8-pm+AF8-only() anyway.
+AD4-=20
+AD4- So, how about just doing the simple thing?  Switch it to atomic mode
+AD4- and check the counter and switch back to percpu mode afterwards.  If
+AD4- we see any issues with that, we can try to optimize it later but that
+AD4- seems unlikely to me.

Hello Tejun,

Switching to atomic mode would require me to add a serialization mechanism
against blk+AF8-freeze+AF8-queue+AF8-start() and blk+AF8-mq+AF8-unfreeze+AF=
8-queue() since these
functions call percpu+AF8-ref+AF8-kill() and percpu+AF8-ref+AF8-reinit(). T=
hat is easy but
requires additional code. I will see whether I can implement an alternative
approach using blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter().

Thanks,

Bart.

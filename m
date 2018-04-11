Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 10:15:38 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411171538.GN793541@devbig577.frc2.facebook.com>
References: <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
 <20180411145632.GK793541@devbig577.frc2.facebook.com>
 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
 <20180411170018.GL793541@devbig577.frc2.facebook.com>
 <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 05:06:41PM +0000, Bart Van Assche wrote:
> A simple and effective solution is to dissociate a request queue from the
> block cgroup controller before blk_cleanup_queue() returns. This is why commit
> a063057d7c73 ("block: Fix a race between request queue removal and the block
> cgroup controller") moved the blkcg_exit_queue() call from __blk_release_queue()
> into blk_cleanup_queue().

which is broken.  We can try to switch the lifetime model to revoking
all live objects but that likely is a lot more involving than blindly
moving blkg shootdown from release to cleanup.  Implementing sever
semantics is usually a lot more involved / fragile because it requires
explicit participation from all users (exactly the same way revoking
->queue_lock is difficult).

I'm not necessarily against switching to sever model, but what the
patch did isn't that.  It just moved some code without actually
understanding or auditing what the implications are.

Thanks.

-- 
tejun

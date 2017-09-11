Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 11 Sep 2017 10:20:56 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "neilb@suse.com" <neilb@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"cl@linux.com" <cl@linux.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] percpu-refcount: Introduce
 percpu_ref_switch_to_atomic_nowait()
Message-ID: <20170911172056.GG1774378@devbig577.frc2.facebook.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
 <20170908235226.26622-2-bart.vanassche@wdc.com>
 <20170911131331.GE1774378@devbig577.frc2.facebook.com>
 <1505146151.2802.21.camel@wdc.com>
 <20170911163756.GF1774378@devbig577.frc2.facebook.com>
 <1505148959.2802.47.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505148959.2802.47.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hey,

On Mon, Sep 11, 2017 at 04:55:59PM +0000, Bart Van Assche wrote:
> > Probably but that sounds really hairy.  I'd much prefer if it could be
> > done through the usual kill / confirm / release and re-init.  That's
> > not a possibility?
> 
> Modifying this patch series such that it uses the confirmation mechanism
> when switching from per-cpu to atomic mode should be possible. However, the
> wait_event_lock_irq() call in __percpu_ref_switch_mode() is annoying when
> calling percpu_ref_kill_and_confirm() from atomic context. How about adding
> a nowait version of percpu_ref_kill_and_confirm() that returns a boolean
> indicating whether or not this function succeeded?

Hmm... so if you know that you won't try to switch again while
switching is in progress, it should be fine.  That can't be
guaranteed?

Thanks.

-- 
tejun

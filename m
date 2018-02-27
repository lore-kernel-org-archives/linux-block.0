Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 27 Feb 2018 10:14:04 -0800
From: Tejun Heo <tj@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH RFC] sbitmap: Use lock/unlock atomic bitops
Message-ID: <20180227181404.GA24003@devbig577.frc2.facebook.com>
References: <20180218130506.GW695913@devbig577.frc2.facebook.com>
 <20180226221444.GD9157@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226221444.GD9157@vader.DHCP.thefacebook.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Omar.

On Mon, Feb 26, 2018 at 02:14:44PM -0800, Omar Sandoval wrote:
> >  	wake_index = atomic_read(&sbq->wake_index);
> >  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
> >  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
> 
> So I think we want a patch for the test_and_set_bit_lock() and
> clear_bit_unlock(), but the rest should stay as-is.

Yeah, that makes sense to me.  Would you be interested in updating the
patch?

Thanks.

-- 
tejun

Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537821815.195115.26.camel@acm.org>
Subject: Re: [PATCH v10 5/8] percpu-refcount: Introduce
 percpu_ref_resurrect()
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Jianchao Wang
 <jianchao.w.wang@oracle.com>,  Hannes Reinecke <hare@suse.com>, Johannes
 Thumshirn <jthumshirn@suse.de>
Date: Mon, 24 Sep 2018 13:43:35 -0700
In-Reply-To: <20180924180117.GG1297799@devbig004.ftw2.facebook.com>
References: <20180921203122.49743-1-bvanassche@acm.org>
	 <20180921203122.49743-6-bvanassche@acm.org>
	 <20180924180117.GG1297799@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-09-24 at 11:01 -0700, Tejun Heo wrote:
+AD4 Hello, Bart.
+AD4 
+AD4 On Fri, Sep 21, 2018 at 01:31:19PM -0700, Bart Van Assche wrote:
+AD4 +AD4 +-void percpu+AF8-ref+AF8-resurrect(struct percpu+AF8-ref +ACo-ref)
+AD4 +AD4 +-+AHs
+AD4 +AD4 +-	unsigned long +AF8AXw-percpu +ACo-percpu+AF8-count+ADs
+AD4 +AD4  	unsigned long flags+ADs
+AD4 +AD4  
+AD4 +AD4  	spin+AF8-lock+AF8-irqsave(+ACY-percpu+AF8-ref+AF8-switch+AF8-lock, flags)+ADs
+AD4 +AD4  
+AD4 +AD4 -	WARN+AF8-ON+AF8-ONCE(+ACE-percpu+AF8-ref+AF8-is+AF8-zero(ref))+ADs
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE(ref-+AD4-percpu+AF8-count+AF8-ptr +ACY +AF8AXw-PERCPU+AF8-REF+AF8-DEAD))+ADs
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+AF8AXw-ref+AF8-is+AF8-percpu(ref, +ACY-percpu+AF8-count))+ADs
+AD4 
+AD4 So, this in itself is fine but I'm a bit worried that this might it
+AD4 easier to abuse percpu+AF8-ref's dying mode.  More specifically, it isn't
+AD4 a good idea to depend on percpu+AF8-ref's implementation details from
+AD4 outside - ie. the only guarantee there ever is that percpu+AF8-ref won't
+AD4 give out new refs after -+AD4-percpu+AF8-ref is called - e.g. users can't
+AD4 piggy back on implied rcu grace period.
+AD4 
+AD4 Can you please note that in the function comment?  Provided that,
+AD4 
+AD4 Acked-by: Tejun Heo +ADw-tj+AEA-kernel.org+AD4

Hi Tejun,

Thanks for the review. But could you please clarify what +ACI-after -+AD4-percpu+AF8-ref
is called+ACI refers to?

Thanks,

Bart.

Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537987695.209118.2.camel@acm.org>
Subject: Re: [PATCH v10 5/8] percpu-refcount: Introduce
 percpu_ref_resurrect()
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Jianchao Wang
 <jianchao.w.wang@oracle.com>,  Hannes Reinecke <hare@suse.com>, Johannes
 Thumshirn <jthumshirn@suse.de>
Date: Wed, 26 Sep 2018 11:48:15 -0700
In-Reply-To: <20180926165954.GH1297799@devbig004.ftw2.facebook.com>
References: <20180921203122.49743-1-bvanassche@acm.org>
	 <20180921203122.49743-6-bvanassche@acm.org>
	 <20180924180117.GG1297799@devbig004.ftw2.facebook.com>
	 <1537821815.195115.26.camel@acm.org>
	 <20180926165954.GH1297799@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-26 at 09:59 -0700, Tejun Heo wrote:
+AD4 Hello, Bart.
+AD4 
+AD4 On Mon, Sep 24, 2018 at 01:43:35PM -0700, Bart Van Assche wrote:
+AD4 +AD4 Thanks for the review. But could you please clarify what +ACI-after -+AD4-percpu+AF8-ref
+AD4 +AD4 is called+ACI refers to?
+AD4 
+AD4 Oops, sorry, I meant the confirm+AF8-kill callback of
+AD4 percpu+AF8-ref+AF8-kill+AF8-and+AF8-confirm().

Thanks for the clarification. I will update the comment above
percpu+AF8-ref+AF8-resurrect().

Bart.

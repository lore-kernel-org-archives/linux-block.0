Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Sep 2018 09:59:54 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v10 5/8] percpu-refcount: Introduce percpu_ref_resurrect()
Message-ID: <20180926165954.GH1297799@devbig004.ftw2.facebook.com>
References: <20180921203122.49743-1-bvanassche@acm.org>
 <20180921203122.49743-6-bvanassche@acm.org>
 <20180924180117.GG1297799@devbig004.ftw2.facebook.com>
 <1537821815.195115.26.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537821815.195115.26.camel@acm.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Mon, Sep 24, 2018 at 01:43:35PM -0700, Bart Van Assche wrote:
> Thanks for the review. But could you please clarify what "after ->percpu_ref
> is called" refers to?

Oops, sorry, I meant the confirm_kill callback of
percpu_ref_kill_and_confirm().

Thanks.

-- 
tejun

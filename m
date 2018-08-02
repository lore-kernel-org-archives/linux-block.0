Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 2 Aug 2018 12:06:49 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 4/9] percpu-refcount: Introduce percpu_ref_read()
Message-ID: <20180802190649.GV1206094@devbig004.ftw2.facebook.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
 <20180802182944.14442-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802182944.14442-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Aug 02, 2018 at 11:29:39AM -0700, Bart Van Assche wrote:
> Introduce a function that allows to read the value of a per-cpu counter.
> This function will be used in the next patch to check whether a per-cpu
> counter in atomic mode has the value one.

I'm not a big fan of exposing this.  If you need to test for atomic &&
1, I'd much prefer a helper specifically testing for that.  But can
you please explain a bit why you need this?

Thanks.

-- 
tejun

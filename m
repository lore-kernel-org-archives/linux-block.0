Return-Path: <bvanassche@acm.org>
Message-ID: <1536163037.11534.6.camel@acm.org>
Subject: Re: [PATCH 2/3] blk-core: introduce queue close feature
From: Bart Van Assche <bvanassche@acm.org>
To: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
	ming.lei@redhat.com, bart.vanassche@wdc.com, sagi@grimberg.me,
	keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Wed, 05 Sep 2018 08:57:17 -0700
In-Reply-To: <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
	 <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-05 at 12:09 +-0800, Jianchao Wang wrote:
+AD4 blk queue freeze is often used to prevent new IO from entering
+AD4 request queue. However, becuase we kill the percpu-ref
+AD4 q+AF8-usage+AF8-counter when freeze queue, we have to drain the request
+AD4 queue when unfreeze. This is unnecessary for just preventing new
+AD4 IO. In addition, If there is IO timeout or other issue when unfreeze
+AD4 the queue, the scenario could be very tricky.
+AD4 
+AD4 So we introduce BLK+AF8-QUEUE+AF8-GATE+AF8-CLOSED to implement a light-weight
+AD4 queue close feature base on the queue+AF8-gate to prevent new IO from
+AD4 comming in queue which will not need to drain the queue any more.

Does the +ACI-queue gate close+ACI feature cause blk+AF8-get+AF8-request() /
blk+AF8-mq+AF8-get+AF8-request() to block until blk+AF8-clear+AF8-queue+AF8-closed() is called? If
so, I think we need a better name for this feature. How about calling these
two operations suspend and resume?

Thanks,

Bart.

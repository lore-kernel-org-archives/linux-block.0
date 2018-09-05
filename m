Return-Path: <bvanassche@acm.org>
Message-ID: <1536162485.11534.3.camel@acm.org>
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
From: Bart Van Assche <bvanassche@acm.org>
To: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
	ming.lei@redhat.com, bart.vanassche@wdc.com, sagi@grimberg.me,
	keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Wed, 05 Sep 2018 08:48:05 -0700
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-05 at 12:09 +-0800, Jianchao Wang wrote:
+AD4 As we know, queue freeze is used to stop new IO comming in and drain
+AD4 the request queue. And the draining queue here is necessary, because
+AD4 queue freeze kills the percpu-ref q+AF8-usage+AF8-counter and need to drain
+AD4 the q+AF8-usage+AF8-counter before switch it back to percpu mode. This could
+AD4 be a trouble when we just want to prevent new IO.
+AD4 
+AD4 In nvme-pci, nvme+AF8-dev+AF8-disable freezes queues to prevent new IO.
+AD4 nvme+AF8-reset+AF8-work will unfreeze and wait to drain the queues. However,
+AD4 if IO timeout at the moment, no body could do recovery as nvme+AF8-reset+AF8-work
+AD4 is waiting. We will encounter IO hang.
+AD4 
+AD4 So introduce a light-weight queue close feature in this patch set
+AD4 which could prevent new IO and needn't drain the queue.
+AD4 
+AD4 The 1st patch introduces a queue+AF8-gate into request queue and migrate
+AD4 preempt only from queue flags on it.
+AD4 
+AD4 The 2nd patch introduces queue close feature.
+AD4 
+AD4 The 3rd patch apply the queue close in nvme-pci to avoid the IO hang
+AD4 issue above.

Hello Jianchao,

Is this patch series based on a theoretical concern or rather on something
you ran into? In the latter case, can you explain which scenario makes it
likely on your setup to encounter an NVMe timeout?

Thanks,

Bart.

Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
Date: Thu, 12 Jan 2017 19:13:17 +0000
Message-ID: <1484248382.2720.9.camel@sandisk.com>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com>
 <ccb6cf4d-4810-47b2-015a-0202d784280a@grimberg.me>
In-Reply-To: <ccb6cf4d-4810-47b2-015a-0202d784280a@grimberg.me>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-01-12 at 10:41 +0200, Sagi Grimberg wrote:
> First, when the nvme device fires an interrupt, the driver consumes
> the completion(s) from the interrupt (usually there will be some more
> completions waiting in the cq by the time the host start processing it).
> With irq-poll, we disable further interrupts and schedule soft-irq for
> processing, which if at all, improve the completions per interrupt
> utilization (because it takes slightly longer before processing the cq).
> 
> Moreover, irq-poll is budgeting the completion queue processing which is
> important for a couple of reasons.
> 
> 1. it prevents hard-irq context abuse like we do today. if other cpu
>     cores are pounding with more submissions on the same queue, we might
>     get into a hard-lockup (which I've seen happening).
> 
> 2. irq-poll maintains fairness between devices by correctly budgeting
>     the processing of different completions queues that share the same
>     affinity. This can become crucial when working with multiple nvme
>     devices, each has multiple io queues that share the same IRQ
>     assignment.
> 
> 3. It reduces (or at least should reduce) the overall number of
>     interrupts in the system because we only enable interrupts again
>     when the completion queue is completely processed.
> 
> So overall, I think it's very useful for nvme and other modern HBAs,
> but unfortunately, other than solving (1), I wasn't able to see
> performance improvement but rather a slight regression, but I can't
> explain where its coming from...

Hello Sagi,

Thank you for the additional clarification. Although I am not sure whether
irq-poll is the ideal solution for the problems that has been described
above, I agree that it would help to discuss this topic further during
LSF/MM.

Bart.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

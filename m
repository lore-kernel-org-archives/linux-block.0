Return-Path: <ming.lei@redhat.com>
Date: Fri, 6 Apr 2018 22:58:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
Message-ID: <20180406145822.GA12198@ming.t460p>
References: <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
 <20180405160503.GA20818@ming.t460p>
 <20180405161142.GA20972@ming.t460p>
 <3a72f42f-db90-6092-5e1b-0579d2095daa@de.ibm.com>
 <20180406084106.GA8940@ming.t460p>
 <e3701f81-8616-31b5-cf29-2f788f06aa64@de.ibm.com>
 <20180406092309.GB9605@ming.t460p>
 <e2dbf168-8583-2011-6520-02bf17051cd2@de.ibm.com>
 <20180406134133.GA10791@ming.t460p>
 <42716ec6-480d-4c73-a02c-1795873aaa79@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42716ec6-480d-4c73-a02c-1795873aaa79@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 06, 2018 at 04:26:49PM +0200, Christian Borntraeger wrote:
> 
> 
> On 04/06/2018 03:41 PM, Ming Lei wrote:
> > On Fri, Apr 06, 2018 at 12:19:19PM +0200, Christian Borntraeger wrote:
> >>
> >>
> >> On 04/06/2018 11:23 AM, Ming Lei wrote:
> >>> On Fri, Apr 06, 2018 at 10:51:28AM +0200, Christian Borntraeger wrote:
> >>>>
> >>>>
> >>>> On 04/06/2018 10:41 AM, Ming Lei wrote:
> >>>>> On Thu, Apr 05, 2018 at 07:39:56PM +0200, Christian Borntraeger wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 04/05/2018 06:11 PM, Ming Lei wrote:
> >>>>>>>>
> >>>>>>>> Could you please apply the following patch and provide the dmesg boot log?
> >>>>>>>
> >>>>>>> And please post out the 'lscpu' log together from the test machine too.
> >>>>>>
> >>>>>> attached.
> >>>>>>
> >>>>>> As I said before this seems to go way with CONFIG_NR_CPUS=64 or smaller.
> >>>>>> We have 282 nr_cpu_ids here (max 141CPUs on that z13 with SMT2) but only 8 Cores
> >>>>>> == 16 threads.
> >>>>>
> >>>>> OK, thanks!
> >>>>>
> >>>>> The most weird thing is that hctx->next_cpu is computed as 512 since
> >>>>> nr_cpu_id is 282, and hctx->next_cpu should have pointed to one of
> >>>>> possible CPU.
> >>>>>
> >>>>> Looks like it is a s390 specific issue, since I can setup one queue
> >>>>> which has same mapping with yours:
> >>>>>
> >>>>> 	- nr_cpu_id is 282
> >>>>> 	- CPU 0~15 is online
> >>>>> 	- 64 queues null_blk
> >>>>> 	- still run all hw queues in .complete handler
> >>>>>
> >>>>> But can't reproduce this issue at all.
> >>>>>
> >>>>> So please test the following patch, which may tell us why hctx->next_cpu
> >>>>> is computed wrong:
> >>>>
> >>>> I see things like
> >>>>
> >>>> [    8.196907] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196910] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196912] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196913] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196914] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196915] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196917] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>> [    8.196918] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>>>
> >>>> which is exactly what happens if the find and and operation fails (returns size of bitmap).
> >>>
> >>> Given both 'cpu_online_mask' and 'hctx->cpumask' are shown as correct
> >>> in your previous debug log, it means the following function returns
> >>> totally wrong result on S390.
> >>>
> >>> 	cpumask_first_and(hctx->cpumask, cpu_online_mask);
> >>>
> >>> The debugfs log shows that each hctx->cpumask includes one online
> >>> CPU(0~15).
> >>
> >> Really? the last log (with the latest patch applied  shows a lot of contexts
> >> that do not have CPUs in 0-15:
> >>
> >> e.g. 
> >> [    4.049828] dump CPUs mapped to this hctx:
> >> [    4.049829] 18 
> >> [    4.049829] 82 
> >> [    4.049830] 146 
> >> [    4.049830] 210 
> >> [    4.049831] 274 
> > 
> > That won't be an issue, since no IO can be submitted from these offline
> > CPUs, then these hctx shouldn't have been run at all.
> > 
> > But hctx->next_cpu can be set as 512 for these inactive hctx in
> > blk_mq_map_swqueue(), then please test the attached patch, and if
> > hctx->next_cpu is still set as 512, something is still wrong.
> 
> 
> WIth this patch I no longer see the "run queue from wrong CPU x, hctx active" messages.
> your debug code still triggers, though.
> 
> wrong next_cpu 512, blk_mq_hctx_next_cpu, first_and
> wrong next_cpu 512, blk_mq_hctx_next_cpu, next_and
> 
> If we would remove the debug code then dmesg would be clean it seems.

That is still a bit strange, since for any inactive hctx(without online
CPU mapped), blk_mq_run_hw_queue() will check blk_mq_hctx_has_pending()
first. And there shouldn't be any pending IO for all inactive hctx
in your case, so looks blk_mq_hctx_next_cpu() shouldn't be called for
inactive hctx.

I will prepare one patchset and post out soon, and hope all these issues
can be covered.

Thanks,
Ming

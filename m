Return-Path: <ming.lei@redhat.com>
Date: Tue, 9 May 2017 18:58:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-block@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Subject: Re: Large latency on blk_queue_enter
Message-ID: <20170509105845.GA24858@ming.t460p>
References: <576f9601-b0de-c636-8195-07e12fe99734@fb.com>
 <991bbc1d-1849-94d9-5787-69a630e7e10d@kernel.dk>
 <A781A1A3-58FA-49DF-9197-35FBD05E7476@lightnvm.io>
 <347b1a1d-de9e-509f-13c2-df0d4c427682@kernel.dk>
 <EAD85BFB-0DB3-44E4-992A-FF789DA1F46C@lightnvm.io>
 <822b8db4-9b98-da1f-2157-12b2af599b82@kernel.dk>
 <98125B90-AA08-49F4-8214-56AC86E4A645@lightnvm.io>
 <7f6e8c4b-504e-b786-da52-776c666e8c73@kernel.dk>
 <9AFF433E-1B77-4800-8B27-8E335F2F5DDE@lightnvm.io>
 <C3E13E05-ECE3-4CEB-ADFD-B8D6A7E6B0D7@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <C3E13E05-ECE3-4CEB-ADFD-B8D6A7E6B0D7@lightnvm.io>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 09, 2017 at 12:34:42PM +0200, Javier Gonz�lez wrote:
> > On 8 May 2017, at 18.39, Javier Gonz�lez <jg@lightnvm.io> wrote:
> > 
> >> On 8 May 2017, at 18.06, Jens Axboe <axboe@kernel.dk> wrote:
> >> 
> >> On 05/08/2017 09:49 AM, Javier Gonz�lez wrote:
> >>>> On 8 May 2017, at 17.40, Jens Axboe <axboe@kernel.dk> wrote:
> >>>> 
> >>>> On 05/08/2017 09:38 AM, Javier Gonz�lez wrote:
> >>>>>> On 8 May 2017, at 17.25, Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>> 
> >>>>>> On 05/08/2017 09:22 AM, Javier Gonz�lez wrote:
> >>>>>>> Javier
> >>>>>>> 
> >>>>>>>> On 8 May 2017, at 17.14, Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>>>> 
> >>>>>>>> On 05/08/2017 09:08 AM, Jens Axboe wrote:
> >>>>>>>>> On 05/08/2017 09:02 AM, Javier Gonz�lez wrote:
> >>>>>>>>>>> On 8 May 2017, at 16.52, Jens Axboe <axboe@fb.com> wrote:
> >>>>>>>>>>> 
> >>>>>>>>>>> On 05/08/2017 08:46 AM, Javier Gonz�lez wrote:
> >>>>>>>>>>>>> On 8 May 2017, at 16.23, Jens Axboe <axboe@fb.com> wrote:
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> On 05/08/2017 08:20 AM, Javier Gonz�lez wrote:
> >>>>>>>>>>>>>>> On 8 May 2017, at 16.13, Jens Axboe <axboe@fb.com> wrote:
> >>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>> On 05/08/2017 07:44 AM, Javier Gonz�lez wrote:
> >>>>>>>>>>>>>>>>> On 8 May 2017, at 14.27, Ming Lei <ming.lei@redhat.com> wrote:
> >>>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>>> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier Gonz�lez wrote:
> >>>>>>>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>>>> I find an unusual added latency(~20-30ms) on blk_queue_enter when
> >>>>>>>>>>>>>>>>>> allocating a request directly from the NVMe driver through
> >>>>>>>>>>>>>>>>>> nvme_alloc_request. I could use some help confirming that this is a bug
> >>>>>>>>>>>>>>>>>> and not an expected side effect due to something else.
> >>>>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>>>> I can reproduce this latency consistently on LightNVM when mixing I/O
> >>>>>>>>>>>>>>>>>> from pblk and I/O sent through an ioctl using liblightnvm, but I don't
> >>>>>>>>>>>>>>>>>> see anything on the LightNVM side that could impact the request
> >>>>>>>>>>>>>>>>>> allocation.
> >>>>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>>>> When I have a 100% read workload sent from pblk, the max. latency is
> >>>>>>>>>>>>>>>>>> constant throughout several runs at ~80us (which is normal for the media
> >>>>>>>>>>>>>>>>>> we are using at bs=4k, qd=1). All pblk I/Os reach the nvme_nvm_submit_io
> >>>>>>>>>>>>>>>>>> function on lightnvm.c., which uses nvme_alloc_request. When we send a
> >>>>>>>>>>>>>>>>>> command from user space through an ioctl, then the max latency goes up
> >>>>>>>>>>>>>>>>>> to ~20-30ms. This happens independently from the actual command
> >>>>>>>>>>>>>>>>>> (IN/OUT). I tracked down the added latency down to the call
> >>>>>>>>>>>>>>>>>> percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
> >>>>>>>>>>>>>>>>>> reference counter is not released as it should through blk_queue_exit in
> >>>>>>>>>>>>>>>>>> blk_mq_alloc_request. For reference, all ioctl I/Os reach the
> >>>>>>>>>>>>>>>>>> nvme_nvm_submit_user_cmd on lightnvm.c
> >>>>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>>>> Do you have any idea about why this might happen? I can dig more into
> >>>>>>>>>>>>>>>>>> it, but first I wanted to make sure that I am not missing any obvious
> >>>>>>>>>>>>>>>>>> assumption, which would explain the reference counter to be held for a
> >>>>>>>>>>>>>>>>>> longer time.
> >>>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>>> You need to check if the .q_usage_counter is working at atomic mode.
> >>>>>>>>>>>>>>>>> This counter is initialized as atomic mode, and finally switchs to
> >>>>>>>>>>>>>>>>> percpu mode via percpu_ref_switch_to_percpu() in blk_register_queue().
> >>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>> Thanks for commenting Ming.
> >>>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>>> The .q_usage_counter is not working on atomic mode. The queue is
> >>>>>>>>>>>>>>>> initialized normally through blk_register_queue() and the counter is
> >>>>>>>>>>>>>>>> switched to percpu mode, as you mentioned. As I understand it, this is
> >>>>>>>>>>>>>>>> how it should be, right?
> >>>>>>>>>>>>>>> 
> >>>>>>>>>>>>>>> That is how it should be, yes. You're not running with any heavy
> >>>>>>>>>>>>>>> debugging options, like lockdep or anything like that?
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> No lockdep, KASAN, kmemleak or any of the other usual suspects.
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> What's interesting is that it only happens when one of the I/Os comes
> >>>>>>>>>>>>>> from user space through the ioctl. If I have several pblk instances on
> >>>>>>>>>>>>>> the same device (which would end up allocating a new request in
> >>>>>>>>>>>>>> parallel, potentially on the same core), the latency spike does not
> >>>>>>>>>>>>>> trigger.
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> I also tried to bind the read thread and the liblightnvm thread issuing
> >>>>>>>>>>>>>> the ioctl to different cores, but it does not help...
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> How do I reproduce this? Off the top of my head, and looking at the code,
> >>>>>>>>>>>>> I have no idea what is going on here.
> >>>>>>>>>>>> 
> >>>>>>>>>>>> Using LightNVM and liblightnvm [1] you can reproduce it by:
> >>>>>>>>>>>> 
> >>>>>>>>>>>> 1. Instantiate a pblk instance on the first channel (luns 0 - 7):
> >>>>>>>>>>>>   sudo nvme lnvm create -d nvme0n1 -n test0 -t pblk -b 0 -e 7 -f
> >>>>>>>>>>>> 2. Write 5GB to the test0 block device with a normal fio script
> >>>>>>>>>>>> 3. Read 5GB to verify that latencies are good (max. ~80-90us at bs=4k, qd=1)
> >>>>>>>>>>>> 4. Re-run 3. and in parallel send a command through liblightnvm to a
> >>>>>>>>>>>> different channel. A simple command is an erase (erase block 900 on
> >>>>>>>>>>>> channel 2, lun 0):
> >>>>>>>>>>>> 	sudo nvm_vblk line_erase /dev/nvme0n1 2 2 0 0 900
> >>>>>>>>>>>> 
> >>>>>>>>>>>> After 4. you should see a ~25-30ms latency on the read workload.
> >>>>>>>>>>>> 
> >>>>>>>>>>>> I tried to reproduce the ioctl in a more generic way to reach
> >>>>>>>>>>>> __nvme_submit_user_cmd(), but SPDK steals the whole device. Also, qemu
> >>>>>>>>>>>> is not reliable for this kind of performance testing.
> >>>>>>>>>>>> 
> >>>>>>>>>>>> If you have a suggestion on how I can mix an ioctl with normal block I/O
> >>>>>>>>>>>> read on a standard NVMe device, I'm happy to try it and see if I can
> >>>>>>>>>>>> reproduce the issue.
> >>>>>>>>>>> 
> >>>>>>>>>>> Just to rule out this being any hardware related delays in processing
> >>>>>>>>>>> IO:
> >>>>>>>>>>> 
> >>>>>>>>>>> 1) Does it reproduce with a simpler command, anything close to a no-op
> >>>>>>>>>>> that you can test?
> >>>>>>>>>> 
> >>>>>>>>>> Yes. I tried with a 4KB read and with a fake command I drop right after
> >>>>>>>>>> allocation.
> >>>>>>>>>> 
> >>>>>>>>>>> 2) What did you use to time the stall being blk_queue_enter()?
> >>>>>>>>>> 
> >>>>>>>>>> I have some debug code measuring time with ktime_get() in different
> >>>>>>>>>> places in the stack, and among other places, around blk_queue_enter(). I
> >>>>>>>>>> use them then to measure max latency and expose it through sysfs. I can
> >>>>>>>>>> see that the latency peak is recorded in the probe before
> >>>>>>>>>> blk_queue_enter() and not in the one after.
> >>>>>>>>>> 
> >>>>>>>>>> I also did an experiment, where the normal I/O path allocates the
> >>>>>>>>>> request with BLK_MQ_REQ_NOWAIT. When running the experiment above, the
> >>>>>>>>>> read test fails since we reach:
> >>>>>>>>>> 	if (nowait)
> >>>>>>>>>> 	  return -EBUSY;
> >>>>>>>>>> 
> >>>>>>>>>> in blk_queue_enter.
> >>>>>>>>> 
> >>>>>>>>> OK, that's starting to make more sense, that indicates that there is indeed
> >>>>>>>>> something wrong with the refs. Does the below help?
> >>>>>>>> 
> >>>>>>>> No, that can't be right, it does look balanced to begin with.
> >>>>>>>> blk_mq_alloc_request() always grabs a queue ref, and always drops it. If
> >>>>>>>> we return with a request succesfully allocated, then we have an extra
> >>>>>>>> ref on it, which is dropped when it is later freed.
> >>>>>>> 
> >>>>>>> I agree, it seems more like a reference is put too late. I looked into
> >>>>>>> into the places where the reference is put, but it all seems normal. In
> >>>>>>> any case, I run it (just to see), and it did not help.
> >>>>>>> 
> >>>>>>>> Something smells fishy, I'll dig a bit.
> >>>>>>> 
> >>>>>>> Thanks! I continue looking into it myself; let me know if I can help
> >>>>>>> with something more specific.
> >>>>>> 
> >>>>>> What exact kernel are you running? And does the device have a scheduler
> >>>>>> attached, or is it set to "none"?
> >>>>> 
> >>>>> I can reproduce the issue on 4.11-rc7. I will rebase on top of your
> >>>>> for-4.12/block, but I cannot see any patches that might be related. If
> >>>>> it changes I'll ping you.
> >>>> 
> >>>> I don't suspect it will do anything for you. I just ask to know what
> >>>> base you are on.
> >>>> 
> >>>>> I mentioned the problem to Christoph last week and disabling the
> >>>>> schedulers was the first thing he recommended. I measured time around
> >>>>> blk_mq_sched_get_request and for this particular test the choose of
> >>>>> scheduler (including BFQ and kyber) does not seem to have an effect.
> >>>> 
> >>>> kyber vs none would be the interesting test. Some of the paths are a
> >>>> little different depending if there's a scheduler attached or not, so
> >>>> it's good to know that we're seeing this in both cases.
> >>> 
> >>> I just tested on your for-4.12/block with none and kyber and the latency
> >>> spike appears in both cases.
> >> 
> >> OK good. I looked at your reproduction case. Looks like we ultimately
> >> end up submitting IO through nvme_nvm_submit_user_cmd() when you do the
> >> nvm_vblk line_erase, which is basically the same code as
> >> NVME_IOCTL_SUBMIT_IO as far as request alloc, setup, issue, free goes.
> >> So does it reproduce for you as well on a normal nvme device, if you run
> >> a nvme read /dev/nvme0 [...] while running the same read fio job?
> > 
> > Ok. I'll try that.
> 
> I cannot reproduce the latency on a normal nvme drive when mixing I/O
> from a fio job and ioctls.
> 
> The path is different from the one in pblk, since normal block I/O
> uses the generic_make_request(), but still, they both need to
> blk_queue_enter(), allocate a request, etc. They only "major" difference
> I see is that normal block I/O requests are given by get_request()
> (which as far as I understand takes pre-allocated requests from the
> queue request list), while pblk allocates each request via
> nvme_alloc_request().
> 
> What puzzles me most is that having different pblk instances, issuing
> I/O in parallel does not trigger the long tail. Otherwise, I would think
> that we are just unlucky and get scheduled out. Still, 20ms...
> 
> BTW, in order to discard NUMA, I tried on a single socket machine, and
> same, same.

I suspect the .q_usage_counter is DEAD, and you can check it via
percpu_ref_is_dying(), or just check if slow path is reached.

The fast path is that percpu_ref_tryget_live() returns directly,
and slow path is reached only if queue is freezed or dead.

If that is true, you can add a dump_stack() in blk_freeze_queue_start()
to see where the unusual freezing/unfreezing is from.

Thanks,
Ming

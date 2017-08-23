Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 00/20] blk-mq-sched: improve SCSI-MQ performance
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "loberman@redhat.com" <loberman@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <1503504725.2484.7.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e4d3c5f1-5db1-0c9a-b801-99089a16199b@kernel.dk>
Date: Wed, 23 Aug 2017 10:15:29 -0600
MIME-Version: 1.0
In-Reply-To: <1503504725.2484.7.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/23/2017 10:12 AM, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
>> In Red Hat internal storage test wrt. blk-mq scheduler, we
>> found that I/O performance is much bad with mq-deadline, especially
>> about sequential I/O on some multi-queue SCSI devcies(lpfc, qla2xxx,
>> SRP...)
> 
> Hello Ming and Jens,
> 
> There may not be enough time left to reach agreement about the whole patch
> series before the kernel v4.14 merge window opens. How about focusing on
> patches 1..8 of this series for kernel v4.14 and revisiting the rest of this
> patch series later?

I was going to go over the series today with 4.14 in mind. Looks to me like
this should really be 2-3 patch series, that depend on each other. Might be
better for review purposes as well. So I'd agree with Bart - can we get this
split a bit and geared towards what we need for 4.14 at least, since it's
getting close. And some of the changes do make me somewhat nervous, they
need proper cooking time.

-- 
Jens Axboe

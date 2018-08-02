Return-Path: <prvs=7457c2e9b=Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v3 4/9] percpu-refcount: Introduce percpu_ref_read()
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Jianchao Wang <jianchao.w.wang@oracle.com>,
 Ming Lei <ming.lei@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
 <20180802182944.14442-5-bart.vanassche@wdc.com>
 <20180802190649.GV1206094@devbig004.ftw2.facebook.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <aa524e89-6626-ed22-ff46-25674354ba58@wdc.com>
Date: Thu, 2 Aug 2018 13:04:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180802190649.GV1206094@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 08/02/18 12:06, Tejun Heo wrote:
> On Thu, Aug 02, 2018 at 11:29:39AM -0700, Bart Van Assche wrote:
>> Introduce a function that allows to read the value of a per-cpu counter.
>> This function will be used in the next patch to check whether a per-cpu
>> counter in atomic mode has the value one.
> 
> I'm not a big fan of exposing this.  If you need to test for atomic &&
> 1, I'd much prefer a helper specifically testing for that.  But can
> you please explain a bit why you need this?
Hello Tejun,

As you probably know one of the long term goals for the block layer is 
to switch to blk-mq and to drop the legacy block layer. Hence this patch 
series that adds support for runtime power management to blk-mq because 
today that feature is missing from blk-mq. The approach is the same as 
for the legacy block layer: if the autosuspend timer expires and no
requests are in flight, suspend the block device. So we need a mechanism 
to track whether or not any requests are in flight. One possible 
approach is to check the value of q_usage_counter. percpu_ref_is_zero() 
could only be used to check q_usage_counter if that counter would be 
switched to atomic mode first and if the initial reference would be 
dropped too. I want to avoid the overhead of that switch to atomic mode 
whenever possible. Hence the proposal to introduce the percpu_ref_read() 
function. If the value returned by that function is larger than one then 
we know that requests are in flight and hence that the switch to atomic 
mode can be skipped.

Proposals for alternative approaches are welcome.

Thanks,

Bart.

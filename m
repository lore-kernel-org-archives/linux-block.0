Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: Oops when completing request on the wrong queue
References: <87a8gltgks.fsf@linux.vnet.ibm.com>
 <871t1kq455.fsf@linux.vnet.ibm.com>
 <bb6f8757-4c3d-8f49-8aff-aa0fdb8bae89@kernel.dk>
 <8fc9ae38-9488-ef52-f620-08499edebffa@kernel.dk>
 <87shu0hfye.fsf@linux.vnet.ibm.com>
 <87a8g39pg4.fsf@linux.vnet.ibm.com>
 <43693064-dd37-92ce-7753-2a8edb43eab5@kernel.dk>
 <164a4c63-065b-b766-36f3-bcef4aa46a38@kernel.dk>
 <49a954e6-2f96-8a63-ce15-2c82c1a1d36d@kernel.dk>
 <dbe42007-8109-2e21-d0f3-0778007cd152@kernel.dk>
 <87d1krzbz6.fsf@linux.vnet.ibm.com>
 <5902c166-7aec-b2ae-72d7-07e8efeb5aa9@kernel.dk>
Date: Mon, 05 Sep 2016 09:02:56 -0300
In-Reply-To: <5902c166-7aec-b2ae-72d7-07e8efeb5aa9@kernel.dk> (Jens Axboe's
 message of "Mon, 29 Aug 2016 12:40:32 -0600")
MIME-Version: 1.0
Message-Id: <87mvjmzh8v.fsf@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Brian King <brking@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> On 08/29/2016 12:06 PM, Gabriel Krisman Bertazi wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>>> Can you try this patch? It's not perfect, but I'll be interested if it
>>>> makes a difference for you.
>>>
>>
>> Hi Jens,
>>
>> Sorry for the delay.  I just got back to this and have been running your
>> patch on top of 4.8 without a crash for over 1 hour.  I wanna give it
>> more time to make sure it's running properly, though.
>>
>> Let me get back to you after a few more rounds of test.
>
> Thanks, sounds good. The patches have landed in mainline too.

Hi Jens,

Our test teams ran stress tests on several machines over the last week
on a test kernel with your patches applied, and were no longer able to
reproduce the issue.

Thanks a lot for helping out on this one.

>>> This one should handle the WARN_ON() for running the hw queue on the
>>> wrong CPU as well.
>>
>> On the workaround you added to prevent WARN_ON, we surely need to
>> prevent blk_mq_hctx_next_cpu from scheduling dead cpus in the first
>> place, right..  How do you feel about the following RFC?  I know it's
>> not a complete fix, but it feels like a good improvement to me.
>>
>> http://www.spinics.net/lists/linux-scsi/msg98608.html
>
> But we can't completely prevent it, and I don't think we have to. I just
> don't want to trigger a warning for something that's a valid condition.
> I want the warning to trigger if this happens without the CPU going
> offline, since then it's indicative of a real bug in the mapping. Your
> patch isn't going to prevent it either - it'll shrink the window, at the
> expense of making blk_mq_hctx_next_cpu() more expensive. So I don't
> think it's worthwhile.

Right, I got your point.  Your patch definitely prevents the WARN_ON
from occurring on CPU hotplug events too.  So thanks a lot for help on
that too :)

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

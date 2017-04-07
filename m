Return-Path: <hare@suse.de>
Subject: Re: [PATCHv6 2/2] loop: support 4k physical blocksize
To: Ming Lei <ming.lei@redhat.com>
References: <1491548338-71005-1-git-send-email-hare@suse.de>
 <1491548338-71005-3-git-send-email-hare@suse.de>
 <20170407093428.GA27631@ming.t460p>
 <2aa7767b-b8e4-1d54-0752-63253283ad5c@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a03c7c2e-9f21-5123-eae4-1001dfc0b267@suse.de>
Date: Fri, 7 Apr 2017 11:52:27 +0200
MIME-Version: 1.0
In-Reply-To: <2aa7767b-b8e4-1d54-0752-63253283ad5c@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/07/2017 11:38 AM, Hannes Reinecke wrote:
> On 04/07/2017 11:34 AM, Ming Lei wrote:
>> On Fri, Apr 07, 2017 at 08:58:58AM +0200, Hannes Reinecke wrote:
>>> When generating bootable VM images certain systems (most notably
>>> s390x) require devices with 4k blocksize. This patch implements
>>> a new flag 'LO_FLAGS_BLOCKSIZE' which will set the physical
>>> blocksize to that of the underlying device, and allow to change
>>> the logical blocksize for up to the physical blocksize.
>>
>> Actually this UAPI flag is only for setting logical block size. 
>>
> Hmm? No, we're setting the physical blocksize, too.
> Or am I missing something?
> 
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>>> ---
>>>  drivers/block/loop.c      | 36 +++++++++++++++++++++++++++++++-----
>>>  drivers/block/loop.h      |  1 +
>>>  include/uapi/linux/loop.h |  3 +++
>>>  3 files changed, 35 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>> index 81b3900..f098681 100644
>>> --- a/drivers/block/loop.c
>>> +++ b/drivers/block/loop.c
>>> @@ -221,7 +221,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>>>  }
>>>  
>>>  static int
>>> -figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
>>> +figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit,
>>> +		 loff_t logical_blocksize)
>>>  {
>>>  	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
>>>  	sector_t x = (sector_t)size;
>>> @@ -233,6 +234,12 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>>>  		lo->lo_offset = offset;
>>>  	if (lo->lo_sizelimit != sizelimit)
>>>  		lo->lo_sizelimit = sizelimit;
>>> +	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE) {
>>> +		lo->lo_logical_blocksize = logical_blocksize;
>>> +		blk_queue_physical_block_size(lo->lo_queue, lo->lo_blocksize);
>>> +		blk_queue_logical_block_size(lo->lo_queue,
>>> +					     lo->lo_logical_blocksize);
>>> +	}
>>
>> We can move setting physical block size into loop_set_fd(), and set
>> 512 bytes as default logical block size in loop_set_fd() too.
>>
> Okay.
> 
After thinking about it some more I'm not sure if I agree with that
reasoning.

One of the goals of this patchset is to keep compability with existing
installations.
If we move setting the physical blocksize into loop_set_fd() (which
needs to be called before loop_set_status()) the physical blocksize
would always be set.
Which would induce a user-visible change.

Hence I've formulated my patch to _not_ change the default setup if the
new flag isn't set.

If this is of no concern, however, I can easily modify the patch to
always set the physical blocksize; in fact, that's what I did
originally, but that was deemed bad style.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)

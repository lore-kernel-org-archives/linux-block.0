Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
 <20170617122106.GB8320@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
Date: Sat, 17 Jun 2017 08:20:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170617122106.GB8320@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/17/2017 06:21 AM, Christoph Hellwig wrote:
> On Fri, Jun 16, 2017 at 01:41:36PM -0600, Jens Axboe wrote:
>> But honestly, I simply don't care too much about it, for a few reasons:
>>
>> 1) I don't know of anyone that uses name spaces to split up a device,
>>    except for places where the want integrity on one and not the other.
>>    And I haven't even seen that.
>>
>> 2) If you do have multiple name spaces, you get some data separation
>>    through that. Or not, depending on the device.
>>
>> In any case, we'll just have to divide up the streams. Right now we just
>> allocate 4 in a first-come first-serve basis. If you have more name
>> spaces than streams/4, then some name spaces don't get streams. We could
>> make this more fair and do:
> 
> Or just not reserve streams for exclusive use of the namespace and
> use them directly from the global pool.  Especially if you ever want
> to use streams with shared disk filesystems or databases you'd have
> to do that anyway.  And due to our hardcoded streams values that
> will in fact work nicely.  And it would get rid of the lazy setup
> code as well.

We can certainly go that route. So you'd be fine with allocating 4
streams controller wide by default, and dump the lazy alloc? We can make
this depend on the streams module parameter, so people could turn it
off, if needed.

>>> "If the host issues a Dataset Management command to deallocate logical
>>>  blocks that are associated with a stream, it should specify a starting
>>>  LBA and length that is aligned to and in multiples of the Stream
>>>  Granularity Size"
>>
>> Do we use that internally?
> 
> I don't understand the comment.  If we issue a deallocate (discard)
> we should align it to the Stream Granularity Size as exposed by the
> device, easy enough.  While we're at it we should probably also
> expose the Stream Write Size as io_min and the Stream Granularity Size
> as io_opt in our I/O topology information while at it.

OK, that's easy enough to do, if we enable streams on a controller basis
at probe time.

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
 <20170617122106.GB8320@infradead.org>
 <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
 <20170617150303.GA15290@infradead.org>
 <b159f6cb-a272-cd06-207a-4cce8336c86d@kernel.dk>
 <20170619062557.GA2311@infradead.org>
 <03b922f9-677e-9618-663e-09f023977fa8@kernel.dk>
Message-ID: <0e920111-7846-f7f6-2288-e375f6a43843@kernel.dk>
Date: Mon, 19 Jun 2017 08:53:08 -0600
MIME-Version: 1.0
In-Reply-To: <03b922f9-677e-9618-663e-09f023977fa8@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 08:31 AM, Jens Axboe wrote:
> On 06/19/2017 12:25 AM, Christoph Hellwig wrote:
>> On Sat, Jun 17, 2017 at 09:11:30AM -0600, Jens Axboe wrote:
>>> I have two samples here, and I just tested, and both of them want it
>>> assigned with nsid=0xffffffff or they will fail the writes... So I'd say
>>> we're better off ensuring we do allocate them globally.
>>
>> That's clearly against the spec.  I'd say go to your vendor and get
>> a refund, as we Linux folks (Martin and I) fought for this so that
>> we would not have to do the explicit allocations.
>>
>> Another quote for from the spec:
>>
>> "Streams are opened by the controller when the host issues a write
>>  command that specifies a stream identifier that is not currently open.
>>  While a stream is open the controller maintains context for that stream
>>  (e.g., buffers for associated data). The host may determine the streams 
>>  that are open using the Get Status operation."
>>
>> And I think this is very important - otherwise you need to either
>> allocate the stremas beforehand as your earlier patches (and we take
>> away the resources from the 99% of the users not using write life
>> hints), or we need the lazy allocation scheme.  And for that to be
>> efficient it probably needs to be lazy per-stream allocation.  That's
>> why we got the implicit open in after all.
> 
> These are just samples, so no refund possible! As you might remember,
> I was pretty adamant on not wanting explicit open/close as well, back
> in those days. I'll check with the vendor and see what's going on.

Looking at it a bit more closely - there's a difference between
assigning X number of streams (allocating) for use by the subsystem or
per-ns, and having to manually open them. So I don't necessarily think
there's a problem here, neither for us or on the device.

If I load the driver as it currently stands, and get streams params
after load:

	Number of Open Streams in NVM subsystem  (NOSNS): 0
	Allocated Stream Resources                 (ASR): 4
	Number of Open Streams in Namespace       (NOSN): 0

4 streams allocated, 0 currently open. Then I generate a single write to
some stream ID:

	Number of Open Streams in NVM subsystem  (NOSNS): 1
	Allocated Stream Resources                 (ASR): 4
	Number of Open Streams in Namespace       (NOSN): 1

and we know see a single stream actually open, implicitly, by the
device. Fire off another single stream write, this time to another
stream, and we get:

	Number of Open Streams in NVM subsystem  (NOSNS): 2
	Allocated Stream Resources                 (ASR): 4
	Number of Open Streams in Namespace       (NOSN): 2

and stream status correctly reflects that I did a WRITE_HINT_SHORT and
WRITE_HINT_LONG write:

	Open Stream Count  : 2
	Stream Identifier 000001 : 1
	Stream Identifier 000002 : 3

Awaiting clarification from the vendor what their position/view of this
is. Reading the spec, I do agree that it leans towards only needing
allocation for a specific name space, but it doesn't explicitly say that
you can use any of the available streams, without allocation, if they
haven't been assigned to a specific name space. I would interpret it
that way, though.

-- 
Jens Axboe

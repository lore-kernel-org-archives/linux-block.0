Return-Path: <axboe@kernel.dk>
Subject: Re: ->retries fixups V2
To: Christoph Hellwig <hch@lst.de>
References: <20170405171812.19911-1-hch@lst.de>
 <20170405180653.GA5548@kernel.dk> <20170405181605.GA9702@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3d389bc8-9de9-f523-f1b3-3e1d4a3d4dba@kernel.dk>
Date: Wed, 5 Apr 2017 12:18:07 -0600
MIME-Version: 1.0
In-Reply-To: <20170405181605.GA9702@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/05/2017 12:16 PM, Christoph Hellwig wrote:
> On Wed, Apr 05, 2017 at 12:06:53PM -0600, Jens Axboe wrote:
>> On Wed, Apr 05 2017, Christoph Hellwig wrote:
>>> This series fixes a few lose bits in terms of how nvme uses ->retries,
>>> including fixing it for non-PCIe transports.  While at it I noticed that
>>> nvme and scsi use the field in entirely different ways, and no other
>>> driver uses it at all.  So I decided to move it into the nvme_request and
>>> scsi_request structures instead.
>>>
>>> Changes since V1:
>>>  - better changelog for one patch
>>>  - move the new retries field to the end of struct nvme_request
>>
>> Applied for 4.12. If we do the below on my box, we remove the (now) 2
>> holes from struct request and shrink it 8 bytes.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, added that too.

-- 
Jens Axboe

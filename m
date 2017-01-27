Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 05/18] block: allow specifying size for extra command data
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
 <1485365126-23210-6-git-send-email-hch@lst.de> <yq160l2a4us.fsf@oracle.com>
 <20170127161254.GA16557@lst.de> <1485537668.4267.7.camel@sandisk.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <05d94df5-0ed8-5c3a-d6a6-7e9418366bb1@fb.com>
Date: Fri, 27 Jan 2017 10:26:28 -0700
MIME-Version: 1.0
In-Reply-To: <1485537668.4267.7.camel@sandisk.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 01/27/2017 10:21 AM, Bart Van Assche wrote:
> On Fri, 2017-01-27 at 17:12 +0100, Christoph Hellwig wrote:
>> On Wed, Jan 25, 2017 at 10:15:55PM -0500, Martin K. Petersen wrote:
>>> +static void *alloc_request_size(gfp_t gfp_mask, void *data)
>>>
>>> I like alloc_request_simple() but alloc_request_size() seems a bit
>>> contrived. _reserve? _extra? _special? Don't have any good suggestions,
>>> I'm afraid.
>>
>> Not that I'm a fan of _size, but I like the other suggestions even less.
> 
> Hello Christoph and Martin,
> 
> How about using the function names alloc_full_request() / free_full_request()
> together with a comment that mentions that cmd_size is set by the LLD?

Since we use pdu in other places, how about alloc_request_pdu() or
alloc_request_with_pdu()?

And since it's all queued up, any bike shedding changes will have to be
incremental.

-- 
Jens Axboe


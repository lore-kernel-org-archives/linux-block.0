Return-Path: <axboe@kernel.dk>
Subject: Re: Block device integrity support
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1496440434.1214.23.camel@sandisk.com>
 <yq1lgpahvtp.fsf@oracle.com> <1496443127.1214.27.camel@sandisk.com>
 <d0bfe2ea-6d77-e7cd-eebd-3f8471c47fcb@kernel.dk>
 <20170603073244.GA23235@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17329e00-ab17-0036-d152-4ca1b3cce520@kernel.dk>
Date: Sat, 3 Jun 2017 06:37:41 -0700
MIME-Version: 1.0
In-Reply-To: <20170603073244.GA23235@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/03/2017 12:32 AM, Christoph Hellwig wrote:
> On Fri, Jun 02, 2017 at 03:52:57PM -0700, Jens Axboe wrote:
>> On 06/02/2017 03:38 PM, Bart Van Assche wrote:
>>> On Fri, 2017-06-02 at 18:24 -0400, Martin K. Petersen wrote:
>>>>> then the output shown below appears in the kernel log. Does anyone know how
>>>>> to fix this? Sorry but I'm not really familiar with the integrity
>>>>> code.
>>>>
>>>> Dmitry posted a fix for this a few weeks ago.
>>>
>>> Ah, that's right. Jens, had you noticed this message:
>>> https://www.spinics.net/lists/fstests/msg06214.html?
>>
>> No, unfortunately not. I'll queue it up for 4.13 and mark it
>> stable for 4.12.
> 
> Can we please get it into 4.12-rc?

Yes of course, that's actually what I did. I just got the version
numbers mixed up.

-- 
Jens Axboe

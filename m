Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] Add support for write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, adilger@dilger.ca
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0eba0cf8-2a3c-27b9-9689-2f62a358ca72@kernel.dk>
Date: Wed, 14 Jun 2017 10:02:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170614160127.GA30644@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 10:01 AM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2017 at 09:53:05AM -0600, Jens Axboe wrote:
>> So how about we just call it "write_hint"? It sounds mostly like a
>> naming issue to me, as you would then map that to some specific stream
>> in your driver. You're free to do that right now. They are all flags,
>> it's just packed as a value to not waste too much space.
> 
> I think what Martin wants (or at least what I'd want him to want) is
> to define a few REQ_* bits that mirror the RWF bits, use that to
> transfer the information down the stack, and then only translate it
> to stream ids in the driver.

Sure, that's fine with me. Let me make that change.

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
 <c2e20890-16ce-a3bd-c696-c53ae14a583a@kernel.dk>
 <20161117125037.GB14814@infradead.org>
 <204d4a18-e5da-1806-433e-a3ff1b6ca575@kernel.dk>
 <87823f67-a2ec-e959-1a23-9ecf3d6fe6d4@kernel.dk>
 <20161117201749.GA15072@infradead.org>
 <721c8908-ea89-a2f4-0bfd-7243a9aa4c03@kernel.dk>
 <20161117210448.GA25566@infradead.org>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d5b16e63-9af0-5e78-35c2-3fa2f67a4f9f@kernel.dk>
Date: Thu, 17 Nov 2016 14:06:01 -0700
MIME-Version: 1.0
In-Reply-To: <20161117210448.GA25566@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/17/2016 02:04 PM, Christoph Hellwig wrote:
> On Thu, Nov 17, 2016 at 01:30:12PM -0700, Jens Axboe wrote:
>> The last patch seems to have some issues:
>>
>> +       bool is_sync = is_sync = is_sync_kiocb(iocb);
>>
>> and it's reverting part of the dio->is_sync that was part of my union
>> waiter/iocb change. So I'll leave that out for now, for those reasons.
>
> dio->is_sync isn't needed once the completion handlers are split.
> That beeing said I wonder how the above statement even compiled,
> there should just be a single assignment obviously.
>
> Did I mention that I don't like the split anyway? :)

Alright alright, let's drop the split ;-)

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] Add support for write life time hints
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org> <yq1shj2tv1z.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8af0fc32-d6f3-e42d-0f31-af51bbd4f007@kernel.dk>
Date: Wed, 14 Jun 2017 10:26:33 -0600
MIME-Version: 1.0
In-Reply-To: <yq1shj2tv1z.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 10:04 AM, Martin K. Petersen wrote:
> 
> Christoph,
> 
>> I think what Martin wants (or at least what I'd want him to want) is
>> to define a few REQ_* bits that mirror the RWF bits, use that to
>> transfer the information down the stack, and then only translate it
>> to stream ids in the driver.
> 
> Yup. If we have enough space in the existing flags that's perfect (I
> lost count after your op/flag shuffle).

There are enough flags, I just implemented it. I'll run some testing
and rebase everything, then send out a v3...

-- 
Jens Axboe

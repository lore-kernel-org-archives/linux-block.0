Return-Path: <axboe@kernel.dk>
Subject: Re: Block device integrity support
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1496440434.1214.23.camel@sandisk.com>
 <yq1lgpahvtp.fsf@oracle.com> <1496443127.1214.27.camel@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d0bfe2ea-6d77-e7cd-eebd-3f8471c47fcb@kernel.dk>
Date: Fri, 2 Jun 2017 15:52:57 -0700
MIME-Version: 1.0
In-Reply-To: <1496443127.1214.27.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/02/2017 03:38 PM, Bart Van Assche wrote:
> On Fri, 2017-06-02 at 18:24 -0400, Martin K. Petersen wrote:
>>> then the output shown below appears in the kernel log. Does anyone know how
>>> to fix this? Sorry but I'm not really familiar with the integrity
>>> code.
>>
>> Dmitry posted a fix for this a few weeks ago.
> 
> Ah, that's right. Jens, had you noticed this message:
> https://www.spinics.net/lists/fstests/msg06214.html?

No, unfortunately not. I'll queue it up for 4.13 and mark it
stable for 4.12.

-- 
Jens Axboe

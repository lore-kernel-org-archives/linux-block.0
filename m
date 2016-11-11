Return-Path: <axboe@kernel.dk>
Subject: Re: Regression: nvme timeouts and oopses
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <af308491-a381-f13d-2d87-89bbca68d99e@kernel.dk>
 <50342d6b-e185-d125-c04c-e72d6fc45ccd@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <99eec845-06d2-4871-4365-0064de1995e7@kernel.dk>
Date: Fri, 11 Nov 2016 12:28:51 -0700
MIME-Version: 1.0
In-Reply-To: <50342d6b-e185-d125-c04c-e72d6fc45ccd@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/11/2016 12:23 PM, Bart Van Assche wrote:
> On 11/11/2016 10:47 AM, Jens Axboe wrote:
>> I've been running into problems when stability testing my 4.10 branch,
>
> Hello Jens,
>
> Can you try the patch below instead of the revert?

See my mails from earlier.

-- 
Jens Axboe

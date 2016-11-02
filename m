Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
To: Christoph Hellwig <hch@lst.de>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
 <20161102145239.GB13964@lst.de>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <1954bf49-eeff-0b16-3cf9-7d7d02f25562@fb.com>
Date: Wed, 2 Nov 2016 08:55:16 -0600
MIME-Version: 1.0
In-Reply-To: <20161102145239.GB13964@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/02/2016 08:52 AM, Christoph Hellwig wrote:
> On Tue, Nov 01, 2016 at 03:05:22PM -0600, Jens Axboe wrote:
>> For legacy block, we simply track them in the request queue. For
>> blk-mq, we track them on a per-sw queue basis, which we can then
>> sum up through the hardware queues and finally to a per device
>> state.
>
> what is the use case for the legacy request tracking?

Buffered writeback code uses the same base. Additionally, it could
replace some user space tracking for latency outliers that people are
currently running.

-- 
Jens Axboe

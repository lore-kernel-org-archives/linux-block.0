Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 1/3] blk-mq: allocate blk_mq_tags and requests in
 correct node
To: Shaohua Li <shli@fb.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
 <b41e8f74-007d-c818-4915-3ea3b7c229b5@fb.com>
Cc: bhelgaas@google.com, hch@lst.de
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fa1eaadf-db72-a642-a917-3f633af2ca55@kernel.dk>
Date: Fri, 24 Feb 2017 15:23:50 -0700
MIME-Version: 1.0
In-Reply-To: <b41e8f74-007d-c818-4915-3ea3b7c229b5@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/01/2017 12:09 PM, Jens Axboe wrote:
> On 02/01/2017 09:53 AM, Shaohua Li wrote:
>> blk_mq_tags/requests of specific hardware queue are mostly used in
>> specific cpus, which might not be in the same numa node as disk. For
>> example, a nvme card is in node 0. half hardware queue will be used by
>> node 0, the other node 1.
> 
> All three patches look good to me. Bjorn, to avoid complications, if
> you can review/ack patch #2, then I will queue it up through the block
> tree for 4.11.

Bjorn, ping. You were CC'ed on the original patch three weeks ago.

-- 
Jens Axboe

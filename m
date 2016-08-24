Subject: Re: [PATCH v4] block: make sure big bio is splitted into at most 256
 bvecs
To: Ming Lei <ming.lei@canonical.com>, linux-kernel@vger.kernel.org
References: <1471960185-14044-1-git-send-email-ming.lei@canonical.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Eric Wheeler <bcache@lists.ewheeler.net>,
 Sebastian Roesner <sroesner-kernelorg@roesner-online.de>,
 "4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>,
 Jens Axboe <axboe@kernel.dk>
From: Jens Axboe <axboe@fb.com>
Message-ID: <2fff8ded-6046-e810-1777-4be9cbb029d6@fb.com>
Date: Wed, 24 Aug 2016 08:17:51 -0600
MIME-Version: 1.0
In-Reply-To: <1471960185-14044-1-git-send-email-ming.lei@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/23/2016 07:49 AM, Ming Lei wrote:
> After arbitrary bio size is supported, the incoming bio may
> be very big. We have to split the bio into small bios so that
> each holds at most BIO_MAX_PAGES bvecs for safety reason, such
> as bio_clone().
>
> This patch fixes the following kernel crash:
>
>> [  172.660142] BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
>> [  172.660229] IP: [<ffffffff811e53b4>] bio_trim+0xf/0x2a
>> [  172.660289] PGD 7faf3e067 PUD 7f9279067 PMD 0
>> [  172.660399] Oops: 0000 [#1] SMP
>> [...]
>> [  172.664780] Call Trace:
>> [  172.664813]  [<ffffffffa007f3be>] ? raid1_make_request+0x2e8/0xad7 [raid1]
>> [  172.664846]  [<ffffffff811f07da>] ? blk_queue_split+0x377/0x3d4
>> [  172.664880]  [<ffffffffa005fb5f>] ? md_make_request+0xf6/0x1e9 [md_mod]
>> [  172.664912]  [<ffffffff811eb860>] ? generic_make_request+0xb5/0x155
>> [  172.664947]  [<ffffffffa0445c89>] ? prio_io+0x85/0x95 [bcache]
>> [  172.664981]  [<ffffffffa0448252>] ? register_cache_set+0x355/0x8d0 [bcache]
>> [  172.665016]  [<ffffffffa04497d3>] ? register_bcache+0x1006/0x1174 [bcache]
>
> The issue can be reproduced by the following steps:
> 	- create one raid1 over two virtio-blk
> 	- build bcache device over the above raid1 and another cache device
> 	and bucket size is set as 2Mbytes
> 	- set cache mode as writeback
> 	- run random write over ext4 on the bcache device

Applied for 4.8, thanks.

-- 
Jens Axboe

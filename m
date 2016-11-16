Subject: Re: [PATCH] block: deal with stale req count of plug list
To: Ming Lei <ming.lei@canonical.com>, linux-kernel@vger.kernel.org
References: <1479290825-23201-1-git-send-email-ming.lei@canonical.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Shaohua Li <shli@fb.com>, Jens Axboe <axboe@kernel.dk>
From: Jens Axboe <axboe@fb.com>
Message-ID: <320f5131-f61a-9a33-31f4-b510857a4a30@fb.com>
Date: Wed, 16 Nov 2016 08:10:18 -0700
MIME-Version: 1.0
In-Reply-To: <1479290825-23201-1-git-send-email-ming.lei@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/16/2016 03:07 AM, Ming Lei wrote:
> In both legacy and mq path, req count of plug list is computed
> before allocating request, so the number can be stale when falling
> back to slept allocation, also the new introduced wbt can sleep
> too.
>
> This patch deals with the case by checking if plug list becomes
> empty, and fixes the KASAN report of 'BUG: KASAN: stack-out-of-bounds'
> which is introduced by Shaohua's patches of dispatching big request.

Thanks Ming, added for 4.10.

-- 
Jens Axboe

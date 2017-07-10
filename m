Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] block: call bio_uninit in bio_endio
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <d0186f22982fb49e88bd5ee2273ba90946318ba5.1499711846.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9c38ce23-0f63-b03a-66d6-42d524cdb9fe@kernel.dk>
Date: Mon, 10 Jul 2017 12:44:01 -0600
MIME-Version: 1.0
In-Reply-To: <d0186f22982fb49e88bd5ee2273ba90946318ba5.1499711846.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/10/2017 12:40 PM, Shaohua Li wrote:
> bio_free isn't a good place to free cgroup info. There are a
> lot of cases bio is allocated in special way (for example, in stack) and
> never gets called by bio_put hence bio_free, we are leaking memory. This
> patch moves the free to bio endio, which should be called anyway. The
> bio_uninit call in bio_free is kept, in case the bio never gets called
> bio endio.
> 
> This assumes ->bi_end_io() doesn't access cgroup info, which seems true
> in my audit.
> 
> This along with Christoph's integrity patch should fix the memory leak
> issue.

Applied, thanks Shaohua.

-- 
Jens Axboe

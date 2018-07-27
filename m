Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/9] bcache patches for Linux v4.19
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180726041741.1669-1-colyli@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1fada353-9f5b-887a-9815-64b8c65fecc9@kernel.dk>
Date: Fri, 27 Jul 2018 09:16:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180726041741.1669-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/25/18 10:17 PM, Coly Li wrote:
> Hi Jenns,
> 
> Here is the first wave bcache patches for Linnux v4.19.
> 
> Florian Schmaus contributes useful chagnes for code cleanup, and
> Arnd Bergmann replaces get_seconds() by ktime_get_real_seconds(). 
> 
> Shenghui Wang contributes a patch to fix a memory leak in bcache. And
> patches from Tang Junhui are for recoganized performance improvement,
> these patches are posted for monthes and good to me.
> 
> Please pick the first wave for 4.19. Thanks in advance.

Applied, thanks Coly.

-- 
Jens Axboe

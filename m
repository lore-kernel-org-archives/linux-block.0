Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: skd: fix incorrect linux/slab_def.h inclusion
To: Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bart.vanassche@wdc.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180202150326.344024-1-arnd@arndb.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ecfc1c6e-1d01-29d2-d418-b086f9089abc@kernel.dk>
Date: Fri, 2 Feb 2018 08:08:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180202150326.344024-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/2/18 8:03 AM, Arnd Bergmann wrote:
> skd includes slab_def.h to get access to the slab cache object size.
> However, including this header breaks when we use SLUB or SLOB instead of
> the SLAB allocator, since the structure layout is completely different,
> as shown by this warning when we build this driver in one of the invalid
> configurations with link-time optimizations enabled:
> 
> include/linux/slab.h:715:0: error: type of 'kmem_cache_size' does not match original declaration [-Werror=lto-type-mismatch]
>  unsigned int kmem_cache_size(struct kmem_cache *s);
> 
> mm/slab_common.c:77:14: note: 'kmem_cache_size' was previously declared here
>  unsigned int kmem_cache_size(struct kmem_cache *s)
>               ^
> mm/slab_common.c:77:14: note: code may be misoptimized unless -fno-strict-aliasing is used
> include/linux/slab.h:147:0: error: type of 'kmem_cache_destroy' does not match original declaration [-Werror=lto-type-mismatch]
>  void kmem_cache_destroy(struct kmem_cache *);
> 
> mm/slab_common.c:858:6: note: 'kmem_cache_destroy' was previously declared here
>  void kmem_cache_destroy(struct kmem_cache *s)
>       ^
> mm/slab_common.c:858:6: note: code may be misoptimized unless -fno-strict-aliasing is used
> include/linux/slab.h:140:0: error: type of 'kmem_cache_create' does not match original declaration [-Werror=lto-type-mismatch]
>  struct kmem_cache *kmem_cache_create(const char *name, size_t size,
> 
> mm/slab_common.c:534:1: note: 'kmem_cache_create' was previously declared here
>  kmem_cache_create(const char *name, size_t size, size_t align,>  ^
> 
> This removes the header inclusion and instead uses the kmem_cache_size()
> interface to get the size in a reliable way.

Thanks Arnd, applied.

-- 
Jens Axboe

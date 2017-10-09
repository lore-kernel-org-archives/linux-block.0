Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] skd: Use kmem_cache_free
To: Himanshu Jha <himanshujha199640@gmail.com>, bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1507498228-11878-1-git-send-email-himanshujha199640@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fb4ee10d-2ef2-663e-7b84-4b8be2d86f4c@kernel.dk>
Date: Mon, 9 Oct 2017 08:31:46 -0600
MIME-Version: 1.0
In-Reply-To: <1507498228-11878-1-git-send-email-himanshujha199640@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/08/2017 03:30 PM, Himanshu Jha wrote:
> Use kmem_cache_free instead of kfree for freeing the memory previously
> allocated with kmem_cache_zalloc/kmem_cache_alloc/kmem_cache_node.

Good catch, I wonder how long that's been there... Applied for 4.14.

-- 
Jens Axboe

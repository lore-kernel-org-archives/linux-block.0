Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: elevator: remove unneeded null check in
 elv_register()
To: John Pittman <jpittman@redhat.com>
Cc: linux-block@vger.kernel.org
References: <20180830195618.25658-1-jpittman@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c7ada2a7-c02c-9d0d-2e81-c52b292e3585@kernel.dk>
Date: Thu, 30 Aug 2018 14:00:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180830195618.25658-1-jpittman@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/30/18 1:56 PM, John Pittman wrote:
> Since commit 3942d2991852 ("mm/slab_common: allow NULL cache
> pointer in kmem_cache_destroy()"), the kmem_cache_destroy()
> function has been able to handle null pointers.  Remove NULL
> check against e->icq_cache in elv_register(), simplifying the code.

You're the 3rd person sending in this patch this week :-)

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=62d2a1940709198a522a43ff8be8b8f6b3654dec

-- 
Jens Axboe

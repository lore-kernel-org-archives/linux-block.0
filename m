Return-Path: <jpittman@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c7ada2a7-c02c-9d0d-2e81-c52b292e3585@kernel.dk>
References: <20180830195618.25658-1-jpittman@redhat.com> <c7ada2a7-c02c-9d0d-2e81-c52b292e3585@kernel.dk>
From: John Pittman <jpittman@redhat.com>
Date: Thu, 30 Aug 2018 16:02:47 -0400
Message-ID: <CA+RJvhxAgtYwxbxb2EwuqKABi17tqbeOUotATvutL6Ex916eew@mail.gmail.com>
Subject: Re: [PATCH] block: elevator: remove unneeded null check in elv_register()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Ha!  Ok, thanks for reviewing Jens.

On Thu, Aug 30, 2018 at 4:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 8/30/18 1:56 PM, John Pittman wrote:
>> Since commit 3942d2991852 ("mm/slab_common: allow NULL cache
>> pointer in kmem_cache_destroy()"), the kmem_cache_destroy()
>> function has been able to handle null pointers.  Remove NULL
>> check against e->icq_cache in elv_register(), simplifying the code.
>
> You're the 3rd person sending in this patch this week :-)
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=62d2a1940709198a522a43ff8be8b8f6b3654dec
>
> --
> Jens Axboe
>

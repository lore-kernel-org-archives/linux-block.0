Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Fix slab name "biovec-(1<<(21-12))"
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com
References: <alpine.LRH.2.02.1803211248020.26409@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8aa57856-ad92-0358-27ed-45ddc55c5b35@kernel.dk>
Date: Wed, 21 Mar 2018 19:25:53 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1803211248020.26409@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/21/18 10:49 AM, Mikulas Patocka wrote:
> I'm getting a slab named "biovec-(1<<(21-12))". It is caused by unintended
> expansion of the macro BIO_MAX_PAGES. This patch renames it to biovec-max.

Applied, thanks.

-- 
Jens Axboe

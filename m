Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] readahead: stricter check for bdi io_pages
To: stockhausen@collogia.de, linux-block@vger.kernel.org
References: <5b5a228e.MdvsdULQVpBGv+1Q%stockhausen@collogia.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6cc32466-a38a-179c-5073-56dcf33e9591@kernel.dk>
Date: Fri, 27 Jul 2018 09:08:33 -0600
MIME-Version: 1.0
In-Reply-To: <5b5a228e.MdvsdULQVpBGv+1Q%stockhausen@collogia.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 7/26/18 1:35 PM, stockhausen@collogia.de wrote:
> ondemand_readahead() checks bdi->io_pages to cap the maximum pages
> that need to be processed. This works until the readit section. If
> we would do an async only readahead (async size = sync size) and
> target is at beginning of window we expand the pages by another
> get_next_ra_size() pages. Btrace for large reads shows that kernel
> always issues a doubled size read at the beginning of processing.
> Add an additional check for io_pages in the lower part of the func.
> The fix helps devices that hard limit bio pages and rely on proper
> handling of max_hw_read_sectors (e.g. older FusionIO cards). For
> that reason it could qualify for stable.

Good catch, this looks correct to me. I'm going to shove this
towards 4.19 and mark it stable, that should give us enough testing
time on it.

-- 
Jens Axboe

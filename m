Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
To: Kent Overstreet <kent.overstreet@gmail.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b3970608-95dd-3d4f-140c-3d7cbd12cf8d@kernel.dk>
Date: Fri, 11 May 2018 15:13:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180509013358.16399-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/8/18 7:33 PM, Kent Overstreet wrote:
>  - Add separately allowed mempools, biosets: bcachefs uses both all over the
>    place
> 
>  - Bit of utility code - bio_copy_data_iter(), zero_fill_bio_iter()
> 
>  - bio_list_copy_data(), the bi_next check - defensiveness because of a bug I
>    had fun chasing down at one point
> 
>  - add some exports, because bcachefs does dio its own way
>  - show whether fua is supported in sysfs, because I don't know of anything that
>    exports whether the _block layer_ specifically thinks fua is supported.

Looked over the series, and looks like both good cleanups and optimizations.
If we can get the mempool patch sorted, I can apply this for 4.18.

-- 
Jens Axboe

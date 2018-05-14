Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
To: Kent Overstreet <kent.overstreet@gmail.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd9f9811-bec7-5394-30d4-5db833ecf5b4@kernel.dk>
Date: Mon, 14 May 2018 13:24:02 -0600
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

Thanks Kent, applied for 4.18 with the update patch 1.

-- 
Jens Axboe

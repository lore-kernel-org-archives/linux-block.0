Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Change extern inline to static inline
To: Tobias Klauser <tklauser@distanz.ch>, linux-block@vger.kernel.org
References: <20161118141606.9520-1-tklauser@distanz.ch>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f93c27df-a31e-1463-1d7d-923cd27da182@kernel.dk>
Date: Fri, 18 Nov 2016 07:44:59 -0700
MIME-Version: 1.0
In-Reply-To: <20161118141606.9520-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/18/2016 07:16 AM, Tobias Klauser wrote:
> With compilers which follow the C99 standard (like modern versions of
> gcc and clang), "extern inline" does the opposite thing from older
> versions of gcc (emits code for an externally linkable version of the
> inline function).
>
> "static inline" does the intended behavior in all cases instead.
>
> Description taken from commit 6d91857d4826 ("staging, rtl8192e,
> LLVMLinux: Change extern inline to static inline").
>
> This also fixes the following GCC warning when building with CONFIG_PM
> disabled:
>
>   ./include/linux/blkdev.h:1143:20: warning: no previous prototype for 'blk_set_runtime_active' [-Wmissing-prototypes]
>

Applied, thanks.

-- 
Jens Axboe

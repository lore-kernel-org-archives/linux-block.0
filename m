Return-Path: <BATV+bd2cc6fb32ca617cb22a+5026+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 28 May 2017 00:49:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] cfq-iosched: Mark cfq_clear_cfqq_*() as
 __maybe_unused
Message-ID: <20170528074952.GA22193@infradead.org>
References: <20170526212237.103525-1-mka@chromium.org>
 <20170526212237.103525-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170526212237.103525-2-mka@chromium.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 26, 2017 at 02:22:35PM -0700, Matthias Kaehlcke wrote:
> This fixes the following warning when building with clang:
> 
>     block/cfq-iosched.c:449:1: error: unused function 'cfq_clear_cfqq_sync'
>         [-Werror,-Wunused-function]
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Matthias, can you please stop sending these patches?  Gcc semantics
correctly are that static inlines can be unused and it's perfectly
fine.  It's your job to make clang fit that instead of spreading garbage
all over the kernel.

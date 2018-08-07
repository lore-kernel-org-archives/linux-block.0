Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] CFQ: Suppress W=1 compiler warnings
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180807231729.30308-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1f12bf6c-a502-67d8-d984-0ec85414fc72@kernel.dk>
Date: Tue, 7 Aug 2018 17:58:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180807231729.30308-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/7/18 5:17 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> This patch series suppresses the compiler warnings that are reported when
> building the CFQ I/O scheduler with W=1. Please consider these patches for
> kernel v4.19.

Thanks, applied.

-- 
Jens Axboe

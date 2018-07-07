Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/DAC960.c: fix defined but not used build warnings
To: Randy Dunlap <rdunlap@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4c76dd81-df10-7f99-d61c-1bce8c20a289@kernel.dk>
Date: Sat, 7 Jul 2018 12:54:39 -0600
MIME-Version: 1.0
In-Reply-To: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/6/18 9:49 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
> by marking the unused functions as __maybe_unused.
> 
> ../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]

Applied for 4.19, thanks Randy.

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4] lightnvm: Remove depends on HAS_DMA in case of
 platform dependency
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180622110535.31796-1-geert@linux-m68k.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <137ed21c-420f-6593-b969-f57df59ece94@kernel.dk>
Date: Fri, 22 Jun 2018 12:07:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180622110535.31796-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 5:05 AM, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.

Applied, thanks.

-- 
Jens Axboe

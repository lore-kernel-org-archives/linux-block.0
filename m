Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: skd: Use %pad printk format for dma_addr_t values
To: Helge Deller <deller@gmx.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org
References: <20180712202916.GA32416@ls3530.fritz.box>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b8229402-5d73-8737-4260-b1a55c43919e@kernel.dk>
Date: Thu, 12 Jul 2018 15:01:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180712202916.GA32416@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/12/18 2:29 PM, Helge Deller wrote:
> Use the existing %pad printk format to print dma_addr_t values.
> This avoids the following warnings when compiling on the parisc64 platform:
> 
> drivers/block/skd_main.c: In function 'skd_preop_sg_list':
> drivers/block/skd_main.c:660:4: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]

Applied, thanks.

-- 
Jens Axboe

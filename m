Return-Path: <m.mizuma@jp.fujitsu.com>
Message-ID: <5840C25A.9070601@jp.fujitsu.com>
Date: Fri, 2 Dec 2016 09:37:46 +0900
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: avoid incorrect bdi_unregiter call in blk_cleanup_queue
References: <583FE310.7040607@jp.fujitsu.com> <d89155e1-4b52-b0a4-9db2-978e8c62cbfd@kernel.dk>
In-Reply-To: <d89155e1-4b52-b0a4-9db2-978e8c62cbfd@kernel.dk>
Content-Type: text/plain; charset="iso-2022-jp"
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

On Thu, 1 Dec 2016 08:04:33 -0700 Jens Axboe wrote:
> On 12/01/2016 01:45 AM, Masayoshi Mizuma wrote:
>> blk_cleanup_queue() should call bdi_unregister() only if WB_registered
>> is set to bdi->wb.state. Because, blk_cleanup_queue() may be called
>> before bdi_register() is called, for example, error path.
> 
> Should this logic be in bdi_unregister() instead?

Thank you for pointed it out! I think your suggestion is better.
I will rewrite the patch.

- Masayoshi Mizuma

> 

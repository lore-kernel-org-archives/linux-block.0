Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: avoid incorrect bdi_unregiter call in
 blk_cleanup_queue
To: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
References: <583FE310.7040607@jp.fujitsu.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d89155e1-4b52-b0a4-9db2-978e8c62cbfd@kernel.dk>
Date: Thu, 1 Dec 2016 08:04:33 -0700
MIME-Version: 1.0
In-Reply-To: <583FE310.7040607@jp.fujitsu.com>
Content-Type: text/plain; charset=iso-2022-jp
List-ID: <linux-block@vger.kernel.org>

On 12/01/2016 01:45 AM, Masayoshi Mizuma wrote:
> blk_cleanup_queue() should call bdi_unregister() only if WB_registered
> is set to bdi->wb.state. Because, blk_cleanup_queue() may be called
> before bdi_register() is called, for example, error path.

Should this logic be in bdi_unregister() instead?

-- 
Jens Axboe

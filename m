Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: change return type to bool
To: Chengguang Xu <cgxu519@gmx.com>
Cc: linux-block@vger.kernel.org
References: <20180816145140.12558-1-cgxu519@gmx.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0f28a00c-da8d-bd72-5852-f51c15a6bc85@kernel.dk>
Date: Thu, 16 Aug 2018 13:44:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180816145140.12558-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/16/18 8:51 AM, Chengguang Xu wrote:
> Because blk_do_io_stat() only does a judgement about the request
> contributes to IO statistics, it better changes return type to bool.

Applied, thanks.

-- 
Jens Axboe

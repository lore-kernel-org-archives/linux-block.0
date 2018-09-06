Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: bfq: swap puts in bfqg_and_blkg_put
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
 linux-block@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
 linux-kernel@vger.kernel.org
References: <153622114435.533797.15694137158197822778.stgit@buzz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7bf130e2-1aef-3ef6-caef-a80d0eb1bb96@kernel.dk>
Date: Thu, 6 Sep 2018 11:33:20 -0600
MIME-Version: 1.0
In-Reply-To: <153622114435.533797.15694137158197822778.stgit@buzz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/6/18 2:05 AM, Konstantin Khlebnikov wrote:
> Fix trivial use-after-free. This could be last reference to bfqg.

Applied, thanks.

-- 
Jens Axboe

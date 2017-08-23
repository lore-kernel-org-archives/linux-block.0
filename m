Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, bfq: fix error handle in bfq_init
To: paolo.valente@linaro.org, linux-block@vger.kernel.org
References: <20170818163714.GA40576@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c11e3747-27b9-75bc-9e4d-d9a665a83741@kernel.dk>
Date: Wed, 23 Aug 2017 15:35:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170818163714.GA40576@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 10:37 AM, weiping zhang wrote:
> if elv_register fail, bfq_pool should be free.

Looks correct to me, I'll add it. Thanks.

-- 
Jens Axboe

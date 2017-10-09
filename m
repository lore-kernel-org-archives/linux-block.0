Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/1] block,bfq: Disable writeback throttling
To: Luca Miccio <lucmiccio@gmail.com>
Cc: paolo.valente@linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20171009142721.4262-1-lucmiccio@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c2b7d032-7306-ea2b-01b4-d61acf6cf3b4@kernel.dk>
Date: Mon, 9 Oct 2017 08:29:43 -0600
MIME-Version: 1.0
In-Reply-To: <20171009142721.4262-1-lucmiccio@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/09/2017 08:27 AM, Luca Miccio wrote:
> This is the v2 of the previous patch[1]. There are
> no functional changes. The only difference from v1 to
> v2 is the fix of the wbt_disable_default's comment,
> thanks to Lee Tibbert who pointed me out that mistake.

Applied, thanks.

-- 
Jens Axboe

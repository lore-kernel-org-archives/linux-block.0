Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/3] bfq: one fix and two important
 improvements for throughput
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20180914142309.6789-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bb31b362-53a9-483f-381f-1fcf0dad32bd@kernel.dk>
Date: Fri, 14 Sep 2018 13:06:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180914142309.6789-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/14/18 8:23 AM, Paolo Valente wrote:
> Hi Jens,
> the second and third patch in this series provide two important
> improvements in bfq's ability to boost throughput with random I/O. The
> benefits of the second patch concern I/O control, and are described in
> detail in this LWN article [1] (and briefly in the commit message
> itself). The benefits of the other patch should be
> straightforward. Finally, the first patch fixes an I/O-control bug,
> found while making the second patch.
> 
> These patches modify somehow core operations of bfq, so, before
> submitting them, I have tested them a lot, and have had them tested by
> other people too. In particular, during these months, they have been
> tested in systems ranging from PCs to development platforms.

Applied for 4.20, thanks Paolo.

-- 
Jens Axboe

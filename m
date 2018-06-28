Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX RESEND 0/4] bfq: fix bugs breaking bandwidth
 guarantees occasionally
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20180625195537.7769-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <359b2f24-f680-2e76-d6e1-3b8b67fcacc7@kernel.dk>
Date: Thu, 28 Jun 2018 13:17:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/25/18 1:55 PM, Paolo Valente wrote:
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.

Applied for 4.19, thanks.

-- 
Jens Axboe

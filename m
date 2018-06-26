Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH BUGFIX RESEND 0/4] bfq: fix bugs breaking bandwidth
 guarantees occasionally
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20180625195537.7769-1-paolo.valente@linaro.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <371643da-7465-91d8-6765-65905776be64@applied-asynchrony.com>
Date: Tue, 26 Jun 2018 18:23:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/25/18 21:55, Paolo Valente wrote:
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.
> 
> I guess these patches are appropriate for next kernel release.

Ran these overnight on 2 machines on top of recent BFQ and nothing
caught on fire. One funny benchmark result stood out since it gave
me (repeatedly!) 560 MB/s read bandwidth on an SSD which is rated to
do "up to 550MB/s", so I guess BFQ's bandwidth guarantees are now
really quite strong. :-)

Therefore:
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

cheers,
Holger

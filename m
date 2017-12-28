Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH IMPROVEMENT] block, bfq: limit sectors served with
 interactive weight raising
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20171228111917.2767-1-paolo.valente@linaro.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <5a9c6573-84a6-ae7b-7058-f202c7187065@applied-asynchrony.com>
Date: Thu, 28 Dec 2017 15:00:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171228111917.2767-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


On 12/28/17 12:19, Paolo Valente wrote:
(snip half a tech report ;)

So either this or the previous patch ("limit tags for writes and async I/O"
can lead to a hard, unrecoverable hang with heavy writes. Since I couldn't
log into the affected system anymore I couldn't get any stack traces, blk-mq
debug output etc. but there was nothing in dmesg/on the console, so it
wasn't a BUG/OOPS.

-h

Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH RFC] block, bfq: set default slice_idle to zero for
 non-rotational devices
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Paolo Valente <paolo.valente@linaro.org>, linux-kernel@vger.kernel.org
References: <154109421062.925711.4117729151502021084.stgit@buzz>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <317076f7-f84f-c08f-5fb5-b227094cabfd@applied-asynchrony.com>
Date: Thu, 1 Nov 2018 20:06:09 +0100
MIME-Version: 1.0
In-Reply-To: <154109421062.925711.4117729151502021084.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/01/18 18:43, Konstantin Khlebnikov wrote:
> With default 8ms idle slice BFQ is up to 10 times slower than CFQ
> for massive random read workloads for common SATA SSD.
> 
> For now zero idle slice gives better out of box experience.
> CFQ employs this since commit 41c0126b3f22 ("block: Make CFQ default
> to IOPS mode on SSDs")

Well, that's interesting because 3 years ago I made the same suggestion
and was told that BFQ's heuristics automagically make it not idle when
rotational=0. Did you actually benchmark this? I just tried and don't
get a noticeable performance difference with slice_idle=0 compared to
deadline.

Discussion link:
https://groups.google.com/forum/#!msg/bfq-iosched/iRMw2n3kYLY/6l9cIm3TBgAJ

curious..

Holger

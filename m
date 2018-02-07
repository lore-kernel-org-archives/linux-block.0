Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 07 Feb 2018 16:50:22 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark
 Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 'Paolo
 Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Alban Browaeys
 <alban.browaeys@gmail.com>, Ming Lei <ming.lei@redhat.com>, Ivan Kozik
 <ivan@ludios.org>, SERENA ZIVIANI <169364@studenti.unimore.it>, Serena
 Ziviani <ziviani.serena@gmail.com>, =?UTF-8?Q?Holger_Hoffst=C3=A4tte?=
 <holger@applied-asynchrony.com>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <8D356375-4C35-41EC-9F4D-0E321B08F9BF@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
 <77124223e6116350a5184a5199850304@natalenko.name>
 <1517924768.25841.32.camel@gmx.de>
 <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
 <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
 <82ffc96aacc3945861cbb708df346338@natalenko.name>
 <E52CCDEA-279A-40D8-AD9B-F4D1AF351BF1@linaro.org>
 <1517995431.25619.5.camel@gmx.de>
 <FBF6DCBB-B0F5-446B-8FD1-106E2538A9C1@linaro.org>
 <1517998516.6606.1.camel@gmx.de>
 <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
 <8D356375-4C35-41EC-9F4D-0E321B08F9BF@linaro.org>
Message-ID: <9a99ff3cb52e475f48327c91e3d236d0@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

07.02.2018 12:27, Paolo Valente wrote:
> Hi Oleksandr, Holger,
> before I prepare a V2 candidate patch, could you please test my
> instrumentation patch too, with the above change made.  For your
> convenience, I have attached a compressed archive with both the
> instrumentation patch and a patch making the above change.
> 
> Crossing my fingers,
> Paolo

With all three patches applied I cannot reproduce neither cfdisk hang 
nor some kind of boom.

Thank you.

Oleksandr

Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 06 Feb 2018 15:59:42 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark
 Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 'Paolo
 Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Alban Browaeys
 <alban.browaeys@gmail.com>, ming.lei@redhat.com, ivan@ludios.org,
 169364@studenti.unimore.it, Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
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
Message-ID: <7eff03cac387051a63aa68df99e49f3a@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

06.02.2018 15:50, Paolo Valente wrote:
> Could you please do a
> gdb <buildir>/block/bfq-iosched.o # or vmlinux.o if bfq is builtin
> list *(bfq_finish_requeue_request+0x54)
> list *(bfq_put_queue+0x10b)
> for me?

Yes. Just give me some time to recompile the kernel with minimal debug 
info enabled. I'll post then list/disasm and new stacktraces.

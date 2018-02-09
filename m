Return-Path: <efault@gmx.de>
Message-ID: <1518197379.26824.31.camel@gmx.de>
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>, Paolo Valente
	 <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, 'Paolo Valente' via bfq-iosched
 <bfq-iosched@googlegroups.com>,  Alban Browaeys <alban.browaeys@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>,
 169364@studenti.unimore.it, holger@applied-asynchrony.com, Serena Ziviani
 <ziviani.serena@gmail.com>
Date: Fri, 09 Feb 2018 18:29:39 +0100
In-Reply-To: <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
	 <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
	 <34041F0A-F460-4736-9A6C-76D861EA0070@linaro.org>
	 <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-02-09 at 14:21 +0100, Oleksandr Natalenko wrote:
> 
> In addition to this I think it should be worth considering CC'ing Greg 
> to pull this fix into 4.15 stable tree.

This isn't one he can cherry-pick, some munging required, in which case
he usually wants a properly tested backport.

	-Mike

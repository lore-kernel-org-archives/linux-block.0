Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Mike Galbraith <efault@gmx.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Alban Browaeys <alban.browaeys@gmail.com>, Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>, 169364@studenti.unimore.it, holger@applied-asynchrony.com, Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
Date: Sat, 10 Feb 2018 09:29:29 +0100
Message-ID: <6394471.U0O273vb9H@natalenko.name>
In-Reply-To: <1518197379.26824.31.camel@gmx.de>
References: <20180207211920.6343-1-paolo.valente@linaro.org> <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name> <1518197379.26824.31.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Hi.

On p=E1tek 9. =FAnora 2018 18:29:39 CET Mike Galbraith wrote:
> On Fri, 2018-02-09 at 14:21 +0100, Oleksandr Natalenko wrote:
> > In addition to this I think it should be worth considering CC'ing Greg
> > to pull this fix into 4.15 stable tree.
>=20
> This isn't one he can cherry-pick, some munging required, in which case
> he usually wants a properly tested backport.
>=20
> 	-Mike

Maybe, this could be a good opportunity to push all the pending BFQ patches=
=20
into the stable 4.15 branch? Because IIUC currently BFQ in 4.15 is just=20
unusable.

Paolo?

=2D--

block, bfq: add requeue-request hook
bfq-iosched: don't call bfqg_and_blkg_put for !CONFIG_BFQ_GROUP_IOSCHED
block, bfq: release oom-queue ref to root group on exit
block, bfq: put async queues for root bfq groups too
block, bfq: limit sectors served with interactive weight raising
block, bfq: limit tags for writes and async I/O
block, bfq: increase threshold to deem I/O as random
block, bfq: remove superfluous check in queue-merging setup
block, bfq: let a queue be merged only shortly after starting I/O
block, bfq: check low_latency flag in bfq_bfqq_save_state()
block, bfq: add missing rq_pos_tree update on rq removal
block, bfq: fix occurrences of request finish method's old name
block, bfq: consider also past I/O in soft real-time detection
block, bfq: remove batches of confusing ifdefs

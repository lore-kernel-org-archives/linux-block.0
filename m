Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>
Subject: Re: I/O hangs after resuming from suspend-to-ram
Date: Mon, 28 Aug 2017 20:22:26 +0200
Message-ID: <1615033.Xza1AIGLzP@natalenko.name>
In-Reply-To: <20170828125822.GA19670@ming.t460p>
References: <3926917.BCSovyVWdL@natalenko.name> <4174287.OjL0pO8MRx@natalenko.name> <20170828125822.GA19670@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi.

On pond=C4=9Bl=C3=AD 28. srpna 2017 14:58:28 CEST Ming Lei wrote:
> Could you verify if the following patch fixes your issue?
> =E2=80=A6SNIP=E2=80=A6

I've applied it to v4.12.9 and rechecked =E2=80=94 the issue is still there=
,=20
unfortunately. Stacktrace is the same as before.

Were you able to reproduce it in a VM?

Should I re-check it with v4.13-rc7?

Any other suggestions?

Thanks.

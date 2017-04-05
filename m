Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Remove blk_mq_queue_data.list
Date: Wed, 5 Apr 2017 15:27:23 +0000
Message-ID: <1491406042.2787.5.camel@sandisk.com>
References: <CY1PR0401MB15363601FA034CE8627DA41881080@CY1PR0401MB1536.namprd04.prod.outlook.com>
	 <20170405140722.GA20495@kernel.dk>
In-Reply-To: <20170405140722.GA20495@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-05 at 08:07 -0600, Jens Axboe wrote:
> On Mon, Apr 03 2017, Bart Van Assche wrote:
> > The block layer core sets blk_mq_queue_data.list but no block
> > drivers read that member. Hence remove it and also the code that
> > is used to set this member.
>=20
> Looks fine to me, might as well kill it. Your patch came through mangled
> here though, on both my private and corporate email account. Did
> something change with the setup at your end? Would be great if you could
> resend it.

Hello Jens,

Sorry that the patch came through mangled. I send patch series with git
format-patch + git send-email. This patch was sent using git format-patch +
xclip + Thunderbird with the Toggle Word Wrap add-on configured not to wrap
long lines. This morning I tried to run git am on the copy of this patch
that I downloaded from my personal e-mail account and that worked fine.
Anyway, I will resend this patch with git send-email.

Bart.=

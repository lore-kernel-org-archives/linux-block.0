Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] More patches for kernel v4.13
Date: Mon, 19 Jun 2017 18:35:25 +0000
Message-ID: <1497897322.2989.1.camel@wdc.com>
References: <20170608173355.25898-1-bart.vanassche@sandisk.com>
	 <578cb92c-4ebd-c5b7-903a-b248f709928f@kernel.dk>
In-Reply-To: <578cb92c-4ebd-c5b7-903a-b248f709928f@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sun, 2017-06-18 at 20:55 -0600, Jens Axboe wrote:
> On 06/08/2017 11:33 AM, Bart Van Assche wrote:
> > This patch series contains one patch that reduces the size of struct
> > blk_mq_hw_ctx, a few patches that simplify some of the block layer code=
 and
> > also patches that improve the block layer documentation. Please conside=
r these
> > patches for kernel v4.13.
> >=20
> > The basis for these patches is a merge of your for-next and for-linus
> > branches. Please note that the first patch in this series applies fine =
on top
> > of the merge of these two branches but not on top of your for-next bran=
ch.
>=20
> I seem to be missing some of the patches in this series, and I'm assuming
> high likely hood of rejects due to recent churn. Would you mind resending
> this series?

Hello Jens,

I will repost this series as soon as I have finished retesting a rebase of
this series on top of your current for-next branch.

Bart.=

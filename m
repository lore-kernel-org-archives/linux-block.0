Return-Path: <ianwmorrison@gmail.com>
MIME-Version: 1.0
References: <20180828154727.3589-1-ianwmorrison@gmail.com> <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
In-Reply-To: <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Wed, 29 Aug 2018 02:07:06 +1000
Message-ID: <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com, hch@lst.de,
	bart.vanassche@wdc.com, hare@suse.de, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
> > Kernel oops when booting on Bay and Cherry Trail devices
> > such as Intel Compute Stick. Bisected as:
> >
> > commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> >
> > This patch reverts the above commit.
>
> Did I miss the posting of that oops? Just curious where this is
> going wrong. Not adverse to reverting, but I'd like to try to
> understand the issue first.
>
> --
> Jens Axboe
>

I've not been able to capture it however manually transcribing what is
on the screen:

mmc0: Got data interrupt 0x00000002 even though no data operation

followed by:

mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============

Do you want any specific register value or should I transcribe each
(as I am working from an image taken at boot)?

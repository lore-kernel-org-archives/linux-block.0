Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180904191431.20102-1-hch@lst.de> <20180904191431.20102-11-hch@lst.de>
In-Reply-To: <20180904191431.20102-11-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Sep 2018 21:36:06 +0200
Message-ID: <CAMuHMdUOdbf=m-OiYWup-WWrf6YS+294DA1dQzt_wVAtqE5W2g@mail.gmail.com>
Subject: Re: [PATCH 10/13] block: remove bvec_to_phys
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xen.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 4, 2018 at 9:23 PM Christoph Hellwig <hch@lst.de> wrote:
> We only use it in biovec_phys_mergeable and a m68k paravirt driver,
> so just opencode it there.  Also remove the pointless unsigned long cast
> for the offset in the opencoded instances.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
>  arch/m68k/emu/nfblock.c | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

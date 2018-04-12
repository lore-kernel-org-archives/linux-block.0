Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <5aceb51e.1c69fb81.c6613.d3e4SMTPIN_ADDED_MISSING@mx.google.com>
References: <5aceb51e.1c69fb81.c6613.d3e4SMTPIN_ADDED_MISSING@mx.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Apr 2018 10:18:14 +0200
Message-ID: <CAMuHMdVELjqx_B7MUsPFHLTVFjLuEy5Z6sB-bafbZTk+V6+vcQ@mail.gmail.com>
Subject: Re: [PATCH] block/amiflop: Don't log an error message for an invalid ioctl
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	linux-block@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 12, 2018 at 3:23 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Do as the swim3 driver does and just return -ENOTTY.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by:  Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

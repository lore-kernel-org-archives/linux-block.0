Return-Path: <michael@ozlabs.org>
In-Reply-To: <c454a5dbb215719991e3b0e6470309101d870fbb.1539092111.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [v3,01/24] powerpc/32: Add ioremap_wt() and ioremap_coherent()
Message-Id: <42YPr02vcGz9s7W@ozlabs.org>
Date: Mon, 15 Oct 2018 15:01:03 +1100 (AEDT)
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-10-09 at 13:51:33 UTC, Christophe Leroy wrote:
> Other arches have ioremap_wt() to map IO areas write-through.
> Implement it on PPC as well in order to avoid drivers using
> __ioremap(_PAGE_WRITETHRU)
> 
> Also implement ioremap_coherent() to avoid drivers using
> __ioremap(_PAGE_COHERENT)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/86c391bd5f47101acf1f3e0abd9fe0

cheers

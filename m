Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1539097191.64374.44.camel@acm.org>
Subject: Re: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead
 of __ioremap(_PAGE_WRITETHRU)
From: Bart Van Assche <bvanassche@acm.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Dominik Brodowski
 <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens
 Axboe <axboe@kernel.dk>,  Kumar Gala <galak@kernel.crashing.org>, Li Yang
 <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood
 <oss@buserror.net>,  aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Tue, 09 Oct 2018 07:59:51 -0700
In-Reply-To: <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
	 <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-10-09 at 13:51 +-0000, Christophe Leroy wrote:
+AD4 +AF8-PAGE+AF8-WRITETHRU is a target specific flag. Prefer generic functions.
+AD4 
+AD4 Acked-by: Geert Uytterhoeven +ADw-geert+AEA-linux-m68k.org+AD4
+AD4 Signed-off-by: Christophe Leroy +ADw-christophe.leroy+AEA-c-s.fr+AD4

Hi Geert,

All patches that have been applied to this driver since 2005 are API refactoring
patches. I haven't found any patches in the history of this driver that seem to
have been submitted by a user of this driver. Do you perhaps know whether anyone
is using this driver?

Thanks,

Bart.

Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E501C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAAC208E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgCaJmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:42:23 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34154 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgCaJmX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:23 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f2nl024507;
        Tue, 31 Mar 2020 11:41:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Ian Molton <spyro@f2s.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, x86@kernel.org
Subject: [PATCH 00/23] Floppy driver cleanups
Date:   Tue, 31 Mar 2020 11:40:31 +0200
Message-Id: <20200331094054.24441-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series applies a second batch of cleanups to the floppy driver and
its multiple arch-specific parts. Here the focus was on getting rid of
hard-coded registers and flags values to switch to their symbolic
definitions instead, and on making use of the global current_fdc variable
much more explicit throughout the code to reduce the risk of accidental
misuse as was the case with the most recently fixed bug.

Note that this code base is very old and the purpose is not to rewrite
nor reorganize the driver at all, but instead to make certain things
more obvious while keeping changes reviewable. It does not even address
style issues that make checkpatch continue to complain a little bit (15
total warnings which were already there and don't seem worth addressing
without more careful testing). Some comments were added to document a
few non-obvious assumptions though.

This series was rediffed against today's master (458ef2a25e0c) which
contains the first series. The changes were tested on x86 with real
hardware, and was build-tested on ARM.

Willy Tarreau (23):
  floppy: split the base port from the register in I/O accesses
  floppy: add references to 82077's extra registers
  floppy: use symbolic register names in the m68k port
  floppy: use symbolic register names in the parisc port
  floppy: use symbolic register names in the powerpc port
  floppy: use symbolic register names in the sparc32 port
  floppy: use symbolic register names in the sparc64 port
  floppy: use symbolic register names in the x86 port
  floppy: cleanup: make twaddle() not rely on current_{fdc,drive}
    anymore
  floppy: cleanup: make reset_fdc_info() not rely on current_fdc anymore
  floppy: cleanup: make show_floppy() not rely on current_fdc anymore
  floppy: cleanup: make wait_til_ready() not rely on current_fdc anymore
  floppy: cleanup: make output_byte() not rely on current_fdc anymore
  floppy: cleanup: make result() not rely on current_fdc anymore
  floppy: cleanup: make need_more_output() not rely on current_fdc
    anymore
  floppy: cleanup: make perpendicular_mode() not rely on current_fdc
    anymore
  floppy: cleanup: make fdc_configure() not rely on current_fdc anymore
  floppy: cleanup: make fdc_specify() not rely on current_{fdc,drive}
    anymore
  floppy: cleanup: make check_wp() not rely on current_{fdc,drive}
    anymore
  floppy: cleanup: make next_valid_format() not rely on current_drive
    anymore
  floppy: cleanup: make get_fdc_version() not rely on current_fdc
    anymore
  floppy: cleanup: do not iterate on current_fdc in DMA grab/release
    functions
  floppy: cleanup: add a few comments about expectations in certain
    functions

 arch/alpha/include/asm/floppy.h             |   4 +-
 arch/arm/include/asm/floppy.h               |   8 +-
 arch/m68k/include/asm/floppy.h              |  27 +-
 arch/mips/include/asm/mach-generic/floppy.h |   8 +-
 arch/mips/include/asm/mach-jazz/floppy.h    |   8 +-
 arch/parisc/include/asm/floppy.h            |  19 +-
 arch/powerpc/include/asm/floppy.h           |  19 +-
 arch/sparc/include/asm/floppy_32.h          |  50 +--
 arch/sparc/include/asm/floppy_64.h          |  59 ++--
 arch/x86/include/asm/floppy.h               |  19 +-
 drivers/block/floppy.c                      | 330 ++++++++++----------
 include/uapi/linux/fdreg.h                  |  16 +-
 12 files changed, 299 insertions(+), 268 deletions(-)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Ian Molton <spyro@f2s.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: x86@kernel.org
-- 
2.20.1


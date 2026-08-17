Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AD1A3029;
	Mon, 17 Aug 2026 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931660; cv=none; b=jRA1REIxcVESw4e7alloUKKgIRN3l+07uM2tYxJC3uvjuiLcOX8ALnyRWmqtqucWU/PtLVbKdU1A2Ewb0IsvG8dBZ/ZDnXexrm5Nm34ybRpYC+D9XPJg5LLgU6HZtLmVlNBuuwG0yvHqXn3Cp6y4Uj+tNh6gILBTaHHrwpk4V50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931660; c=relaxed/simple;
	bh=ji/tyqGcon233QSJflPcXwKpoQczkCDbfQE2u1wqlbc=;
	h=Message-ID:From:Subject:Date:To:Cc; b=AfRsG+gMSW6sieGpF8Ca6B4P+WZw8Wmzo/BwfNArHEW+KlnD0LUDC+YQGaPO9vwuZKFOlXFYsfiTQjGiKgJayds14mccnUiZbtjdRNrZf/xOaw4ue+/eNYmjYT9pVCnYtDJ/cmQapDRZ6m78jfE51liACK0w+ZCVdF1l7jddpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HuTIbPRd; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HuTIbPRd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D94FFEC0218;
	Sun, 16 Aug 2026 21:54:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 16 Aug 2026 21:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786931656; x=1787018056; bh=His8knTytrzQThMDL3SL/PU827Fn
	BOezKTrC33j3YGU=; b=HuTIbPRdvEWtCSzKbMdhJj8AeDPMWpS/vKmWA+kWzaJV
	WdJtx7SatlKPdeEBcfrgVqTto2oyE2sFZVzBuBIWg+6gWWDXUXFLznCWC0oq+lHk
	4Rl/3zefX50MJHdM4PRVXy4LpEWyhJZOzYaERPBSyrw0HL29s0tmwToxqb+Nn6jH
	Cz9gYOmYMXq6EyaYvPFsq5v4WE3nxh/7quRVX+uJI3hwuuUoqvGRR1/F2nLtPbVP
	Edp4K9fo+311ZUucP06FvmAo72SiF7rO9b9Lg/I2dmNO4gODjXeiMeGP8zZtSvrZ
	dAlPaYjmDHGCF2CfMKJTnQPVCTOzHDDmq7V1xmqMgg==
X-ME-Sender: <xms:x2mCagEHFw3LFU6ffDuGcxBl1qaslq7lXHCk5Xt1s9b7A4872-WDdQ>
    <xme:x2mCalXfvHZAeaV34biahvq9zqXsVi0vcAnfyHi7KQn2BJYJZvX6uPbyREg6JoG3B
    RRCGUiHvhv4dHaFpJvoMoEYU3CcY739kt1eJbkfWUB6V83yqKA3jUl0>
X-ME-Received: <xmr:x2mCasXFMFq4AJTicfc6qUr3-FmJhRKfQdJdSnJH4ho06V6-11n4Ju6BATaIVktrV-zs1zJUe8KLZRRhSEqIrtVv9bBEFn4lvZc>
X-ME-Proxy-Cause: dmFkZTGyfXgNOQEqrRudDkzZqtQ6tyZT3wZgVsrGBATePRJYx0N6BKRpbH8SmCJMi4OFGM
    uGwRgtmvt2cEPbqXvzd9ixrnBxYdDQ1OlCMafTPFIBVNEm2bwKv7njKuteCs24usi83wB4
    BiFM6gso3Otwv6Prg17FtugB24Odd8+gfgONVs44oi9DIwcHfy1nIbDyhS59h/XBx//CCF
    sIE6qMkoI3NgIffKLLWh9rS3yRGolXB9Q3j3w6KQNXAeA4x9BC2o96MhSnpT25NKm808kn
    6C950bmj8dXRCM2/i1Vfght8AjxrvMOqYkXSlPUFGSdXYUkvvd2TXjD58A6HhHUf7QLEYD
    aXxOhKrOIKjxFk+5jjaFBhFPf8vcSa9UQBwAm5aDlMOuF8wiSG7RIueZ9lB2NOPfG9RdAQ
    ePLS/qFJ6+ImWyOcvkYkOaVktFzLo18BapMLiuGXEAut0yQR6A0aOSqo4E2HJFrJxAlpef
    hL276wbx6cHEWOiq0iA5in+ZwyUETQCTqD/RBUkDDG10LVLxKidexU5QBMxnnfNBRu8ftD
    sHTVDG9Z/DaRLh+Bdfo7eDMYKVs4Qf+3ORAJ59sP0vHCQM5E3dRI07pNcEi8gblTweFkXn
    oaZU0OhKkNYdGKN1A4S9otdNp+LfSL7GkF3eZfcBwpOm1PWhY9EMhIEA3NRg
X-ME-Proxy: <xmx:x2mCajITw5LO8ECVM-ICXzdZbm7UIoDRDRzfKwlNdpYY77Ss9pEGuA>
    <xmx:x2mCakDtg1U7loDe52bF1GUx7bGEztziv0el0Gk46OgooITmKTkmBg>
    <xmx:x2mCarc54DQ_wxYOVoQ2BNeCjPcSiALw3tMsCIqxxT6XNOukyMmAbw>
    <xmx:x2mCar0sh19zMe6aDfFJb-W6klqWXyMYUQH687ajeXro3bp20lbCVA>
    <xmx:yGmCaoSZFUlHXgRbRGrAKpxUfvcf5AK9ZqgFkPW4r_iwys4AkcgMaVBM>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:54:12 -0400 (EDT)
Message-ID: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 00/32] block/swim: Fixes and improvements
Date: Mon, 17 Aug 2026 11:17:10 +1000
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Joshua Thompson <funaho@jurai.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    Omar Sandoval <osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

I recently had a need for the 'swim' driver but found that it was too buggy
to be useful for my purposes. I had two aims in mind--

Firstly, I needed this driver to help me test my new BMoW Floppy Emu for 
emulation correctness. Being that Linux is open source and MacOS is not,
this driver should be ideal for that.

Secondly, I needed to realign the heads in some disk drives. The swim driver
has most of the code needed for a feedback loop for manual re-alignment, so
I wrote the remaining code and pushed it to a repo here:
https://github.com/fthain/linux/commits/swim/

These patches fix all the bugs I found. They improve stability,
compatibility and performance. Additional patches improve source code
quality by removing redundant code and cleaning up a bit.

This patch series was successfully tested on the following systems.

Mac Quadra 650 - SWIM 2 with Mitsubishi FDD
Mac LC III     - SWIM 2 with Mitsubishi FDD and Sony FDD
Mac Quadra 700 - SWIM with Sony FDD
Mac IIvx       - SWIM with Sony FDD

---
Changed since v1:
 - Patches 1/31, 19/31, 23/31 were revised as per Laurent's remarks.
 - Some minor improvements to patches 9/31, 13/31 and 16/31.
 - Added patch 24/32 to fix a bug causing silent IO corruption instead
   of an IO error.

---

Finn Thain (32):
  swim: Assert strobe with stable outputs
  swim: Select appropriate drive once only
  swim: Enable the drive when probing
  swim: Don't disable drive after every sector
  swim: Perform ISM/IWM mode switching according to specs
  swim: Configure parameter memory
  swim: Enable clock divider only where appropriate
  swim: Don't start motor until medium is present
  swim: Recalibrate when drive is probed
  swim: Add track zero recalibration delay
  swim: Handle FIFO timeout error
  swim: Simplify return value initialization
  swim: Check for CRC errors
  swim: Check error register during sector read
  swim: Don't use the mark register to read data
  swim: Fix buffer overflow
  swim: Convert to blocking queue
  swim: Remove redundant RELAX actions
  swim: Deduplicate polling loops
  swim: Check drive ready bit
  swim: Revisit delays
  swim: Remove pointless mode0 register write
  swim: Don't needlessly re-read sectors
  swim: Don't search beyond the first data mark
  swim: Remove pointless specifiers
  swim: Move swd initialization
  swim: Add some helpful references
  swim: Remove unused macro definitions
  swim: Clean up whitespace
  swim: Define macros for constants
  swim: Define symbols for constants
  swim: Unexport global symbols

 arch/m68k/mac/config.c   |  31 ++-
 drivers/block/swim.c     | 447 ++++++++++++++++++++-------------------
 drivers/block/swim_asm.S | 358 ++++++++++++++++---------------
 3 files changed, 449 insertions(+), 387 deletions(-)

-- 
2.52.0


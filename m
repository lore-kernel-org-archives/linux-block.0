Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A244065C;
	Fri,  4 Sep 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514288; cv=none; b=D0CIU7LbZaBlWbRynJaeFNoyn88l9JhkeIOCWDLMLnWLFBBmAGlkyZuE6Hbe7jEo5ZSXkqnc+flgLh/PFD7dvrVvG/cMh4T4Ty7/IatBTMZevKD3h3OS2QODyImty5fz04WOsNGumYF7COe8jGxkE3vkCyrj/wDYBUtmWQLbRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514288; c=relaxed/simple;
	bh=Bk6agGTkGhO17/ptxZFZm7ZXadBaOCtXHALvbNd4TI4=;
	h=Message-ID:From:Subject:Date:To:Cc; b=uZdWfjIgU6vJGrXQHG/ZfuWIOpFfSbiouxQXu5vfVCD3avxM36K+lt4PZ1hkJl2I/feiUJww9iEiHFfj0GeN8GzU76H//K08CXNfYoGHKhN9VGXJ8Rr5BMaItlCLn0VTeoibevt211WHnCfYbzqD+BqNZTKGsSnFV/kwJnOMFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzgNzAbv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzgNzAbv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 079B51400134;
	Fri,  4 Sep 2026 05:31:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 05:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788514285; x=1788600685; bh=kFam2UdvptTVTLhviPOo5NmOADy3
	z5NhlFhoDE0Zn1c=; b=fzgNzAbvVfdcX7oMZC77CZ8xQfmMrEUimKRKIx+bjcjV
	vKAkH6xPjjIl2+BrD8NMrieEKOCbTs9Mhb82vVwvJrBJs4JBjNbenrOYA4uVWPcV
	KJwL8Uu78tqq+Wb2Wvsll4OxCEv41VDDzOLFikU/hBMMLov/N+Kl6eQqA6B3DLkU
	OtPPGYH0cHgn8h37PKRjmmDAvvOsXzIAz8qrY6JceEBASuxZTLkgPYE+mU7kPCmM
	K2F1+llcxNPfjsgIA2FW900YuoUaIo4lcZnOnDnaLICMdkrN3oA3Z/qTAztQMz7T
	YLu5fM7uLfEbW3mxDes3BIPMvYxj0l+DaiU8nVgYYw==
X-ME-Sender: <xms:7I-aak2Qn1tHmJnQacF06sW21wJPeYIj0biC7PqhDOHiqPNkPEQlSA>
    <xme:7I-aarGcSQwwu2YraMv23t0qOMa-s18WZ_QqyxWGJpHhHGhtgB9NX2hBp45nKnCRC
    GHJwWTQa0JHQuvon4E18rf36BajMYjyMTqGGh7YAMPyqxlGvtGLjuxH>
X-ME-Received: <xmr:7I-aavENDtKgnkLM6Q3hsR60AhxlWJmjUCWY9t-265g-m0Q3PYlB9W2x1FkrjXOIk_Nb8NGZzVYRZxcIspmznB1b-Nyakz5Qeuk>
X-ME-Proxy-Cause: dmFkZTFELX6SjhHYpZR1kZnJYO/LgLgTaX5N2tgvw93fcR7gEEcuRWFuJbijwLD005Uq36
    QJ2P8BL7XCdXKNfltU44bZwXesEhRUEq0gHneJQICZ8m5MxjtYNXhQdbzeBF3+LhsHQqJm
    rHa5pOra8D+tqJDZcIAVNmLYeII1d7wRaFZAwuDj7Nwtu1W5/i1VAsI0wYou6sIuwKmIW8
    lb4BDDn+XPkDK/Nec5Os0JTw9PEmhfByU3nsT1uozsn4z7LsmXDPAf5gVIUsjzU0JVnN7S
    10FulqtdDe/kq4lnOr3H+GpFABIPfomk16p+12VZXaxtfoZQwuseD2vi7KfbjRHog54MZI
    DgKthaX/se2NTo+HB9XWzYuRtz9Sgeai7i+sFcagmP41Jp3MyNZEgp75U293So71Q5FxK7
    vxkO6Ij9UJ7pZKPSxIaZTFG9PBi/ZpFxvSZ2qhBSexO5NK8e34ipPXB85y4RgrVSGbQ0aS
    vRZ8Lb81/2ExwPnokfRg/h9eM4uSjylBuV9I4IscUoPrRGv6wa14PNgbMPG7jV/BbnDaX9
    oJrA6UZiy4mf7w7/MSCUGZ0eDQpgmzKSYIR6aHVo0jAis9wjAK9Zyd7lMsfL7Ksen1p8mp
    KrjY0VGVuVrI17c5VI4hf+GB+RkI7QNDiK+HUDSysuctRpnvxwwvc9JxPDRA
X-ME-Proxy: <xmx:7I-aau5VYhsT6ERp3s4KR-DZ_PYMDEy_DVrrUkH4iXBqlIGAgFL56g>
    <xmx:7I-aakw_mCQ8JL-I-iuwPu7QupTpW0Qsr-6yUFKfssM3URKsdim47w>
    <xmx:7I-aatPwTa3r8hFDjNUgFo2zT7-GF8fpV1eJT7CceexThuBFzGCoow>
    <xmx:7I-aaqlLkU4NqRLzvsphh20RoaqOoWlwW35k0c5eWm6t6mdAReXcpQ>
    <xmx:7Y-aaupVBt_RGwH23Eb3AIi1PMTedcsXnhcx2GW_-WYSNruNh08B0NXc>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:31:22 -0400 (EDT)
Message-ID: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 00/33] block/swim: Fixes and improvements
Date: Fri, 04 Sep 2026 19:26:36 +1000
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

Changed since v2:
 - Reviewed-by tags were dropped from patches 1/32, 9/32, 13/32 and 16/32
   because of unreviewed changes.
 - Better assembly code in patch 13/32.
 - Patch 23/32 improved upon to reduce excessive interrupt latency when
   medium errors are encountered.
 - Patch 7/32 was split in two, and readability was improved as requested
   by Geert.
 - Geert's acked-by tag was added.

---

Finn Thain (33):
  swim: Assert strobe with stable outputs
  swim: Select appropriate drive once only
  swim: Enable the drive when probing
  swim: Don't disable drive after every sector
  swim: Perform ISM/IWM mode switching according to specs
  swim: Configure parameter memory
  swim: Refactor SWIM setup
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
 drivers/block/swim.c     | 451 ++++++++++++++++++++-------------------
 drivers/block/swim_asm.S | 356 +++++++++++++++---------------
 3 files changed, 452 insertions(+), 386 deletions(-)

-- 
2.52.0


Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409D400980;
	Thu, 16 Jul 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197039; cv=none; b=eHYSZFKTiQ6VstN3q5cY2+CNRLmUiBhcY14yd5vY+K378ZFT00JKOZvDh0KplbJdZxayGXdQbqcHwDzU5NhIbgvtycDdR9lXgJEvB2Zaf6iTryJ0h15yKNvfoJeE/4e09hn5lCRzY5jqfR3oSnfUMEjfNYMZJ0NuHMnW4bVYUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197039; c=relaxed/simple;
	bh=6/eckOiWFh6Pr5UTfrcyRgKkQih3gyse2papWRUcEaQ=;
	h=Message-ID:From:Subject:Date:To:Cc; b=oqjXGdYeCcak4V+JAd3IPPIQ9S/QSvpcs7PrtNffUZIPh9sGua9J0xFEkp4NNIgyvdLT/lmatEp+XJ0BR76bpgwlR8kLw14zTRyDGTyMUw2aHMcrCu1NTLi0obPPwuA94FM5+mismLHG1XXZ2TFpR8a5NoIQq6+vx1jjBzP+cIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oR/EYreY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oR/EYreY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id ED0D0EC0178;
	Thu, 16 Jul 2026 06:17:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 06:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784197033; x=1784283433; bh=HT8d07KWmpWRn3nVrLzBYFmE/8xd
	lMWGqbhR+fWeSHc=; b=oR/EYreY379S7JfxH+PXKC0MVQ1h2EaYdfF+xBuoVlXs
	f/zuZ36hix43bAbCUzq3iExdxGxS/vcY1kbwPK/8b4FF3pqUViHuEVfOTLo/Berv
	gmuE3bQYwgTdEhrZWV+1mSnIojaLHadnbPI4SBbMDx+TfdlHTyZAuOJ3brHQ453b
	cboWG+KUic/xp7Y2+pu3LxZ4BUn/pQJcQGZOKRabk77bL2UDaokuXahc4Z1ZDdqN
	vZpWUEMmBCI22hWol/toR8YMMwC+wEXYkiNmr4D66PBsEO82b8FRTqfXPjTgUbAd
	la9+JaqBwwt6JO68ZWyfhjFa5vlurY8tiw/XNL/suw==
X-ME-Sender: <xms:qa9YavI-oE3UIyoFIvyQHz7Hyl-3Wd6PRz2Z_ZQtLxtkCcM3BFY0vA>
    <xme:qa9Yap6Jo2vEBqlSv7NwPMWBmoK8wB_n_QIHp3YZLw9afaQdNIgPrjchgzSRzd5GN
    3LRvVxa2HpW9c-V8Ggh-5lKcNem2mAdkFET3AmVpNebe2F4LqQ-k84>
X-ME-Received: <xmr:qa9YapdsodZWIJaJFTu9NdR0tF7YA2rWZhgTOSRoEJLyC1kEbOr9HHLl2ASjmng_Ea1QBqYIoONJDsQNQkmC_5pq0n_wLrud8PM>
X-ME-Proxy-Cause: dmFkZTEFlgfSsIHEissvjoRolBasER+BSmQiztZ764mRrzQppVasRNhlClHBGkhne1GBK7
    esIV/FqfyjcceS+t+kRxSFHsEeeAjX1OI0YyRDJDlGav7qajaLofWyFdKKd+RHCk+VIyB6
    vf685T9Zlb/2BsDCF/oGGV1v9pYX7UTWBl8mxrULRdWcmZsTJJ8cp72qLQxumFca2I34/5
    dBWV5jAti7rvoDVLZjCLCqFWuyS6aJnJCNlfwD7DvGPdTd7UhjD7p43/XKUSyVHMuiUHfh
    Ut1XlGf+NJ93KVVL/RnXEpER+XQyLJQlIIT+oIEJaWlL2bpJEzKnnHs5RzwDNY4dQu35ls
    Jd+F1pZ+0xx1QIWExfCyJjkhAoYbzr+Ei2fMVfcH2vyqP7kgXP1g2WRPb5mA+EdSxBXZ7l
    1qtYQmznjJc0tNSTSA/2zo5VVKtdrV2LVC/ys8QYLeF9YY0R4Cwtzg2hFg9NppJ2Cgja6x
    j6VCb/akdGz06M2BCHxPDpcIJ4r8Mm3BwbGVXyAnrW2Gli2E7CuI76pseckGoo/5xgHhnP
    tKezmDUTDWQnukNmhuSyj49h3TF80QNbdbrVmRiH85qsFUWgu9ynV7USJLYZ/bIl+Do4xA
    FG7YBtIrT/QYO2Ocnyyx/UKQ1BMiQai1gTYnaxcoaSU70xcKhc3VzgKleGNw
X-ME-Proxy: <xmx:qa9YakG7nP78d19Cct29j3E9yPOWjzNgXH5487uCXujBIssT-TcDog>
    <xmx:qa9YaiTWcEQ2r2RepQhyCWYWI28Ze3tthgfC6oqzH4lJY8haPzQB8Q>
    <xmx:qa9Yaia1H6d-z7MdQqZLDq3iEAfzQHJZE2T42UOYPOR5rLwHcoZiZg>
    <xmx:qa9Yal376akCnPuKlW1S3vPP5Qmy2U7-QpVklIYxfrqNgzi9nqcbiA>
    <xmx:qa9YaveG-uwbFlLAskClYUXqpn_jzMA7XOw6dx3EtLUB_4LchdYdPycw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:17:10 -0400 (EDT)
Message-ID: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 00/31] block/swim: Fixes and improvements
Date: Thu, 16 Jul 2026 20:02:15 +1000
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Thompson <funaho@jurai.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Laurent Vivier <laurent@vivier.eu>,
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

Finn Thain (31):
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
  swim: Remove pointless specifiers
  swim: Move swd initialization
  swim: Add some helpful references
  swim: Remove unused macro definitions
  swim: Clean up whitespace
  swim: Define macros for constants
  swim: Define symbols for constants
  swim: Unexport global symbols

 arch/m68k/mac/config.c   |  31 ++-
 drivers/block/swim.c     | 422 ++++++++++++++++++++-------------------
 drivers/block/swim_asm.S | 306 ++++++++++++++--------------
 3 files changed, 403 insertions(+), 356 deletions(-)

-- 
2.52.0


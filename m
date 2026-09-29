Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1934A3BF;
	Tue, 29 Sep 2026 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641698; cv=none; b=JbrIGKm/aMSwHVNDxmkkSGJP3+5RfxbZH60+bqPY0v8AS9RQIKw+cVQlwqwJH9QKBr2ytK6jibb/Vm4NwIrRrXbY2Aaduy0gWzI3LijPNv41C+9DMiUBK4CG7bOSDADSKOkPXnKb7cSb8bs5vPEtR5ip4Esy/uKOk9S8wT0usOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641698; c=relaxed/simple;
	bh=yx3Z/Z1i1CZ/Nq8EU+wafaIB9IzL0HnFkYtRVMPTDqU=;
	h=Message-ID:From:Subject:Date:To:Cc; b=SsmEBa0MGI8fIgbDivOMpmgY1VHRR9fBueivHd5ATjCHetFt/zq1s/ddA4k3ch3SoPdbKgefiQrKy/+wAl2wGzfFUYKx88sP9B/Xk1Su7mW/+y+uyPDCVJsM1P2Ngu+EnydFZdaYcLMVUMMUJH8xn16AHlKZCimY8rF9IllSLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s2bW4S14; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s2bW4S14"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 003D2140011C;
	Mon, 28 Sep 2026 20:28:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 20:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790641694; x=1790728094; bh=xu3utU9VereBzGVmyv/XDg81Gfuj
	SCUAkLOrSNL3D4I=; b=s2bW4S14m9t6NWC5RHARxkDy8i8i6hSMXT6U+mox5nhY
	cIQjyvtrG4Ia47imS8JYsbYDFh/KeM2YaW/GylMdvtKnyIMXlu6J3ihFAQsS7QT1
	BHDo0VmOzNvcl7fYYQ2SUD1c0joAoW+QRHrsVMCCL2Ccbjxx42v6XPjsvqvUGFtj
	2InnYZzvxb50/kAKHU8oIS2Lou1U+YW8L/X/DQxyFg/oXUphUACk2zPshDK3oATl
	ghYwA6h+UksChRTMixdhDDopK0grOaytshSNvmAIY8fxwMKrXj4nzeCY5geEVmUp
	rC8ranpKhd7qNCZsxSBTeSm98ZALxd1V1VVBHpM0mA==
X-ME-Sender: <xms:HQa7as6to9zI_98JVPQtF3M9R2XszAqGzZ8VMxJA4IMeEYbI54z3NQ>
    <xme:HQa7ap4SeL7QSMSJgdH4q-jRo71BwqDL2ktiunPWRbLiEl5GkZy79uoD__FFUhc7S
    tLEh3vdmd77zLrCyBOU7p91_zhq9L32JtMVEcqL5TIQSwGH5Kl5KPY>
X-ME-Received: <xmr:HQa7atoxRar-YAV2d06vi_ZW-4-ceRYoOcG6nLUUNnUh3vr1vm4xZzxQWG9IFoGgxH2E0wsLOoVkuvNFBsmkuez0GKvxee9uvWY>
X-ME-Proxy-Cause: dmFkZTFzQtIth2WkhrKI+6+E4UcGi5XWbtp7l6Qnn6zjZLbyXTa0rQ2Iwz4ZANn6XgA6pE
    Yy8oMu49X8YEQgnHj8KX5JSvOLjYM1YH2mbz3ZOI7baZodjqs4vQiceyIg8mGPVINy22Uh
    ArlGbesjAe5dgvuWAxt4ey4RiWX4Cpyy1G41sr7B8DuyDrFVeq5mmvC1P3kSw6MQ9aD3VF
    R4t2qj6UA9VZElaIX3XxqycY464Cs9T1Aod9vrHzcxTIhfSDAtZTU0yKoVVlJ5/m9hsFK2
    h3zF6X8XPA5iM37S0Ka5lAXOb+AA6GDczC+iQ/kR0tAlKrF4ekH7C0QKjotg/cLzDFb/rU
    waro3ZhCwXEZfnftv8eBmP/hWunFYfY7wlV3NquKbh+NN5OX5iQldFhtD2hhoCvMWLTSim
    xSfE/DqLw+eU/9xMyoP/5ifDtJeBEG6Ki3i/WXkHCHkdo1Us0KLy0ae1PTgEc6ZBb9rQKH
    XIvfQQNBsNL+y/c3cnJF/M86y+NuEvSlZh13o7wQBNZU1qZAohrLVl4T6F6xxXyJJ85AYo
    tIdnNeFNIue7YeNvKPP1IFlxRpEbZfTjX6Bdj3vBZJG7Ux5f9WSjiDPk3aQNgx37bSFtYL
    +Cl7txoBoKE1ivaSOi8iPq3P5auJxlnWoxKgWSbRXEK6xV/LtWPROv0qQfJw
X-ME-Proxy: <xmx:HQa7aiP2691__pk8TTTlgxRUTWIkztvuUZR4vvlmNL656rpblI1U6A>
    <xmx:HQa7at0T_UV8XL-qActyUQfDWk9oemw7aB2nrwMIuRaBVeXU130qAg>
    <xmx:HQa7apC44i8gs5CQQdkJq-mdzKKRCe4ldfcYolMJTBOgZ8qEfJju3w>
    <xmx:HQa7aiIlmpuSeybgbn7f4NOEHTpdMPYvuj9APiNvoGZvyw-zMNAvOg>
    <xmx:Hga7agp2kW_KSt2Ok6r7oJ_FWSGWGjqYZb9kMWSN64DRlwjg5VeWtiB3>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 20:28:12 -0400 (EDT)
Message-ID: <cover.1790641175.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 0/3] block/swim: Minor fixes
Date: Tue, 29 Sep 2026 10:19:35 +1000
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Thompson <funaho@jurai.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Laurent Vivier <laurent@vivier.eu>,
    Stan Johnson <userm57@yahoo.com>,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Two old bugs were reported to me by Stan Johnson while he was testing
my recent patch series, "[PATCH v3] block/swim: Fixes and improvements".
The following patches fix those bugs.

---

Changed since v1:
 - Patch 2/2 was split into two such that each patch alters one driver.
 - 2/3 and 3/3 were revised as described in the commit log entries.
 - Tested-by tags were added.

---

Finn Thain (3):
  swim: Return -EROFS when opened with BLK_OPEN_WRITE flag
  swim: Fix FDEJECT ioctl for exclusive open
  swim3: Fix FDEJECT ioctl for exclusive open

 drivers/block/swim.c  | 10 ++++++----
 drivers/block/swim3.c |  8 +++-----
 2 files changed, 9 insertions(+), 9 deletions(-)


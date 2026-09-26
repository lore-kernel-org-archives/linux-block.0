Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA203033DE;
	Sat, 26 Sep 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408942; cv=none; b=VZgcFjDgf+84CsTnzdpch1Ke5MjVP5F0wJs3bR8yHPJJo1vIZ/fLoo9QmIA82OgU85d2lpr7qTcqRi1ihw+wUIzmXuSWdV+SAUAJCbfCLt04HYvnzCvHyrFaNwzVKVMcfq4HlCtU0gNP+G/2avOPqXpF/kyP6FbjC+P1NAqqvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408942; c=relaxed/simple;
	bh=QQQiIdqSI1XJN3Sh0kboF8zbU5xPrbwNi/kpdgmykdI=;
	h=Message-ID:From:Subject:Date:To:Cc; b=O+2LR70KLc6KX2EeDSbqIfbMw071GiY8CEOLV01wUJvC1WZicDCwaVCkLitE629iOZnUFWMPOz8OquM+2WUv/n+BGnGBeBZCi7NR6cl+yhvaZaiaqdtAAi0GITJ1yuQg+vtEGXg88mbXtsGmZX0SAuaZmK3m7+hfpW17u5vE7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x9oViO36; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x9oViO36"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C2C6EC00F3;
	Sat, 26 Sep 2026 03:48:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 26 Sep 2026 03:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790408939; x=1790495339; bh=d1mmb2UiNoeI9oVLWfvbZXTGrstl
	tGHMkToorgt7Sts=; b=x9oViO36OA0eUe2+d6F7jLlZzXYoXi1q2uVQx7oaNR39
	bh/yokP38rTH9VIWQDpjP+PE4C/LcuRGmv2FPRGkmvLjrU5Ydvz0SIOo917X8sEw
	lru62B/05KTmFEzFiD0I0H8ar+Q/fEh/YeAj9TaRWNKR5p1TskA5WhG++Iu2q8jg
	W7Hh3sTNah1T6H7AZ1ejHVvySUJFTNn9WsJ4lbbLp8EG6O4h3ncWZTFZouxzrjue
	ih1UrgwV2hLxeV9JD2jHPFxKrVIHjacF7OggWbe4hknhRThqZq3uI1uWQgjIS8Fw
	c9SRjZPecnW8dJy0Db/XGsnhItl0JdQndugZzooy2w==
X-ME-Sender: <xms:6ni3au-svBx8iQkZ9lQTLDz6sevSK7DubaQq5Ds_LTTIPHAFGsVVtA>
    <xme:6ni3aqtZwE7LF0C_HSrPD1snGfwzekix2xdKEtXMsD1i9Xj9wdxHM5nttczthiMh-
    DfcNZ2OSgQxIBbGYOysVOPzcvDc8Hr2DcMEHmpbRP24Hq6D_dhcnxRIYA>
X-ME-Received: <xmr:6ni3amMg3c4QVP7EBBpRAvuyoNeuOvmQwhfSLBLPValBX85gOFf0hfmlJrx429TxgSkA6M3YPHdGKBSKPln-C-h43F6xbCVvJbM>
X-ME-Proxy-Cause: dmFkZTEHLNOQ3U362klOxr4K3aiWR+sgIipUEvem9vaoWMXrujtJnA4pX4QM0kAvF75QxQ
    FC5vdq5NT244OduLOkFtWgO8vx1LvnrtqyddI6jk4GaOE3lUW10f1HBEbNq7jwzZTSIyHc
    GokMf+gXyw6wIeQurCGpv2K4AKLZya/vZfV+LmH0lb1RFu9CSbGLogMuJCXuw1XcEyl1zN
    GqNpEYPLVbBAfPFxXmmAGVvoQJ6G96Xr2maJnGN0DEell8eAtVPpLVMyvnqwdm2jh6OXns
    CaRRnBiWFm9Au7mmWbXLlVHGjqBx/eeEu+M1mWPFAbzJ0TU9yAZx9aEZ9uBQoUed4BnXUZ
    2Pff8MUiznHG0vkQD7TrJjeIpGNSAl2sqNnMUI+OfcOC8mqWAd4qsFaTCRKbAkxpyWzNX8
    RZtnqfN/nehGaCx3L7zoaAK+W6Z8Uty9lmn44InVIIt5CAAFs6ZAuhBtYPRESMzqTLemvJ
    nrDb4VsM/yL7zvMKf3MrgydnxdFSg76jsuCazwXL2y637JaU6VFiDIIRMQrKuQV/BcZPTr
    XCI/EvE9WgWAupYPXmNajI1lGjC6sn4TJuiDkkW9NqZ56LnakyJzYRz2sLTJMSFMQw7CtT
    3g0hGjC//fg2/ijo009G36v/z9s3TBs/Y3/jWTPxev2NeXxNWBirg7aTx7OA
X-ME-Proxy: <xmx:6ni3anicN6cpSi3SffHOvMHWg_rULqSmUbURel1cc4UqFPrBTH2oGg>
    <xmx:6ni3ag5E__4CX5Rg88fepnytje9NJFt0ddBxQCwwOncYrlE1kDuGLA>
    <xmx:6ni3am1DSdgCIJWQCxOQFUuNb23XzDZ4ENFZrpqKWTyr8IjLSzK8nA>
    <xmx:6ni3ajvTwRnUmjUdjCMVnob-30Nw9VJcf6JWJjUgQV3MwFpNeM68xg>
    <xmx:63i3ahdnywWwrgyrxe5b9rmdPAGUQ20jVBTOnYS_gpMjAwO4Bw8YtExF>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 03:48:55 -0400 (EDT)
Message-ID: <cover.1790408363.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 0/2] block/swim: Minor fixes
Date: Sat, 26 Sep 2026 17:39:23 +1000
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Stan Johnson <userm57@yahoo.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Two old bugs were reported to me by Stan Johnson while he was testing
my recent patch series, "[PATCH v3] block/swim: Fixes and improvements".
The following patches fix those bugs.

---

Finn Thain (2):
  swim: Return -EROFS when opened with BLK_OPEN_WRITE flag
  swim: Fix FDEJECT ioctl for exclusive open

 drivers/block/swim.c  | 5 +++--
 drivers/block/swim3.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.52.0

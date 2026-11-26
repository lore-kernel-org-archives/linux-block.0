Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704784;
	b=RW6C+BCylyL5vpl1GXqla0bxM+jsdkQBXsi4TVOel5hSe89mQrdHcTQ8W8IYqItPd1Cj
	 7fd+IqMWhc5wxUrJ7mW/0ea2nNUoaMkyvdw1ZIQiEiRtGqQFPrLNc8sJYI4yRQ+fv84Ch
	 k++yny/VFLxf+h9qbPZ6WPGPAbqkYd5z2dIpnfj9v6k0YnaoNu1msQa9IgWb4gBbUAU1F
	 nS4+DNNBpDd6DRu177TbYbwz0Nd4CCt2Mlc4J3mm4tm2I4AjhKecgaLhe2pDG0L0wuxsK
	 bFXiJkIPo+SJIY8+C1soB5noUGrLuVUdC6kuRvd8x31UMZI60L+jBzDHsBwIdylh7yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=L3L0Ub8N0gUUtY/O7U7dLEItaB3jvAIkFWpIo7dlmSA=;
	b=HWx/xHVTeyqjAr4V8j+//cPKSfVmN9/3AsbRLy+mZ7FHeCQ8mWeGf/HpUZJKY2OB0h9o
	 U06hgqqOkBYCpSvAu4XyQLu+LKc5uv/iuAwqnjEUNjiqhVMkYYxbSyOc+oB4JnHeVPO9Z
	 lX7r8arGEaVtklSJKR6L0TDF4UEfrWAuuoxuCR+kkl1T+sNi2bT0dVfq5Q1zn+zJBNV7+
	 bzXC3n29SF5Z9bYeNNvEKCUw9i6EBwYhS948s4fzc9xsu21GeYcAy+IFsH+pbGzsTvDip
	 +b8dTY7gZ1sIWFva2X8ilrSA5XUm3LwlXTBq3oH+AvcSt10oRMDrNNHo2UzVwJA1Pgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=HGRFlyh2;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9348606A31C
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 14:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9348606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=HGRFlyh2
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb61185057so45727915e9.1
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704782; x=1796309582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3L0Ub8N0gUUtY/O7U7dLEItaB3jvAIkFWpIo7dlmSA=;
        b=HGRFlyh2d9KEfwVpxGR63vAFRjUn7LCT76XddXpd/AphaWgsNXdxCk6xaUfSz2ia/H
         IHH/qupTme7cFNHftGDYDG3XS/fBKXPsN2KYGRKifIPqGOJYwz9MvZy4IkCGs1zPGfxb
         07Gp1rl1mBnxxr9p5zf53/i4CE5S9QxiCCwxEGHYcFvru+pzab9aWyoaVDeB5sq1Q9Y3
         AwWpFSIFbkhabOzqUURFFV9he//u39wG7BDgzs0UqP5og9YsHY/iHeSGzB2UfwjcZFXq
         x+PTXCU7IhVLTeJtTbx0YfxVu/7G8iKbf1Roxu2RI2RnU56pJPW8MASef//JEIDINYV5
         KwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704782; x=1796309582;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3L0Ub8N0gUUtY/O7U7dLEItaB3jvAIkFWpIo7dlmSA=;
        b=kFJ6QnhjDro9lq/2+sxLUzGsWliw65mQlS+9aZ/aIyeVLNR+xUW+RZ9cocddQrYmIE
         NWO8Zb2scQE+UYZ2bpQF9f+GojB33AqdhyGRXnQ3vEg0G+yOtbeVYJaKHpaSqlHA6CGQ
         5SYjfPw4XSnWAuHaIcl6URboMZrIFU0fHpJjLBLJLlmDyuzXfqSETfv2MIImfJsbA4XC
         0H4XAhDKqfjDFBSwCzVIrLSqQ1u0Rroshj++hX6lxnmrn6crYY/KOoLTk+09QOPCG72R
         D13ehJgzfkamgos/wIoRL2nEgtWeKB++lXjhWIVUlK9NZdYSTJ2vIcSgShCITBh7iFGu
         MwGA==
X-Forwarded-Encrypted: i=1; AL+hErGr1XINOXZ41/FUTB1oJy4ROdQGEPO4TH5S7LhM+m+VRpDoVXXiTFGStXzQ5PbX2Y+jtUBTFqHrmMrHsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OxqnfuuZ/81ff1IjrsklNSUhX6jBAXbSkdpWJBP1kesnxRaEp
	oFMNlXlI/SQvtIEznAAtYkWrzeygDut3uZ/ziWUc55Q66Fh7mk+wsEPZvTgjrJhRJR0=
X-Gm-Gg: AZFdTZdNBNVtfgojQtisuYNm4rxf8bUfQZSQ8xY/PEiugWF9m/OLUTw6/TwdQwcexPS
	2F7Ag8BtNRBXBiwTw/JYgyG6wFI51hmY9wgZi8m1RYRcQtX4kWjKTONCuo0tRsim2MDYjreyQpk
	ouFiO27N75Ktu9pNuks6vu4ipA5Lwxb6GSLE7HZNZSJRLH+gHnLuvlJuAfRvBkak47NhJJIRzWr
	s+8OdQCXijMUz/EHAjHtMPfWJWvJYlaTJX3xBTfjBZWNJW4+lYxqPxXsxst4ynRgdP1o63X5aPb
	YAzk4avvcXz8+qNDd26RzY3W1imHdp5VwASEy6Nk+0R37xfvxy+hzvWZaqUVFvIExRcg+IDKT3P
	LrV6jHAiNvJFPbVXj3sFjk4/+WSFfBGU5tp5/G5DmhYXqZfG3f+hIGJbbaDAedN87bITeBZP9pA
	nqrmaKKUaEJg5VDBDTw3g4HGTygbcovxD/cOSQJfDP/PpzP3W9qFBjd8waAizHQIUWY8qRnIWDN
	UJine2df47CSV7D8PY2a7WHuNroHonPiChcvogvmNUlYIQXJr/mFf9PkhNqJ9pwJp6a9RmGtDAP
	ZSUmQUSZAIEMN7rf2WUdvAz6N1EvpnG7CeFl1oCuzrDPmjB77u+hE4RfOOY1ba73DcKVh3+eew=
	=
X-Received: by 2002:a05:600c:c086:b0:4bb:a5e1:8288 with SMTP id 5b1f17b1804b1-4bba5e1b76amr87718865e9.6.1795704782235;
        Thu, 26 Nov 2026 06:53:02 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:00 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/4] drbd: assorted fixes for discard limits, bitmap IO and resize
Date: Thu, 26 Nov 2026 15:52:53 +0100
Message-ID: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jens,

a few DRBD fixes for for-7.5/block:

- Assume a capable peer for the discard limit before the first handshake,
  so devices stacked on top of DRBD don't latch the 4 MiB limit.
- Fix a lost bitmap-work wakeup on weakly ordered CPUs (seen on aarch64)
  that froze application IO until the connection timed out.
- Two resize fixes: don't silently truncate the device after rejecting a
  too small peer, and refuse implicit shrinks on resize unless an explicit
  size is given.

Lars Ellenberg (4):
  drbd: assume a capable peer for the discard limit before the handshake
  drbd: fix lost bitmap-work wakeup on weakly ordered CPUs
  drbd: resize: do not silently "truncate" the effective size
  drbd: refuse to shrink on resize unless an explicit size is requested

 drivers/block/drbd/drbd_int.h      |  3 +++
 drivers/block/drbd/drbd_main.c     |  8 ++++++++
 drivers/block/drbd/drbd_nl.c       | 22 ++++++++++++----------
 drivers/block/drbd/drbd_receiver.c |  5 +++++
 4 files changed, 28 insertions(+), 10 deletions(-)


base-commit: 64e3fd6772bd8621a751fb916274be2f2dee3a16
-- 
2.56.0


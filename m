Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2817C7CE;
	Mon, 12 Aug 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470734; cv=none; b=EaCABNJRYbV4roznV8VRzppQ/6+uX/RX/pBNWEY2OV70zYmPlHfX0ye7Hxug+bEgmn6HUnoMm7von7ZfmOl80tR0nJBseaVWYOBXk2JzX11vgrrKm6uPfLzUe71rSvtbF0X7pSqUtECoqJCslputpqwyImt2xOt5M27/NeVPKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470734; c=relaxed/simple;
	bh=V5ZPDmh43i8l3KEoh21SaPP5tY4BJlAs6+FKR38+K3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmgnwdJLUZzdyOyiAS5Ks3f+dE1gVM61k8A3RO1DSy+Ld3nSngBiqYvhWIrUyBjzUfRJmvCGF0cINfeaWJviH5vVlmmmoZVoat56i8Gaheb2Pb2PlL/X2737FlxgI6FdUq1nLShTa2jUpPqB69R6GbTP2JNlY0W2KGa4rehNW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=D9ZrLrho reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="D9ZrLrho"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A+4sBfKWeCfbuDkaZhU1Kf4QCY1Wd5VUFDYqssjztWM=; b=D9ZrLrhogWPSlsuueziK3CCG8L
	AskBvCoEspbaccPX9fDLjgjNgpCVk1JKlE3spb7r5yH3QvaxpZOcu6ByVGnzSeiku8U/J6Jo5/1XK
	XB2dBuEgzLtLgMc7wUq+9fVF3EIdqibz2IYzH9aJnP45SRpgTA8mOMuhMbB0Wbr7AzMF3qThNaRvP
	9Jn5xB7lMin6eQLdgzC+YyZf8CSADkL8WlWLkekSn9cUjSM2q8kG3ZvF3Nr47Ph6yuaC/6CxvR+u8
	b38W7bHfjPwEGQUX1WQ+Va8CGJj3X2Mq8TYDr3BffWE4djseVHnT/g+lK0S15onfY/rE7OKB+7fRY
	C633ennw==;
Received: from vc-gp-n-105-245-229-160.umts.vodacom.co.za ([105.245.229.160] helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sdVSv-009Xo8-1x;
	Mon, 12 Aug 2024 15:52:05 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sdV9C-00000000V5W-0Nos;
	Mon, 12 Aug 2024 15:31:42 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	Eric Blake <eblake@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] nbd: WRITE_ZEROES and a few fixes
Date: Mon, 12 Aug 2024 15:20:35 +0200
Message-ID: <20240812133032.115134-1-w@uter.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the WRITE_ZEROES command for the NBD kernel driver. While
here, add NBD_FLAG_ROTATIONAL to the function that decodes our flags for
debugfs.

---
v2: Divide UINT_MAX by blksize for the maximum number of sectors
supported by trim/discard and write_zeroes commands, as NBD uses 32-bit
values for byte lengths, and otherwise that wouldn't fit.
v3: Use the SECTOR_SHIFT value as a right-shift operand, rather than the
blksize value, to get the correct operand.
v4: Fix commit messages to use correct style. Thanks, Jens.
---
 drivers/block/nbd.c      |   12 +++++++++++-
 include/uapi/linux/nbd.h |    5 ++++-
 2 files changed, 15 insertions(+), 2 deletions(-)


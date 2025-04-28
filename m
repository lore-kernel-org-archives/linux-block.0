Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A92156677
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849421; cv=none; b=eabeWy4IUhI7i1Q2fv7fogExN5GV8hKV2w64IbEQl0546iw+N/+To6/zNGc5uIHJ+W3sOiTw1vTVmoQptXmnS+giz2CdxSdyjGlhBWYk3ac/4BSW4ZnxFW8nWTlhJdhUEcqrncZBVnc/ZE+QC9cC2pmms3PheKWrIARslWyQXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849421; c=relaxed/simple;
	bh=XCUHV6qY5DlwFZ1MLjFKxLESqa53swMiLk0QMM+ZdQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSSdAhbJ+RWpprwcY8/sw2L40aotYWjYDn2VLvdYmPoFoNtblaOxgdt1S2jaBvgpP20d2DOLzooaIS+hPV8WZkDqwUD02s9pDE2ynkRY1Ud7hWMJufko70H/sVg/zU/wfuKRuE1DWwuF6Ud2myjpWF5veblDRXLW/g2x73VII20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AnQJfowY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AnQJfowY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gxvZXeMXWtQPOeXS7LSxja14FN1bqd78Md3KR+AvuOM=; b=AnQJfowY3qDlBJQNOBy2TgVwIJ
	aTLnWTkk1UJKWhw0NF3WlW6DImIxxwG7mDqPEaP8FG1XrFhr2r3aXhM9iwjlCSL7JxkVues0q75Ed
	rwc9h/k3Qh8Q67Ps6HBd2i1SsTcRsjBaKKPdtGTQC6ymfe5hhS4ZuIheycc9O8acpkxoWkehjF6CK
	I/5CbA50ynDRXDL0FUXznhje77yCMMealA0tkdr1STCdn1zh0zhV7tyII2pG6MRkREaQWeQgROiOo
	IQLpp3ttCUIFFjaLCelA7ebw2GhDosqOj6nwHzkAEfr7NoW2u5Vi3v+2zyex1DPPz0gtrwmMLpRPF
	FTpHY07w==;
Received: from [206.0.71.28] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PBZ-00000006aV4-1VJO;
	Mon, 28 Apr 2025 14:10:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Subject: brd cleanups v2
Date: Mon, 28 Apr 2025 07:09:46 -0700
Message-ID: <20250428141014.2360063-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series has various brd cleanups mostly to get rid kmap_atomic and
poking into the bvec fields.  It is used as the baseline for the discard
fixes from Yu Kuai.

Changes since v1:
 - fix a subject
 - minor tweaks to formating in brd_rw_bvec

Diffstat:
 brd.c |  166 +++++++++++++++---------------------------------------------------
 1 file changed, 38 insertions(+), 128 deletions(-)

Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E339281F
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154695; cv=none; b=QG0mkdrpqaMUvtE9P9pU7s7G/ouaHRGzzLwU91KeIIREaS9Bk26Z4/TsBP6hz5cmFR/yWEb2T0pi0DSxypi1D1LpecgasSfeVj0WHNM36QMxnw4n20/543SQGVaXVymQ48cUM/BAC71a1oIDR9ZdI6eSA/s5wTThD0GG5hUeYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154695; c=relaxed/simple;
	bh=4Y8GlS84uClttevE0oE4twJSi7qSnCj4czgcLNYyn00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvyQ/X/0mo1zPFmjHWMlySuhNJzcJBseKo6b1xoNVpq7nFeZHFKrVuVw586hfAYoapObr56LKeq6DlT/QZglYogkbfmH4OjhcRC7aB3AJsF2zowP2QJUME+aGXzyNo6hhAcGtIwmTqG7LobW6sTOtCFHkJlDZhCwFQCXmXhx7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4lRxeT+N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4lRxeT+N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=N3iT5ibdbK6iGzthYws2du+/IRJERIxRVtz+MPsDIEQ=; b=4lRxeT+NYMgmEzSa247Az8eaqn
	7V/UbaNfi6H7EJZAGGlZM9QmxpscwxlK/jXOFs8GygceHvlot2awBbdu8M1L8hAkQDich+JxjVNA8
	wsh7svWpxtqpegkAQb+v5gxKhmH/dvQ1hXa/F6/3sRRdgBAK/e/A5Esj8YyLjfehTm/n+//py9ciC
	JVcMbpsvg5WPrt3OstnDtaggJXic2bV5M34moh9J4UNjpheUzbDfk504DI81FU3oVslW12sje3sw2
	li6UtYP5cZaDtghDfTrhAumQ5QOOp4DPcruHaIdbqKOlLEEpzxvC81EScHsq4n/wDm2QIUU+MwYIi
	kIJRNWUg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYyM-0000000GxiM-0Kgh;
	Tue, 14 Apr 2026 08:18:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: zloop fixes
Date: Tue, 14 Apr 2026 10:17:45 +0200
Message-ID: <20260414081811.549755-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixes a bad bug and a few minor issues in the new zloop code
queued up for 7.1.

Diffstat:
 zloop.c |  123 ++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 59 insertions(+), 64 deletions(-)

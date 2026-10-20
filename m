Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515804;
	b=qxdBpLBqvMOtNMblODEi+DVHOaMhP6ew/Un2dEStiIQ6RM+DQJbljpR79+i80MbeEcha
	 1XYPaQv6ZZE5vj9/fsCVE6TnsDIFrbrEHAgIOWO6YFwufciNcSJL9nNymb7+cWdv+4Txn
	 zqznXaaWBkI6Uw5DrZpNPVlYQg11SFn9OwCTl2kvuqqK2iv5Fv4WpG+itbsSg4LDhNrfZ
	 aSTiurMhJYKYS7W/MK87CAdNBl+n8EMzrnmTBBY3TwAGf2R0+Rona/o3ssJA2uLpizjyX
	 ht1VlVKZmxzlIFobgeiWwfqW/d3EID9MIxA5wg/yvNgDPx3L/3HgBwgcjQzSd44HUCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515804;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oESoAQCuZrNGKORfGFDQ3eqpeMZSdJxrF4wmGNCHWgE=;
	b=l/GnUfTUvIpLyucUyVHFTRF5dsAl2oj302wWQvOq684Dnv6WueniULtm/asWbl1vjoVv
	 aM0p8d1zBZgMdk80iHUc7M/kzDT0YzrbBJSy+psYKiCEVVFnlfnN5shTdHVN6SXy3pwEo
	 p4eVrlrOfcNe4RkN7b6LOsWs4rxZphVux8ji4VuC8jV3OfL5mvpnv/9pCFBig05YvGvVu
	 gApRrZlGauAC5vcF8RLudm4DFAEC0tGZsKHYqbq69gkHevfGWKdxNdopWnF4A4TiYZouZ
	 DLUornzgI0ghwZYihUn93l/dBbXlE+n+ZrBdi1+lluPhskPT0PUX18eqX+HduhMFx4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oZ8yZ0zi;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973D606A333
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 17:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A973D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oZ8yZ0zi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oESoAQCuZrNGKORfGFDQ3eqpeMZSdJxrF4wmGNCHWgE=; b=oZ8yZ0ziv4/4+5loOTwkNJ5tJ+
	SOV1UhheQNrl+fXhTxDcKK8+zSOktH4f7qXY1lnDyzGDLihaMb8G0DITJZhk0rF00/8IwSAQvdLFt
	nOM0arIqTk6WLjt4IMbk35CBu10owJ3myoa5djeD4Hahf8dtfkG3lFDh7U6Uve1cd+4cMUuhsGc1K
	aEa0Eu4UlVa1u60R0qtcT6ZfnRbD8Z4E64HTW85qnNJjd3rmrbbM96isIgY9nV7+p/dtwjhFszQfC
	1yhyf7HODc4Zr8y74owifzydYTDcQyYt3SEJFBJcIQtFEljfY1msBzJxuzfhxC9p4uQD8C8jX0kDk
	T4XPE6bQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDFD-0000000AImT-0PUV;
	Tue, 20 Oct 2026 17:03:23 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-block@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Phillip Potter <phil@philpotter.co.uk>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] cdrom: drop linux/fs.h from cdrom.h
Date: Tue, 20 Oct 2026 10:03:22 -0700
Message-ID: <20261020170322.3687068-1-rdunlap@infradead.org>
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
Content-Transfer-Encoding: 8bit

The comment "not really needed" has been there since the inception
of git history. I have done build testing of all files that use
<linux/cdrom.h> with no problems found.

<linux/libata.h> includes <linux/cdrom.h>. I have also build tested
99% of the files that use <linux/libata.h> with no build issues found.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Jens Axboe <axboe@kernel.dk>

 include/linux/cdrom.h |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20261019.orig/include/linux/cdrom.h
+++ linux-next-20261019/include/linux/cdrom.h
@@ -11,7 +11,6 @@
 #ifndef	_LINUX_CDROM_H
 #define	_LINUX_CDROM_H
 
-#include <linux/fs.h>		/* not really needed, later.. */
 #include <linux/list.h>
 #include <linux/blkdev.h>
 #include <scsi/scsi_common.h>

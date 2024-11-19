Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1B1D0143
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032722; cv=none; b=UYPOCwy/PUP5RmvtPG0vLaz9pHU5Gn8a2ZY/1b9McZcaQmoYTiL1aQ9oS38pDU303RGBI9npr2CoHfAe1fWDfEfvSir8d5e2E2dgUWXd/pps0C/bMTyKWB/XFhn1jj08uwcLfWvNguse2YNYh6xJtNDAphZHK5dWjN6moF2d7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032722; c=relaxed/simple;
	bh=wBRkG6e0kcn235OHZBTY4csUNPAwWpQo772I4uhyd7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gamIwE+Af6+6FRvGygroEyU2sqpgU7zmHz7diazSFym8R31Xwu5ULLBqmde4UrQonPZlSXPY/ZQy3w5J7UsLBVVwilCsyNxI3k16mA32Z09YYziGiiz61HOt4jCQO0qOlLKPd6f+e3Bp98lfgFcMt1o0CP0OsHZ+1jdAnVT1JLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yNZJc1iO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yNZJc1iO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3m3Q6N4SSJrS6T3lZoYmPRGCxPpe3gUwkjOTOh4Atxk=; b=yNZJc1iOACdqX+I+dsJDRgvfJe
	mDrK5hHVZZwGVQVXlvfdXgxgd0a/t73OSvgyuyrDuxkl4BrShMnZQ6ihtEKS5K5OUWVX8+vnmSYTJ
	7gDNtMvkgLFtbzGSAnI1QHHo3VpTzyq7WtwJUHMzq5ZZ/47L/FhZVd5OfXLpaKH8hiOyUWrEM2pnq
	NmbpPhcgDqbQy/JAiymiJhSe3xw4AWXLIc5q0YNAlnpF29pGzN1/xw0Z2ifeQQowOtoHVg5ZglfuD
	IQ/TQrJx7/K+UrPWdmsgbMzWV+qqLT1f0QoZmWbXR7c0OAJyHw+Cy9HNAt6EDmhtILsGUZPcPLG4z
	Cyt+0kXw==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQpc-0000000Cz2a-0S6n;
	Tue, 19 Nov 2024 16:12:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: clean up bio merge conditions
Date: Tue, 19 Nov 2024 17:11:49 +0100
Message-ID: <20241119161157.1328171-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

Dan's smatch run pointed out that there is no need to check for a NULL
req->bio in the merge bio into request and request merge helpers
because they can't ever be reached by flush or passthrough requests.

While validing that I also found a few other odd bits directly next
to it, so this two-patch series fixes all of that.

Diffstat:
 blk-merge.c |   35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

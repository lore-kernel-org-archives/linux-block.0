Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E851C68BE
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032578; cv=none; b=He0WNxRhNIb1pbPbf87/oQT954kH71RzNoAO7vCrwKf7PmPjxhje9VS5+M/NAvWSrsYw/L4dRt/Noy5cJujqZyJ0YeVs6DQROIkgnAfjXkfk19si3vILKIbIqszmGk5t5iTTFAVwQ+RDIvK5dPZ2/FDalAVPftHpapRZD/8+HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032578; c=relaxed/simple;
	bh=mfMmq0n4Ojtju/w263bo4wfv92nQyMZYkwn0ScK42m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nU+RgBon1yXE68NTEGrlImCVFKkMKEAjSmrz/F4CEjXLt7yj5pa9gFmftnAANPgv60qG0D4LpGe5Y/e+CS6vaf/G9G75LI2EKxmUaCrLMLLsglXrmWZj4QyYdtf1U4nWf0J8XUtdQRkwyKwigB0LM0ki77h8eJCdMmckhRxf51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WFeQYRsd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFeQYRsd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9h6cYAEIS/daWazsJyy2ofUdaI8EqANxrjejDawQNW8=; b=WFeQYRsdUuBBe0bTMFDLZNZaB2
	Y5fXMGLnghnPjMjkUAQJ4QQfblBJ0F5W5RVIpZkABvIDAljurJQWptmPopIUcfnTsGqfbsBxQZPhD
	Vr1P/iBBJ2E/0sDKhUG0yB0Y67+ZjwH5915+DmMFkj7PKpCXAuEra5ctXEfeK7a8W/kWUCcNLq0Yh
	Z67BDrYqBvCsFYKcJFPWVh3tz50ixdOkBaVLhj49edxZCIloIn5Gk1lG2hJyL1DSEwD/hEX6KQYEP
	4POlZF90Gr3gw4X5DpbofKmqdiHqDYjlBTUEtIUKDs+UloKYJKr5BEaWGDqcs/4EgEoTOQc8kpEUm
	0tsp3/Lg==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQnH-0000000Cyk0-3Rqb;
	Tue, 19 Nov 2024 16:09:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: more int return value cleanup for blkdev.h helpers
Date: Tue, 19 Nov 2024 17:09:17 +0100
Message-ID: <20241119160932.1327864-1-hch@lst.de>
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

as John pointed out there are a bunch more helpers in blkdev.h
that return int when the underlying value should be unsigned int.
Thid series fixes those, and also switches those that return boolean
values to bool and drop a duplicate prototype.

Diffstat:
 blkdev.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

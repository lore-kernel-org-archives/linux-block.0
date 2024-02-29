Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3D137772
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217550; cv=none; b=sx7QtRdfiwhbl/QgxBwSGD9YSfkvTh6E2hff6ifTAxocQzpgNmR5g32+HW2a+jhdbBw0IAjIhQPCl3AUFrBwmJ67Huzn0zWYOjIAav5fdGEtRFc9BGBE6mdYQcZuJe6fLADNT4HScWQ74YnJZq1aD/cfQ5Le37ClMv9/v0CcROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217550; c=relaxed/simple;
	bh=adZyo6pE2m/plXQTB/wamQvECGMrXXRSR+ZcPOyRwA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GTfKN8ayA3lIwwAHsAs9STHGJWhIKjHLCMCIOjS2ytX9yTDaM8sYr9fN+2yT/kfayB18pppE5mE0536svCJbqw7msExV1fGP/V0im3X72he44SO9j/FNlJm5ioTErNuUBV1QZve4+UFS79ic9KiPfyi7LKp1+2c91UsOqWRi0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=STH2NU4k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="STH2NU4k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=perIjoAUmYxlUdQxqsH8WVRP7++pJ2+r5osSF6CEQdg=; b=STH2NU4kBLeADWRl1a5Bd7hccK
	LR6xCMygraUcWNgz/ymlvwvFz4hdK1Z2oX3S3pJeEtUdg28lfoOyw7kqx2a7eih+oRH5p2HVNgjNa
	g+yfI3M5vDrhOh8sFnZMM9UPjjj20UbUy6RCJfv6aJ9A8V7Ml1dmTF+gZxDX6AR4rkjEbEHGXgjEB
	JFRfgRnqYjZRDRLRAOmtRRtiJ9EQ0faKIWjHCx6caSzCMDzWQwnwVVFGDEFSExZdz9nRgOI128ceR
	DxIGsGGVti81VCxFl/5BMWQRIW1TDFdtwST5mukZPl7ocpzUELZjeR8OIT/JbGdoMabmbQ8rEKSDt
	hNo+UQaw==;
Received: from [216.9.110.7] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfhYx-0000000DtkS-2wLL;
	Thu, 29 Feb 2024 14:39:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: atomic queue limits updates for nbd
Date: Thu, 29 Feb 2024 06:38:43 -0800
Message-Id: <20240229143846.1047223-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Josef, hi Jens,

this series converts nbd to the atomic queue limits API.

It makes nbd/001 a lot more likely to fail due to widening an existing
race window.  I've send a blktests patch titled "nbd/001: wait for the
device node to show up before running parted" a short while ago to fix
the race in the test case.

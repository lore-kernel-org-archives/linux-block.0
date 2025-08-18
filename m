Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D142676C9
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492902; cv=none; b=JRBjfF79u/eOgE8qeMrgh4c3hegxBCrcHlGxZFTMNw+xMwQG+C3DXKsZkUv6EYjwIpc8zPCu+2i6hjYv5coy56IwoZ3fnAgnpFwP4B7BFJi0AHi2ZKPpdVWEarKm4dn837z+fbqgMU7sAkJIh8m0NRuQD/T1YbEaeyUOr59PFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492902; c=relaxed/simple;
	bh=MBGxHtGwfUmOXnMz9eFnIZaIUJMBX6dA6mTcB3WRZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPjxYHjXoTEjcSScfvC99PzgW/VHikfiMElse/djPddyjyPoDcXyeE6vyuJMNI5o7ENbfz4VejRrGEMXGnTlWrNSvlJRhDf6e3nIA3lOwlD9bPJM7YXq9TCaX9XrM8BCu0GvOXvmDDFPGy4j837BwuqyVVh/DDFARrV1C+a5MYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s5y/eu3z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5y/eu3z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8hb0eTF3NxRA76pS5wqU+0GprLo8TPB5CO7a62Yvw6Y=; b=s5y/eu3z61Yv9Ojm8uFQrajrHo
	Goi7PIz7RnG7p92y+iujZFD/YBwJvHtYHHZW2rnuANV/eFDORJBTwccDhIKQjn9BPuFGLwU6C1DzW
	f3207uDOtUM0jr5cWPlVWjbCWMX1SmRdNTt374CpekmHZy7IMPXdaG4jdmNFPZoz0Yr+NdMgdXIGv
	5aHZszbwOlVk0ZNIW5T9UrBZddI0/qoJgymUrNMr5ZBuqOqJPs10DhoXav0t9bUy4P3jcheHE6sLz
	7UKzNJusJjxCfL4MPCQLyFUz+qnIU+MPOJccI1Cl1FkHz68IyGx0ZYFMFwhw9nf5HRHCcuvK0/ov8
	hn1UOi+w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unrtb-00000006VPt-3LlH;
	Mon, 18 Aug 2025 04:55:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: fix stacking of PI-capable devices
Date: Mon, 18 Aug 2025 06:54:49 +0200
Message-ID: <20250818045456.1482889-1-hch@lst.de>
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

this series fixes stacking devices such as DM on top of PI-capable
devices by adding support for the new pi_tuple_size field to the
stacking helper.  It also makes the error message when this goes wrong
more readable.

Diffstat:
 blk-settings.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312252066F2
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494677; cv=none; b=tdoSLykdLqg/IJ63Ubdq1LXmNBh7QZN/Qo1K1Zz2uZvts8Kz19JQFJr69BYoUQSrkhkosu3eDp6uQ7zXzh29cMMDfamLsBhdqCf0AMWhnsIuxWlk/iqViUSoz0Tc4JJkjQf7TQ+XpHajhAjoyBdzz7uDPQ8kGWSY1dUeWyPvUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494677; c=relaxed/simple;
	bh=7RQPWqEQxHEG0ArWb+J7sjJR0RDblrHepgyNHHuaHl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpYGIn6KnUHTIJvearZMMPvduX4nadqdelbNR8AvfoNyzdawsi8UVijiy7JQM8h7BgvoG48wrVMzeL/ZzkUHN1qts3ezwQjW4IXZIaAhwUTIok+dxZBxepy38GXMZOs5JDur+VgBi3PeIUOtvWD+m9TCgiTyti2jFMvB0SE4htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ja84NCVR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ja84NCVR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jE3eja4TGVMfGmdpOBgi7WS+Xc35m2M3XC2uSlQSqVA=; b=Ja84NCVRyJ8PsowdpqWmN02E6U
	Qc0XaozBrIF9u3DgYM/IH8xAhAQ/0iF8vyvlNsbP1fp5uA9efVgeomfF9PIZdQkuO5ZsfPM820U/+
	Z/ivwrFSqdIYyOc3GxyQRvbD4tVMrpyWETaAJbu+5gVTp5+SBwOFdoCCxSDoAtVMyF9PdrCxWNvFC
	IPBabqaK/YY7+geesUspBDT6V1q5aEqNlacIyavJ2CVwy9vURiLa0YVrd+IOacP5DL9Lp2KWhxHM1
	RbrZJOXH6rfsAewtvfkfJFSZsBJioGXgoz3NUer3CbQJI5UEqhmGCvdNPUau/o4D0CL63qqPSd7Dr
	yOxs3hVA==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9ac-0000000EONj-0pYh;
	Fri, 10 Jan 2025 07:37:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: tidy up direct I/O flag handling in the loop driver
Date: Fri, 10 Jan 2025 08:37:30 +0100
Message-ID: <20250110073750.1582447-1-hch@lst.de>
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

this series fixes a few inconsistencies and cleans up the direct I/O flag
handling in the loop driver.  It sits on top of the recently posted
"fix queue freeze and limit locking order v4" series.

Diffstat:
 loop.c |  123 ++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 61 insertions(+), 62 deletions(-)

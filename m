Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9303C1984
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255862; cv=none; b=Yyjpvwxlyr+vH3fT3y+RkwGTaEyq8pyVunMfM0JpjrNPtEgjGk2R7p0ZdwFlfeo65qkRl64M86pvwd7vFN2MOc6OslYk4xYbgkf0uJ2Q1gnez+ZLoGMS9GGEXdqhG8S5cwCpP1cd5fAsvUJS94Sh5iNPkusalnyvx/vQ3DOLPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255862; c=relaxed/simple;
	bh=B0mWhkVyn+hXPyozb9Iq7XcUCDn2cSTDXvuD6y6EP3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmzth9FEvWIMigYtJlYP/ltm9nIoDqPGLuuYflq7k7AyjDtmhNhEtORWIuuZ9FQfuiwYx+4qMXDDXXNdKhznaFkHBhknPS0Z7dIn6QyVTGXPSHcEfdeabKR8TlWVU4Wjp2SKx5B2yG2Ca9FvUAJGLw6o+MBWjkNGJolwPq7G+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2kTLpHtt; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2kTLpHtt"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvNz2K6pzlfqKv;
	Thu, 20 Aug 2026 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1787255856; x=1789847857; bh=tK6Ce+k4HOI+4OIuTN+YyyO5AWDTBj7I07I
	yAjFiu3Y=; b=2kTLpHttRWafbKxF3jdMbMHdY6wzgWM9v6u6P7sbIphaRwos822
	fJC0tXqjVjUmy7s5ncdnJFA9zS/GqodBOcevaP8Wp720QTkZFW+2o/JrOBLMe4wA
	xmar6GBzUOKKCC9jFhW342bkiA46r6Lkn4BRl+VQDjc4nE9foq+5GCR31SPt7dsL
	XqVShZLJVvkQSyzulETZPCTwXH1UibTYDdBfvJdfmQOie7IBx9A8B62vKgoiMxtK
	sNWbwyG9JA7P2jdYRx9sayNzzQqmasjo4FgmJDbErXmIFUMpU51Gq6J3Hiz1uEpF
	yBRGIaZMBg5IARhruURZrPYCPOMlkKDAiCw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gvRgUOGOmSkg; Thu, 20 Aug 2026 19:57:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvNv1p6TzlfvpW;
	Thu, 20 Aug 2026 19:57:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/13] Improve the loop driver
Date: Thu, 20 Aug 2026 12:57:08 -0700
Message-ID: <cover.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series fixes two bugs and enables lock context analysis in the=
 loop
driver. While I am aware that the merge window is open, I'm posting this =
patch
series anyway such that reviewing of this patch series can start.

This series of patches is a reworked version of a subset of the series
"[PATCH v2 00/12] Enable lock context analysis in drivers/block/". In thi=
s
version Nilay's feedback has been addressed.

Thanks,

Bart.

Bart Van Assche (13):
  loop: Fix the code for recursion detection
  loop: Reorder checks in loop_validate_file()
  loop: Enable context analysis
  loop: Assign a unique lockdep key to each lo_mutex instance
  loop: Add more __must_hold() annotations
  loop: Protect all lo_backing_file accesses with lo->lo_mutex
  loop: Fix race conditions in loop_validate_file()
  loop: Remove memory barriers
  loop: Split loop_change_fd()
  loop: Split loop_configure()
  loop: Remove the "bool global" function argument
  loop: Modify the loop_process_work() calling convention
  loop: Add __guarded_by() annotations

 drivers/block/Makefile |   2 +
 drivers/block/loop.c   | 382 ++++++++++++++++++++++++-----------------
 2 files changed, 230 insertions(+), 154 deletions(-)


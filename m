Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948472FDC54
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813825; cv=none; b=hYhZ8Sru6LVKf08k1Up9RQeUFSMRIxmZ9q5VAcV3sHtIjpd+PkIH6eaJWqCXQpA0UTxy7BHO129t/zj1fMm7PhUIeZbUWq0OPcc195CiJgqCrSHrK5nzpxuD7JNdIDJPOTFOvZCA2IcjdadBVs5j6UZYwt9JS0KjmtxZWHLbYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813825; c=relaxed/simple;
	bh=9zBndcnIzazmTFubweGCcNOBKb5xcT2XWQj0Du19Qzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0kjXiefWHX2n9SYyNXr8PEeN5hTXw0bv5++FVfRcwM22J7u6zNnpGY3y+Lxx0TWyCn3iqDYoYyG9rtG054tlC8V8nvZKwUE2ENy1luMh9uZf8IbvJZ/4pI1gSXZWXWLf3b5BphH/hFVHLhR9TklsBkzdH5QX33/1V4xBXYlLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RCARCXrF; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RCARCXrF"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d549l3wTjzltH96;
	Mon, 10 Nov 2025 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1762813818; x=1765405819; bh=3dHHpUsryC4KBhyvW/NowhoNIZTz3RAMZaE
	5AGagi9o=; b=RCARCXrFYNpaPBhJR3mmMinp1BakH5XRRCwjavfJ5kgc+NoJo3A
	7SYKLg8fJ4nynmUe3p/USjEPa4PeCc3WYgxzFTNAPwgRNlCKEmagAtlR8h4AG3cz
	Tm6l2wPWem1AlDdDd/AyTmm/oHqXvpWAKIDAVQKIYhClppDCxiWpuL11yCP9Z813
	n6vhklSzRGJukQkLlsJVN4zG5KfCkS4Bz/zISjVBUOmdchYq4dISL07V/sRZIdLH
	MzaqUXyx9bg7nBg9qjwmLJh02sY2Yd8hxdwmgX1eL2XbA9gTa5VzcScYi5c3zP8G
	+Nia6zUGthbmfEXKSIiQ6bt1qhbCx5aPJ5Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dtFhVnUE117K; Mon, 10 Nov 2025 22:30:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d549f6z2Zzlrxs0;
	Mon, 10 Nov 2025 22:30:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Zoned block device code refactoring
Date: Mon, 10 Nov 2025 14:29:58 -0800
Message-ID: <20251110223003.2900613-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This series includes four small patches for the zoned block device code: =
a typo
is fixed, a lockdep annotation is added and the code is made slightly eas=
ier to
follow. Please consider these patches for the next merge window.

Thanks,

Bart.

Bart Van Assche (4):
  blk-zoned: Fix a typo in a source code comment
  blk-zoned: Document disk_zone_wplug_schedule_bio_work() locking
  blk-zoned: Split an if-statement
  blk-zoned: Move code from disk_zone_wplug_add_bio() into its caller

 block/blk-zoned.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)


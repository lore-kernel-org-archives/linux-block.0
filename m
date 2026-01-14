Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8B30FC19
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418898; cv=none; b=NtcjwnbcyYHTxpFLEzq7XfmciG/jWT63pC022AFaTUyTQdRBP3MbP1JYtQ0yzM/ckPCOpXAclj0FxVwSZNHb8/5xKeWh1+FdFCuDGFE8F0gZM1x+//krEVGj1X2CMIwufxa/N3ndrcbDYSSlxo0VXGTGLpK004Ix5B9/4ZU/Sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418898; c=relaxed/simple;
	bh=gYk3qfKOnCc/hZZVpNIb8O5oRaYx+qc7kgmxxSr/neY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RC+85nOCjYkrWcZgzHY5GUaGGO0pt15EUzr+UzoGb+Ou45xdhUU6ki6oqz2eS27e5MtNn6v/emKjQu/WIWVgPTmyWdkD+VFjR/lU2vRp3vEeNS9LoLdlY3adfptGBLXtlXEhXmfUDij6S5oovMoLWx55Bh29GLn9feKHiJG09SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gPkqa0or; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gPkqa0or"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4drx3j0jn4zlfc9C;
	Wed, 14 Jan 2026 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1768418895; x=1771010896; bh=zefvVKDJhOF361kCW3bI5B1547VnwrvlRcG
	e5e3rhD0=; b=gPkqa0orbR5pREcKlUtJRn/ahyR2ScFpfNmfcAAD+DoGE+oRE+b
	uSm3NXAkn/nyBW140aGbqG0nHFazQAyRq4CjThaFmZtoW9kMKINdXluTA/+J1neW
	vGctQZE32wUTJ9K/w8tFC5tgtMqnJx0whVU408nV90yyF9t3uyaBC/CekoceG0oL
	ynT87nKM1z9EYDLDlSJtmZE7y4aZGnlSpPk4GHiH64tAwDLhKvruHdKF4lmLezW/
	KfojPRbxGgF/D3xNQth9YIa/8gp4agkhceHXeDwncLuTxi2fz7a4xZl9HHV0XJlY
	jhBop2z9hKqFP0n2cuIKkzuHlCWjxRGOnag==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id U2mz5utAcp3Z; Wed, 14 Jan 2026 19:28:15 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4drx3f5f5Dzlfdfd;
	Wed, 14 Jan 2026 19:28:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Fix an error path in disk_update_zone_resources()
Date: Wed, 14 Jan 2026 11:28:00 -0800
Message-ID: <20260114192803.4171847-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series includes a fix for an error path in
disk_update_zone_resources() and also the patch with which this bug was
discovered. Compile-tested only.

Please consider this patch series for inclusion in the upstream kernel.

Thanks,

Bart.

Bart Van Assche (2):
  block: Annotate the queue limits functions
  block: Fix an error path in disk_update_zone_resources()

 block/blk-zoned.c      | 1 +
 include/linux/blkdev.h | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)


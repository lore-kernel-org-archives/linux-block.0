Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911782E4982
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480690; cv=none; b=Rs54YrDBEs1FxWmKeipB4Xfq9ZtqYC/zBUalkLia8yZOUxK0blTTUqrZ6I4wcRnrN37vMBGqAiawsRoup7CyAwqTu/gkGhyiokVgKoJm7WLtVUKn4Ip8nPXY0Ey5wsuQQwen8NFM2nOKROQ3IZsRBEDRTpPtA3aNdRYUVkdbL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480690; c=relaxed/simple;
	bh=bJQe9OZ+KFdgfwQG/GjZJFcQmPqYSaZjgvTBXdLVyMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFoT6MnaWfiYrfDJ6pG0b8wouzEd0tz1MmYuedTNPBKue24bvql3ur5D/0d5rVhHPBXOK4iO4fgR5zwsWXz9cHp4gE/+umxzrNFNVf1ACUTjsa+4Tj0wf/e6Ll0K1T6IoXj3IkndevgWhPaxC/8NK6CuiYHp5yhRuT1js5Qg81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Kosr5/Sz; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Kosr5/Sz"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXSwv3FKCzm0gc5;
	Wed,  2 Jul 2025 18:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1751480686; x=1754072687; bh=zN3V/8FqKafrBJ2mfg3smThTRKnIGuPBalF
	TsreaaCk=; b=Kosr5/SzbREYE6ZAFnIDyznolyulTH7NjMmMXE+RvPTtb3SaTD7
	Py9NIBjIHibvXjvX/dTJoP4zO3DkdZa06hblGes5Qv5lf6mf2W3L2jBjK7y5IocD
	677crUMFMaz8xYeb17+6yF24H8DgmGhhcykrsuTdSYkgqslz4NmwvRyJi6zcqMan
	BSmmiTzfJ1uzxY5j3F5q/fh8HVfRqn9JQdSLY3KVt8p/Ibl/0HKwj3Om9dxdNi/Q
	704yEpf3tVSXa0YPCxly/epN+10txe31S9uakom3cSGzT+JNB0PBrRfszNmUOwVG
	+g3Kh4H+apv5RGsrRA0Nc3qhAqMCaPaZMCg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OmRxszYtIdl4; Wed,  2 Jul 2025 18:24:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXSwr060kzm0NBP;
	Wed,  2 Jul 2025 18:24:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
Date: Wed,  2 Jul 2025 11:24:27 -0700
Message-ID: <20250702182430.3764163-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

In kernel v6.11 code was introduced in the sysfs store callbacks for free=
zing
and unfreezing the request queue. This may cause a deadlock in combinatio=
n with
dm-multipath devices and the queue_if_no_path option. This patch series m=
odifies
the block layer sysfs store callbacks as follows:
 - Remove the request queue freeze / unfreeze calls from the block layer =
sysfs
   store callbacks if it is safe to do so.
 - For the sysfs attributes for which it is not safe to remove the queue
   freeze / unfreeze calls, fail the sysfs write operation if freezing th=
e
   request queue takes longer than expected.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (3):
  block: Remove queue freezing from several sysfs store callbacks
  block: Restrict the duration of sysfs attribute changes
  block: Move a misplaced comment in queue_wb_lat_store()

 block/blk-mq.c         | 14 +++++++++++++
 block/blk-settings.c   | 32 ++++++++++++++++++++++++++++++
 block/blk-sysfs.c      | 45 ++++++++++++++++--------------------------
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  2 ++
 5 files changed, 67 insertions(+), 28 deletions(-)


Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0301F4704
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382996; cv=none; b=Suy1wCSBxEUvylBbFD4NINWO9ni4opE9czLLK07S04cxziUrcIz9pHt8lvVlzjL90agz87wfuj9BhR6iw/bLYRg4Kd4w4TxqTFk0SIhQKrP035u/HBWADuvNobj/DjGAp5Q3J8dz+IGGx7w+3h2mAuxulOaiMfvesVwn+VCDycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382996; c=relaxed/simple;
	bh=2/wuVBd9vtCgCvitew9JXGAcumfl3qFLh4zbUSM9Fiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjP+oLoZE8PmaCj2884R746+2ca9i8XzPUODqkfkSbStdB3v8R0hp+a8tco3EDrjH11R3eMPfB1TlQMRq5x2tDzT1HJL1DyWmRXmIlwfq9o4VFIIPyPsotofk8tHV2eNybRbQ9bU2/bDtx5sAJ3aHpa9EP7xwvgUTo1Tdj3acsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MIYjyHOB; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MIYjyHOB"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsq65rTZz6ClL9C;
	Mon, 16 Dec 2024 21:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734382992; x=1736974993; bh=JOtqq
	cgCdGHoYCryMnj3aKo5LqKKur4Z44DupCz9HOg=; b=MIYjyHOBwpQT7xVUH5pZo
	KVotTi2z+X4BuGhb5Wz+RO/OxgNqf1emS4zLZmHcMlF46ZDAhd6ebvIz/YeIve8p
	3K8/jBzZss58KasPY5P9eXk963COPjGa5RaucQH9WtzG3lL4shkMyAfZ60r036Iw
	Bzw8bH2wqA/f6BgeBeojFOaTO5bN/jzQYxufWtRibPf5EjDs0J0r6X/siRQiRjt5
	xIVo2y9i45dOxfR9oS1rKHDXXs7YhpaBf7BOQEimh1wtTEpYkJs+K2gXATlo2CCp
	p4FJpbYRYlrsNGcSjURIjoWkiw3ESUlZ5jXMHgJoHXIpq9Du4A+igmrMHJn0g83c
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pGM_aeuBE7yO; Mon, 16 Dec 2024 21:03:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBsq20jbJz6ClL92;
	Mon, 16 Dec 2024 21:03:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/6] blk-zoned: Document the locking order
Date: Mon, 16 Dec 2024 13:02:40 -0800
Message-ID: <20241216210244.2687662-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241216210244.2687662-1-bvanassche@acm.org>
References: <20241216210244.2687662-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document that zwplug->lock is the outer lock relative to
disk->zone_wplugs_lock.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1575b887fa38..3e42372fa832 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -46,7 +46,8 @@ static const char *const zone_cond_name[] =3D {
  *       reference is dropped whenever the zone of the zone write plug i=
s reset,
  *       finished and when the zone becomes full (last write BIO to the =
zone
  *       completes).
- * @lock: Spinlock to atomically manipulate the plug.
+ * @lock: Spinlock to atomically manipulate the plug. Outer lock relativ=
e to
+ *	disk->zone_wplugs_lock.
  * @flags: Flags indicating the plug state.
  * @zone_no: The number of the zone the plug is managing.
  * @wp_offset: The zone write pointer location relative to the start of =
the zone

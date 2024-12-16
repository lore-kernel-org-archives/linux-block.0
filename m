Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEA1F63CC
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383001; cv=none; b=CCKhvzYVTjx7zmbOYL8FM1HlwpzMyWwABjVhFeyCl51hixrTrWlDG0xkOg9B2jWHX728pyhrLPmoG8dsYhwfHGl4NwhNlaMhxikJfh3jmTNTG6m9H02d162MyCSTFA7k0d98PROV9kQpio51R5civIZz3H59NxurS7IQjBwg7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383001; c=relaxed/simple;
	bh=VUeOKj6HZr9/fJs+KOeqwtbg6S/1QHBiTNXjgw/6DcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9vp80HvTHPUMzjX6NL6qI0w3DZWIm/2pfsZjbVbkGxjxJGcCZQPP5sjHO4mCqwFUTWzoYyWTqCphPEkbKIVH9a69J8Z4E8P5K0Xt2YXMXT9P4h15124x7hyAHuB2MPGSU0MG4Z5vAfdFEDLStTqriQ74zP6QkcJaZt3T1YsBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=J5/6zC6g; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="J5/6zC6g"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsqC3r2Cz6ClL9F;
	Mon, 16 Dec 2024 21:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734382997; x=1736974998; bh=oqtFk
	XX96EFCrVmhT1/SQ1yFceo55p1jUK2XK3s8VHw=; b=J5/6zC6gphOIyVWE0INh2
	kheKAwAre9Ky3a2BL0tklArK2HTqSwZutW+mnEIj/D2CbVtuFt6TPT8KsHFSMTeZ
	rPIcW05T10t0JHM5Ow9b980hFOXcRvjaJDXm9PKEyLicUSOJbjb/FC6pv4HSOATS
	1AKPB4865SaS29U/miyu2m6dUaMcjoG0T0QyRijaQd7lK5rhbohVEk8rfWCD2MAO
	A3Mmn0XCHXEXtzo4wTLU8JCDdcGkM/N/TGxC5JJRmb/Kp3ucbT4cX/BVNr4m9lgB
	NfNFoQuf/kghSgvJRalY27tZ6Kl5oZh/GcXqmQE7+ZfMWC1P4vPUnuInQudLX1Mp
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EJ9Vza-OCLiy; Mon, 16 Dec 2024 21:03:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBsq71xBgz6ClL92;
	Mon, 16 Dec 2024 21:03:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 4/6] blk-zoned: Improve the queue reference count strategy documentation
Date: Mon, 16 Dec 2024 13:02:42 -0800
Message-ID: <20241216210244.2687662-5-bvanassche@acm.org>
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

For the blk_queue_exit() calls, document where the corresponding code can
be found that increases q->q_usage_counter.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ca44b2d6727c..0f7666441fe1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -583,6 +583,7 @@ static inline void blk_zone_wplug_bio_io_error(struct=
 blk_zone_wplug *zwplug,
 	bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 	bio_io_error(bio);
 	disk_put_zone_wplug(zwplug);
+	/* Drop the reference taken by disk_zone_wplug_add_bio(() */
 	blk_queue_exit(q);
 }
=20
@@ -894,10 +895,7 @@ void blk_zone_write_plug_init_request(struct request=
 *req)
 			break;
 		}
=20
-		/*
-		 * Drop the extra reference on the queue usage we got when
-		 * plugging the BIO and advance the write pointer offset.
-		 */
+		/* Drop the reference taken by disk_zone_wplug_add_bio(). */
 		blk_queue_exit(q);
 		zwplug->wp_offset +=3D bio_sectors(bio);
=20

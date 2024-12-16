Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CF1F63D5
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383004; cv=none; b=c3ECmo7abBl/u5TBQkj5k2dsSxUUZswJq6PE3gzKQZICTFR9DTbX3WAOAeMA0SDkwIbbaggSyc+8PSt04AL1z50od+AWVK93l+r2rZVIlE5kR8N6QhxZKyDysR5kNp30l0HsNxp9ZvVsWgyy2Y9aDInBIZlav9RyDVCYsVOARWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383004; c=relaxed/simple;
	bh=VACA2ecG33bUQrgFylNRnrD3Pd+WfwlZMeNrvbBi04g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRGON06Xft6/Wix9w33odKAj+TOyJuXtHb7jS1Gb96su/67HB/e2v/SPShajcZK7hTotsBkiMt795KZvd5QJAOhkwl6L1N/fmzRLdhF4xQ8NtC3EVLZH25383qR8efPQh6Ct/J+I0ZsqOHfmMqmqo2+35HtKyvOmFh8nEYc14pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=T3DSW/Xw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="T3DSW/Xw"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsqG71srz6ClGyv;
	Mon, 16 Dec 2024 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734382999; x=1736975000; bh=/L/Hm
	MFqqbZ+RCYLMJhKCmZR2Q+fxYlsaf2qmBBxSS4=; b=T3DSW/Xw99fRHXQHhkPW8
	oKav3ogLa/D2l+B+Fql3WRy5Bb7KUh19Y/MnE0FgCfRYaC0MPxpwau/tShLeduw6
	GwUQTAdwfbCpT7XzL/jRweN4wfN0gyssmWpVPSVg4CPkiUdXT5/2sTanZvdz6S3D
	zsTQvVJws2vWvrVc5n9N2Rn0LBdcSTmPf6EAVYSh1AYvjld7btaXlaWyEKTLgv3H
	e75W0Ly0Chax4hjUUN4ikhm0HMh992VBaDP6/wNZHUSuQN/CnB1r6owNzqn2ares
	sK9hTqa1sj/tguTL/nJMpH4L4/kSKfLnH9I68C1kfdDFL44ZgCfrxNV4/RM+Weew
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Bu2aufGzZ-nb; Mon, 16 Dec 2024 21:03:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBsq96Ynvz6ClL93;
	Mon, 16 Dec 2024 21:03:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 5/6] blk-zoned: Uninline functions that are not in the hot path
Date: Mon, 16 Dec 2024 13:02:43 -0800
Message-ID: <20241216210244.2687662-6-bvanassche@acm.org>
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

Apply the convention that is followed elsewhere in the block layer: only
declare functions inline if these are in the hot path. This patch makes i=
t
easier to debug the code in blk-zoned.c with trace_printk(). trace_printk=
()
only displays the function name correctly for functions that are not
inlined.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0f7666441fe1..046903fc6030 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -575,8 +575,8 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_=
wplug(struct gendisk *disk,
 	return zwplug;
 }
=20
-static inline void blk_zone_wplug_bio_io_error(struct blk_zone_wplug *zw=
plug,
-					       struct bio *bio)
+static void blk_zone_wplug_bio_io_error(struct blk_zone_wplug *zwplug,
+					struct bio *bio)
 {
 	struct request_queue *q =3D zwplug->disk->queue;
=20
@@ -1389,7 +1389,7 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones =3D 0;
 }
=20
-static inline bool disk_need_zone_resources(struct gendisk *disk)
+static bool disk_need_zone_resources(struct gendisk *disk)
 {
 	/*
 	 * All mq zoned devices need zone resources so that the block layer

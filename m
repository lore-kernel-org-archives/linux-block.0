Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E0396B9A
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474667; cv=none; b=AhRiqEwKeVTDLG9V/9K46tRAmtIpykykYCYXFRCjac9yoL+lvRXA0cPh44LgPKFbgPy+TKYFz+TLsGmscPs2qf1GC1ozOuujk5jF1m3/58INgKKsJfSn3JBhmEPXHV1Zm3s7RwcioJ2O7ri0FoSxPrFYpl7LLerJ4fDPNCIRl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474667; c=relaxed/simple;
	bh=FJ6UCAha3g867AQDfyJRQz4YFbWvok19qxKEtBjwcts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCbo98Bd5jISN2T5N5JZONwBJ85emcbpWWR7LFteRrSxJriF3hjXBOuBevx6y8K4RzZ5j3KzN2N/dAFmkIdP7a8KNQ1FRCcsJj2qjdaa11zo5mqYJLjo79Ewj30fisj9St/O2qDDj+qV5Cgv4MpTZkX0ds0DNYj7xv5klANRaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gIph/BGi; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gIph/BGi"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0ck3G7Bzlfddm;
	Wed, 25 Mar 2026 21:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774474659; x=1777066660; bh=WqQG4
	XSh3Lo0qwC2t05jAqXV91txu0Q3n95/qsVqXuc=; b=gIph/BGiNHap/Bw8/b1bn
	Ya7BVeftBsD/dNKpKW28xNAcSQPlvwQHWteO5mwlMUAGvM2iBATC4NlVOIX8jPfE
	SPIKJr+g4qNvbQG8aFI/jorp77+PrTV1VjnssaP67OGip5QtaNWj9z2VcYRFZuB5
	xo+33PNnC+Be1Ciellh95VXdKGgZxR3TQM8C8KmI0RaybQwTeHf85emcfTXKUONK
	rW89wVqbWQouSoD3RTa1EELOR6hRRcwLP/89uQMwjRbFTFYIOWdrEn3/tgnk2ZLJ
	Sk4NfpuT2M9XJlE96Skkuj4i/uD4lBOb28vI1KqnZPEHuX+btzMy8/xg7LFC8e9c
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pj1DOKH49aUY; Wed, 25 Mar 2026 21:37:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0cd4Y3PzlfgQJ;
	Wed, 25 Mar 2026 21:37:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 4/5] block: Reduce the minimum value for the maximum DMA segment size
Date: Wed, 25 Mar 2026 14:37:14 -0700
Message-ID: <20260325213719.2850619-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325213719.2850619-1-bvanassche@acm.org>
References: <20260325213719.2850619-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All block devices that are supported by the Linux kernel have a DMA engin=
e
that supports DMA segments of 4 KiB or larger. Allow smaller DMA segment
sizes because these are useful for block layer testing. Reject values bel=
ow
512 because such values would result in an excessive number of DMA segmen=
ts.

The only code affected by this change is the following code:

	if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
		return -EINVAL;

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 7082dd5a87f9..7c792c012b0d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -23,7 +23,7 @@ struct elv_change_ctx;
 #define BLK_DEF_MAX_SECTORS_CAP	(SZ_4M >> SECTOR_SHIFT)
=20
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
-#define	BLK_MIN_SEGMENT_SIZE	4096
+#define	BLK_MIN_SEGMENT_SIZE	512
=20
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)

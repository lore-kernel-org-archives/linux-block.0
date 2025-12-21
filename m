Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AB253B58
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285615; cv=none; b=WMMzyseSgoznIsPfp92IN6jcoVJ5jdnVb5RlzJ2Kp+7gHe3ouHXbiga99VeBz0p0iecXmBXmeyp5WAOUtZA5GQTUsRe1fp2DKWk0jzdGkddmRAH1WPaeYqdtLzSr3ebBEa/FnGAfl8VI3WYPXuQUU3oLTtg0m5GW830UpfjXTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285615; c=relaxed/simple;
	bh=4P2dhr1JL9AniZ7kydn/X2v06EQ/REJNhKDabgui29c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnBuDAbn8gR1tOKGPf7ypGOADjhCMlwar+LZ8SHo7yfoYUE0r+361Vgz6Ex4+zKNHw13ubWTLUBl+GPebOY8SxcPaX14lqL7MQyNFEpqrURCwTDxB4GpRflQsFAHMJbQrjRgxq3VdlUQHGlL4C/90Nhb2Jr+5HvLYtzpChlLjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diN/HCtx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diN/HCtx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fol6UoUTNivE27QS2qgrcPSW+57SEzmLBc6042LIvfY=;
	b=diN/HCtxV0hCbq61qQEDs80ie+V/My0IuVENDXJ0Cvsner/e1/i8skvVYM1WPdzPBI5qj8
	PPENbp65o2a5hqG4ixFerTilkC+cv/AMj7ODPdDy7VuhS6UzjwWfQ4zXkfRtkZGou7V6pI
	5cJ5J/U4IWloSoxOpJVH7/Fpq/wgbio=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-o5WEt6OwNsyRSe35HCz4Kw-1; Sat,
 20 Dec 2025 21:53:31 -0500
X-MC-Unique: o5WEt6OwNsyRSe35HCz4Kw-1
X-Mimecast-MFC-AGG-ID: o5WEt6OwNsyRSe35HCz4Kw_1766285609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 943D619560B2;
	Sun, 21 Dec 2025 02:53:29 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94EF8180049F;
	Sun, 21 Dec 2025 02:53:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Satya Tangirala <satyat@google.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 14/17] bio: switch to bio_set_status in submit_bio_noacct
Date: Sun, 21 Dec 2025 03:52:29 +0100
Message-ID: <20251221025233.87087-15-agruenba@redhat.com>
In-Reply-To: <20251221025233.87087-1-agruenba@redhat.com>
References: <20251221025233.87087-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In submit_bio_noacct(), call bio_endio() and return directly when
successful.  That way, bio_set_status(bio, status) will only be called
for actual errors and the compiler can optimize out the 'status !=
BLK_STS_OK' check inside bio_set_status().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 381bdf66045b..acf0a82a90ce 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -821,8 +821,8 @@ void submit_bio_noacct(struct bio *bio)
 		if (!bdev_write_cache(bdev)) {
 			bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
 			if (!bio_sectors(bio)) {
-				status = BLK_STS_OK;
-				goto end_io;
+				bio_endio(bio);
+				return;
 			}
 		}
 	}
@@ -887,7 +887,7 @@ void submit_bio_noacct(struct bio *bio)
 not_supported:
 	status = BLK_STS_NOTSUPP;
 end_io:
-	bio->bi_status = status;
+	bio_set_status(bio, status);
 	bio_endio(bio);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
-- 
2.52.0


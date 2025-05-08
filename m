Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D070813
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663603; cv=none; b=WrtTPvLigtYzSGJQ/1i0Ao0kzYgBoS11v9pai4SN2/y8tKmOCRAkQYNqGv1+XBTA1nv5IDms0SPQXoQSHMbSfmt4BZn2Wt6hSA+A1D+hNch6IcjAyLYIcWlHHP9Je93Mib9XRbAAZQCMr8f+5C6Gt27pGPgpGG1PsLmf/jbjXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663603; c=relaxed/simple;
	bh=y+8hTc3isBVYROcZmAP7aSesVsVTkxzOE9eDa6CySMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcHl39z+J8WaRCUgbg2saEKMWw/i2qNLtdcNPGX8sacNseKhqY6f2rCIFPbh+7Lm8fVQWNRPURZuXoOOMLwK8Iw90+bFF2G2PlDTXeW4zNe1cSVdDPrCRi2nV67e9q0sPc3lAZqf7qrPIE81HxWiqCcsHT9hhTCuFDPSV4rDqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsSgyMoI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsSgyMoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746663600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwDEthktXsttku0rhvvshKdnxHIUVkCoKQIjfcYC44A=;
	b=AsSgyMoIvubgYUjE7F0Ak+5EZe7VGm1W3+1/aYXcy2Q74hVz65o1lN5lkrTTXtun57Eo4z
	eGuagCdyOgWllxrB3cvoyeYLGgd04y3q0Z53tmcnjk9XuD/uhLzJ7Lopprc/WoxwmA3Qfx
	k6xC3hyMwS1B7phuucn+bgjzcQZDnKg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-zf3JBtQ4Mj6vf83gBN7vwg-1; Wed,
 07 May 2025 20:19:58 -0400
X-MC-Unique: zf3JBtQ4Mj6vf83gBN7vwg-1
X-Mimecast-MFC-AGG-ID: zf3JBtQ4Mj6vf83gBN7vwg_1746663597
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0966180048E
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 00:19:57 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6939219560A7;
	Thu,  8 May 2025 00:19:56 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: Alberto Faria <afaria@redhat.com>
Subject: [RFC 2/2] vdpa_sim_blk: add support for fua write commands
Date: Thu,  8 May 2025 01:19:51 +0100
Message-ID: <20250508001951.421467-3-afaria@redhat.com>
In-Reply-To: <20250508001951.421467-1-afaria@redhat.com>
References: <20250508001951.421467-1-afaria@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Expose VIRTIO_BLK_F_OUT_FUA to drivers. The simulator is a ramdisk, so
it handles VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_OUT_FUA in the same way.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b137f36793439..64f293e2931d1 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -31,7 +31,8 @@
 				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
 				 (1ULL << VIRTIO_BLK_F_MQ)       | \
 				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
-				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
+				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES)  | \
+				 (1ULL << VIRTIO_BLK_F_OUT_FUA))
 
 #define VDPASIM_BLK_CAPACITY	0x40000
 #define VDPASIM_BLK_SIZE_MAX	0x1000
@@ -158,7 +159,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	status = VIRTIO_BLK_S_OK;
 
 	if (type != VIRTIO_BLK_T_IN && type != VIRTIO_BLK_T_OUT &&
-	    sector != 0) {
+	    type != VIRTIO_BLK_T_OUT_FUA && sector != 0) {
 		dev_dbg(&vdpasim->vdpa.dev,
 			"sector must be 0 for %u request - sector: 0x%llx\n",
 			type, sector);
@@ -191,6 +192,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 
 	case VIRTIO_BLK_T_OUT:
+	case VIRTIO_BLK_T_OUT_FUA:
 		if (!vdpasim_blk_check_range(vdpasim, sector,
 					     to_pull >> SECTOR_SHIFT,
 					     VDPASIM_BLK_SIZE_MAX * VDPASIM_BLK_SEG_MAX)) {
-- 
2.49.0


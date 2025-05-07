Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69E21A426
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619468; cv=none; b=SugQnFvHz4TG51+aG8s74korU4WZkhHmvu7uHmn6FrAy+J6s6KhEAd83ulrHqg/oZ+NiSeNUNg/El0LAsfakAKMBfWX/ZxcjwqKddkqHDpyhCshSGlGX+lG0ZYohLBb/WkwLf6Zz3Jr2li3viDCh3Qb3HFGuqcvgk+Q2fbZADtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619468; c=relaxed/simple;
	bh=tl1O90LtzvnPDJ1KL0/1nwUGri9x5X4hc+7ZVqK9+6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWXWPJyH3NSe+Pdu1GqqT/S4d6atA7W+EX2RyZuSnx4/CqF6hxUN17IFH3Z/zMie6d8VqXX2X4DTX9Ow3+X2dWBRgqegyBThSzm88lJGb8gcd+OdZaLK2BDNjgw3PBQ5/GVWsTL92pWvYPP1NCXvoJkQLc/Ea/nbgNMnYeOfLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zf1eDmFp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf1eDmFp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746619463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8JKZpEfhO2HCqtKyq/FkO6rNFn5kRQb9I3dg1Uam3Oo=;
	b=Zf1eDmFpy25vUOiqWZuXaZAxRC/b2K3rLNhjEu+2L2DSGfRgWUgbL7VBKeSRPEPbPT9VQY
	kSd98frsp9f8yoW+WU/NDO/NEyFjKHhk1nmInyOymLtUb4eigmRwq1qA20ZLc2HGmDX6k7
	EETNxLvdhhsulA2L8PG/9a43zBNtznc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-UzNa_KinNlSrtuwkAb3dSg-1; Wed,
 07 May 2025 08:04:18 -0400
X-MC-Unique: UzNa_KinNlSrtuwkAb3dSg-1
X-Mimecast-MFC-AGG-ID: UzNa_KinNlSrtuwkAb3dSg_1746619455
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42FBC1800446;
	Wed,  7 May 2025 12:04:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.52])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E494619560AF;
	Wed,  7 May 2025 12:04:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: fix hang in elevator_change() and improve elevator_set_none
Date: Wed,  7 May 2025 20:04:01 +0800
Message-ID: <20250507120406.3028670-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello Jens,

The 1st patch fixes one hang in elevator_change(), which is introduced in
elevator unifying patchset.

The 2nd patch tries to avoid to freeze & drain IO in elevator_set_none().

Thanks,


Ming Lei (2):
  block: move queue quiesce into elevator_change()
  block: avoid unnecessary queue freeze in elevator_set_none()

 block/blk-sysfs.c |  5 +----
 block/elevator.c  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.47.0


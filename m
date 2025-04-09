Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F515689A
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161305; cv=none; b=hOC0RMvIpnSpR5OrpkwonJ+lokiR4X8IacithGOyhPM//+V0ngN4eNCKG6X8zDqFPotI2Ty5C6FS0tu1shD5pPfp+qt8EZ8vkVKsa0U2YRnoBZt/TjZaasooBCejMOpO7LCXmKEac7ygdDjjiXPxXu2ty8yvr88Va5ApOJ2fTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161305; c=relaxed/simple;
	bh=xOv3M48Gy/JDb8sUZejtI8jpv6JfXo5vIRXKFsqS4mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NF8JohoCJiY9UQUPpr0gpqP5S4pw4VRnhikiLyo7oeTb8e8Db+koKBymuWjQNFOrWqrkxp0gViOx40Cm96YV0WkHIrfghE50F18+RWzLIeQN8wsh8+X1oh0lgGtzUxpK8BgoFtGXCt6PYvp6PHdGB2U5LHfQdqRx8ZXJHcg5kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tu915KMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu915KMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744161302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9vBma/AKKxAm9PWAJWWp3eQuVaWsow73FXCp1Oc3BL4=;
	b=Tu915KMXTdtqkXx1f3nXd38Q5qY4JYlFTtbHgvBaVi6b3R1URGvvBM6xuMvRcC2S/VW6Lc
	SB3w+8nNV3MWLSXTNttphHL5e0an736yi38HwcSEkW52bnu8ZdCjuO7curdazwBraZnuzO
	QRN6WeQXefWg657bKn5PSquPfIC5C7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-mwqYUleZM7SkT2vSLkCsGA-1; Tue,
 08 Apr 2025 21:15:00 -0400
X-MC-Unique: mwqYUleZM7SkT2vSLkCsGA-1
X-Mimecast-MFC-AGG-ID: mwqYUleZM7SkT2vSLkCsGA_1744161299
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8450F180025B;
	Wed,  9 Apr 2025 01:14:58 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3960D3001D0E;
	Wed,  9 Apr 2025 01:14:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] ublk: two fixes
Date: Wed,  9 Apr 2025 09:14:40 +0800
Message-ID: <20250409011444.2142010-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jens,

The 1st patch fixes one kernel panic issue when running IO vs. remove
devices on ublk zc.

The 2nd one fixes one regression introduced in this cycle.

Thanks,

V2:
	- fix 2/2 commit log & fixes tag (Uday)

Ming Lei (2):
  ublk: fix handling recovery & reissue in ublk_abort_queue()
  ublk: don't fail request for recovery & reissue in case of
    ubq->canceling

 drivers/block/ublk_drv.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

-- 
2.47.0


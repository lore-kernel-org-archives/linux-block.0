Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49C1DF98F
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205727; cv=none; b=r8bZYFEMMF0T5NRgqjS7PLC9gmM0AwHgjqZUKeykKbd+kHUK4Ss9UUB3eFdAFzzwSWfzg32yWL/rGRXBaI5YzSxUJW7mXk2Xzi3lDK+/DRP1wR4su7x0jcEeZHf3ZetXJgvvTWv0/X5U5Ljbk+q00IXplkyOTx+vKIoyHsodX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205727; c=relaxed/simple;
	bh=0ljOpkyfjZqanSaEy5/y8FMJStiCHYKcp1rDILKb3hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aer5RrxVMGbsHJZ3Hv77M5WMfc3dDnKmBusEpWXTytYQlrj1nBS9wgHSRShlmCeTa4kPs2+TsW/8yWPerulGvsUyLpCOmEaQIBjMwy/QoopVWi8O6xArRqzybKEOVA2n+z7NRfHJD27X38iP5KRoUWrP414dEPgzmijDnGdWKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnjSJ9xn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnjSJ9xn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747205723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HYzBb5SJ78VUZP41t3KTybXYvlm+RxzbkoO9o+em8bU=;
	b=SnjSJ9xnEJ9vqdupqM2fBI+AupDUESdWO251z2fzYdUjgMzPjGEc7mD9L6fWGd2yGXswJ7
	hBgESNxJitgHP0AQMDRM4owXtHb+PVeAbE81u8qvc6z9InAEFXok2zvsBW/kI16Tc7hc1/
	YENGoiC+YWQ+QvxtOMN4qL15tzc3N+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-58V0JxEPMSeu-Ex3d0dCqA-1; Wed, 14 May 2025 02:55:22 -0400
X-MC-Unique: 58V0JxEPMSeu-Ex3d0dCqA-1
X-Mimecast-MFC-AGG-ID: 58V0JxEPMSeu-Ex3d0dCqA_1747205721
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so33647775e9.3
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 23:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747205720; x=1747810520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYzBb5SJ78VUZP41t3KTybXYvlm+RxzbkoO9o+em8bU=;
        b=pZ5mKDjYZotj6bmD3LYcjNwkw3WUDqiTw9qeSfVfREg3S1Rl5cplsGwu6UwGnjadlb
         HU3ISVpIiUhJsGiYDG3zGx8uzlGeUtuKWFwvQGVNKgki4BzQ6rs2Knffh9erYfFyXXcA
         sWidt4h0oGneY29Sg3MIQg/WuITeAJ/9W0Xr3ktzp0U53ptCPkBHGV5TmW8MM/krTxJy
         /yAPNEkd52Xv/cd/iNbEJtFNtg1iAUhY20Ix06awx0KHEXDfqnDTXxu0kww1outf0x7f
         rhQFJN78yr3blUWUU3YyDHXTgIdqkmfOzPtDTwJ2tbIDXjcYzUUNmGugNMUFQgsxLKaL
         HmHw==
X-Forwarded-Encrypted: i=1; AJvYcCWRd2JlQdHVzXJEQhVYBQsueTqDqvBCXZ+wTJa+laHonAi696sMzPfHsTpH0/jjWM+mbvYhK53LJzCC/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKEY5aNOtVB/Pi1PzV48v9zlVFjRJOoLyRJdHQzyN6nd6AJ66
	cHe+Up26e2Fwji9wCAKLHy4L1dKB3/g+IbgiY6DMx4b9bYJgyYW7aBlbNwjBLdnG5d1eB8W2xZJ
	d8WXKsFQjpw4xh2HTeRG5yAID4juSA5QTF31IRDiBmtRLBg7FONbx802z9IXp
X-Gm-Gg: ASbGncvj6Urj+ztbj8y4/1XGEl9Ad6bn73fdix8HPdRvF0uR90hIlP+oQNiu2a37Vkm
	F/ljxSswtWDjbSK+nT1oEN5IAXG58DzYhelLfJY2RKwKrkgEpYoQd+ioKjUithFHbCgjA7H0M7X
	1ui0+R6uAI7hjaGHWV5CltXX3uVLQMk6D5cK+SLoqoJygJ0YUycvFm+f5wi8wYuOHZOs/3YCfv3
	E4bfNM9YDpprLTxG9B7QI2ekr94FEJDuWGq2iTvz5DsK0JeuKmnlxByBV7lSp7njWXn56/vLHCP
	wnreg8mSk3bAWySWNU+6VJyRSHIDdKH1Y8wUsVXevH+eoyk4lW7BqiPYkw==
X-Received: by 2002:a05:600c:474a:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442f2177839mr14481345e9.28.1747205720113;
        Tue, 13 May 2025 23:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFwOplruz65UjRaahKOum0fhAp3drpaJMqfFD47FxF0twZaXDmYs20HOpHSKREcFKpD0U5mQ==
X-Received: by 2002:a05:600c:474a:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442f2177839mr14481185e9.28.1747205719752;
        Tue, 13 May 2025 23:55:19 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395060esm16218525e9.17.2025.05.13.23.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 23:55:18 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Daniel Wagner <wagi@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] block: Remove obsolete configs BLK_MQ_{PCI,VIRTIO}
Date: Wed, 14 May 2025 08:55:13 +0200
Message-ID: <20250514065513.463941-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 9bc1e897a821 ("blk-mq: remove unused queue mapping helpers") makes
the two config options, BLK_MQ_PCI and BLK_MQ_VIRTIO, have no remaining
effect.

Remove the two obsolete config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 block/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index df8973bc0539..15027963472d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -211,14 +211,6 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 
 source "block/partitions/Kconfig"
 
-config BLK_MQ_PCI
-	def_bool PCI
-
-config BLK_MQ_VIRTIO
-	bool
-	depends on VIRTIO
-	default y
-
 config BLK_PM
 	def_bool PM
 
-- 
2.49.0


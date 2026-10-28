Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205970;
	b=WPLZNW24vgJcnqeUTomvj2XKFm6qqNwIHFdet0FEKCp6s+wZZ/gy7TwturC74nYOd2Z1
	 ltZHlpUENtazhYWNiUrKLJ44e2+coVmQmS8hClkRMLNA10V2E3u2jh5Q4fc5ZyE/S33W2
	 qujNctjcygx5bp2ixr499PGS7C2kiIO5bewYGsb4rRvRvq7mc8ScB0DNWE9WoTcYLsaik
	 CbnP0glz5788rjiyWYHgeDpz1NwvFfH0hV0BfKE65vvGCZ0D6WRpe6xzJFP4Ppy4xKm2b
	 1s5nZwpDxOKr8tLwqfi4BWqNQoxDIaInSAncx6xMfdSXJF02yK3qGEkH+r2hooOTDfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cDaKKj15XpHheditUlHiAbwqmg3KaBldaJdT3GLwilw=;
	b=ttYvHJJQJpBGycllSf7oihohAuf79+lVXIIR9YmarjcLKcFh2RKJiK9VKCB/8JgSLhFJ
	 yF5BZdxW87UCxhswVpTLpo5wApx8EyIE0z7TP4Cf5BJc4YMDIt2mpAc4wf+ow7JJbFVXq
	 rIrWr+9a7UgEIyQ0htyjFqd+kjaNoX+aCCvxkHZiLg8M90+dfGf1WqhJ8frv6vdBDOkJ6
	 b1wZlDMFuaak+pI+OTqsg9N5lyKlB3EQ0Y1ULQhPhaDMSNRGdwkjZ6RTPLfuYX6XiChtI
	 Fm82kiVJe/rpxu4a8dNICze9j+pJctRVXrlFAD2KrOcGECs5M8IOBOLFhl8zFEwLdiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l8Xsey0F;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFE606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33BFE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l8Xsey0F
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-846566246e8so1081731a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205969; x=1793810769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cDaKKj15XpHheditUlHiAbwqmg3KaBldaJdT3GLwilw=;
        b=l8Xsey0FEReEioio2OP5k5Av4xLUw+A2h41AVA8ttQrm94gPeNsFmFE2J8atQWF0rS
         ZSH5xWYHS/xj/23L3L7SLYdSv+3EewdJM9BgZCTbNOsg6WZ8GAsWgnagJlQc/EphtLbp
         QfaORpSCXLNDSUo80MfNvdjJDQ5O4uiysZZoQeLtzxOskiYFaGSJqSlHurNajjtaRikg
         8sposp2YOv9lDXNdDdwliF8EmHMXLD6eJrCHqjkUBls3YMeT2bcu1D/1T7OYzWbarXA6
         bEtoV+P3vzxOyhSa5jkY1GHXUb/G57i+DHUswe2FJ1BUUdad33TFAUQdYpEez+Wz1hjd
         5GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205969; x=1793810769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cDaKKj15XpHheditUlHiAbwqmg3KaBldaJdT3GLwilw=;
        b=TkzuKr7TkQ0dihX6Z87jmxcgc2aHaW9VX3Dsy2Z1fHgD5XzVz8vHTVMm9aVp5gyHvl
         6i9qxKXuKrB8xowqq2IbQUbqu+BPfuyDUPZBu5DzFhIU3FGP3dsjn92K0wFcdRQ1Bs9S
         0UPVXQDbUxZscbONQ+ux65mFXUfFf97cae+2skE2aNPWzZH5ocNXZRMpfEHTonC+kV/h
         DDU+Zi5pXCjrt8RaSLWqiX5+uP9wMgGH8bhfUGf4qxcIDTPK5sl5l8UoPEBmcOC9NmnU
         rssZIZhIKF7AwxcjhdYM2R5fWtTJM4CBG/ATjBukvAT/uSKnsLs+mZ5i3aug22UA1r6a
         akpg==
X-Gm-Message-State: AFq9FYLDDqdFFiGrBz1XqWj0cDvly3vg3Sy9Wr1bxoshZA9e1Jh7ApSM
	kxxiR240OYnqJduWU6ZZMMqniZpZ6HnpHh9Nm6c56uOrkx0SZuasOlrIQ3ZX6T2b91ik/qZVB/7
	5apXsGDU=
X-Gm-Gg: AYBFou1tiZVWirbddsYE5nYapahUssmy7lIncjpValeeTd8ePJjpQ3uoP58ow+me3g9
	RzyifiOa92H4rDvPNL320ijJIxsilxXrCi5aPJB7XN0s/0D8Lhf+VxHWXzDdE1W1dTVyBZQbaxX
	dc8wZQseDQzKTLsY0KQ9SwrJM2jxFl7LcJo6G4MIbxkZ4OWqlT2JblTaHCgSBCjPatbqzH3SZa+
	4/BjPtFY/dk0Urnm5aMBJZDeRoS9j2oXz51XwehpxqGraEA8j3C/eEcTvPI5OljkJfWYfSwUC0S
	rxrTHmdKdH6LDhFE2ZR2ZABt+I5hJF1+i7HPVFecH6VvPahpLd8CJWVOD9iKUdj8H8nRHD1zxRD
	OYr1AU/3e096L9rryw980e+2PXHceF9AJ4C4HFaNRoDv/4DdUNu5xmBA1krQXIO9wGze6VzhPXL
	H1vSw7FZnD8zfbltwvQHZPsSD7s4YzYiMKxrxj+4IVp2K5O3T4hO/INwST/RPwhipbHeRtVYcH8
	ivCRvLRrN+eBSbqTnmsuoG7gHhJxTYLXM/agWw2ldIdu8UtMs18eo/jQYhAx5W3/lNR88Clqjhh
	xnZho3zWPb3imremW5kDeo5KxuOvVXKCfoiQNKTLdRrp329n93cvKPpvagWrtvFYkcZeekcECA=
	=
X-Received: by 2002:a05:6830:b13:b0:84a:2db7:dbc1 with SMTP id 46e09a7af769-85c2316fcacmr45598a34.36.1793205969083;
        Wed, 28 Oct 2026 09:46:09 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 88/98] nvmet-rdma: flush nvmet-wq on module exit
Date: Wed, 28 Oct 2026 10:42:31 -0600
Message-ID: <20261028164415.1262013-89-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

nvmet_rdma_exit() relies on ib_unregister_client() to flush nvmet-wq
through nvmet_rdma_remove_one(), but since commit a3dd7d0022c3 that
returns at once for a device no longer on device_list. The release work
of the last queue takes the device off the list in nvmet_rdma_free_dev()
and still has to drop the mutex, free the struct and return through
nvmet_rdma_release_queue_work(), so an rmmod in that window frees the
module code it's running.

Flush nvmet-wq after ib_unregister_client(). No release work can be
queued after that point.

Fixes: a3dd7d0022c3 ("nvmet-rdma: Don't flush system_wq by default during remove_one")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index baaec9a36d8d..b961d1c4aaa4 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2170,6 +2170,12 @@ static void __exit nvmet_rdma_exit(void)
 {
 	nvmet_unregister_transport(&nvmet_rdma_ops);
 	ib_unregister_client(&nvmet_rdma_ib_client);
+	/*
+	 * nvmet_rdma_remove_one() does not flush for a device that has left
+	 * device_list, and the release work that took it off still has to
+	 * return from nvmet_rdma_free_dev().
+	 */
+	flush_workqueue(nvmet_wq);
 	WARN_ON_ONCE(!list_empty(&nvmet_rdma_queue_list));
 	ida_destroy(&nvmet_rdma_queue_ida);
 }
-- 
2.56.0


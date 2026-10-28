Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205951;
	b=JOrx6OIgGpmi8qgGZa6ht1MYjqpJ39sBeMnWNMd0hFR+06Mw6UbhnEDwSz8663Swc4Hu
	 xCEdckcSDR82nZ25XhbEJGadr7KeSO8tX2UIcXgkHFXYIgFY9/pY8F2bfP303WL8GOKcG
	 eiF3UX8smD7ZrNaVgVF+rxIsQU0qAUumd6Cs6OSlFbek0dVIy48CmVxHP4nT/BtHfNRU7
	 +oWU9eOjUcDaQOJ8tlYWVOJUsAdm7MtBm5mBUljjkOCN3datjy2I1n1vv7QWEecPg7lvI
	 qZCtZuCP+uoETc7y/sDPiK+vn24FZxS8EQaaFVesN9XfcOUrA6YwQv7KVYl0LCre9vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YXxe+7kIYAtCbjpADluWoq2mIe6ZpS5Y1HhIQgut8NE=;
	b=pNc5OTpNCxzcshhp+P1MyLeWEBQCHUYPdzlsaMBHF6gbYlsKd2a+t0ZxZ1f8dAP37ucM
	 vXhcS1+5GIeeJQzXB0wiHZl8QWwjAnOU0X80FCNVj9ElzmwASXxDdnrz1ogrc9jBRUbW2
	 +vcpzMlfH0RzEcmJrfLpnez9k3EF9PQF6OGp158raonptCZAGklGYAVmTVzkcWGnPVY3m
	 +czZfMaZui4AUux+5uVkqcE/PDDN4IYU0crUGN2raYDKfBUnpg2quXKgXY+PNoF42Jeex
	 5ip9gHKgz+v+fdiDX5MOAuLBqKFch9k9aboxTrG+MgFKB4iXJWXcBwCIHBkRYjk6VYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="m4b8YP/e";
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB542606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB542606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m4b8YP/e
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-85a5455bd3cso734270a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205950; x=1793810750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXxe+7kIYAtCbjpADluWoq2mIe6ZpS5Y1HhIQgut8NE=;
        b=m4b8YP/eUXkeNU4vSdGZddcznXiJMNwrBehAUWVgsPp2/DLw3ohtQS198t9VrW+BRZ
         FMYTW1jusImCA4xKPsG7v31sA5Iqp5WOi0yFehig5ohk/UMNo66V1q40CN8c3eSDYJas
         58TLo3JOsivhDVdrdjBgg/3H89P44XbFaW6WanmHw7lIBOSv3P5ttoWerGMcEUatrP9Y
         HoIK5e/P/JTnHJ+9UwlbdA/TzkJ/G9JAH0jGVxObzGE1ANd8RvQ0S8qBM4y6+QkpheH/
         vbA3+/e0qgr8XfsCVLYVyLR49eN+iadw+m6D7Ovjc0rouvG8cc6SNiZXKBFm72w1s6qG
         0JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205950; x=1793810750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXxe+7kIYAtCbjpADluWoq2mIe6ZpS5Y1HhIQgut8NE=;
        b=dDbxpNqN1YcoubXaoeE+yOaeSMMf4nWRjLQIpQogbuCRW6t7byBjskDGDYwNJ31sJO
         sbzoMdH/Z90Meo4VAdsEK91mGoCmGyZ7HcgEV2tE3jVmvtTlsub2CMdIVYrYMbPiX/AL
         xFwR7D+P+FkptPVFHiAjsk9XDfNwc8jQpRXwGfdr4TH5kgCYBPAw2IxGvkXy10hkEjFo
         OVkuZ4SWQWGihucQ9dAtSdCIIk+rlDuMz+qiR/XVKFLBEq6W7ZuJynrUBtFo9ZqLYeXG
         rQ5IuB9turinhyyvtbWR8V6bCQm5xaeSy6SDPtgWSoTsEUBESNocMHT4AIU6vlWza0Z9
         ZoJA==
X-Gm-Message-State: AFq9FYK9LHxyEB5gzfI4AOrkM4p1Rb4BxMJJASS8drTjHUmDm0rE9wTU
	nH7n+4g6+XPHHlkVWOZF92kpNKLH8e1Uu7jGtPYFAKfuFsnAoAYwR7uHVckRoXldMV2pGgC0DOP
	G1NHD8vM=
X-Gm-Gg: AYBFou3032uP4ofbTFXkAnWseUEndXzIm77ywXDBoqvv5UgBHYd7cfp44jdZXgSRG1s
	mT0FuUbjuMrRXJZgmRfxLA4Fg/BntrQz6OqHP/D5O3u+EvjIgMw10z7xqOnv20EqmKHUqhVM3Oy
	oLymcsO8FcxiCKu8CCzTWtt/0b1cPstwLpYsiqtbh6pPQmkMIHmO3JuWz/1/EwHlwbVFrrB1OLO
	ZwhSbtZw0GX5NzB2Po+NOQblHzCazZAxzMoaVE8/X/BpXhtkQQU2+8wwGdNP3FmuUz0Ek+NFgNk
	1HHS0kjYu7NxDlhVaQiFGWfiZ/y7LSqWow3x27Jm8wi4TtksoGVSS06zNxvBV5Tt96s2BX/LKEe
	Qpo+b+aPr5uEZNv9kBPGOLRZWPd1fI9PniSjSdfRDQ93bLB6XicG1/RiaxwK+xsweqgyCHvrJAS
	vyClchL7QjepeH/Fk9zh8eTKmzmP9ZqS05Upe0mveN+vBFZC4Tuc3ppaU7UhxOixG7CZ2fdF7jN
	6zwHEvUZgdjOEtAZPi70/vHoHunMTkWlz3TRlAUp5/gXYHjDDRAr6jvm7QN84tBYSlWjyB/lnkS
	0h94lFwDfxTpeupDg+a518SlsB4DFv3p6oJwiCyF2EobLGo0DBrC47saLACNA3XLH5mEhlLATw=
	=
X-Received: by 2002:a05:6830:44a2:b0:81b:a5aa:e82b with SMTP id 46e09a7af769-85ab996d1b9mr2375296a34.24.1793205949810;
        Wed, 28 Oct 2026 09:45:49 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 73/98] nvmet-tcp: stop listening when a port is removed
Date: Wed, 28 Oct 2026 10:42:16 -0600
Message-ID: <20261028164415.1262013-74-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

nvmet_tcp_accept_work() accepts until there's nothing left. A
connection that is already dead when accepted is torn down right there,
which takes a few ms, and more can arrive meanwhile.
nvmet_tcp_remove_port() waits for the work with cancel_work_sync(), so
someone opening and closing connections in a loop keeps the removal from
finishing. It holds nvmet_config_sem for writing, so nothing can be
configured and no port answers a Connect until the flood stops. No
secret needed, just an admin removing the port at the wrong time.

Shut the listening socket down first. Pending connections are dropped,
as they were on release, and the next kernel_accept() fails and ends the
work.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3d24efe3b7c3..0b70d3647e28 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2263,6 +2263,8 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	port->sock->sk->sk_data_ready = port->data_ready;
 	port->sock->sk->sk_user_data = NULL;
 	write_unlock_bh(&port->sock->sk->sk_callback_lock);
+	/* The accept work goes on for as long as there is something to accept */
+	kernel_sock_shutdown(port->sock, SHUT_RDWR);
 	cancel_work_sync(&port->accept_work);
 	/*
 	 * Destroy the remaining queues, which are not belong to any
-- 
2.56.0


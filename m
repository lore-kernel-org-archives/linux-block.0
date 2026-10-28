Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205958;
	b=UuJZwUYFUXizr9PNTScBbtUqIxpbTOccu8gw2V9QWBpgaZmLNkHSPjJjX1hSLkycxBhF
	 YrB/LZbi2jxbQjIAuzcAVXdiuliEWE2ng5Qmav2vh+W9Ghrbm6t8rjSzu9VkWhRinLgzn
	 WPE9NyA9WXfL5OpyJQoYNDKFJyv4aFz5iRBRnfEngu2ocszYOpUVWJR81hOes2cehnibc
	 wdPqjBGnP0uJuQ4gd/7N5/1TC1vfKQena4bUx09MvbVQCY58EvUOLCoJbYzLghAR9LR1l
	 N1MWSVCuju+YyXcjrrIt9/CcpeiMjj/o/fG16UT7rC9Zw8CJkZDvaYHdh8lps6Pl16g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5in8JYDIp4RMV45UjLJidXa8aYTDsL3MP3EiBYAT+V8=;
	b=eDekc8rC1o7Kw7+GJcfGCrNMsXcz1EKQyKBigIcb4GuwNpDdot/9FYtI5HtVFhBKZL1t
	 apY+r62hdStr0xCKLrqaHq+DXQegHvI4nYldx/0YVuFIBPAy6hgQ85tJGeMJP2hORfagT
	 /vSG0XuYeJMUoKOsbK6z6u4m8JfzzpbHhtSpEXAfmp278YVATNe8im3Cj15AeXcmhshb+
	 lMbPclZB/9/x7/O55fT8uh+b14fnf7T82EaErWoKHtFpvXkDlWuOxQwy1cOWlPSRlKlh5
	 5fCamBIyG8p5EWH1D5m9Li9dMnOlBbE+MpFzHik7VvwJyK+2jIScDi0uNVYiNcFaGcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NzHXjCtd;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731B606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5731B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NzHXjCtd
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-854b6e2e41fso592242a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205957; x=1793810757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5in8JYDIp4RMV45UjLJidXa8aYTDsL3MP3EiBYAT+V8=;
        b=NzHXjCtdmcFqLH6SvFF8+DmIwMvbxWkG5wf7h2ZCHeIDqVlj9XmSGY3ja0e8vKSj5h
         KNf+D9omOT4ijbrmEWQv6qTP2fiXYnc2djKAE8+3Sjy8mUpg8Yml5AjPYSbbdlyC1CDu
         ymbvWD/fb5xG2ydNF6PuZg643ZU5TMfZo51L/5DDcvUYpLLJnGW1gMNiR0A8JR4ASRcl
         V1BNvBNUc455lxqMRU+w7au2Bf7jsN300FrqV97VJLFYS0Hcq9r0dFNnPEDzZ3D5rcSg
         4GPQ9mlZ58u0U/MRJqXMUhK5GhTbdndxUfHXxrY3dh+vyyClAJhccCs3zMp3eF77+aUk
         A9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205957; x=1793810757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5in8JYDIp4RMV45UjLJidXa8aYTDsL3MP3EiBYAT+V8=;
        b=Gkrh6sYtqZWA/SbWetKXRdPO+FKZ6QkRXr5WbAmWpBZ7JERIVL0+EZiLlpg5QDEUrf
         IErfMIbDKhTew8I5cCpsJM2RyN+hTcuQ8QrHTSsoZcr+KmtJSurHg/U9dKc31qEQPuif
         PPEhZnforJTKXdOy6DTKwnKzz9WUtc1TzLRW6WjwM3JrzsSgsLTeGckfGn+33Dy6+sTM
         WxiefUb1fnWRbe8FdjgATuuLrBnvPtZfEnf2Iw8hkEJ1jcfqtqdRxWl2xOp8vaqtGjM5
         PQiHAJQEZ3EzGPaOQYeZ4F9HqUIT5XC0AUw8+3HsGaTaJbF5KlDaccv2czyofRbkKy0A
         At6w==
X-Gm-Message-State: AFq9FYJGTgecEIK5b47Q0iCZQDXFjJ4H+JeONuxAdIAD1Hk8aN5UGtJ+
	vZetw2oP9x7Y+oa2sEkjbKj6t/b1T0oJH660lvC+VTQrW0mHq9+VdgmgBi0uGHxPzUkeauQ01Um
	5rkrAArg=
X-Gm-Gg: AYBFou163DF2t9lXpymOpZS8Vmc1oHKR/Cf6DxZlVKRRAJOS+23nbAO7BQSAyDojxXQ
	m/XVjeJrb260biAJ01y+qy/KsygDBuw8KxQ4myIDPIOP7E2TqW+Ka8GTiH3zlMNbsA9BVqTejvO
	ZJwhskcfuAqYldYj9Lt+aStfBUd8DLn2hcmf4GJ9swHmGMRTNDm0qh/sxnyEMdA+2CQjunHYise
	moaqp5wu/tXlTNE4GlvtelhGVuDMb/uCj7R4S+SWFPHi2IaD8U3R9jBbwbJFBNbk07MFHWaJ+FB
	XTudURnKyls7pSjicabG/2OYkHU0OaztMDJ6xLkceD8xXeevcj7YLn7T/3rAHeOhJQuhrvA05nO
	eO3VGS9T3MjoEk02VL1Wf64MhJA7FWKX8xnhcDvPBZGVUCDWWmSeJC37R79pLJ0yoytQBuqatjU
	N7nRmRUiNmEXUX6uc7cGl95gUk3MDse47hTla+HRBAmkgpQKovC60RZ1f9vaL307qXMQyaEot5I
	/W/3Hnbwd/YI5PVl96ONtS+xUcFQMSkp23pb5PR2AoCKCrP7eJEfopUUbQsKPtlb94Lfo7lAqKB
	Oz9hMMdN166DtkEdufRM2NZ689NHBBbKaV1JVxzWC9/J/7U9yWZwVxMBM/QBpTCdpM1ZrncaBEc
	=
X-Received: by 2002:a05:6830:2b22:b0:84c:85e8:f922 with SMTP id 46e09a7af769-85abe8bb899mr2885193a34.26.1793205957278;
        Wed, 28 Oct 2026 09:45:57 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 79/98] nvme-tcp: start error recovery when a send fails
Date: Wed, 28 Oct 2026 10:42:22 -0600
Message-ID: <20261028164415.1262013-80-axboe@kernel.dk>
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

When the target closes a connection, nvme_tcp_state_change() calls
nvme_tcp_error_recovery(), which does nothing unless the controller is
live. While connecting that's fine for the queue being set up, its
Connect fails and the attempt with it. But if an already connected queue
is closed at the end of the attempt, nothing fails, the notification is
lost and the controller goes live on a dead socket. Every request on
that queue then fails with "failed to send request -32" and is retried,
forever with native multipathing, and if it's the admin queue the first
keep-alive fails too. Nothing but a manual reset recovers it. The Linux
target closes its connections at exactly that moment after a fatal
error.

Start error recovery when a request can't be sent, as nvme-rdma does.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4aa666dd0266..52c7f6dd34d0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1461,6 +1461,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 			"failed to send request %d\n", ret);
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
+		/* The close may have come when nobody could act on it */
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
 out:
 	memalloc_noreclaim_restore(noreclaim_flag);
-- 
2.56.0


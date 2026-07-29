Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB242C518
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345049; cv=none; b=gFZm0RaeZkL/jZx3tEToVMi/fK9H5HhQtQRFQ9YhUG9VzWpgRItBYSYaDPqzwBbSDaQAwGXXOmEg+m2t5eeS2lQn3zjBzWGHwnY7Z/PmRatlonzYgXBGskCIsx2eao73EWj3k5bR8EXA22CQYapEeIHbtBIWzaW+XppP/k+4484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345049; c=relaxed/simple;
	bh=MXEkjL34ea1s6Q1W61eODupyZj32zu2EgZa08MhdXqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwp5+5Sj5muk7VGk5BBn4r8qbXySlcwm5qTuOG8picw5WZnTrWhOhzLrc28J4cE7iU91e4c9nTUTc4zzjRNaiUgG4rlgUfDqTC/FQ2CrBmlaoD+U86cjiG3vCqArqxBU1/0/CpWuQIPRsMH3cZ8LC+JMDlsMPxXrMdniuuLoPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TPBTsJY/; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TPBTsJY/"
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-46f88060e8dso69529f8f.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785345046; x=1785949846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLVHhkHBmoWr4hLnZhpWfFYwOT17Jy9Iwi9YgD5R57s=;
        b=TPBTsJY/KEBKFaoV9u2CuldYr+IhSxu14sLaI2TuAsOpAYtCCHH9UZKZBn6Fmdwol/
         Q3C3TCiIPILA/P16GolFTnt2c7e4IFo9WPKHujrnoSIQ+uy+lfX/RWbFc+Si283sgsVe
         TdRaRNjCG18bMCGMm3UgvKz7VMPxjnmY9jkePf8KuS6izGtKl6BPx73me0g/2TZpun1H
         iZ+K+IIVj6w129TibhrdTPe2U375BfZBPuI6GD8pDRuErh7j6vNy9XWdsEeDrLH36uzD
         Apj5fO7DE7hx5qYy2OQojr3XmjAfLvf7WJOPNwLcYYc+JdmjTnAvcOjUtXTdzPlhsIeo
         Y6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345046; x=1785949846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLVHhkHBmoWr4hLnZhpWfFYwOT17Jy9Iwi9YgD5R57s=;
        b=I6Lj4UWAcGooDQoTCzS63Ka2mverNYB17/fDfFG6wRtWeIp1bu/esYo6b6JOOdhtUT
         NxiwR5piWQhhBmn9eZMgM23IUcOi6erXNBDzoXUG9rCBGZ2VPNKhoLoD9X7n82YeAhig
         ptbsJ0aikMVbMPn2zcVtxcdaLOeHsn+vpsO+9RNhlkCGuo3DSwRtmHMybZjMcLn1OFDt
         D64OMw/2qKLKyMqU2a+dRSvTk8jWzMb7fJ7oD047n2cLxTCNHi22NPnPbPodORN0DRc/
         EWFSgkTNX/PyJIM+le4cDPZi+OA9ZaNRQtQJxbC+qdIc6fDpGQ+y1SIzStlWohgehxKu
         T4Gg==
X-Gm-Message-State: AOJu0YxCKukypMZFyiYtyhtZAIG9+hz79UY+jwJpXF5OI8MCs9fGFKCI
	wxQDtqQuujLieR3I5LaK6Qrb6+wG9QlOfs6wYuZ42JYnB/heylD8ZyW77mf6LckBqFqVtOPZphF
	KvmfEh/FegjxcO+i/dfMonaowRcnmcSmFMnJb
X-Gm-Gg: AR+sD11vgShlnDqtJ+rKG9MyBpnbOo4f131CKwaPHvOu7rWExGOCSqiDl8vCdMB3JRI
	1L1y6kMJlfLEbwVo7vK28QTWgkCamnG99OJXP/UyashbIaSaRum3Z+uYEsmQSmtmUQLlMW5HVH3
	7E+7Fyv0zITK028QXST5YF5FGoDcfdnkSIRG5FeH0PkduSLqn2+GfOypoWkkSkeDHYHxXjXrydH
	iQ6cXo3GD4swnGNia84afOCU9Z+u2+WsNfBeqIr/LrVCxSyAJLX47JffFpnaTBVUHwgD4SLJwgr
	WOOFOJEuFpcBASXQ93MFr194GvgY86AvARPoiNeE3RaNlil+HEJxpeo76tliDPinAgdHaWUx3p2
	Utj1j/jC27Af172gXtXE8LXiQm6KvIaV1
X-Received: by 2002:a05:600c:1d19:b0:495:4505:dad0 with SMTP id 5b1f17b1804b1-496c641546bmr76812285e9.2.1785345046288;
        Wed, 29 Jul 2026 10:10:46 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4976bd8bd7fsm2233975e9.14.2026.07.29.10.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 1DF7E40202;
	Wed, 29 Jul 2026 11:10:44 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1BC7BE4017C; Wed, 29 Jul 2026 11:10:44 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/3] ublk: remove WARN_ON_ONCE() in ublk_unmap_io()
Date: Wed, 29 Jul 2026 11:10:41 -0600
Message-ID: <20260729171041.45061-4-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729171041.45061-1-csander@purestorage.com>
References: <20260729171041.45061-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io->res is set from struct ublksrv_io_cmd's result field, which is
controlled by the ublk server process, without any validation. It's thus
possible for userspace to trigger the io->res > rq_bytes warning.
ublk_copy_user_pages() already limits the copy length to the request
data length, so drop the warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2cbc359dc196..8101c2a73efd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1495,12 +1495,10 @@ static unsigned int ublk_unmap_io(bool need_map,
 
 	if (ublk_need_unmap_req(req)) {
 		struct iov_iter iter;
 		const int dir = ITER_SOURCE;
 
-		WARN_ON_ONCE(io->res > rq_bytes);
-
 		if (import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res,
 				&iter) < 0)
 			return 0;
 
 		return ublk_copy_user_pages(req, 0, &iter, dir);
-- 
2.54.0


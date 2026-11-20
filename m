Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143385;
	b=ewCiVxHrhCbsV8/2VBu4nJCOPDZNf2b4i0bBh6sGw8x/HooLAst6PZhl4AGEDDcGNbRO
	 7eKINVuahmOwKGzWvQ2KW2ntGkvUYQxIGbxzYnqSIhotXIepteQoxgGCM5ifDX5zoIqkD
	 V+b2er8aWlh2mEgQ54PH79b1E1X94mjOsc99EPcvlLB0Hzn+148Uh9Qp8F1xcWOZKnEf7
	 +2wv0/e4mvzBdwheZqVePUMxkiv3jAEZ2YOMyld5hx1ijtu2ct1WAGPaYyhacNBfYSkv9
	 Aqxrnh2Ntnjkp/LPmnCRHsbLWgYU9JG3OjG4dxQbnqTbVAN5sgnBL27xo50ROstuGXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KWEY6nl/y5ZxN2FGJqAD1BanEQOLjtbrxGkg3tG9xY0=;
	b=kDNxWEnBKU3QOXMGdNiJWtKAU1vb2Iz4urdL4GvmZFDhtUIvqFmnE1SqLMu3OAxkZcun
	 wm6Dfmowm2wf3xonDvrVOjWXkZxQ/e7jyC/l1POwdrlKtiKUqPh/YhHTygXOyKlGlBFEz
	 JNDOjDvk01vT67+bFxkeBixEZGBm0QEwZI5J4hD+o1+tqwL+GnZNMVVFkLWVwcp1EQs3O
	 Lx/sH4FEaq+8fTVyeUa3zteBC37jZnzN4YkDoTesboBhb8ugOlQmPBy8CAvML/hjuwodU
	 am0BHkjAk3w7NGmWF1PPl8qe+vWUarBJbf6O5wdwEPVDQ2auJjwc7X3TDypqzJqW4iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NVEghiJ7;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46260A2616
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C46260A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NVEghiJ7
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso314773a91.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143385; x=1795748185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWEY6nl/y5ZxN2FGJqAD1BanEQOLjtbrxGkg3tG9xY0=;
        b=NVEghiJ7Ob3LqdXCc9Q3IfI1SEwA7mDDRvIfvBHpL4Hc7e8ehixqSDwd62wlpsqLMi
         PDj/Z3OiLuoxMDFGHRN7c8W917rU343Rq5uLhv8VUjS4aQKjKJoS2VNYSkxuts3qlXSL
         m1miO/XS+ayG9BzUn17rXTJaXrZNUhsBy8vA0YSoeDdJLqSPleYAgiElnw67Ovm/NOvR
         LihMt4I7FY/DLzsCivTMn0Jm7cRdwGxFXf9jG9HacYdfJsx1OhIAw4bzkj0+VuEWspnZ
         trFDDPDCQuBunBYrdcc4YynNO5PY+PhY73q8cWDDKpkL7mZQGBQQ7UmggjvROBbWQStL
         LbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143385; x=1795748185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWEY6nl/y5ZxN2FGJqAD1BanEQOLjtbrxGkg3tG9xY0=;
        b=mQ4gIdLFcl3eRM/3dTxoagB3+pGwARWms1vGs+1vfvTc1SR+yJmvbkWA2mSTDfapXJ
         SnJilWNiB/ShLKwvH5DO4cYUMx60WHdrprS7pgEGLtzIfgDvodqsOH0h0jFWMOswgzxU
         fJLAP3ZMEqRj0XqSA979Okzm8JPr2q2GnEN300+kTGxzebuCoiCkM2bFf+kOQufIjbKl
         lZfUWTVTJiRkH1mJi7EjzhGRKpK5t9kPYmgeSrNCeR7jaU0G3VJPHRLFHQ5hFOTrw8cD
         patbZFA+byt4aVpSVXuWS7Gb/CXv11+BdTjtMsKDpmuAJrE2BmnSqkEUWawytXYd1vEv
         pDoA==
X-Gm-Message-State: APuU4Z8IsU62GLpRklMCLUd/7YazDS5iGw5gT5+UcP/Pzqbui0YL9b7k
	6Yp4W3xxh8uCn8dFSPNOfxTvA0zzaVG7XEKDNknccwjgdIKG0Qrstk5y8JTyvgJKadH6cymhmF9
	1wU9BaBMndM6bW2a3Ir2wqh31ama9OKxJXE7HdweWHaHj6nRzWqUIb8DKBQ==
X-Gm-Gg: AZFdTZf56EnGI7mB+tKh+sj4pRtG8FmVmr0xjTnFvBEN4zLu+HThtbaX4oiRSGcml01
	ZvbjCS2DmpEJnsNu1nEjfs1K3fqWK/ZbBepvVabxC3lbZ/k55Vj2UzXX8HKb3rIRHd2RIBSzuPk
	EF0o3qz2YzEo3mxnhIMX7L+92tzfsp4haipdir1MmM1wQWNumEOd5pvokibY3E0ElM0rd9iJKG1
	ZPfJEtb3uwVIlIFuVfVYbgdVHUKUTf/dG5PyjZfRDiGecruEYE9wZJVoI2EhqoEJeSnGUPVAtyi
	QbGNbFtHiZQqfDSv47SN7IE5F/SCuf7ZQbf+zLynbqXHCQfHfbogY9YQ1OwyPtxPEejYzKIAOey
	XT0t/qRdIY/noALOYmHSQLQMxdjo+fk+aGS8xyIT8XW1x/lYBL57jLuPEdymw6WNRujzvcZZutU
	8KLoaRlqFdaeDJHiqFPXVqL69v3T1gnreTFBffQ6PI9LFUTjXXDMOty/eauZ0B0NZnpRGRXX9U0
	UeFWDLE9Ef/hM0n9tDBYMwPZSjrAVnt1mkPIhdFfbzJJe+fQpCqURxcGywORak9FkE7/fEW/4f4
	LQhRqMQYHoTqBiAKPBzyiluhvIn1xemCiHLAVQ==
X-Received: by 2002:a17:90b:17cd:b0:3b3:ab8c:c7e5 with SMTP id 98e67ed59e1d1-3b41c95f65fmr1345392a91.56.1795143384542;
        Thu, 19 Nov 2026 18:56:24 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm5546461a91.8.2026.11.19.18.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:56:24 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v2 5/5] scsi: mpt3sas: Link tag set debugfs to the controller
Date: Fri, 20 Nov 2026 10:56:04 +0800
Message-ID: <afdf1d26951b84f4de98c0a8b34d3800019df3f0.1795143228.git.lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795143228.git.lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com> <cover.1795143228.git.lei.chen@smartx.com>
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

The tag set debugfs directory lists the adapter's request queues, but
does not link to its IOC dump and host recovery debugfs entries.

Link the SCSI host tag set to the mpt3sas/scsi_host<host-no> debugfs
directory after adapter debugfs setup succeeds. Remove the controller
link before deleting the adapter directory.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
index 183391f6b8d1..9f64a7c9db60 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
@@ -144,6 +144,8 @@ mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc)
 	snprintf(name, sizeof(name), "host_recovery");
 	debugfs_create_u8(name, 0444, ioc->debugfs_root, &ioc->shost_recovery);
 
+	blk_mq_tagset_debugfs_link_controller(&ioc->shost->tag_set,
+					    ioc->debugfs_root);
 }
 
 /*
@@ -152,6 +154,6 @@ mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc)
  */
 void mpt3sas_destroy_debugfs(struct MPT3SAS_ADAPTER *ioc)
 {
+	blk_mq_tagset_debugfs_unlink_controller(&ioc->shost->tag_set);
 	debugfs_remove_recursive(ioc->debugfs_root);
 }
-
-- 
2.43.0


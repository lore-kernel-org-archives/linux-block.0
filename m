Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763528121F;
	Fri, 11 Oct 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661815; cv=none; b=GXp8pWvQvFRSzZNJYdGtcU2T6A6fY1XUWA2Mi1QWprY3EJsJma5mSFkrOWZhl3fFtYJX8JCdqBJnA1E37VXZ2hA07kxxsdkJb1TH1FVmh8SV08TaUgMaAZlR1CQcQsPmyj3N2s7wzamzTT/R7uXjhEabgLmQcRI79ks4jZTnKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661815; c=relaxed/simple;
	bh=dNaagMp2bYJLozsyoqEG1U0iqwnLasapZ115/GGHmbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stz97Nx4Uy/p8WNAZn2U2CyrOM2YFxq1zewZd76D1KjXnAxjP+VgMN+Pr72JSl1qRwCkWDX3s25AnJb56vgaP9yDMUpxAAYNfT311/YDwcdTDQwy9bwe2UYfbD6wvLfsTDFnUB1XvUaEDnlQdXpP3VJUYs7LA8y9WYZToayXvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53993c115cfso2932190e87.2;
        Fri, 11 Oct 2024 08:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661812; x=1729266612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+mX6k5e271iKgfaonKKogx62EDuj/U0NnrkRDMTuNY=;
        b=CSOo6IJ1R1eM1pp34cdnNhGA65dFdpcowudQrs29tenUZGeMe0KUcZ5VNK9EZusiSF
         XT7iG3+Ef8AQc6S2LQ9YJwgqbmUr/CBM7geTVZYRdcTCYg3wt6i2euN8zICTTR7PXkj5
         8pkHPg/DArpV/F4XXd6yAmXeNK2sfvnB1XSLsRIgFAmyrUrulABKMWhDExayGmibufMt
         GG85gEJtKVogqV1m8rQHxLMOOD3bMPysp1xUL9k8elHof+lZCeZGI7M9bAfBjYKSxB1t
         Nh79a4DoLcMZCaNVu5vPDhCy9KavtM+RDaOwQK0s4wh3T/+smV0X3MDKVXV9FTD/VFrs
         PyDg==
X-Forwarded-Encrypted: i=1; AJvYcCWf1yuqsiZCSG065b8p1nz6x9aMooVBFGZVK2dcl2cahFjlY0mLocC0TdpkEhigTBLs6VhgCeTxQtX76Q==@vger.kernel.org, AJvYcCXdW4dRUXeyrT8gjp+XDhOe1cstzU7dIeOmYWb+mrSE7Zh3YeWS5Fxp4Cnve5Gc6Tc9C8LkCV8qYssBe5GT@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDWXkgo4rAsi1oE3NptFo+wE0NbegYYPOHMQh37ec9uq8oYWk
	gCSpqOEVNjC4ECKTEQlubhoQeToTWz48MW/2G4ElLGqQN0Eqqvl0
X-Google-Smtp-Source: AGHT+IG3GX73KARzZhDvyJxM7HeNeFateF+eFUiu8tSBQc8pi3a53XDvlEtT1q+yrvyY6eriaBq7xA==
X-Received: by 2002:a05:6512:3e0d:b0:530:abec:9a23 with SMTP id 2adb3069b0e04-539da3c67c4mr1886915e87.17.1728661811251;
        Fri, 11 Oct 2024 08:50:11 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf49910sm78482775e9.20.2024.10.11.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:50:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hch@infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-team@meta.com,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] elevator: do not request_module if elevator exists
Date: Fri, 11 Oct 2024 08:49:58 -0700
Message-ID: <20241011154959.3198364-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever an I/O elevator is changed, the system attempts to load a
module for the new elevator. This occurs regardless of whether the
elevator is already loaded or built directly into the kernel. This
behavior introduces unnecessary overhead and potential issues.

This makes the operation slower, and more error-prone. For instance,
making the problem fixed by [1] visible for users that doesn't even rely
on modules being available through modules.

Do not try to load the ioscheduler if it is already visible.

This change brings two main benefits: it improves the performance of
elevator changes, and it reduces the likelihood of errors occurring
during this process.

[1] Commit e3accac1a976 ("block: Fix elv_iosched_local_module handling of "none" scheduler")
Fixes: 734e1a860312 ("block: Prevent deadlocks when switching elevators")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
 v2:
   * Protecet __elevator_find() by elv_list_lock (Christoph Hellwig)
 v1:
   * https://lore.kernel.org/all/20241010141509.4028059-1-leitao@debian.org/

 block/elevator.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 565807f0b1c7..1ac9be3e47d1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -106,6 +106,17 @@ static struct elevator_type *__elevator_find(const char *name)
 	return NULL;
 }
 
+static struct elevator_type *elevator_find(const char *name)
+{
+	struct elevator_type *e;
+
+	spin_lock(&elv_list_lock);
+	e = __elevator_find(name);
+	spin_unlock(&elv_list_lock);
+
+	return e;
+}
+
 static struct elevator_type *elevator_find_get(const char *name)
 {
 	struct elevator_type *e;
@@ -708,13 +719,16 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
 			    size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
+	const char *name;
 
 	if (!elv_support_iosched(disk->queue))
 		return -EOPNOTSUPP;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
+	name = strstrip(elevator_name);
 
-	request_module("%s-iosched", strstrip(elevator_name));
+	if (!elevator_find(name))
+		request_module("%s-iosched", name);
 
 	return 0;
 }
-- 
2.43.5


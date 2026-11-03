Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687289;
	b=Mqor8d38ztFblkcSBL6ZtjJP1c+W59bR/M6aVUnQ2xcq+bCoDIRFmlpl4EhJ9hDeM45k
	 xwkkfvOiuQtZRzH0ek62b+l7/bO2hU01B6RkAhJWNqBT2rgRzpZOr04cgw8JTuX8vsjHY
	 s9vQ4TGqnmIf2xAdVK7qqmqlIFbBskH1cBz21e5yHelxLlt1OVp8bm+XZAWdQafpEhqO2
	 YBPILA/3UCZoCDebZTTQBi7nCWIWt+ZORQcf3sm43/Gs/FpX8t7vA6+mQyXro2g2amVJC
	 zV5AuqMw7CfB+rJs78uHBbGhPejvRufHmye/GcqK4qQC54O0EZi/9hZdwxoZfHGzU0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer;
	bh=iFbLP8rEml3d1ZY+239sLeSasqkGxTGMtsL3D+TgbaY=;
	b=MR/nWnKeycYMJndkG6c/TyYOh+/S6K19ghHUsORxy8nQ2kLshiw+cbNqj3SBJ23gBQJU
	 A6/JxrsIocfT3Y7eAcjseadXwXogBm4Sqepo32hRRbzViyo6zP11pQ3xiDiKg+TiBB28c
	 eZp5fHGI0pQENghqBcOJ6nK5vaEXy3FlWHM+zCe9vPzkObcMe96+vVbE/KfpHKTZN+k+1
	 n6hsPcN4CS+K9yDCvjz1h8ob6hDLXwna1uO52vNqi98TLzUQX0WiWFCQEhS6SYhXTIxW0
	 LfPhyrb377mDT6uMAmzQ/j74EZGkgravYscHSZv1NZ+74js0KUKGmelDdUsjov+p/Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPi0gZOw;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F7606A32E
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 06:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE4F7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPi0gZOw
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a18fc7a38so7198176eec.1
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 22:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793687288; x=1794292088; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iFbLP8rEml3d1ZY+239sLeSasqkGxTGMtsL3D+TgbaY=;
        b=vPi0gZOwAeTjvFBYIA/YnMPJeKjOqoiR4T7PNBAxhdntPkx2Oz2WDIkbOHvn97gziP
         v5d+tK9Td/WJf2OrFFVCcWXTQTK8f1hOkbCSiSdzHPOqW3pOTMsXFkJNAB4L/BTyyB2g
         XlQ81Fjx3HuFuJlPuVxFo/+6evEVVXpftXR4dU4ZYv/i1+mLnrrvahu19pTcG2mf0/bt
         mlOt+b5D6tfA4arB4zylFcSUBEh/k1vPnSyC8lCTxqJjMvOth8k1DF+DdCO3kL7Kkt0b
         oJ496ksEBiCU/EpSdJxbch9osWnTJxhYKW4+XJDi0ca7+GISVAuxk1VXV9FSqXKfCkkU
         52Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793687288; x=1794292088;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iFbLP8rEml3d1ZY+239sLeSasqkGxTGMtsL3D+TgbaY=;
        b=OL1yUmwl6RCwfLtrLdDo4nCu2E+Sy5ZkTXHMA6hctx1wPQsQ/zXOk5lr1ZC5LoMa7P
         INRX/PURfeyyMrQ2+1UG5ngfxxgriV/iajW3PIuzTFPH1wEoiXoB1F5dWa3Yhk3ZY1mj
         aQv/aDnaoRnWtU0dTuN8a8bkVsHteFhcCBhZ4Eva/wZOnOUpAXzJp/A1Xe4ipQxszIb0
         72ZPHXzOJMbc7eIcNCrw9f5SA+DDaPLT1udg0cgesw7gADZPDKk9oVT9UtZcGho+Xnoa
         gugYSjNtTG3m2EQ62tAxOWf8VbHt3YKljMA9WTwnHY4RMBU48UJhuRqInkBABibAUKmQ
         Q4CQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYhFGWdNy9V9Xv0Heg7CIGu4tF0F1cKwSSx2lMHmgTkKRisyuosrokXIIWyZE1c7/NFwWnKJ0KfDMERw==@vger.kernel.org
X-Gm-Message-State: APuU4Z86ylRIviFroVIqmFjYw/MioK+A910G6S0UsgrhhbtkHsqivXCv
	Xb54uBiC1SPiGHuX7HoskPf8u5NxPVOZdCjLXg0Lx8WRd29Fe86ESa89
X-Gm-Gg: AYBFou1v5f8TZ/jsNKuTaT9LG1ABarnH3KBOQeutQbDjuPr4ccORtvGx/YKPQcgJcmp
	ELvVtYkHUXiUuOFPWcoVD9SnYAleerLbqfZfrrXYKbXcLJ4EUplugVEcyd+LHkB+KSNyF9F0xse
	3g7teKfUdBLJ7VCCpcEUI/xTrxTwZV0O1YFlVft2VZ5JMCl7znCePvvw9pc5P+2Vioa73zVg+QW
	G58RHj0GULhGDNZQWrvEsdVeC2ikw0DxRhCv8HfuIbystUwxtrN4c13UL3jDkzMP2a7Anlvx8Oa
	umyflK7xNfYRR6rR4W+EyYXbUJN1HxSZulkYnbP+5j4O5pqHKZ46Bz14ts6VBxzCjTGt+OoQDt0
	VB7D2Yy7M8C4QQzY1hDMWOdW4hhyvFNgns+3kBm4wdO9H8MpsXVWrycPax73zYTelVms1tj6YL1
	c0UBNboOKQoI1F7a/gAZOGXms3eHQEwS1mide2ZpoJaTGKsBfkzeBw8b19B3XpQCF1KgQrU2VfQ
	UiBPOPuEMSWnOX33wHrdxXw50kTVw7ik29tkA3tsIYejbCL8ErdBZ3Dbr6OCImxNg40Mnwix7yq
	KpI7c25m5T1cIImUi+qfV2IexQcI0jo+QhKPApD8/Lj15Q==
X-Received: by 2002:a05:693c:42c6:b0:369:d793:328d with SMTP id 5a478bee46e88-36a4242f5cemr20252427eec.31.1793687287991;
        Mon, 02 Nov 2026 22:28:07 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm40577000eec.12.2026.11.02.22.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:28:07 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Tue, 03 Nov 2026 01:28:02 -0500
Subject: [PATCH v2] nvme: remove namespaces in parallel
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPF+6WoC/42NQQ6CMBBFr0Jm7ZhOF2BceQ/DYiwDTGJb02IjI
 dzdyglcvpf89zfIklQyXJsNkhTNGkMFe2rAzRwmQR0qgzW2JTIWH+8JQ/GCSXwsgiEj5zU4dML
 MJAO33EGdv5KM+jnS977yrHmJaT2eCv3sH9FCaLCl7mJGESJyt8mzPs8ueuj3ff8CijixCMAAA
 AA=
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Stuart Hayes <stuart.w.hayes@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

nvme_remove_namespaces() removes the namespaces of a controller one
after another. Each removal waits for RCU grace periods in
del_gendisk() for the namespace and for its multipath head, about
20 ms in all.

Deleting a controller, such as disconnecting from a fabrics target,
thus takes time proportional to its namespace count, over a second for
64 namespaces. Scanning had the same problem until commit 4e893ca81170
("nvme_core: scan namespaces asynchronously") made it add namespaces
in parallel.

Remove the namespaces through an async domain the same way, and wait
for all of them before returning. Each removal still waits about
20 ms, but the waits now overlap: a grace period is system-wide, so
removals that wait at the same time are released by the same grace
periods instead of each needing its own.

Disconnect time from a target on the same host, over tcp to 127.0.0.1
and over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
boots per kernel:

  namespaces  transport  before              after
           8  tcp         170 /  171 ms        85 /   91 ms
          32  tcp         628 /  628 ms       294 /  293 ms
          64  tcp        1201 / 1308 ms       533 /  550 ms
          64  loop       1988 / 1913 ms      1283 / 1200 ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Explain why removing the namespaces in parallel saves time
- Drop patch 2 until the elevator switch locking change settles:
  https://lore.kernel.org/r/20261031044141.5569-1-laveeshb@laveeshbansal.com

v1: https://lore.kernel.org/r/20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com
---
 drivers/nvme/host/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..18948c2ba218d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4716,6 +4716,11 @@ static void nvme_scan_work(struct work_struct *work)
 #endif
 }
 
+static void nvme_ns_remove_async(void *data, async_cookie_t cookie)
+{
+	nvme_ns_remove(data);
+}
+
 /*
  * This function iterates the namespace list unlocked to allow recovery from
  * controller failure. It is up to the caller to ensure the namespace list is
@@ -4725,6 +4730,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(ns_list);
+	ASYNC_DOMAIN(domain);
 
 	/*
 	 * make sure to requeue I/O to all namespaces as these
@@ -4759,8 +4765,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
 
+	/*
+	 * Remove the namespaces in parallel, as each removal waits for several
+	 * RCU grace periods.
+	 */
 	list_for_each_entry_safe(ns, next, &ns_list, list)
-		nvme_ns_remove(ns);
+		async_schedule_domain(nvme_ns_remove_async, ns, &domain);
+	async_synchronize_full_domain(&domain);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-async-ceaaa1eda6a7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


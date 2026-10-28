Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205936;
	b=xkbnFm3gI9YDOEbF+Cwfrg7U1hRj4opj5+GWxvdkC4jx/3MAj+xe9r13bBOd2Zi/lEf/
	 zIA7hCtIfqXBoErhfIk65qnqonSa4noL1QopnzG3AUucQ0ucopw1dsu/Ddpn/yrbM/v2b
	 f2ZXe2OdHKkwE1g1flJM8tWn5ikNRSEOd+6dNPOG0Qib/y/TpFVW00fq3PiRHbtBS5BZu
	 Igc+tziINRIZ3jNpzQtA1YR6gy6xAHZWIb6yPqkO1mBvmc+lKQBhUHiM+JsrgTA7fxH9v
	 Sg3VSLTfe+I2JpeFfJPLMRlL1Q5/sEjIRdE5ogy65pHs2+54aDojf9QnH+Yr+kHjahA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wCUY0em9ODZPFMSyvaOv2IqIbeYwuWkix2Dn3VoYk3w=;
	b=dGX+Nj83C7Wql1zivS9Nm/SsB31FNbTJNA+v1ZkDZa5CtdC0ecTUIyJvSHrDQcm+fGds
	 6H/WJGgw6+62Rga31IegutFzt7nP69UCnzRMAb8MiuQrhINQC8gA/SMYlsJrtQIaGiVTQ
	 BNQpc5N28twwTzUl1SK4r3jpw2z3QsyL5vJGhU7/QN36uRTR1sBf2UVZHYyvG6kEOKkSZ
	 cfdTj+tt4rpL5Is5fqlZ6ASkdJURRYiT8rmAgZA4NPSm7kUg//wxts8++jTApcPKkgt2t
	 RM18JwAYEePhm+Hg91df/kr+swAWnJuN+U2YrJrt0K5dk9K5JS+cCzmjhjDVgX/QDJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dQumBcxl;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909A606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0909A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dQumBcxl
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-85c1135c286so72354a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205935; x=1793810735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wCUY0em9ODZPFMSyvaOv2IqIbeYwuWkix2Dn3VoYk3w=;
        b=dQumBcxlEcltR5UOMnschNrSuxBEgOUcUpU7fcIqy/IKK0gNov2EU27m0AkMc7Rri2
         RS0x1O+SaW9ZuBBgFmZOa6qq54L8m8DEFi4hvxYfVntyFj2mHjMOz7QU+c2XoRO3+Zwq
         b0qvocWDdHCmLD8Jtpzp5jxOQzf7fTFFu5o9xZhYZwop5//be/ar8T8Uph7/t0NaQglg
         ltATdTn1Sj4pfoE3APZhPjoIAscK8MAbX+XAQqK7uaWhWpPQ1bKV9Un8QhLycJ1sO8fb
         m9X8s6KAJS2JxTwR0q2eBwElIxjvfRCN9zoYEdp+BdsbjLk5RjDATdjq3vlJG4az0JdQ
         dCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205935; x=1793810735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wCUY0em9ODZPFMSyvaOv2IqIbeYwuWkix2Dn3VoYk3w=;
        b=KRpRquIkd8lxth+zD6IZY0qRNQ54o6XoQXMFuYe7NH0sQ3bvu4eJv4+WRh0SXxSmN4
         L+9ij4WQb569SCSnKyldQfOvEN+m3dBD0oMUj0KiKxE1OmUrCjdla5lpKTQ+9K+30RFR
         42/ZtrD6FJnCyTV7f1tycxlQGySo9RkT+LJSrRUYsKfiezj04CCva/GJprp/1HEqf4us
         6A3meTg4+WIoomjW4r3FyOgCMFxCwKY/cTyOadoi/N9RpSGuf4KsWkukB2xL5CzskSq9
         PDImeHm4bIEr+202QVOd1JhK0itAhbytvlswl0radyKbJVAoSCG5gcbY2mYEz490nOgu
         UIyw==
X-Gm-Message-State: AFq9FYIZzna2f7Twe2KvYOu9WDO7VhIKCVyqgaDMRRWzBNsvuPXfnFmX
	W/zi0gj3eCyBUJuTtOy4lCV22iuD9LbW52NwC0IXheOLGlTfzF6pUVhpcOQVQ75fy/XbdHsMjTx
	NTdn88rs=
X-Gm-Gg: AYBFou2C9T2LLkVBvmx3+4BMHnGsgb6XDtcKAOptniS/aA+QInPH2xHWTGsiQ3/6HZs
	twL5YWyQ0TIPX8vVS9AKxoi3JqW/8yJTFSF8BCSwIQai7juNzdme/wNSUcrmyKU6kokm/DEA6kK
	lolHMEULArn4FZEdf+em71Rspw95c/C9xprIu85q3OIaaLpsFcWMUsXyW0YVW6CUceFoVAYn0AW
	jR8zbsvZXrWc2BK9jJsO8HkwBM8zxReg3FQEymaK38lFGgn1cvgV811WF8x4PtAVYjjFUCd+kps
	PjW8y342wP3DAUKsPVy8imXfEAvqDLKpcvF7aBabI0y0SDhLodtlDjKT8dYC4zpy/JnFWXNhe/l
	b3z/FVFjWNza3ucWt9gFQC0eVe6OX0wjgzASQROsphqj7j9UNQZJSgOK9Yom5Ckkc0aGtXGM07M
	ALTA4/tLLpVhJDFrJ2d2QEfbFOgPNJNprjnPeYxcoj1ZAdXJgi6B7c1NozgT/SjNfZBzdSff6aS
	hp97rm0OSjnqfhTRW7O/2lSadWxBhMBxsKnjxKEJUhxKQlmqebWt/tk5RmAyFlPkrcmXnm3TAdB
	KuUay7gAWwd1UsNW2JmTLBOTU6VVLwfMaKzL61WKz8NVPZVZX/svW0du1uPNLZgou9/qxLUb3w=
	=
X-Received: by 2002:a05:6830:4393:b0:806:dbd8:9929 with SMTP id 46e09a7af769-85abd90dd7fmr2640240a34.15.1793205935110;
        Wed, 28 Oct 2026 09:45:35 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 62/98] nvmet: don't mix queues with and without TLS
Date: Wed, 28 Oct 2026 10:42:05 -0600
Message-ID: <20261028164415.1262013-63-axboe@kernel.dk>
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

Since commit fa2e0f8bbc68 a controller whose admin queue uses TLS gets
no host key, the PSK stands in for DH-HMAC-CHAP. But a port with TREQ
"not required" takes plain connections too, as does any other port the
subsystem is linked to, and the Connect of an I/O queue names its
controller by NQNs and cntlid only. So anyone who reaches such a port
can add a plain queue to a TLS controller, and with no host key nothing
is asked of it. The other way round, a TLS queue skips DH-HMAC-CHAP on
a controller whose other queues had to pass it.

A host uses TLS for all queues or none. Refuse an I/O queue Connect that
differs from the admin queue in that.

Fixes: fa2e0f8bbc68 ("nvmet-tcp: support secure channel concatenation")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/core.c        | 1 +
 drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
 drivers/nvme/target/nvmet.h       | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5bd78bb83cf9..333739f14c2b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1646,6 +1646,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 
 	ctrl->port = args->port;
 	ctrl->ops = args->ops;
+	ctrl->tls = args->sq && nvmet_queue_tls_keyid(args->sq);
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	/* By default, set loop targets to clear IDS by default */
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 38311187d27a..ddb732f62981 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -377,6 +377,15 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 	}
 
+	/* All queues of a controller use TLS, or none of them does. */
+	if (ctrl->tls != !!nvmet_queue_tls_keyid(req->sq)) {
+		pr_warn("ctrl %d: queue %d with%s TLS\n", ctrl->cntlid, qid,
+			ctrl->tls ? "out" : "");
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
+		goto out_ctrl_put;
+	}
+
 	status = nvmet_install_queue(ctrl, req);
 	if (status)
 		goto out_ctrl_put;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46501d0757c0..cc7fface77de 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -308,6 +308,7 @@ struct nvmet_ctrl {
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 	bool			pi_support;
 	bool			concat;
+	bool			tls;
 	struct mutex		auth_lock; /* one AUTH command at a time */
 #ifdef CONFIG_NVME_TARGET_AUTH
 	struct nvme_dhchap_key	*host_key;
-- 
2.56.0


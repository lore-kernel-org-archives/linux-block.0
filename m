Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205948;
	b=ADrYVj18pxXqOtM+hQvFhkwHf82O1OzRBQmzBN5d5eqjQ5w4/DK/tJ6EhLiRtmjib+5p
	 OhY0LXP2oydgUIqooIY6eCWLK7DSo7XtZ/qoxkAXjAsQwxhFhoMRkNGpoSvc5+rMOqMrK
	 Ke3e9HqxPoiaqjWuzEQlLYpc1Ln5xnlw8PkgQIxCyVNoDAZi8TfBw44v53O24QbCddsLE
	 vyG9cKKZCXdqESW77dUtVMWn4oRD0zqnPZd2/kmZNDBOygW9rDkI0pla4H3YaGlFDSFgG
	 vtNWHJUtFZeVGHh7w1yQ2cXaOCdRisVjzdMbFeQwuoPiRgvomaPXeEmylr9H2n+Sdxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8GlTZg5Nmi1xEFEoDbZjjkwa1ikE9ENyXWgEb2Andtc=;
	b=HMPE3q1mV75tMiA/1nibfRRv0sM1B9KyKpzVt1a8ymgtg1pE6YQmoK2x1UBNvXkBKrVJ
	 qpu3bakU8m1bywnyTHMffc0RoAO/3Ihp5NPeOm2YhAKEMncuZag2haKiIVz2oYcF0Fxdk
	 erUbBNW4vrLu+1lv+9FSB6fwNxwKTR4wuLic7NeT4QN0GLe4voGsRu7FnEGvXcROXY8IR
	 xGXc2xveF7P1aXDbRFfufDTQF8frFR4OIWRTJmJ0RkPIii3a1U3ycOPttThJtSpdLWLQF
	 mG5/cOIQpWZDRNACsgfWwa0JY0iF4cIvLG93dIJEIRMj7YFNcj1V2QFV4ALWXdqtlGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cxe1o17m;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BC606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C6BC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cxe1o17m
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6dd059478dcso925964eaf.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205947; x=1793810747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GlTZg5Nmi1xEFEoDbZjjkwa1ikE9ENyXWgEb2Andtc=;
        b=Cxe1o17m2vX5nphkSRSqz5OxxRux40Q873/NoUPC0kmSYgkpCTUWiNOj9KZTk/wCla
         4VSoCV8c01WZuTX0t8TDp0Pbwld4KHqvPv5QWn+ar4pUfq/TFMIWA7wGYC8T8DYoXxcu
         d1/1DDrlbo5W6a5DDKQH9uytV6NrQ8A5jqjnoxnajNzbasVv34yoPczOyOYWLFXnjU3M
         sECkN56tE4aoWWIj8/a1h5KOFc/FcIiiv1zWdoqzQ2VpueOJPHWh/XBibcNkvBvvUIWk
         vrPLTzECwWKDMjUP1RnY+8OeD0rLIYH08qsAnYRHFfWb3PZcDwVHf9nggntQy/QMuxmW
         53ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205947; x=1793810747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GlTZg5Nmi1xEFEoDbZjjkwa1ikE9ENyXWgEb2Andtc=;
        b=WpvHNYHNFRX/+HJwU8aEJB5k9uHNCvQQC1L6S0nyKe0bRg96MOzFqjniWa4LCATMPB
         bzJmUa9WIShMnB6/EWG9pXWers6HjB96J2HihjUiDWYIqV2Lpl+PT6Svwm5AiS8Pl/M2
         sdU8GyeRgjO4iUxighRjCttPg7LiNPRJrI720mKnOMJsOShZTCk4rVRaRUg0Tz8/KiJd
         YaN+TxjCBXq/LQTWYvPTCwhI4e1GE66+NAwai6UVHiOBHOJ6xfGqCXZ9y37TmvAaw3GN
         QeE7hf/p6s94qQ+JBvy8myF4H1+DmJBFieLlwtAjS4gRefds3vv3mvcr0IekibcTKPUM
         qpCQ==
X-Gm-Message-State: AFq9FYIj0BNgV3rvwTYwOEgpoHgt3wcqe4LQxaYhEuGROOe0ZZo+QTGj
	ChUkgIZAbl2aCKQKN4qNN0ayk07+oCNlsXK0MFYwPse6uZISFmx3NCdYskH8tMPbImDo09GeHyU
	obKDqiQU=
X-Gm-Gg: AYBFou1fncaL9fGoLG7HY3v7MXLkm12MoOquitcEBzzsU4341zGXgs+zCYv8ZA/jMe6
	ih3oSr49XnGPOsew1QQylTyJbacFH7RXfqKJD8kmKmuweWJ7ghAKdEqcJaFmb5HAtqvWS2qRePP
	R3nX37JpEwFPZ3PZHxo7XmbnIEmQJb5opBAOlSPhizza+pulwqmIZc8jtdxtK+KNUWt8OpavU6l
	SD251SDGEGA3i640ggWchFsqIoCbZd8bNYMj2Bajqo3vn7qjDY54FQZsu0dkkERv8lHSqNB4cJJ
	VaFQXEVb0xxx+vJNP6VAhFJ28tvbN3EXNxXCt4kFfrYh5g3Un8pGbiCcE0raRAcPLm9gB73fV7H
	hg/CZ8VY0cpW+WtRvUCnIWxgcnPZI8m+imCr0yjgpQyWu9iXVutCJ5gP+B2bg1R2dhanwP+o+sM
	KydrJb0w9bRTcz0JmTL8SM3pmL6ii/zeykMI9c+pU30unRzkYZJ2hh9JJJL8mDEJZhE6diXs7ID
	e9HyqayOVbekwajYm7GxWwVJpm+4bOGUe/3IEGDcEaNHvxkO71u2CQmvVBR8/mzHBjC+ihKH5HP
	nkofup+D9aS3hK8qgG1VTSrKZCVNXE8spslzh4jKaT2h8MFrqGpZHsO0XMLcn1yAJyO/fEniMg=
	=
X-Received: by 2002:a05:6820:151b:b0:6f6:e7e5:9044 with SMTP id 006d021491bc7-713ede98f82mr2038901eaf.34.1793205947476;
        Wed, 28 Oct 2026 09:45:47 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 71/98] nvmet: check the host NQN against the TLS PSK identity
Date: Wed, 28 Oct 2026 10:42:14 -0600
Message-ID: <20261028164415.1262013-72-axboe@kernel.dk>
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

The identity of a TLS PSK names the host and subsystem the key was
generated for. The target remembers which key a handshake ended with,
but never compares it with the host NQN in the Connect that follows. So
a host holding any PSK in the port's keyring can connect as another
host, sees what that host may see, and isn't asked for DH-HMAC-CHAP
since TLS queues skip it. It can add an I/O queue to that host's TLS
controller the same way.

Refuse a Connect whose host NQN isn't the one in the PSK identity of the
queue. The subsystem NQN isn't compared, a discovery subsystem goes by
two names.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/fabrics-cmd.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index ddb732f62981..089e3082c388 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -264,6 +264,30 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
 }
 
+/*
+ * The identity of a TLS PSK names the host that the key was made for:
+ * "NVMe<version><type><hash> <host NQN> <subsystem NQN> ...".
+ * Whoever has proven to hold the key is that host, and no other one.
+ */
+static u16 nvmet_check_tls_host(struct nvmet_sq *sq, const char *hostnqn)
+{
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	size_t len = strlen(hostnqn);
+	const char *id;
+
+	if (!sq->tls_key)
+		return 0;
+
+	id = strchr(sq->tls_key->description, ' ');
+	if (!id || strncmp(id + 1, hostnqn, len) || id[len + 1] != ' ') {
+		pr_warn("TLS PSK %08x does not belong to host %s\n",
+			key_serial(sq->tls_key), hostnqn);
+		return NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
+	}
+#endif
+	return 0;
+}
+
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
 {
 	struct nvmf_connect_command *c = &req->cmd->connect;
@@ -309,6 +333,10 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 
+	args.status = nvmet_check_tls_host(req->sq, d->hostnqn);
+	if (args.status)
+		goto out;
+
 	args.subsysnqn = d->subsysnqn;
 	args.hostnqn = d->hostnqn;
 	args.hostid = &d->hostid;
@@ -363,6 +391,11 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+
+	status = nvmet_check_tls_host(req->sq, d->hostnqn);
+	if (status)
+		goto out;
+
 	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {
-- 
2.56.0


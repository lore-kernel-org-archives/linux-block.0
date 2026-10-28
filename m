Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205933;
	b=xHHHg4ugNLnEXm+7wQLS274lA1MV1G8vnduNQCLA2BYYkcwUBPuq+CabQYo/j551mKkm
	 +uMhI5Tjot1i8TP3hJ9lrHXSSPs9Tddd5dBNqGReg+lWesYKMwfbAWcA5fr2JTeN6yqAO
	 U2EXO9mkT9SVbADsSf0wntk5LB80KvEQNWz38amGTvFJq/jw4R+jtmSV5lG0GTh7cClJ3
	 cOD+Ge4IpmhsRYX0N5nP2F2tE0KNYjp+akxPM2agQuwljsgDpfsEphcDqZ+FDSfbyzr18
	 UV5gjKhkiBmv34ETAkp9VPJflmCOfJHAItH0nOi3pYdyy3nYp2jE/97gjk5ePLahkbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nG+DHn1LzFCaeXWX0dwZORZZuaohaWDMfP3DcwooPQ4=;
	b=I6gF0TcbKcppKV36sM7BRiu5nnwvVo4OLbu/C1E1AmTqaMOpSYHrKQDM+lu+YBeEDeSd
	 EnfWSGSc7hEnUmbFP1DUSmOqsqi28+X8d//3JYVpyU6/eq6Q39ilPP9xXW2kDUL9ldA/C
	 3RPJPbfEJ3QxcwwgfLMJrrRfDa0cCx/wlk6exQ+1A1X1s3LxIRg8WWZwOhVEM7CzgxXq9
	 MwEJboV84VWzQGp976buT/oxnnAv9ptkyHFyEcfSXnneKzznsm9VkN7yZm45nv2fTl05W
	 Z18+hKrZ5u5VhI4HMteG48JvHfC1f1ECiknpSxaaSbHZaBeyt3+zN2+p0ixfXafMlrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="HY2/kCuj";
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3D606A32A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB3D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HY2/kCuj
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-82380b0f55dso617901a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205932; x=1793810732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nG+DHn1LzFCaeXWX0dwZORZZuaohaWDMfP3DcwooPQ4=;
        b=HY2/kCujC2UK0EpIhtXXej0n0xGUbShMO7yXnM8irMWhpb10TnQzTakyhyIVoo37sY
         XGUVN6JOsQbCLOjt+KeSfSvOr5TrL6MtHHh9tecBJx+Axj+PoQGFucxUkz5UfB1JndIT
         lITvL5jUtv9OcJSTMkgei1lFjC7kU6LlT7WXnol6sQzTvLmqcQIEm9zr3+goO/D2Z46s
         IxoXcMTLOEhH8msNwGdCw8lLBOvmdFd5WHaUVeR0W3BlrmVzoaA2/54FntoleYQ2jhxH
         Q8pNnOwhLuNzHU5cF8itiZ7yQHFiFBoQzRV3yVTW1Pi3kcnS2GP7Na3/A6dHE7kFbBxw
         zxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205932; x=1793810732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nG+DHn1LzFCaeXWX0dwZORZZuaohaWDMfP3DcwooPQ4=;
        b=pbcauT5YfzD4A7G8UJpt7lnUIzMqonvJx3ERQswFLxwJJIDqSdSw7wZi8/OqsMord7
         dzE+JWN1FHh6eSBjRJy2a7C5Lhm72esndOBl5GsWyaDJYOQzlA1A33SshONz/dPpN+Wu
         0GnyrbhOw+is0Rw3YIyJuicspKTo4wFALM2SsKlWOHBALd6E8MRPrGSiYGXe+kLEpv9T
         U1qUavVB1ZLibLRzLoPLg6WY6j9n2a9nN0wnAVNV6QZ8jWPz0Xfe1QosZb6KceW7I0Ib
         xN8J2LDrfgYnw9UZK9NB0kAT69YKZ6bkGHBoywQ17L1MfHIxnuNsAxnZ5YUsyhAA4WSX
         ia8g==
X-Gm-Message-State: AFq9FYIPESEZd3crcu2KNEEpusUIi3ihTIAcHVpuJ5XcPMqnsNNyi7h8
	oVyfibNs/hHVOHQSvA5YJ8Qbv+2aiAfyGCKJOA3DGKGoQS6j98GVGh5M3Tu/iEYgWfHJ/hoQvpY
	JJBxedc4=
X-Gm-Gg: AYBFou1omQ0XqsFCcfYlc+AB8q11drphT9CU4PvTQSxhp5Xs+CixdJ7uZHAYT/E+BEN
	UcdHRAAxSu6JI7G7EgRYUM8f/SiwOhlYghZtD2EumJRST0JExQCKcF/ciKmZh/YSy8ZpW4SZApy
	7EPWSUiKPSo7ezVxGxREaQnVPGdlN5nlciGnFK8Swv9kUk8/XZltYw3s8YkQbzkOakRMr8/Lyof
	22cyxe3QmYw1/BzOgpA82/zLUkAJm64DSaApN3t4SameJ/ZdG9KmlaM+29NHVL2kuyeYVhCK+ha
	C4EwjXdT7lwxioNoEMXVnblLEwsQ46P2uVE2SYCzeiSmki3wuDU/KBckzKTANLzky0HPOuh1UNk
	nnRuWrnE2M7KxJwcZ16wxnlplAet8YlBeQWMOPdopu86wQcUPbpEc7PFrVjeZViUsCJS9eEELW0
	5qyq6lc8EgbrAqCmLmkyETr8velJb/Vq/B/oeWvSV69OZFcP6nvjhs6nIIZIu03JL0ALF4WIpbM
	9oizYMbKM1wzVvku9efeJ4gF3o7e+1oBsB8l5CJGlkcY7fZi+DL8SS5WtP+gPXuicxoS1SPEpeB
	ecvqBkw4g1uuJMzp8K4pKrksWMFPhoHpbQla2LeN/Jk7J9IHvgae5Q1CHCzairBADWpvm8Uoog=
	=
X-Received: by 2002:a05:6830:2e05:b0:805:620e:4d40 with SMTP id 46e09a7af769-85ab6f46631mr3432506a34.2.1793205932417;
        Wed, 28 Oct 2026 09:45:32 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 60/98] nvmet-auth: keep the negotiated hash per queue
Date: Wed, 28 Oct 2026 10:42:03 -0600
Message-ID: <20261028164415.1262013-61-axboe@kernel.dk>
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

Every queue runs its own DH-HMAC-CHAP transaction, but the hash that
AUTH_Negotiate settles on is stored in the controller. A host that
doesn't offer the configured hash gets a fallback, and that changes
ctrl->shash_id under the transactions of the other queues, whose
challenges have the length of the old hash:

  qid 1: AUTH_Negotiate (SHA-256), 32 byte challenge
  qid 0: AUTH_Negotiate (SHA-512 only)
  qid 1: DH-HMAC-CHAP_Reply with a hash length of 64

  BUG: KASAN: slab-out-of-bounds in nvmet_auth_host_hash+0x2c9/0x530

No secret is needed for that.

Store the negotiated hash in the queue and use it for the rest of the
transaction. ctrl->shash_id stays the configured preference.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/auth.c             | 35 +++++++++++++-------------
 drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++-----
 drivers/nvme/target/nvmet.h            |  1 +
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 1680e5e6839c..0f64fd4ade59 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -299,14 +299,14 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	if (IS_ERR(transformed_key))
 		return PTR_ERR(transformed_key);
 
-	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, req->sq->shash_id,
+				  transformed_key->key, transformed_key->len);
 	if (ret)
 		goto out_free_response;
 
-	if (shash_len != nvme_auth_hmac_hash_len(ctrl->shash_id)) {
+	if (shash_len != nvme_auth_hmac_hash_len(req->sq->shash_id)) {
 		pr_err("%s: hash len mismatch (len %u digest %zu)\n", __func__,
-		       shash_len, nvme_auth_hmac_hash_len(ctrl->shash_id));
+		       shash_len, nvme_auth_hmac_hash_len(req->sq->shash_id));
 		ret = -EINVAL;
 		goto out_free_response;
 	}
@@ -317,7 +317,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			ret = -ENOMEM;
 			goto out_free_response;
 		}
-		ret = nvme_auth_augmented_challenge(ctrl->shash_id,
+		ret = nvme_auth_augmented_challenge(req->sq->shash_id,
 						    req->sq->dhchap_skey,
 						    req->sq->dhchap_skey_len,
 						    req->sq->dhchap_c1,
@@ -371,14 +371,14 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	if (IS_ERR(transformed_key))
 		return PTR_ERR(transformed_key);
 
-	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, req->sq->shash_id,
+				  transformed_key->key, transformed_key->len);
 	if (ret)
 		goto out_free_response;
 
-	if (shash_len != nvme_auth_hmac_hash_len(ctrl->shash_id)) {
+	if (shash_len != nvme_auth_hmac_hash_len(req->sq->shash_id)) {
 		pr_err("%s: hash len mismatch (len %u digest %zu)\n", __func__,
-		       shash_len, nvme_auth_hmac_hash_len(ctrl->shash_id));
+		       shash_len, nvme_auth_hmac_hash_len(req->sq->shash_id));
 		ret = -EINVAL;
 		goto out_free_response;
 	}
@@ -389,7 +389,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			ret = -ENOMEM;
 			goto out_free_response;
 		}
-		ret = nvme_auth_augmented_challenge(ctrl->shash_id,
+		ret = nvme_auth_augmented_challenge(req->sq->shash_id,
 						    req->sq->dhchap_skey,
 						    req->sq->dhchap_skey_len,
 						    req->sq->dhchap_c2,
@@ -456,7 +456,8 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int ret;
 
-	req->sq->dhchap_skey_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
+	req->sq->dhchap_skey_len =
+		nvme_auth_hmac_hash_len(req->sq->shash_id);
 	req->sq->dhchap_skey = kzalloc(req->sq->dhchap_skey_len, GFP_KERNEL);
 	if (!req->sq->dhchap_skey)
 		return -ENOMEM;
@@ -464,7 +465,7 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 					pkey, pkey_size,
 					req->sq->dhchap_skey,
 					req->sq->dhchap_skey_len,
-					ctrl->shash_id);
+					req->sq->shash_id);
 	if (ret)
 		pr_debug("failed to compute session key, err %d\n", ret);
 #ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
@@ -478,7 +479,7 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 
 void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 {
-	int hash_len = nvme_auth_hmac_hash_len(sq->ctrl->shash_id);
+	int hash_len = nvme_auth_hmac_hash_len(sq->shash_id);
 	u8 *psk, *tls_psk;
 	char *digest;
 	size_t psk_len;
@@ -487,7 +488,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 	struct key *tls_key = NULL;
 #endif
 
-	ret = nvme_auth_generate_psk(sq->ctrl->shash_id,
+	ret = nvme_auth_generate_psk(sq->shash_id,
 				     sq->dhchap_skey,
 				     sq->dhchap_skey_len,
 				     sq->dhchap_c1, sq->dhchap_c2,
@@ -497,7 +498,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 			__func__, sq->ctrl->cntlid, sq->qid, ret);
 		return;
 	}
-	ret = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
+	ret = nvme_auth_generate_digest(sq->shash_id, psk, psk_len,
 					sq->ctrl->subsys->subsysnqn,
 					sq->ctrl->hostnqn, &digest);
 	if (ret) {
@@ -505,7 +506,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 			__func__, sq->ctrl->cntlid, sq->qid, ret);
 		goto out_free_psk;
 	}
-	ret = nvme_auth_derive_tls_psk(sq->ctrl->shash_id, psk, psk_len,
+	ret = nvme_auth_derive_tls_psk(sq->shash_id, psk, psk_len,
 				       digest, &tls_psk);
 	if (ret) {
 		pr_warn("%s: ctrl %d qid %d failed to derive TLS PSK, error %d\n",
@@ -515,7 +516,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn,
 				       sq->ctrl->subsys->subsysnqn,
-				       sq->ctrl->shash_id, tls_psk, psk_len,
+				       sq->shash_id, tls_psk, psk_len,
 				       digest);
 	if (IS_ERR(tls_key)) {
 		pr_warn("%s: ctrl %d qid %d failed to refresh key, error %ld\n",
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 9779e664b65f..841fd2683702 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -111,8 +111,9 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d, u32 tl)
 		pr_debug("%s: ctrl %d qid %d: no usable hash found, falling back to %s\n",
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 nvme_auth_hmac_name(fallback_hash_id));
-		ctrl->shash_id = fallback_hash_id;
+		hash_id = fallback_hash_id;
 	}
+	req->sq->shash_id = hash_id;
 
 	dhgid = -1;
 	fallback_dhgid = -1;
@@ -454,7 +455,7 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	struct nvmf_auth_dhchap_challenge_data *data = d;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int ret = 0;
-	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
+	int hash_len = nvme_auth_hmac_hash_len(req->sq->shash_id);
 	int data_size = sizeof(*data) + hash_len;
 
 	if (ctrl->dh_tfm)
@@ -469,7 +470,7 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
 	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
 	data->t_id = cpu_to_le16(req->sq->dhchap_tid);
-	data->hashid = ctrl->shash_id;
+	data->hashid = req->sq->shash_id;
 	data->hl = hash_len;
 	data->seqnum = cpu_to_le32(req->sq->dhchap_s1);
 	req->sq->dhchap_c1 = kmalloc(data->hl, GFP_KERNEL);
@@ -493,7 +494,7 @@ static int nvmet_auth_success1(struct nvmet_req *req, void *d, int al)
 {
 	struct nvmf_auth_dhchap_success1_data *data = d;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
+	int hash_len = nvme_auth_hmac_hash_len(req->sq->shash_id);
 
 	WARN_ON(al < sizeof(*data));
 	memset(data, 0, sizeof(*data));
@@ -530,7 +531,6 @@ static void nvmet_auth_failure1(struct nvmet_req *req, void *d, int al)
 
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 {
-	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u32 al = le32_to_cpu(req->cmd->auth_receive.al);
 	u32 min_len;
 
@@ -544,7 +544,7 @@ u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
 		min_len = sizeof(struct nvmf_auth_dhchap_success1_data);
 		if (req->sq->dhchap_c2)
-			min_len += nvme_auth_hmac_hash_len(ctrl->shash_id);
+			min_len += nvme_auth_hmac_hash_len(req->sq->shash_id);
 		break;
 	default:
 		min_len = sizeof(struct nvmf_auth_dhchap_failure_data);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f6a9f2e1c0ed..46501d0757c0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -167,6 +167,7 @@ struct nvmet_sq {
 	bool			auth_expiry_active;
 	u16			dhchap_tid;
 	u8			sc_c;
+	u8			shash_id;
 	u8			dhchap_status;
 	u8			dhchap_step;
 	u8			*dhchap_c1;
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205939;
	b=ijHB3YvV2QmG9Dx6USoBZkuRheUBC062tUyaEgn38nQVz92YEBGPXFOFSn4o/1bQk8LN
	 BOQFOdGSlNUYsenZTIWijW5rdR+X4nhfiSh8YSX4gAqXsO98auZNaoOPX5+nusxnmf0Tx
	 qSmLnEwWNYWQQSFMKiXAWjcw6Tp2+I4r1tkrSNA/g/SCMOVW8ywSHoaaUy5D5aNhl6UhL
	 In2uuVsSJXEfalpWTzpa4Wlndi/J/mxW8ay6qdg798S0S/12w7zCCrqEfO2xb45tktdD/
	 aW+vz0mW3VZW7wLQR2yUzgYGN0eivWA0OWrYbYIlVAo2g5831KS5lkv5Y2+9KmPB9mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9HjOEn5KRYeDjPxl3+MADDDzMUtxCO6TVOloylcVmLg=;
	b=Y2GQgppkFsWYO0nPPq88RjVozCtBnXdvkV6kRXHjoYsA2/8z8oDoX20BE9SphCkvRcC/
	 NRHLqwRvbZpCR21RG57I1IexOESw+4iShnsSm2mafD8IzK1NXlKckJ70+ZcKQKB7i7/mj
	 O18679SnhYWOadjPtwLQhowFJO8CXBZkLQCfxQ7Lp7tfvC7OZx8/9avTYMIdDbRXw9OpU
	 WGiECIkImVCs7F/pySze6tLMjKw2MFj0sPpxNXDyDrYrHB+xC7oa2zaZGPuManIZUOKPL
	 L55rVWLKF6R4/x6S/fQ5BkxHzjkgYdCidE2uIFAbz41YYFHeqDKbIAgn1U9sWoye6cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HiCyaL3L;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7898606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7898606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HiCyaL3L
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1411763a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205938; x=1793810738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HjOEn5KRYeDjPxl3+MADDDzMUtxCO6TVOloylcVmLg=;
        b=HiCyaL3L3VXp7pKchkOYu+Gq1KVlt3dQp8pWULeZIkkSZLKB364fft88J3z90RxYBD
         8Pif+bMMIOc6gU2fkEQJbEj8hYyrL4E6IcchFH4ETsHbnFl7CKGgvYg3Z0h3oHawQC4P
         01azJ/KMNfLqReYQhfYZeNMtEn5v9EZFJ8KAG2gzVSzylLNbNGmLJzn0Ly33c3LL6au6
         eR5bK5twDxhDXUldJqdAAWhB6YaY9Z4AqYMeOjDWnE5nawOtc2RErlWHHe5YFwvogI8Q
         lzczWXPiR42SY9ZBvRLgTf2wOv+1ayTWDHTH9szGlVv1IKjMi5DJt/0fE5LbObleD4/n
         CyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205938; x=1793810738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9HjOEn5KRYeDjPxl3+MADDDzMUtxCO6TVOloylcVmLg=;
        b=fhoKVCAkifB7uTYoOxF3CeyH9aq9Mt85rPQWsXJZRsY7yCDRoZkST+Gz0L4DMP+7YP
         zo6u2E2jiktqV8lc4gneIBj0bgobsftj8G4nD+mDh03My8QM3N4Cp7ji/2386BW1g60c
         qUsBjpYR//s1YxyTsSIZAcSC5FKyQR3fu0APUqykXRM8bYfzbV64srOSE1R4ktDvAa2i
         D7SfYo+Dyj7eT8PGhd1z5NBRT8wd/ijfQlJ79RIIueeKAdAtN+w3xLdYb8HFI2hSwJX3
         tL6PGK5ZTsmfXJuHYrgA3IzH8fb9FIsUXdfRe9mVaYmXHq09ZahBiyPitAKEmYlc8FJK
         lX/A==
X-Gm-Message-State: AFq9FYIJZV2wXlnRswCexa7Zktd/exMnfwZ9mmyc1MLCmjHdsbivXEG3
	hMD2I59GZakgaVUo7TUryNTjeUYr4DAqu3U/9AncIrZLguQBX//Umlyf1mU6LgThRrYpr/s8Spw
	ZsGvZHyg=
X-Gm-Gg: AYBFou0zI5yEYCO+R+CWRLEZBeIJ5WlDn+FIqsijlA46Vsd5ng6rtIoVklBa0YgnlQq
	sCLq4QeHQ0i9o/dTt4d8tlYSsFhMh40aU7AJ2yXhuFtKBT5mWQ6X/DDXj1XaSqwjmJznQv2NphT
	Mweyj3UaCmPg3yN4da2y4nC1M8Qa1RAQuzwR00RWlUz4xmNsZpwiMqyptXFU1+5g3CWClFvigFV
	f/p01JG7Ed63IhJIcIRDYdaBXWMB4YWHxt4SodfJbUM0iYl+WraPqyaIt18fUhEcs8kborqC5KA
	3TIQ2sfQj2w9sjJMSTP6kl4nibQJCNJJoHxgspAxtw7G+E4udihKmZC8t6NQYRcO7aPtgyb0ZTl
	0rFzRW27s/xVxezrgY17Mk7ugF0+qF//i+Kr24OGbjLrKzfHfN9VKjVb0w+DMCs9t1lZnfIn+Jz
	oJfoK9VQkp/ER2wSRFF1IBr1jyZegNy8eNbZZEu0PKqZ67UnxDWZQcT69upIWaMcfuD7unYDv9H
	dbJnlvXrve0MdhLLKjWiwnqxEU8LJd6DWEWLkVU1ubuvSWeH66Bk+ze/0CPft8EMhyQCoJR+KBz
	+uap+wbmC8YY9bWSaK0QRVusUew40B0bCiQZHFRXV11zGxsJTRsfsSiFBeXixU10XVfMSSiUZHU
	z+DU6PYnGlAFwzbVs2zZ9
X-Received: by 2002:a05:6830:7182:b0:846:5201:5286 with SMTP id 46e09a7af769-85ab7632a54mr2911307a34.12.1793205937688;
        Wed, 28 Oct 2026 09:45:37 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 64/98] nvmet-auth: keep the old keys if the new ones fail
Date: Wed, 28 Oct 2026 10:42:07 -0600
Message-ID: <20261028164415.1262013-65-axboe@kernel.dk>
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

AUTH_Negotiate on the admin queue has nvmet_setup_auth() reload the
host's keys, and it frees the old host key first. If decoding the new
secret fails, or an allocation does, the controller is left without a
host key, which means no authentication at all: nvmet_check_auth_status()
passes everything and I/O queue Connects no longer ask for it. configfs
accepts any string starting with "DHHC-1:" and a digit, so one typo
while changing a secret opens the namespaces to any connected admin
queue.

Decode the new keys first and only then replace the old ones.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/auth.c | 69 ++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index d1af4a921e7a..5809ce32a2e4 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -135,6 +135,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
+	struct nvme_dhchap_key *host_key, *ctrl_key = NULL;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -172,55 +173,41 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		goto out_unlock;
 	}
 
-	if (host->dhchap_hash_id == ctrl->shash_id) {
-		pr_debug("Re-use existing hash ID %d\n",
-			 ctrl->shash_id);
-	} else {
-		ctrl->shash_id = host->dhchap_hash_id;
-	}
-
-	/* Skip the 'DHHC-1:XX:' prefix */
-	nvme_auth_free_key(ctrl->host_key);
-	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
-					       host->dhchap_key_hash);
-	if (IS_ERR(ctrl->host_key)) {
+	/*
+	 * Skip the 'DHHC-1:XX:' prefix. Keep the old keys until the new ones
+	 * are there: a controller without a host key needs no authentication.
+	 */
+	host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
+					 host->dhchap_key_hash);
+	if (IS_ERR(host_key)) {
 		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
-		ctrl->host_key = NULL;
-		goto out_free_hash;
+		goto out_unlock;
 	}
+	if (host->dhchap_ctrl_secret) {
+		ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
+						 host->dhchap_ctrl_key_hash);
+		if (IS_ERR(ctrl_key)) {
+			nvme_auth_free_key(host_key);
+			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
+			goto out_unlock;
+		}
+	}
+	nvme_auth_free_key(ctrl->host_key);
+	ctrl->host_key = host_key;
+	nvme_auth_free_key(ctrl->ctrl_key);
+	ctrl->ctrl_key = ctrl_key;
+	ctrl->shash_id = host->dhchap_hash_id;
 #ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
 	pr_debug("%s: using hash %s key %*ph\n", __func__,
 		 ctrl->host_key->hash > 0 ?
 		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
 		 (int)ctrl->host_key->len, ctrl->host_key->key);
+	if (ctrl->ctrl_key)
+		pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
+			 ctrl->ctrl_key->hash > 0 ?
+			 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
+			 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
 #endif
-	nvme_auth_free_key(ctrl->ctrl_key);
-	if (!host->dhchap_ctrl_secret) {
-		ctrl->ctrl_key = NULL;
-		goto out_unlock;
-	}
-
-	ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
-					       host->dhchap_ctrl_key_hash);
-	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
-		ctrl->ctrl_key = NULL;
-		goto out_free_hash;
-	}
-#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
-	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
-		 ctrl->ctrl_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
-		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
-#endif
-out_free_hash:
-	if (ret) {
-		if (ctrl->host_key) {
-			nvme_auth_free_key(ctrl->host_key);
-			ctrl->host_key = NULL;
-		}
-		ctrl->shash_id = 0;
-	}
 out_unlock:
 	up_read(&nvmet_config_sem);
 
-- 
2.56.0


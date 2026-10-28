Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205932;
	b=X9yR0PA/tD8XTHueYUAIqij9LiMVLtQKLfwz85AN2anEmpFxHUbMQ5dzctoid1mCP9J/
	 DWdcKBhHHDvyoi1txqu8dVKY0BEkG1HhEYenMO2ihdkT2KYfsuK1u5MatBnUkbw8/gF33
	 5Gxibvg2nH2ypx+ahlL5l6e/6EbUjTM0O7U6Z2XAvnm4ZuKt9x3KuqQFzgWPzwCls56Ve
	 K1lB1csJmVhiVpZj4cr5nXWX9YcN4vZjw28dxGSu9ITHmh2WszMv48PLaSKl67/3OLMyG
	 MT00wRBbOJ0O09I5IQXZaZnK+4Nl2SfuqBLJgDtqYZmQ6VzVWYDkn/WQT/dZbssFydg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=57alDxAZKHbWslhiN+ncZnnWWIX7LK2pQ/+frwjDwvU=;
	b=2uKVLg94upSpnIYBESlxO/cHj8Ucsl58x6wEpVfXvaBBRaKc/3pxxxSAotMT+BBC0ZAp
	 huy6fwntdkAVoHWmi3+OTCIGa5o5TYjG76IMauQOfW1mcj6TsYzlocsjvmvm3D08sgtIe
	 smu4AAuyex1ylMOOpHJSeICU4GVTRWzeqqyYcf0oGNAKNkFJH3x/g7U4mjtX6fh/TxwnQ
	 HE4c8L1c1OBbRPKDA4MnVb77v2WDrYzgcVhV1+mr6zFavCRaxv0NEEWWCu823lkKAguUe
	 2iodDrz6nm91wbodqzNI+xR5ldk3ONqidEpe5mgChyEOYNjbzZDSwobQq+eiF+ku6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RmGrXGnk;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7D606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E7D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RmGrXGnk
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-847ac7ccd85so793253a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205931; x=1793810731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57alDxAZKHbWslhiN+ncZnnWWIX7LK2pQ/+frwjDwvU=;
        b=RmGrXGnksSqWhqszcpsX6JooBXlQZWuhQJkKQZ76tSgutkBeux3k/eg1QjVQ0wCSLB
         UNy3NQmE2f7w/26pQM++vLDoWUL8a4H7Ye9kqjf3IIq2SCwoUYs4MKsFCKSNTHGf+Ywy
         +iVMukA9nmeD/HGmRtzKu37HkxoXquN2MNotVdVuOUSOm4jphafFcZncmCtBMwf0HXYd
         PCR8dLrljtYKclnAn5ndxhPj0fLM8YihauJqqYw8AnaFjhBD/abAbaATdo0jgu52rDFL
         N3hDYibJEJM7jED9lrB94Tn48ojP4h/sHNU0Fe7yvx4Ytak5kxuaD8spt6AJWNQEuET+
         r+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205931; x=1793810731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=57alDxAZKHbWslhiN+ncZnnWWIX7LK2pQ/+frwjDwvU=;
        b=BsKdCFk7EjO0flUlM7PTlb11PXcXGQsk7yNTwPptPrEIVi/uOlRL1rEF+fWuHeQvtA
         WK3xAbFJ1bE8Q7flpf2dor1uphecBq3lzEzKIlw0oPXLlix5/cSmodj5D+Q2oWtiOLvS
         VO9uyF3liotgEK0qLV+VxY7+V8gyUNHx3tVgnazo6UlycpdYIqpnwmF32A1pGfEMpEu4
         gMFiWUxnF1WqAiLsL4zNsQ5nVTGII6JQjnW9KZwS3uzLjnH9JwquVFoEpE1jeueSpduZ
         zo16Rhm9MTPonllQYPOkD0fMen+pFtMZZD9ATVMiEniVmMN/56LYtjhVls3O3QU7S5Bp
         3r0w==
X-Gm-Message-State: AFq9FYLbKEJYi8NCJrgjL8hW4FVmgJnsOMLP+Lnc321vvL1gQB10AHSx
	rjYTKJHIjkbGIj/OUmN5+AxM0EFeDnYbhbNnISpvDWl/y/sUJd/UpTEpd/lQb1TTFhQAzfbMH0b
	WLXCOyyw=
X-Gm-Gg: AYBFou2RgGT5+nccELy2cOMuPUhn4NC8sWiGDhbqvyy0rThgqmyKL95PL8J4dtviPvX
	gbBRlDcSAGkswU0xmpLwECuvjN7ZkxX5guvta+A/83nTM9T8+ZP6jJihexzmZ81cjQA8wjlexrd
	TCb0iD7HJAcvlKyFwMTE53eVuJIst9NsY3OtcJDJ/CQKqvluubKNcPqMe9YgvuDp1PJp1Y4eUGT
	a7nsJdlzDWQu5pg7EQ+NNaDXVdDCO2nLvWmM1dugdGpBDvCPkZ9mqlaX+hB9xwwUcX7yQuvFW58
	WbehdA2E5TCxP7R5qJaEJM+lWJOJyxTO/Gj3HJpCUrW0W2p8PpzFmkKKfZFO4LzWHzvYyV2BiF/
	/61VAvsfKP5sQwgegqm8uMQ8O/rdzn1l+oFpy0AaaXAcRKl1WwgS85DHNkQq9DtfIwbqpkNvdOj
	40oZJ71yrh63TY5tBy9sO1SBZ+QzM7TGoXZV/XeRMn3rwnapqN2kRo/LUGO2FeNDk+5hbQ3meEY
	dxicaDKIoLxNq7vYLD6AfoLTep3iBgHAmQkZaptQvQ/RkajVyfAmR6T8klXWrLlcs8zFZ8V7OVI
	Kx2rSeRcxWzWXstneICaJgkk2JmqAIrLorm9vGaVWx/bCkFL+Q3vm8k6dlx17vc7DVEf8HV9YQ=
	=
X-Received: by 2002:a05:6830:44a3:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-85aba80b487mr2406159a34.2.1793205931115;
        Wed, 28 Oct 2026 09:45:31 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 59/98] nvmet-auth: serialize the commands of a controller
Date: Wed, 28 Oct 2026 10:42:02 -0600
Message-ID: <20261028164415.1262013-60-axboe@kernel.dk>
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

The host and controller keys, the DH context and the hash of DH-HMAC-CHAP
live in the controller, and the authentication commands of all its
queues use them without a lock. A host can send AUTH_Negotiate on the
admin queue at any time, and nvmet_setup_auth() then frees and reloads
the keys while another queue computes a response from them:

  BUG: KASAN: slab-use-after-free in nvme_auth_transform_key+0xa3/0x250
   nvmet_auth_host_hash+0x10e/0x530
   nvmet_execute_auth_send+0xa4c/0x1a00
  Freed by task 194:
   nvmet_setup_auth+0x166/0x3a0
   nvmet_execute_auth_send+0x3e7/0x1a00

Neither queue needs to have authenticated for that.

Add a controller-wide mutex and hold it for the duration of an
authentication command, dropping it before the request is completed.
nvmet_alloc_ctrl() takes it around nvmet_setup_auth() too, as the
controller is already on the subsystem list by then and an I/O queue
can connect.

[axboe: upstream already has the per-queue auth_lock and expiry handling
 from 53f6efe00cea, so only the controller lock is added here. It nests
 inside sq->auth_lock.]

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/core.c             | 4 ++++
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++++
 drivers/nvme/target/nvmet.h            | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8353950f346f..5bd78bb83cf9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1642,6 +1642,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (!ctrl)
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
+	mutex_init(&ctrl->auth_lock);
 
 	ctrl->port = args->port;
 	ctrl->ops = args->ops;
@@ -1728,7 +1729,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 
 	nvmet_start_keep_alive_timer(ctrl);
 
+	/* An I/O queue may connect as soon as the controller is on the list. */
+	mutex_lock(&ctrl->auth_lock);
 	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
+	mutex_unlock(&ctrl->auth_lock);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 1fe21f2672f1..9779e664b65f 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -269,6 +269,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	u8 dhchap_status;
 
 	mutex_lock(&req->sq->auth_lock);
+	mutex_lock(&ctrl->auth_lock);
 
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
@@ -297,6 +298,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	}
 	if (unlikely(tl != req->transfer_len)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
+		mutex_unlock(&ctrl->auth_lock);
 		mutex_unlock(&req->sq->auth_lock);
 		nvmet_check_transfer_len(req, tl);
 		return;
@@ -442,6 +444,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		nvmet_ctrl_fatal_error(ctrl);
 
 complete:
+	mutex_unlock(&ctrl->auth_lock);
 	mutex_unlock(&req->sq->auth_lock);
 	nvmet_req_complete(req, status);
 }
@@ -562,6 +565,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	u16 status = 0;
 
 	mutex_lock(&req->sq->auth_lock);
+	mutex_lock(&ctrl->auth_lock);
 
 	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
@@ -590,6 +594,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	}
 	if (unlikely(al != req->transfer_len)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, al);
+		mutex_unlock(&ctrl->auth_lock);
 		mutex_unlock(&req->sq->auth_lock);
 		nvmet_check_transfer_len(req, al);
 		return;
@@ -650,6 +655,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
+	mutex_unlock(&ctrl->auth_lock);
 	mutex_unlock(&req->sq->auth_lock);
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9cec19e6f485..f6a9f2e1c0ed 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -307,6 +307,7 @@ struct nvmet_ctrl {
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 	bool			pi_support;
 	bool			concat;
+	struct mutex		auth_lock; /* one AUTH command at a time */
 #ifdef CONFIG_NVME_TARGET_AUTH
 	struct nvme_dhchap_key	*host_key;
 	struct nvme_dhchap_key	*ctrl_key;
-- 
2.56.0


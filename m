Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205943;
	b=3d/3jdpqQayUUOaaB0JquM1FPXHTKL9xnaJ3OSiVQ00fxbEraHxxTZ6/f3pJkKRPGCmS
	 qkpb2hineahQCawXtOY5xe7GlQ9fgFKKgAGRuNzT49CLlI5QA+7PWnzh3K5l9RjA/FoAq
	 oPYaD7sXWjyTfHG+Tj7UkDOUnCsXigcdF8b4iLT0oSd6OPy/dZudygUdHshBCXaPjgaVU
	 SYyBJA2TZ2LrtA8bUrezG9kwSlmJlXiKx6zs7GQOyYzBFG6f2wikTLqcwF85SrjPos3K4
	 tC1XcIfUCsHG4vGHlTlfF/gogq1RrdkK9QaNF09PzFIjd3klOQKlPQlMS0GFiXbQPzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/f+r4kxEcUQOYGZe79oHiUBaPBQKV22xg7N1GSquL44=;
	b=CuiSFXy1218eCldl49nPpHfWucreJzwiDPE9v3BSrPqKx0RsEdqvEO3DKNC/nmBXBeJB
	 ltRiXIucZnbX1KkTKMncqkXHzwFtgkpm1IH8k5/SN8GuVON2m57GgniWqwPASyr3UXzM8
	 6q6rDkujTrLAyca5oDeLvNYMGL1Kut5ZSD/zLDoOxRp43vxpTTce2/tQCoDzzHJbI+avC
	 Vy5fzY6I9F/a8a71K0g5NRf7JSaSW+C0mhdaVCJD16+pPRGbo3EzyxFcCgKVItmuOpDlS
	 kp0JM0s2gq5fDlX58Q4PLtxXMoIy8vRYZbmVllHCjD3dJ84Lzxmslsy7L1Tf9js6Ydw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QjnUcjq+;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFA606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5EFA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QjnUcjq+
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8490a7d6696so709293a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205942; x=1793810742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/f+r4kxEcUQOYGZe79oHiUBaPBQKV22xg7N1GSquL44=;
        b=QjnUcjq+huw3p68ETlOBHcpGdKBr2MLHp5EaowIez054Y9w45dRjJbwF/PK92LNz7X
         NJtWXVoHr5IZSA8ZxTckZbXZuPggBYqVdNHKMgsqly6xre86te0uVcJDRPydY0xXYXTW
         S368pzbERasrUqnQIA5pcrcGxXnpXe1+3BSTZiiYMBnJVcAOBLd3JQJZHmldZ1vdaECS
         22BkJaHlK8qSNgoWfgnc3IjZgQPKHDKSjjhWX2k95cVcX9hvHQdxrL7XwuXmWHnvLHvm
         uzAkgVodTyyi1peEGPi24xsapF4vlj/1j71aY6r7nWFWz+i6JWBFpjeISmSFBqQ/Oakz
         PHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205942; x=1793810742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/f+r4kxEcUQOYGZe79oHiUBaPBQKV22xg7N1GSquL44=;
        b=cxG/kXEVheG835B2BuwUHE8HCIa7jo2BZlVq0Y6JURVuHwI+akvtVpvCMpu+LpCAm/
         sz9D5kezc0YB/2r8KB3aJaRovH1H7roxNS072mO9XjAodjC34iU0xkLAd5QSdgQWeCzg
         ZIi/CSu7QijKS2zwkwsCJdRNkrG9Ja17rqokNPE+cdFgdhAci4m8PeOLquqwBV4cr6dp
         XlfA15hQKnxGQl2D4PPTbrDtdnPt2Kpmg4V3Myzz12cMtMHBcKLh/Lkcf5x0iIl5TAlK
         W0TyCu0XtAwfUSMEHol/+sIC9WwKelkGlNhDDGZEyCu5tjwd9uoU4VDDvI3l6+Q5WRbQ
         dvTg==
X-Gm-Message-State: AFq9FYL/UYl77KqUtjvavifnVWDypCSCrxo+GjZXlQkucKvle3mSjXNL
	s8Nm9A0EJJEQGZOUubSePWD1erktqguv2OY/SZegqqOUNMFmbCzH6cdNW+FandZU2lh0mF0qZBT
	aDuROC1Y=
X-Gm-Gg: AYBFou1RBcOSXsJfsWcM9mI95/g0JyARCvEoux6z9fdBrSkIOmKlWXV08rH6kKNyvQZ
	EVcdAyLNz58v03kfwTFCPkRL0y+MhFmYrBU/H5P3wcO4D57tsUkKvFUaRYU9IkbaeDpEZmWA7s5
	anONsPt0jaHC9+nTE1MUakvdwydzKXVh86oj4OIsxoCMayktL2CnrGbZiOX7TA8rk0dS5tAOHM6
	1HBZICzJEBmQQNFYRedEmagI1YYC/W4W1wrbPWg50sbQKKUU5onzeOib+uHWiGadTEq8dFmnjZy
	N8Bj4vpe97Kq3QZpTKtEgVLKJ3nhquBVOW1k+8ehEihYiI8u61wHZzjTVLuBXKIb7OK/uSQU1bq
	5cpwLoywE/IiGmqSU/Y01q/cbTkGzNtIvibNgYuD9AkA9+06oMBaa5xeSdzWrQArcMeyziH+X9S
	c6ZjpaJ4DS9ITDL/aCCs3RfurVDFoioqWNqA+UUzie9A89qkFq6wRfG0WRl61XTvCC2Ms+DaCDc
	AQmT+9XCWYBALRQ82m0HuBTU3+HuBXQDTeaNzEl4k6bRLaGbpSCKSX1aRCtXRepKgzGV58Gofq3
	A9GzatpZk2E7vXx243MWww1+6taTQ9zeQ1mQzpkUWtFRokOk1YQSKOXyeuHsijz/GtQ0+hhixQ=
	=
X-Received: by 2002:a05:6830:680d:b0:830:43b8:72db with SMTP id 46e09a7af769-85ab81e111cmr2676949a34.24.1793205941801;
        Wed, 28 Oct 2026 09:45:41 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 67/98] nvmet-auth: fix the check of the offered DH groups
Date: Wed, 28 Oct 2026 10:42:10 -0600
Message-ID: <20261028164415.1262013-68-axboe@kernel.dk>
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

nvmet_auth_negotiate() matches the first DH group in the host's list
that is NOT the configured one, and looks for a fallback among those
that are. So a host offering only groups the target isn't configured
for passes and gets a challenge for a group it never offered, while a
host offering only the NULL group is refused by a target configured for
NULL, since there's no KPP algorithm to fall back to. A fallback can't
work anyway, the DH context and public key belong to the configured
group.

Accept if the configured group is in the list, fail with "DH group
unusable" otherwise.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 27 +++++---------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 665c56d29d07..8c48140eb542 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -47,7 +47,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d, u32 tl)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_negotiate_data *data = d;
-	int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
+	int i, hash_id = 0, fallback_hash_id = 0;
 
 	if (tl < sizeof(*data) +
 			sizeof(struct nvmf_auth_dhchap_protocol_descriptor))
@@ -115,32 +115,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d, u32 tl)
 	}
 	req->sq->shash_id = hash_id;
 
-	dhgid = -1;
-	fallback_dhgid = -1;
 	for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
-		int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
-
-		if (tmp_dhgid != ctrl->dh_gid) {
-			dhgid = tmp_dhgid;
+		if (data->auth_protocol[0].dhchap.idlist[i + 30] == ctrl->dh_gid)
 			break;
-		}
-		if (fallback_dhgid < 0) {
-			const char *kpp = nvme_auth_dhgroup_kpp(tmp_dhgid);
-
-			if (crypto_has_kpp(kpp, 0, 0))
-				fallback_dhgid = tmp_dhgid;
-		}
 	}
-	if (dhgid < 0) {
-		if (fallback_dhgid < 0) {
-			pr_debug("%s: ctrl %d qid %d: no usable DH group found\n",
-				 __func__, ctrl->cntlid, req->sq->qid);
-			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
-		}
+	if (i == data->auth_protocol[0].dhchap.dhlen) {
 		pr_debug("%s: ctrl %d qid %d: configured DH group %s not found\n",
 			 __func__, ctrl->cntlid, req->sq->qid,
-			 nvme_auth_dhgroup_name(fallback_dhgid));
-		ctrl->dh_gid = fallback_dhgid;
+			 nvme_auth_dhgroup_name(ctrl->dh_gid));
+		return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 	}
 	if (ctrl->dh_gid == NVME_AUTH_DHGROUP_NULL && ctrl->concat) {
 		pr_debug("%s: ctrl %d qid %d: NULL DH group invalid "
-- 
2.56.0


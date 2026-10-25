Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894742;
	b=CqRudYeP2oyE8fYU1t8jN6WvulP2YDiPotbol0lwMXe/KjLBTxMTBwkvpdGII97A88Cf
	 nwLQSEtNtyVbSR/TWV55Zqbf3iJBkpj3dFbMTFHGzrdqlQhKEXgOIWUcxwjz8wxZknv7h
	 tqzYIUSupeDpf/BHF+3a82AUbEOlkCj9gnd2nynbRrS5kjCLOlNxvnDF3L869KGBkYqcL
	 Z44mjqACyZ6I8mFRR+6Syg4K52FIJL5pCQEcfGafrjIvki4VmxrAzh4oHN4k0szSAfyZH
	 VyRT4o38vHtTxKcXht9wvrKNXVuiWoZme1FLDTZ7iqCqP+sLvPOcCYCmchJ4gRxH+Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KEgwNj0hBr33FG112cIbL9zPffMBohhrmKqGY1PHao8=;
	b=CVF8aXyDikbjiCqSt3YRlW+I8Z8XjHvqXfPs+qfNhkJ+VnRqcM8uduZ16UP108EWkF+G
	 rEt3Jt6kmxfVRJK932EdahhKtSKqKSQFrHDt2qmxMNvj0UCBLBlW2UkVliTPlwl4Jig31
	 AQoIYts5Gl/dx8KgjVybMsPvvBuZa7a1tZIPXrlg9z4P+AKUevzupAY9Ug8VSkJMNxfPe
	 BMvS3yfeU7LqeUzz6tXAsP5pGJMm/siwoIHi7oVrDXQTZkJbRahvsiWiQ3R7HWjSgc4tV
	 ebUX9CMV/QYtDhwarIqkQ7JOcPncK/qAlKt3C2R4MYmcU6VLOpciLZtC5XJm4CMjznA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RER3u3GX;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E234606A31B
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E234606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RER3u3GX
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so4064011c88.1
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894741; x=1793499541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEgwNj0hBr33FG112cIbL9zPffMBohhrmKqGY1PHao8=;
        b=RER3u3GXQWClMrGYyDbxqrV5BW1u1GC9lYWD26e3W8DlbaI6wBNL6hIVzpUj5WviXR
         C4kHoGhIl4ux4PwKSWjBO98Q7DBgQR3gIXg5Q4VAfrO/Vs+sM3jfvXQA1XJ95ZxUScR7
         nuw+2HhfyTQIVSwhuUpkzcGMuT8Jq+NFOoutk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894741; x=1793499541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEgwNj0hBr33FG112cIbL9zPffMBohhrmKqGY1PHao8=;
        b=laSV1FNPVqI9+YzNksu2/4Fow4OqyngBxZ3cRD+2O8QF1yinmSGLJe5lsbTUx/Lfdt
         GktDZS3S9W6irBl55W+i1HDF9vznupmVR4oatsOROZRAUcgd7jw8g/JaMb7WEz5obThc
         4V+XSu7HT9xPiQvXW26WxBCKzhzwPUOke326kc93TNUZfiuQ9Ce4GA8XAzrh6iSpML4D
         NfhVE5TNGE+7lN43vBAJJpCMOK8Aa4ZFUjwyLXlyZx+S0l7IYP26ObXIFxc1k+d4BYZl
         wqsfI9h0CEcJseLtNwo8ifhcdKIonkKj48V9dyfwoyPBGyAMtKebjFGb64jVGAtCLbVR
         1NLw==
X-Forwarded-Encrypted: i=1; AKwUvBx2fwJr9vE7A3C329i/bVte5ULUuIaV36iAMCdJccxWIDip1MlqMFWy+P7LozEoDYfHXvUeeuf6d8CTCw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI3BLhzgF/HZqZ2A7tJd33aoIBQaZbCkC0Sm8M1hFlZJDiRl8LB
	1/YDpBTqqoxXt7iUrxzFqsR2Eojfr+dY5IgRv4kJsHfeeLV7t+WroLTtevtyKfSpig==
X-Gm-Gg: AYBFou1eO+8K/iuNu57Vt9sr5iU2iqnsm4KZ4FHtw6iGADAvqoQrg8Dz1NW1/5xaBrj
	QpPW1FRMuQ2UnD/QAtvykZeOvYYdwxIxuw/tcofjqU1O7O+F/cbEXXCEyr3Fs1fzHZElNuwIJ1u
	5+/3B8eHwgIbdxL/qC/9j1QrddDBGvTWfwDNC89xzJqs3av8Y2+tU8jQhKMeOCID2KNt2D1Mkzg
	wSqWY5qw5fuTdBBt51LMto9pfR0KypRPtQydpocBzbclvW38GrI7pos35Tvb+obNru6YmeBh6VC
	Lxd6oDocMU/D84y2JuO1NgmEZ+7PCdbEdzgJv9Iq8klWbMODeswIlwkqWRO2VPgfRCrusqT+dR+
	2hUiXnqrIciMW7ZfxieOTkMjwK+GxOKDHEJKinmP1QC/3/rWZckp2jBisOt+ONy++ly/VCbIL0F
	Kc0FXAmK8Pz8OX327QZEkwDQaibBmRkQVj8Yw2yQnN9G3BFDZfxqlAjKal/cPzFHV9Dkhr5S2vz
	GR0xE6QTQkpgX8g+g/M7xUw9RjBRB69+JLfF9rFhfOL5V6LfFmeW71Gmm8UtB3kyyk6sHhC9ZnJ
	kZc1AL4L8Dfz0gOMv3Whha/vVg68cPlTVdACx7crs7SmAk3TvRTc0WaNYQHRBzwTl0Jq9OT5M0u
	oyQ6A0x8MPa1qOoosprcPWqOK8KndTWkauNE6cMM=
X-Received: by 2002:a05:701b:458c:b0:192:3b7e:ddb9 with SMTP id a92af1059eb24-1993499dc7fmr4508047c88.13.1792894741245;
        Sat, 24 Oct 2026 19:19:01 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:19:00 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v7 07/15] zram: lz4hc: pre-initialize dictionary stream in setup_params
Date: Sun, 25 Oct 2026 11:18:23 +0900
Message-ID: <20261025021839.1542805-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
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

Pre-initialize the dictionary stream once in lz4hc_setup_params(), store
it in params->drv_data, and memcpy() it into the per-CPU stream before
LZ4_compress_HC_continue(), matching backend_lz4.  This avoids resetting
and hashing the dictionary on every page compression.

This also rejects dictionaries larger than 64 KB at device init time
(matching backend_lz4), instead of failing every page compression with
-EINVAL.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4hc.c | 31 +++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 5c009835a684..f3656c27af21 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -18,10 +18,20 @@ struct lz4hc_ctx {
 
 static void lz4hc_release_params(struct zcomp_params *params)
 {
+	LZ4_streamHC_t *dict_stream = params->drv_data;
+
+	params->drv_data = NULL;
+	if (!dict_stream)
+		return;
+
+	vfree(dict_stream);
 }
 
 static int lz4hc_setup_params(struct zcomp_params *params)
 {
+	LZ4_streamHC_t *dict_stream;
+	int ret;
+
 	if (params->level == ZCOMP_PARAM_NOT_SET) {
 		params->level = LZ4HC_DEFAULT_CLEVEL;
 	} else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
@@ -35,6 +45,21 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 		return -EINVAL;
 	}
 
+	if (!params->dict || !params->dict_sz)
+		return 0;
+
+	dict_stream = vzalloc(sizeof(*dict_stream));
+	if (!dict_stream)
+		return -ENOMEM;
+
+	LZ4_resetStreamHC(dict_stream, params->level);
+	ret = LZ4_loadDictHC(dict_stream, params->dict, params->dict_sz);
+	if (ret != params->dict_sz) {
+		vfree(dict_stream);
+		return -EINVAL;
+	}
+	params->drv_data = dict_stream;
+
 	return 0;
 }
 
@@ -93,11 +118,7 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 				      zctx->mem);
 	} else {
 		/* Cstrm needs to be reset */
-		LZ4_resetStreamHC(zctx->cstrm, params->level);
-		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
-				     params->dict_sz);
-		if (ret != params->dict_sz)
-			return -EINVAL;
+		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
 		ret = LZ4_compress_HC_continue(zctx->cstrm, req->src, req->dst,
 					       req->src_len, req->dst_len);
 	}
-- 
2.56.0.257.gf7497c7d27-goog


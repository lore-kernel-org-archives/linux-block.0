Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894740;
	b=GaeVKBk6vmv8RwDsmuQBuslbj34xdYPDuv3OtJ/ii04m6zVy8gr+/QG/nqKupVLOe7Cr
	 eRwY1opULy7G7fTFjppozFXFEhPBsXOF3XFeb4+tuytM/oTqiJcuMEcF9/qtyi5XjxTks
	 UB8i5rehxNCFeP+v775gH+3QnMxmDB8fXlXBX21Zb9JsDU0ifzTpBPuAG3Gg8pW7sPklQ
	 CBNOWlmVwsa5ObnKYcYxHPKGM9vy+DX1nrQdTNRE4PmWIfGiuhkx361gcTXvuoW9nc7Eq
	 rq3ONhGclqutg5Fmu7U4C7a3zJ+xEbbUU8M18ehteg4rHl81lf2VCDOiWhXoZ/8eprQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m/5b7j8QNKagV6FrH9MtDrAVHWRcPhsXwfAR70xb0Ug=;
	b=MxPaWtT2+XObF/k6JQ6Xit0mURJ/hw6YV+O0Fn78PTasZk6DCEj0vX2tiZXftc7Uyqf9
	 XvCwQiSCzai+aAzVd2soYEVVVt2jO8LxtRm5jvHc0s7fZT+OIMElUXLUEV6utpV0S9Jj0
	 dhEEgO7tZNq5/5T2nLfDxLZiDN4Jf58oXtItJBboH5VPFHnnfD0kKj9h0b8S5exIjjWz6
	 z6De3O5bqnVYYnNx1esOgqlAtFc5EAd9lkEpngGgbxMGgAzjVXuNaCI5jHAmlSdxLGQ+B
	 nrZZurayuhiomK6LqbFz+GShdzwN1KnF20mi0ApFPCyOSMAVw3Ovwf4etQ2Zm4q25eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mEaEtWj1;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D5606A323
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E00D5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mEaEtWj1
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35c76e9614aso3169504eec.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894739; x=1793499539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/5b7j8QNKagV6FrH9MtDrAVHWRcPhsXwfAR70xb0Ug=;
        b=mEaEtWj1OFaHbLGuSLDOWsJZilE11kSLTXklpDVe9Nq/k5sRlT+ra3XSCqIX3jSnRt
         V1BaNi/mcsF+VaKi2bRK0Oyy8Sger5f5DR3cORrxrTmOi7srOxQZCy8KxfD3oiwPMBF1
         iqgcnbvVx2TtfrPMtc10d2NtZMnvRrW3ebggk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894739; x=1793499539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/5b7j8QNKagV6FrH9MtDrAVHWRcPhsXwfAR70xb0Ug=;
        b=x0YgkEWheVJQMRFmcFPy6nfs2suwMcbv5HTSdPZKPyZXpGKlX5Os16Iuif4PiT0Yd+
         69ztwHD+mK6ixTtbQ7ZfifG25MTrcnY6kX1byXBv1bS4fp64npm46Mdc90OtHfzaQ2fk
         qhfPKatxClV1WnjJELj8EOnZ90eig/BnOTbQbMd3PCOZOcapbJpaFJVJQ7OhnhC/zAhC
         z95i1195eysSayNYsNpB3Xj0WPhY72+DGcDOwVwg6Di7hhc+LjsVsIzbOm63S/INek5d
         APHNnwtRuoQZoB85K2TAgbPPE6HOM/SRkqnm8xs+hmX9mc4guVST3Nu6K4SCIKuwrBsN
         kEaA==
X-Forwarded-Encrypted: i=1; AKwUvBxMaSn1i8+nemYz9b6v6X00/woxnDnye1TjgcdEOxDQu+lSkpN68q2byN/vYJdnRSQXOfpKeQSVDH3orA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJczIzq6pxqSRK4YNBjijWKFhSlVSafdmj19guoRciuK41vB57W
	u7tMR2biRVb3zgYil7F8f12jVVoft4MKdNnQNX5Th5eUvbqWaxbZ2nDbXp4BJL4unA==
X-Gm-Gg: AYBFou3vLVPcO4T20M9uNZ1GvTzpOS/myYAtv5FIIYMDcYBhQOKEemlICgY9WnK81i4
	tCTFQLzBLQYudbQH5RI/QEiJ2PqukK1u6eCbKj6irqYB8MWaKvyQtIXLashXPXPKYXNV/AKmp5a
	HhYOeui2Sn1OVu1Luw2bB5OaKhYOD18uZUkDciZsvUkVV7M6SGc68URaXhivnmqf8cPYGUsHh90
	JGO26GWCpoxtxJzLPu5A08xgHAEzE6Pihy3OKEgUmKeUJkG0OJ5Xj54AZP+ujnHQsgvrTeDSBmg
	Sjzb4iGAM592KsYezKeqBiSoZIiyUChjLP5Eb77D7ZeEkyBRJgzCR4Cy36XpLT4W4zxP2wqZ5bE
	8SJh3HsiYh2aTA3AuC2Aa6hj7EwwBB/QsFjsoGBGabXp1wxHGZy0vhIfep4hIMaAX1uVPssULMG
	sAsDVsxxZ2oRSYdH/3LaDK9bxwkqCTYX7TLgLhyU3znWVfi0XW/gqMJ9u9n2BV1M0Ba0K+lbkeQ
	C6Wg1t7e6yHjwqsqSw4oOK5v0ydBUPbIhWxw5PCWFzqt3w+znU/WKD1dNH4+YPPQ0IlWsjELgUK
	s0F8VOGPDryKn+iLAHhdABCC0xMn/BK4f62XBjXEFEAO
X-Received: by 2002:a05:7022:fa02:b0:166:37d2:3b72 with SMTP id a92af1059eb24-1993686f496mr5842218c88.27.1792894738959;
        Sat, 24 Oct 2026 19:18:58 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:18:58 -0700 (PDT)
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
Subject: [PATCH v7 06/15] zram: zstd: do not allocate empty C/D-dictionaries
Date: Sun, 25 Oct 2026 11:18:22 +0900
Message-ID: <20261025021839.1542805-7-senozhatsky@chromium.org>
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

Do not zstd_create_cdict_byreference() / zstd_create_ddict_byreference()
C/D dictionaries when no dictionary was provided in the first place,
because zstd still allocates internal memory for such calls (~96 KB at
default level 3, and ~160 KB at levels 9+ on x86_64).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 127976b5455b..b367049f131d 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -76,6 +76,9 @@ static int zstd_setup_params(struct zcomp_params *params)
 	prm = zstd_get_cparams(params->level, PAGE_SIZE,
 			       params->dict_sz);
 
+	if (!params->dict || !params->dict_sz)
+		return 0;
+
 	zp->cdict = zstd_create_cdict_byreference(params->dict,
 						  params->dict_sz,
 						  prm,
-- 
2.56.0.257.gf7497c7d27-goog


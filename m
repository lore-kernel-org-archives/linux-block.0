Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550576;
	b=FoTDqDI7jrpAzQ+KLcQ9Vw3MYATrL+coY5CUGfHcm/1mWp54kC1mhkSC7mR4itMOj5HV
	 9es0mW4xYfih6ZmP8eBpCb0AVZlRtD5dnKbqd6MWcwEOozpqrsdCNQHhDKoPj+Vce3JaB
	 FU5bC8ZY5P4ZAMfSe9GXNIb/9esNzgYcKv0Ol51O86SbxtwBpjUikXHGJI89WTrzEL9fg
	 748VMH/u2Cmi8DCFfgYPp8JluVaSTZ+P7ODhINt3QDe/D7BkzYwIbxxFRm09dx92c+hRJ
	 ftVbGhjkKRsNZjyg3H+G2Nl6k/+aeLLcW4FAm1xxsmdPTLHS20XCEfvyDf8EdQrfbbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NSNm3PGjiMFoOsDzDjaZU4Z4GyR4rNUbLgx0Nkj+0wk=;
	b=OKHuMuSqdf9c+6euHkegboe5QttW4ArzHkdKthn7opNEfCs0BtT4RItqZYWYH0ke1uAi
	 BpesvV6wbeAyoy0N8RbSZyAB/WO5yKr7k//OycRqw37PGND2Yu030BDXY/YYAvHIs6b5J
	 dIUGQEcbFSl1rahJfIz8Je2HkT4GvepAMXJujbg/sAESKZJD0aWS6eO9gkSHjSI+EkKzL
	 mJNwRYyEhI+hR2EHRo72X5Cpx1L6/qqpMtIeQtSsPFY03P0mFaefHFUr7W8mF5OyQUONA
	 wEMQNieBdBckASiIdOjJb7+tQe3pwXvVPcATc1DKOv/hx7BoPy0CqTpFgx+tt8Fq8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=e9rUmx9b;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05F606A320
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C05F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=e9rUmx9b
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36681e85e87so424458eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550575; x=1793155375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSNm3PGjiMFoOsDzDjaZU4Z4GyR4rNUbLgx0Nkj+0wk=;
        b=e9rUmx9bzG9+1j7EgduvYDIR8a0RyPKrm5gYNFkpkTOx9q7kVV7E6W/zfEM+cEjijD
         yJFOOuNRokkPKizTmwgUwXT1skOYgb/35iZfT50YewjGwaD/K3TmSHI6F8pUQcP2tvuN
         FQ5NDbljFpY1A29xEpnd5ua2h7qLX0RpaLjec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550575; x=1793155375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSNm3PGjiMFoOsDzDjaZU4Z4GyR4rNUbLgx0Nkj+0wk=;
        b=S75NCkrVgz1CZnJMRs9QDbUS7eeN0atjyphH2X7nCePLMC3LyzgK6GHtX5Di2PFBFY
         yp8zxprllc+SbvasugIfHmSfbbmk8Yb0+Iy6LRuGCMERZb9P9D5BpZwAuHLLWvRDMcsQ
         JF4SXO+WYUv1Lc7bJuYze3bQRHE93qALk188dPds/5AkkJrKEb2rL9lG7QGJLFL1UGk1
         nhFpKAsgoJASvsNxdQzMPtu45xGUtOZEf61KKRZdx2YYLNdzWCY51vUrIUgjNbbZwk6V
         CRuiIeyZ/ZgOseFEjX+fVVM21RZZHDfwyETaW+xKl4McWCgKF04cH4J1avBdg+qSWnOU
         FYfA==
X-Forwarded-Encrypted: i=1; AKwUvBwyHAXH2Mwy9luw0mjLuZNzJgv+x41e0oqRJ/6LLtONYz3qRibyhdI7MfnqegsIM1JtuPQHTjWWfX+Mtg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJrI4rw8y78s05vEcwRRfHwXwRJrYM6naVk/FHe2SddcTH10KGA
	6djyk2N+R4f9haw6DVhiWgdpaazja7VATv/qGFFZhLRz6Qss8PT42tecYF67DM1aEQ==
X-Gm-Gg: AYBFou3G1mihCutpVypk3ewRLbC6EGBKWcWYKPL/mNGVJV3f9ABRTRj2jeivCbzqqnX
	dLP3iwvgZ3R+AOz11CgIdol0hZe2mwfa0BQmAiuG64nAn1Lej1dtU66fAQwGJEHDOBwduOPI5Jj
	KNcHGdaaRgGLYFBd53VJ7131Cps8AEOhR12MO2Zgace67HLNCxUbP45xh65zlzMgqaTtq9gPQqt
	hzoE6joWnCHKXuGMRSIywd+V8jR+Ef0z6K+QSRrdu12Q2f9Y70GdUnXubb3xyNrV4ppnFeX0XJF
	YP2FIe8vBp2MK3CLLNgSicJ8tTiVUQZmAGgSrIq+VP9lT0BRiBgCxbSpbb4zce6Cm5FjxjODXR3
	Seh8vRUNhmZyirCnzsTn/r1S+5+1C9FqmMW+bY3vLC+v94CjYvsZwK7yXWECmVLF3O8nvQvctwb
	AsypGhjvjWvPYcybrdtzWx6qJC54q4CNrTSK98Oy4a4vobZZs8olWIBvNW5h+8sduiebWKZeljG
	K3FlNefosSQSnzsfnJRVyX3nu++3EyQp1Q2Pg12AxtrKHf5QfzKShg7pdIsksRzNY8Ahtx2aZYF
	oq6rccezl9F7ur3uFRfjTz39uxKUzgnxucRm6V/h/1BX
X-Received: by 2002:a05:701b:428e:20b0:18c:ad6d:b790 with SMTP id a92af1059eb24-190a81e3c24mr914391c88.45.1792550575181;
        Tue, 20 Oct 2026 19:42:55 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:42:54 -0700 (PDT)
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
Subject: [PATCH v6 04/13] zram: zstd: do not allocate empty C/D-dictionaries
Date: Wed, 21 Oct 2026 11:42:14 +0900
Message-ID: <20261021024236.1787884-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021024236.1787884-1-senozhatsky@chromium.org>
References: <20261021024236.1787884-1-senozhatsky@chromium.org>
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
2.56.0.212.g129ede20d9-goog


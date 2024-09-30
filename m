Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C68191F73;
	Mon, 30 Sep 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695894; cv=none; b=XTzLTC1tQbs/vNVaf8QMRF5muPeEUjs2HVh+e191dQdL6qGZeBfNiSEpjm+jVhSjCVKNWiLNa+igvz1xLC6KVW1mEtzvC+4g6gLJQ3FB/isNGYBva8VZ9apletp6nDnf3P/EEnzUpCI/xfscsXK+wLZoai2vUpMeD/QEiB5ijsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695894; c=relaxed/simple;
	bh=Fdg5b8SVAH5j0Qu176AA7my/fJNS0PCGFYU3JPPLVLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbarnkSuatvcZo0nB4/OS72KoSkn7iIY09egXiglmheUAC85F8o+UuFimivfPP4VvFtBWHfp0EGbGFtxEvKvbhTDMmRdSnIgXCdQKtHD98Tz6a4kGU1SKr/hq2jVrPqrvmGN1hB92dPIpQZELMTTjok3GNkyoxbehKXLH6+NCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8tTLz2d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8tTLz2d"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e758093so33658345e9.1;
        Mon, 30 Sep 2024 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695891; x=1728300691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdWET63vJ0wHHaPGfNh/Rl/SDLzGR4oHq+JYF3SYx8c=;
        b=R8tTLz2d3pRXzh16tJIYid+/XQKfJh5JxPGGHBufur/xOYw7BvdxKThkvqHKDmyd5T
         cBSlThWyNKC2uq/UA6skcEuVYEuc952QVMvNppNqiq4pmoNIEtU6b1/w/9JMrYSBzi6R
         eN/PbXnq05SrNq0S7m2N7rkf9VBe2KBoWVYSQlIdo+YpqMPvKG4WlnHh6u0F70L4kOAk
         UnZDLI7bYCPyF7aNS+7+XIya1dPVA0jo8kSnKzYcuytBfmHeDmWq/LdyG/Db2c3yhPnX
         BCKb6Lx7hUzqoo1Wa+WueA7y3tmi64mbUsaFL80EKcou2Kl+H6fn1w9F+yo1P1FC95Wh
         2R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695891; x=1728300691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdWET63vJ0wHHaPGfNh/Rl/SDLzGR4oHq+JYF3SYx8c=;
        b=U00kNU2S7I1NZbWjZ+ptBLPMDxmDhiPN4RbwCfub1pX9ttIe3BahCiw3ofDQQKnCyr
         1nIHrxoMwNgiAbpTUgDXGd35vyUH0AMPk76bYED+HsSVKbrakxNphWPZg71RstT9NM6K
         ceuT8baIdUTjrRrS8yKXs+aLiPAEPARo94/MS2bRP8B5kM3sHeDuenPQxxiDWWprwAGk
         CRINEdsX1U9vNiflgB/zT8/NRg81VdneHO5nbbPjSJ6wPM0PMhbu1G0skKI1AMk6MV5u
         J/z3qc8FtxrgcTv1rLxJ6WF86kHkRJqTY0XZ/S8JQF/dY/F/HD4ZZXl5VflNXXpJ/oWO
         pjrg==
X-Forwarded-Encrypted: i=1; AJvYcCUasyVdqDZsC08/n+vszvPAkBI7JfSQ/mqBlD8+IcWablZvLfkfAP2z7nPxXIYud0i5g/W/OE+puqLu@vger.kernel.org, AJvYcCUiFOQV3skpAVix7PmqaAdRBD/mTQdHayF2sJU+fjxguwhPNsECDeZadH+Kp1EH5Q2TOjU7QH7FLpPAxf0U@vger.kernel.org, AJvYcCVUsLLVWh6Nrd6IBzh3s8dkMJAPacjr5KR+F6QI7elTryE2CXkbCuT0DmK4RZX7BURykxnjQ1uhQ/wr@vger.kernel.org, AJvYcCVy+M0dtXpo5qznltnMwaeO3md9s5qA5ySPwjqjgSNUhQ7Y2HL4ISNMe6IUZWP5K2RMDY6bVrwVC1WnxXY=@vger.kernel.org, AJvYcCWKtPJiTIVN2uxqnUCmEq8UUhSK5Yi+MSa+G/etXOgkBQNP0DxbWCc/Ng8tqRaGzQdiadoPGT4VmSeNMJlwVUVl@vger.kernel.org, AJvYcCWUT8j/uBGa5k5yBCrR6AqlffBrghg8zO2RpNPoVRARZUm6/zarD0Y6URTNVyN7btNWUPWX22WVaV7u@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLhVWknp0BfyqFWhPDqhCdMOPFxGiCYRpkLt9idXRGtA6zTDN
	lXTOJ+v++lo3SoyoMuVoQKNNQXgndDd9Qjk10LOiLKYVeLblLBFM
X-Google-Smtp-Source: AGHT+IG+FX7wQbiPTrV+FZ9bKUhqJKnd538V9esFrVT+ydwCqe9J1R6Rzi20PJszdP50SknlXHumOw==
X-Received: by 2002:a05:600c:1d25:b0:42c:bde5:9082 with SMTP id 5b1f17b1804b1-42f584481cfmr82686035e9.17.1727695891212;
        Mon, 30 Sep 2024 04:31:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm8889363f8f.96.2024.09.30.04.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:31:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 3/5] string: add strends() helper to check if a string ends with a suffix
Date: Mon, 30 Sep 2024 13:30:10 +0200
Message-ID: <20240930113045.28616-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930113045.28616-1-ansuelsmth@gmail.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add strends() helper to check if a string ends with a suffix. The
unreadable strends is chosen to keep consistency with the parallel
strstarts helper used to check if a string starts with a prefix.

To prevent out-of-bounds read, len of string is checked against the
prefix length before comparing the 2 string at the offset.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/string.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 0dd27afcfaf7..2c3df6ffb326 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -353,6 +353,19 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
+/**
+ * strends - does @str end with @suffix?
+ * @str: string to examine
+ * @suffix: suffix to look for.
+ */
+static inline bool strends(const char *str, const char *suffix)
+{
+	size_t n = strlen(str);
+	size_t m = strlen(suffix);
+
+	return n >= m && !memcmp(str + n - m, suffix, m);
+}
+
 size_t memweight(const void *ptr, size_t bytes);
 
 /**
-- 
2.45.2


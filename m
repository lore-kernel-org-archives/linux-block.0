Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C03F7E80
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789805; cv=none; b=TS9Lp+BWVRkZYQSXVj5pKBkA5NFQQuewDTrp+cmh1HsXTDxa4S642fh0U+T8KmcRvm/bH2W5Yy5Os6itlJLyU+ZcjgQ0iAdZybc2vAWT2YkgF2ScyP3C/NuaR56CGpHVwNR4eO066Nb63d4OwhL6Hg6plDTsV/k7zvxkXR7j+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789805; c=relaxed/simple;
	bh=MamMwEHvD7VENb++o+ubuwCysRUMRUnSxlW8m9IcJtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maVK/JdKlsjBqbhxsJ5Fw3tMFwFXLR5dQ1aJ0JMmpvRGhCuLtkiMLDjv1rwf63nJsKDqjJXUd9DFJFANS5WWD9Kmv/LhXOKnduY76ST6h0yTDuldHWfHcV3msZ+XBhSR3bfiYMzqm+C9PoKP1P9Q1BFLWDixsNeEUuReGChDNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PewwBtqY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PewwBtqY"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79853c0f5b9so49819717b3.0
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789803; x=1774394603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qAb7BAjRHOKOhLG2ZwGENg8pg0OEX1p0HLdyPGydEM=;
        b=PewwBtqYLja3Gc9qhxGWsbRDgmuOKbe2bSAvUKKlmX1P2P5c2sA8hO8rUS4v+PsAaV
         Qbn0WTICYMzmYcqVj7zsKhWeOcGMa0LZkeGruVMD8ujslHfh6q1NuLJOZs4uYVTPq4rB
         Wxp63OgnrinaymSAybZbsr/Uw1v+aV3fjDRGWCJXKlkykLhWImjRSD3jA4LU9uZ4d8dS
         hnmsQlV7cpUi+VkYrlXOmnRlzuP1Mpip+cTe14ColX5u9VmjjFLBkjIotUcVtfcKsoq3
         tM3BsmuUsjFriyJjZYFEMaw3P1kBwo5sDYalE6zdFz107ey7Ixg/SdEarN/TqWxawKdH
         FIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789803; x=1774394603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qAb7BAjRHOKOhLG2ZwGENg8pg0OEX1p0HLdyPGydEM=;
        b=tOte9FP70leAEvfaSPMLGhG2qkXSDLBt2PEs/Y7Y6q6zq1VYWmwRTU6nAjjAMRyTO+
         V1nJPuqjq2PkZqrvSgLzefysRY+EJRGkVsFUys7uFNJRHM4LDN1venC7xxgtR88NnIrs
         NOHn0Wmi/41l+N/ErwtnH8MDASqRw/8iTK1gqCizre5HDSPsxvsfTqPZ4UjibX5AJciy
         cS8CPHeOgnreOBOpN0hHfoOKyhMxBWB8x7zF6+eREuhWUCci/7APeeCSGQCDN6kTBKr2
         ePlF6kC1LIVdVz1UnhRi5CejU9jWMvqCWHvrWQbyAA0W7BujIC7HNP19khxN3U3lTz6b
         WbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+c2g8H5C7K5mCsjjHHaUGuAB73Ar49TlnSRH4l4BMpDqOsSa6IV6d7ZDrzrV/oP7ZD9A3Aln1pmWeRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94pRNofaDXGq1b2wDufvSlF09DAKbvX1qJghU7t++W6cAxe0V
	SNpEHeLvF2UkOyO9hLMQHrDacAgp5Y7dftMUi2kbmYfVPErxSHEQIJau
X-Gm-Gg: ATEYQzw5YqNZQVx/KW4Aq5K5yOQZJmaT2GpFNzoDbgtMgUZVBcqZs2SUFK0UvgkTfrD
	pW4cZjITpXz4hEVKbfxgME4OUZRL9bAvr1ZOqptPzMU27sy7SH0FOULQ0zNIa4U0pstif4n1mZ0
	quTDOXywUMUjIm3+dpYAd+UpubF7R0BnBORgblF2MRaQswhBxj/n484m3OcBwN63y7pNR9Jn+Hd
	2AAsDjSQuN0ZOtRhle8UMtm8mvfbt/i5gEHWqCewUWo4xeqAkjVghINfegjtI+0+c3MqdtP2BQx
	O2PPhnoBIJZRMbE+EiqTMFgrDVwRahDqF/hoOteXZtwvu+sX2tlQahC3CFGNsb6Nio7AU05Bydp
	gtxxpoo1m99Fk5vRzyglHx18UfRYRze9QX2GaqBsj2efFF7C0I820Fi8zyHDdEiX2H0bdIagdNO
	Dw1XpjeFrQRdBBtAS4czmsOTy0ZiG9fHwuU4KGHUXHrtvKeQWtAudfbbKSZRaK3v+EBCsup1G7V
	y2syuG6p3qQfQigusMU5//1
X-Received: by 2002:a05:690c:60c4:b0:799:1c93:7adb with SMTP id 00721157ae682-79a718a5e91mr13675337b3.23.1773789803317;
        Tue, 17 Mar 2026 16:23:23 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715d221dsm6858217b3.37.2026.03.17.16.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:23:23 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 4/4] drbd: Add check for error pointer
Date: Tue, 17 Mar 2026 18:23:18 -0500
Message-ID: <20260317232318.18923-5-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function find_cfg_context_attr() can return an error pointer or NULL
in its error path.

Change NULL check to IS_ERR_OR_NULL().

Detected by Smatch:
drivers/block/drbd/drbd_nl.c:6571 drbd_adm_dump_paths() error:
'resource_filter' dereferencing possible ERR_PTR()

Fixes: 626c95b0e2a23 ("drbd: rework netlink interface for DRBD 9 multi-peer config")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c5e253820ccf..1f458eb972e9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -6566,7 +6566,7 @@ static int drbd_adm_dump_paths(struct sk_buff *skb, struct netlink_callback *cb)
 	resource = (struct drbd_resource *)cb->args[0];
 	if (!cb->args[0]) {
 		resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
-		if (resource_filter) {
+		if (!IS_ERR_OR_NULL(resource_filter)) {
 			retcode = ERR_RES_NOT_KNOWN;
 			resource = drbd_find_resource(nla_data(resource_filter));
 			if (!resource)
-- 
2.53.0


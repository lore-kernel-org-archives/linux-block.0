Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B640188CC0
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486239; cv=none; b=LKu9FwAF4djRiXmgY9Cs4+m12ADyybJi9I2mc5NPC9W4vZq6siFdi04uFrOeMPkxFppXBAeeZXbIpGuW4wRwmAq3ERPUkOMGvaaj50Dc4AZ4uTYuIldUNszmg9nvEovwLUJmdskOBogM1ztqLFQ5I7lHm3pu1Nkqv1o6h+19su8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486239; c=relaxed/simple;
	bh=aJ6ZU28ITBRd6nGxltKZi7zyMGXrls9kcFOA3CzWEDo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TvmIvKKBSNIVoKyCyyKgl8tzqyfyJMyF7kYeCVPGtvkQ88PZi/RLtjZy0CY/C/3QHIpz80gqP8tO9DGJhll1vBB4xGGsVzVeZOt5Ebm/oKVBkYuDGz5A7moKJO5Uy76HZJNCLLQiVvSLr2l/HrnRO6PsajQzm4scBPSgL/IldZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZemXAnDV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZemXAnDV"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso4547347a12.3
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723486236; x=1724091036; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7WvS4QEtGO9MaKew9zs9A+uTL9zTn85nBuVo7ut2UQ=;
        b=ZemXAnDVQVJIAhYqCw3m2XbP7psmxknz9XJk6MtUCqO4rjP1mwbSuS7130xbm7wCQv
         NiyOxb+U6VYsn0fqdFARDUThZBEoGw4079djFV5v4W7CsAID4QFvwU4rsacM33kEdvfo
         4c4kAi26MwIhgYYD9Jb5tAinbPDDv7+6BDy6GQvroWX8pwd1YKmrLZJrlVD5e46DMCoS
         nDayr6wlO+30IsqsDcyCS9iuhJl7HCwOAUMIpgQomQ3rhv7ecwl3UU1slE03cOU9VtcV
         9bUW/fIt08yZUVAQg0b6rK8Y95KTd8V0OgJdoXg8SEdogxSdHAe9TdcdPDsjuLzy6oMI
         QCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486236; x=1724091036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7WvS4QEtGO9MaKew9zs9A+uTL9zTn85nBuVo7ut2UQ=;
        b=W5Y46UyAT1qJswqHy9RdN806mLd02PeqaKpimALOTCNACI4ARrXJYHMPjMogT/Si3g
         VjeH3KlkLXcvKXx8nvCwFKDgir9tQARHJnmx07WerflvTtJTu9gbAFD9iqeI6SQrKqF8
         UAPCXEmeQ3kw5L8Sc9SJ805XZZ0TyGB8SaCXbKUtdN0ER9cA/p1AHf36KnF5UaHHMBxv
         hiSL88CivMOjhoDKJzthpPPSnLIPeMysKqmBJAjaD94WBJbdsloIjpVSk6rpTRkOMq3E
         5zF6h7gsK2x4AaWqzR63B06VI8vSwoSWGAo3/ap2PTF+KP8zGgMi4TUqpgvfeX+xcyQa
         m5yQ==
X-Gm-Message-State: AOJu0YwzmLO35K1UnisoX+l94xK9PktTaClLUkn4aNe0CUbe8fmvw7wZ
	3O0BVB/mjl7A06zNxCmpaAnB2TKmM67OpNWdgt0LWX6wJbLukgQ=
X-Google-Smtp-Source: AGHT+IFFAPAKi1tw+Q+9KoD0EvSsF2RLMzhI74sKXGD9t+NCXGFvf6KOYweWUW95+X+06korlJz3kQ==
X-Received: by 2002:a05:6402:3813:b0:58d:81ac:ea90 with SMTP id 4fb4d7f45d1cf-5bd44c7cc25mr798201a12.38.1723486235912;
        Mon, 12 Aug 2024 11:10:35 -0700 (PDT)
Received: from p183 ([46.53.254.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f3306sm2320526a12.17.2024.08.12.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:10:35 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:10:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: delete module stuff from t10-pi
Message-ID: <216ccc79-5b80-47b2-b507-990951aa810c@p183>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

It is not possible to build t10-pi.ko anymore.

This file doesn't even export functions.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/t10-pi.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -8,7 +8,6 @@
 #include <linux/blk-integrity.h>
 #include <linux/crc-t10dif.h>
 #include <linux/crc64.h>
-#include <linux/module.h>
 #include <net/checksum.h>
 #include <asm/unaligned.h>
 #include "blk.h"
@@ -472,6 +471,3 @@ void blk_integrity_complete(struct request *rq, unsigned int nr_bytes)
 	else
 		t10_pi_type1_complete(rq, nr_bytes);
 }
-
-MODULE_DESCRIPTION("T10 Protection Information module");
-MODULE_LICENSE("GPL");

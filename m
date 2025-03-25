Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3440269B1B
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941209; cv=none; b=KSrvkURYP8s4/xunhXwbtFR3GYj2SSoE+oEXkKyZEKHlNE0H0C2OrH3lMZDsDw856wNsrrQ3tppM2lQ2lGjl5s3HXvwuM5y5+galz9d4LnljOQdTB7xeWEFPcAufiUYsKzbdcdK8i4Mmg8GYVCxzBnJ2RVqxD3MuN7WvAmeXVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941209; c=relaxed/simple;
	bh=IukoZe1GMKFKCT6AG9qWXRdmFYXwpjtymU1Xp2ZmbHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9DNK+HskY0RoRSjAB1W5qoaUoKrg1GIqOH7obzQXqDyzgpuWXXBvhS4wCZ46qRjX9+wBKQMSCGJUbiG+xCK0N2THxoe3aAOR9MQzjhr4IyEwY0uCfUH98c0JY2s85gV/Z9y1tt2RiRgFaWiGpSIXOJ9G8wAg+M880yi/Wh0CmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TCE65fsy; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TCE65fsy"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso8070672a91.1
        for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941207; x=1743546007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaD1f0dkmAmr6EkfX2zgrSqJ41O3Qgw2EtPX5+qTxTA=;
        b=TCE65fsy8ydcRESp4tvrbk/aj/S4bs/oaxUdNYYNI5KaqFDGxGw2dreY20sfOYpME/
         /ukTG1Pqzu0UKz9Bv4BIpe1SkI14zLaJvYMAZ/vxT7B0z7v+cuO4T3m7aY7WzB7mBZJ5
         BBZ5oRUb/kuFYPjxM8IBBxCpiFxKJwsZ3nIKYy7oHI+X+CeVlhiqJTee+X/ygAXYTnx8
         6poILVYgWhaJfiU/c4ykr+0MWmNiHYFG+CYFt8yDMM60nEtR8z7A6Hueoj8cH0pB9rE1
         FqW6LEfNjGRXgR2ECfahd8/yrxxMTECawlQFtaoK7Z3uzLip226eBKN/fijnu0Xow603
         8oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941207; x=1743546007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaD1f0dkmAmr6EkfX2zgrSqJ41O3Qgw2EtPX5+qTxTA=;
        b=Z0DejaR1X4qpV3W1htHJTKJeC0DN/ak1uW0hdxwGtcwlVYVUkpgKoMBRWVON0yehkY
         nAymrra7Lc3CaWcHvYYHj2aM7h5UeoIfEUB0IksCaVXsqQWj2clo1tqj636IAAR9vOtL
         tYTxEfxnxdooYUmy4Kxv10LSCCkwL9RWJmLfmQOJzN0aB5WiGp7mJuX61kipD3HsVxDn
         cu3ompRhJFOgrzrnI7KiXx1DnirxLJ37YoHA9JJ0eIGOcnmxkjKBdQeQDyF68SSEeHbz
         U8wKUG/o7kA2x5svRzTAB+Bf+g2OkQKWEZjkz9NCFI8eVgpVh4XNdJdJmTzFOXtipXgI
         mg2w==
X-Gm-Message-State: AOJu0YzThCCtvtSTlKmfmKeUuhrALnRcaESED6OaWDdBIb9HGdA2Cy2Y
	t4B9GCMwS8R9CHsO49nGF8kHAWlJU5U6ZNvw0C/SKmfkK+/opfGvgdy5XXFVuGLUiNvNO4twsky
	OThxwmmWrUOlGC2AQXfAp7sePlei4/dO2
X-Gm-Gg: ASbGncs9ZkQHHK+pwMtjOOlEmgw8UxEGmDIO6MJk5a5Ryroh6qWzV0SmMoxG4yE9qzJ
	B2L3jyCu9kNlzxl/m5/6PC8RVVMaJztl4KNPt0Bl2wK5eGyA7ZVAgGzI4xOoFVSbh/8ZH2btO9P
	/r7wpB8piRRvk4KOvTc1jHeEhlt/cycaOgQeZdx1+pr6VHQNPnvqdsN/TpEc2+gk20LGBmkmw2Z
	F/4mBf1o2a/fZqc5Qm9am5tpZwxZ+JDuM+LnysTSJNkb6115qu5DN+UMwnGdUS5BYuNC0LA7qGV
	DwIoGNdM8TEDmD9zWeFPmeJuVyYGL7Rt7BDhAyNJz+NUX2DQDg==
X-Google-Smtp-Source: AGHT+IGS6Daus7qm2CJ7Yu+HWXaf3SPjvYYwo50CAFD4+MN72OYepK7+CxhHCMpyyk0kzla/ZeuQ4Em/0fZE
X-Received: by 2002:a17:90b:4c07:b0:2ff:4bac:6fbf with SMTP id 98e67ed59e1d1-3030fe56aa9mr28017596a91.7.1742941206960;
        Tue, 25 Mar 2025 15:20:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-301bf61e28fsm914628a91.14.2025.03.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 58E573404B9;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4740EE415CA; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:32 -0600
Subject: [PATCH 2/4] selftests: ublk: kublk: fix an error log line
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-2-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When doing io_uring operations using liburing, errno is not used to
indicate errors, so the %m format specifier does not provide any
relevant information for failed io_uring commands. Fix a log line
emitted on get_params failure to translate the error code returned in
the cqe->res field instead.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index b17eee643b2dbfd59903b61718afcbc21da91d97..ded1b93e7913011499ae5dae7b40f0e425982ee4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -215,7 +215,7 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 
 	ret = ublk_ctrl_get_params(dev, &p);
 	if (ret < 0) {
-		ublk_err("failed to get params %m\n");
+		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
 		return;
 	}
 

-- 
2.34.1


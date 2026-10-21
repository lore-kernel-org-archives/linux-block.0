Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550570;
	b=x6qdvLpx8LwACHlVp3WzroFrrwjuCm6oj/qKXwqNl/6r+lFKrV17BD7AZwN15FEoACm2
	 +VSLOL1R9scdN5+7+Kbk7vB4i1wP6sWVDfeECPBiO4Ls9jsBJcbFOgxzCcqbaVdXjkfyu
	 sMjj8RixlwDLK4ll+/qppvzv/gGQH/YGwtb3Ov0cM/QxGLU5MAVBdS5GlTDalcYc9d2wq
	 NRJCGOwoiM/NKD2DmNU4iWEWqFfq/6AH/4x9ka0q6ndua5PdakGqpxSwkemGYzpxQLy8h
	 6jaKW+7DVHtNYmydv85tiTMZKLcZig6PtZaucfNzg9WJfE0XP+iJPl2w4/CLxuG8Riw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GdNakqdic+EhTnNZGwTPeLsVaa0lc3BNOTpG5XYOw+g=;
	b=g8hLtXmEv3nhkelr6s4kmvGupwcBwQgdazYn38GBlhDFw83XJnyA9n2Q0QFfhCgEafXl
	 i6RUMT5WULdZ/d11LgiZRozdTxZRV50FrVC6pV9ZnPE5uwr7VN9fkmFjRzTD2phMHPIyp
	 cw3TVRURnW0dfeaJniBSzqxYVDABj4iPx0VN+EZ1K5HP+MCpWpAAIwIXT9VZ5N1OHoplH
	 2bZn3Km1XDbaLVLUbzs9IPBzn3UXVxllULikMB+qbS67wmYL0SWMJlOeDO5hCbNPvAMZR
	 yOkxdUGIsIYImfYJdUkFRMTc/p+qHJcZOkKcz228qRex1U2NYZyjFKSaR80kOUBTxKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ERXfoy9r;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EE606A323
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814EE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ERXfoy9r
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-18cdcfc05ffso210963c88.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550570; x=1793155370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdNakqdic+EhTnNZGwTPeLsVaa0lc3BNOTpG5XYOw+g=;
        b=ERXfoy9rntp4QITYu3f2H29ATGBVvi1dBQsjhAyJqBaGgW29SWOkIpowLin+YE1mO+
         Lnf2Blat2rCBrLoMWCvQ0pBBRnenVj8FdJfwykNR85Z5s59qKxTNO0LiSrTFpoKyfWIW
         jve8xFSpbRknDcdC/CRqdbLknPwsF1wM3iGY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550570; x=1793155370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdNakqdic+EhTnNZGwTPeLsVaa0lc3BNOTpG5XYOw+g=;
        b=LTIRsyzv46Axzeui6is4KW3neHHAQixes4j+/bCVB8QK3IXLo7J/Kph5mR9FK28+r9
         i4zRZS7NRUIfzcfvKmc0uhO8r+Mgl12Pl01MX+fE5diCjj7pEdRSj8N9Fd1QaevfGQui
         0YGn5rqjatmE4IjIqz3zLKepMzS3HVg70IJRZsgWJBfS5n5x13Ck0ftJ8++2mcb3q7lx
         dLHNfYK1K5bEc9/aDYKfgQ489/zGypZET4mtfcG7qIN8kBIjcvnfLbiQOjUo3ArDwNsr
         CbhTHV5UcCEMzgjh3yyHAyppekqiF25iEw46UwkVrT5X7gK/765gnDl/IoSoUO8n/AiZ
         QbIg==
X-Forwarded-Encrypted: i=1; AKwUvBzeDh8aeMXDLFde9AEjVZtbp0vRNyaR5gET0JYhj6JWeGjtm6cOTHpF/Qq5FRtoVVKfIoeTjf7wOk6xYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKNdg2hxK14vj82xP5MSHkOF58r280vV/dGcZXUCabHtgEUdBQB
	4s1VYkR1m/Kdw0BMQ/bU35PNt1tKHD2Npqg0hSvbveAk4qF2hMW+V56IHN7x2mYH7w==
X-Gm-Gg: AYBFou2ZGDglCgDBMJO6o0t1nGCzMGA762MGMtH8C1xtEZnQLmDehyPt97g/9JLQqSp
	7FaZPl4X0L5b/2M9yFVcG6+Ki5NMiYnZjs2hCsKDOFZv8jsgjC9HCxw5S3yOc5jzfN9EmIGtH12
	M37QtbJ5EDPdgrx3zY3jbYttbDFrNFDQiA8KD5/x/6a6xDtn3XLbO/EMSOKrd2BrWDzfqN/mlKA
	/ImLe7MC62yzkh7kUIetkTTIVAfOxPhstKB5SPxnr2U6jArk3jaJ6u5qQ8Awuu4R7Ej8uuieXsj
	5vrTB+t9ZVkJHyEMiyuHWQWE4cUVpPqwz9qTErfkBOPfXaxr41tLX87sGqphN9k6X+qrPp9Q2Re
	TWJUMIwAfEKwOwU09Kdkk0TOm5EvzY3xvID4CooWseFW+WbPkPM+ydbcR7rvIsXYKNx/sLIqf2i
	NpbpiEsI+csp2IQH6qWpiXYibqYxUg8zokXS6ndmjBWXxBOjHseGvqpRfD29sUy2AKsTTOsKHMt
	QQB+Hm/DQXrjRcHFssHQL+ceVk8+up8yAhOvIqarDF3IJakUFMrcQSRB/Jud+wvjrY3wR1Jl5j+
	5nXdqvOATQU+AKbsCGHYLb9AFJxDL5GGJ9nyh6Nyp4Oz
X-Received: by 2002:a05:7022:f512:b0:187:efba:9ba2 with SMTP id a92af1059eb24-190a84c55a9mr745932c88.44.1792550569542;
        Tue, 20 Oct 2026 19:42:49 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:42:49 -0700 (PDT)
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
Subject: [PATCH v6 02/13] zram: remove debugfs entry on init failure
Date: Wed, 21 Oct 2026 11:42:12 +0900
Message-ID: <20261021024236.1787884-3-senozhatsky@chromium.org>
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

Do not leak the debugfs entry when zram_init() fails to register
the block device.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ab064c84b092..593fa4ae47c4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -3297,6 +3297,7 @@ static int __init zram_init(void)
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
 		class_unregister(&zram_control_class);
+		zram_debugfs_destroy();
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
 		return -EBUSY;
 	}
-- 
2.56.0.212.g129ede20d9-goog


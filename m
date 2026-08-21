Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808E392C28
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297045; cv=none; b=kAYLdvPWhadx3HfYaUKc0mABzZ1KkeEJsrXV1ArtMlTi26l5YstpUuEPXkuiZcksokvMcu1THxOB76LrL19+YUEE2viBUp3ojeP6zEQGMCBpB0m91n99lfK9AOisYpIorGx/rt5inqLH+OKQKTdbT/yjbYKEoei2+l3hexvT/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297045; c=relaxed/simple;
	bh=6aTwQdRfTlZr6KPYAsI1pZcxvvIIVjR7PqzfXOD8IOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcpcbgBF6UDCiiIkkpTn76CgIb8JYoQWIe3VM74O44ug3r2wLX1VKJDI0aO+gYz3srupVoihAjc5gjyZXm4aUjzWArIda5w2n/pkB++zxyEUqcvU5CrSLCdN+d2NgtQkVy913dGAoNhjLLfVmru1FT1LVK8S0wzKUifqo+5qlnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AliSbaUy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AliSbaUy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso486397a91.1
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787297042; x=1787901842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/dT/kH2RMkdhW0wPnYVez698rdnGbsfuneIzdJ0ufp4=;
        b=AliSbaUyJGjVUsqA9+Xzc6izr86lWxUpkqdmQzUKgEmrYlOn5TCflQeaGnSFlIddk6
         ya8dpZis/OU3L3YgpxCx49Aor6yxLIAUOHgD7bJRvK2czGtTKTiJJxc7dlPry99uCfwT
         iwwVXcniZJl6zTUFQXysEesK8OzphZjqRyqxx745jYrT2kvW6GH+4vsMGk/LFh1zeURp
         Av+dK3BqL9T//9KttZvl/2vSH5LA9RA7u5c6I02sDAC0tYIDPPm0vEBhaeyw3iGvq1X1
         XE070hn6IP1bpmUPOBTc1wkIdAONuyebl7WYkhL/1tOCDxl0cbp1AI8eXwKywLfSkUM8
         W3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787297042; x=1787901842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dT/kH2RMkdhW0wPnYVez698rdnGbsfuneIzdJ0ufp4=;
        b=nSTBE+BKs+gUojemTyto5qCaXg5pysp0RxDIIZ3zSQsQkcmIRq+zB+v+M32anG7pew
         f6GnbizGIB+XUx7FrZo8rlMTAEpXLw2SNjEwEOETLYEXOGLG2RRCeH4foTZCiiQiBMj4
         sIobA/XJMAypEF7VJgWtx9rOFTHyjabKoKthAh52VYk+2E3FccDhC1PwfMACvJO/nIYO
         VQlndt380iw5jD3Zo9aZ3H2lk026kMl9m3b9tGzMCGB0qVbuyWdBYsZaDChRBkhGMjlT
         2UBMTWh0v8U10PBBGmGZfxiBgDmT7f8zJlNY8z71xGVpUQq2ZNu2C3o4RLIhfEN24525
         JgXA==
X-Forwarded-Encrypted: i=1; AHgh+RqdnXl0br2l3xWb9Ffzn0PVxSU4FiS02HqmRbet81OaxXd0fetUOMLTJm6cdNTYUYq+yWmtJSepIPBVWg==@vger.kernel.org
X-Gm-Message-State: AFuF++mStXZZ31KvaHmQzXjC2CemSlv9GZfvQjHs7NQZJq5TCSFMP+D2
	RqgU+A0jkL24KDxArpaBxJGb2GSY2E8dAegL+s3dbjuAwiQmjkSxSvbT
X-Gm-Gg: AR+sD12Z6iVh+6uM2VyGF+qtKZW2DYP2mHLkSh4E0ZZKfvdect4gp+1lD1/w7kMhfoc
	K9QgoDZ3mVHd1K/sUAJ/yzct08+xFoQ296bLDEHxgblLUpyEPEqhtBjMG1YwIL1kr6BSIcd0Io6
	n8fV6hYwHWuWg/QPH185LWGE1+Kn2mxpmraVOY3Nf40JpQD9Jxy/qQIK1xDZgAVm6k8fItwCeX1
	FXWEmMhCB1sTFLm2aDPSVVfJIYhsxy4wtvguQk1g8A3ALnqHPexKqGeRozY0HwlYyhDiUkMUWdn
	mYmxTkTqsIn1gwqKU6UewtPsl9H0a1iHDwBnD/byaTtalKbNM4Ddk0QvAeS5645iE9CoIk3UkJN
	2fJ0N+Ot1b+q40KqXsnz7eAV1LxLIUufpH/XhOHK5gO5LgiXS4kipzw9OHPIW89+m/fcira3bD+
	c+sGoxiRSBYE9JAilLeu8Qyr/22CF9mSn0kjyXKz75ZGFu7VV531NoUszR6UYrEZZwGl0PxomX
X-Received: by 2002:a17:90b:1b0b:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-395c35ac458mr7309206a91.6.1787297042374;
        Fri, 21 Aug 2026 00:24:02 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c467d907sm2025485a91.7.2026.08.21.00.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:24:01 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: [PATCH 1/2] block: partitions: efi: report the right relation for last_usable_lba
Date: Fri, 21 Aug 2026 15:23:54 +0800
Message-ID: <20260821072355.2006771-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

The check rejects a header whose last_usable_lba is below its
first_usable_lba, but the message prints the two with ">" between them,
carried over from the preceding test against lastlba.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 9865d59093fa..76994d3edd1a 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -406,7 +406,7 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 		goto fail;
 	}
 	if (le64_to_cpu((*gpt)->last_usable_lba) < le64_to_cpu((*gpt)->first_usable_lba)) {
-		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
+		pr_debug("GPT: last_usable_lba incorrect: %lld < %lld\n",
 			 (unsigned long long)le64_to_cpu((*gpt)->last_usable_lba),
 			 (unsigned long long)le64_to_cpu((*gpt)->first_usable_lba));
 		goto fail;
-- 
2.43.0


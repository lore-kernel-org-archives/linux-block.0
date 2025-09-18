Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB02D9789
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224057; cv=none; b=T35NTQvxkbCS7WjzS9VK5EO6C0PzddHhTd9Xc3uR68ka86+/gkDuAtBfAA9A98OYy3z0Fnhu63daYPWjlE/2ls3Zx2oyBVptYIc7YoTDq7obqL7t+C4Jfh//7iWbpxvDbqwOHBmCbI570VmzYohwqW3d/UtdRW7dudB8nXcjres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224057; c=relaxed/simple;
	bh=Y9/Ne8zaqdwA/LXEG0LconEi+zVGsXicyRVHEDgancw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Og3LKZLvQoODKbvWUMmrk64Uxeb6ktnMVPV+78xCloP6CxQLf+iNri4tsiG16ZoMfR6YbAxGPgZCuVpDvtZDnkSnPFLV4L/trsd4oMKi/VvRmv2RkLqliRPkKkhXyF6fnMwb0955R9oSlj7edJSYlhh5r/8YuSRwTUE8neqOZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UKq2ug09; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UKq2ug09"
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-ea5c1e394a8so1039026276.1
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758224053; x=1758828853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUwZ0WSYzRWLsV37Zv2zW5RoOF8gsqcC5qtG3FfYLLc=;
        b=UKq2ug09nECDKJ8qP52M5tEonD4ouB9EMtR+X7SlGgf8Q5ifu431/jNdxo/guiTZiL
         e6rcrF9vVt36B1VXSVd99J27eJpitA2CIRozfsKJfFd4dxujbtidpWvFNa27ls1jA+Rs
         63fZcd0W9kBh0DeAnKh7bvJ0i+PnBaid3V4aE2cotImXwL7AcsTG4PmF6pVBwa/tUNDy
         pAiduAQec/w+HLMGpfIj6Fyiqbjq6FuJMmHmhm1moADeopI51gClaamKT6dlwg62Bxn0
         3CwM3JLsWKmakrQn8vhJ3xRelgw+5vBpTrJl5cGOX9e1O9ZI5tGecMLTW89dS2ipHn+6
         /y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224053; x=1758828853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUwZ0WSYzRWLsV37Zv2zW5RoOF8gsqcC5qtG3FfYLLc=;
        b=cEJQeh6mF8z8AMfmJVqyFQ3qs90QZxYnMShHgS1Ggz37N2Bya1AM3jyN4smLaqnN+Z
         wjiudHk15p4yGRr4hQzzw6+xjm5GgHXP4EJGg13JeHFlS+hyhjS/A44r/gl2tb/53bHy
         UubAGYvsnrXNOwDz4Dz0DyFR9f1HQbLyNg7Rqb25Li5U2u39WtTuSia8G/0wAuzqvuS9
         jEpmJvjk8G/Yxgm9swDeJSvTNA0hrTMnRupvDhbUv21GjD7g+DqyRurc5YJkg/Q7d5ER
         /m7VR/K8pDOkJmu98MyPNIKBQxKmd4IVwjN4siTEbf1c+OTHDhI6099FUH+NcmRLn3kQ
         XMvQ==
X-Gm-Message-State: AOJu0YwP7jc9GmK1e1aE1Xam9bnjSDwLgwKBw1MNckaCgEcvLnTed6eh
	TGQQ85dkJTDYop7DI7T05iq+vXlHVfHUpRShkAOuuayYn8Vhk6jUtAuDwxrP2ukvb5I1J2fxmMy
	TBt077zWp3sVmlnc5vKZtYb90OeOaGyC06WkR
X-Gm-Gg: ASbGncsyK8sSO8RNq41IxC0wkbsv9ovbHzSOdyPxFVs4D9lndOil15GQWn5zJbJ8tQQ
	Kuo8QECgPgDxfy7a2XiOUFncz0I0yZrigBLMAz7JBBzm8rdmme9W/Q0Ak6rWOwA4groVPzSCm3K
	M+2vPWlizMpu/fgVj0UibS2Dp3nbV+9c+WFYuW5xDlo7oGFbuwey0GhoiPEIbkiRbW7q0A8zlCa
	m1IBu5JVAMa94xK+bCbnOToRwfk8nHYbyp2wR0sexbJ9qwjl8eykX2C4PjGUEhhCVwY+ndCIqJK
	p8OunFj/7qmbOXlo2dCAj8gCMRQ38Pocv0/EUB5W4REWQDdU5xfK5D4n8+x4ecOIFB1/Njx7kg=
	=
X-Google-Smtp-Source: AGHT+IFECpZeDDEGAhBtzHw6/PxcEE3TRQwhyGlv3EpuDKpWXDFvddkM3Bj/6+YKpS1VWGtiLzjjfhO9SUic
X-Received: by 2002:a05:6902:150b:b0:ea4:d1:e832 with SMTP id 3f1490d57ef6-ea8a867ea09mr636869276.42.1758224052816;
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-ea5ce832831sm198429276.16.2025.09.18.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3432334049A;
	Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0452BE541CA; Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 18 Sep 2025 13:34:08 -0600
Subject: [PATCH v2 2/3] selftests: ublk: kublk: add
 UBLK_F_BUF_REG_OFF_DAEMON to feat_map
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ublk_features-v2-2-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When UBLK_F_BUF_REG_OFF_DAEMON was added, we missed updating kublk's
feat_map, which results in the feature being reported as "unknown." Add
UBLK_F_BUF_REG_OFF_DAEMON to feat_map to fix this.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 4e5d82f2a14a01d9e56d31126eae2e26ec718b6c..b636d40b4889d88f7d64d0e71c6f09eca17e3989 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1379,6 +1379,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
+		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;

-- 
2.34.1


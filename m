Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D72D6E4E
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224056; cv=none; b=sf44sM0S1sFgR8bVhqRBqcrzEDsDP3DiGVQCN5EQC9YqLOELy81qQFs63C15au8SLHexPNv5/xuAkFXfwrkngbkpaGG4k6ys2qHzHwTyUStReart4MnElpg+fCPCNABmh1BzsaHwhAzDNu33+hyz0QLT0Adkf3FUEuNFU5zHlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224056; c=relaxed/simple;
	bh=I1SvgDPbViudLFOaGAb6f8a3G0PYsCRpE1vM8Gvi1dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzT11FUU9zmCbluB6ybsSWl+HZoU2Wv0h2AcTvCjRsyjFZKfCJMqwqcxt1GxiaS9/KJKp1qYbSczmgvY839bB/XrO5mvWqD5hm1D5gONyqNGKQ3F6v8YLlOfYCqXR40wCFg/dccjSkN3c7f7OclvKThSqzIHAXBd1GxJpupaQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZL6YDe3Y; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZL6YDe3Y"
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-4247cfc66a3so4670915ab.2
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758224053; x=1758828853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGgcbSkc4b3TEAlty1vI9MIlV1K03L2tgLefNKM4ZS4=;
        b=ZL6YDe3YckrDXAaaWbx3/TfDA6hxeiGENu7eH4biMVW4KdBXwbLCb8NJArqML6vjLK
         HyYQPQlofeDAz0U7N+KgCLc34SFLacpWeLfBNsMXAWtcmnuhsBW3mtFWxGODNPYm33aG
         3+59jvrmf8FrglWW1Li+nkpC22+XB1WNTEYg1E2n/MpjxgislggAQE6EDlB//514H/4w
         R4rf7pj4rqPYKBTq+vkS4pJx/QC3AsrscD05IP4iepSY+B/94Cb/I50n9gYEr1aoiZVW
         hmpkVRxkWazwtPLOsYiEYAvVVAuPwDnWoUKpZQ+Zstf/Iu5ng+FEzC33B/tZOExZ/tuz
         WsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224053; x=1758828853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGgcbSkc4b3TEAlty1vI9MIlV1K03L2tgLefNKM4ZS4=;
        b=gX/RvKeA675SPnyH0s78wqJ/e5o6amLq5zKIUTJweSsGO5psJNTQztXchYclHl8EHm
         /jRVPwnp7/RY+g+E8FLRTZr+EUUrorInZvb3gHZFxNRGO8CFpNJI9FJ+Hlkk35NzuMh1
         wJQqS9mOFRkiJT2OOht7O1Z/B9i7DZSTmpX0WYOGde5rN5hbIZ2iCUDmrTVj1EusRb2M
         9YGVMKJCZrF6xbngB7IgqGQE+XX+Bs++qzwT8MPIF1raxxjQYUoOaGgjqqy8o69ub7J9
         Q829GR04h029W3AKgSfGkbjdZk7JJMCQBxOHxnUFLcW4ikq+Wmjx4X14Mrc7hBHoRzAE
         /IpQ==
X-Gm-Message-State: AOJu0Yw7I8vp9QeWZsq71AG2Axw4c9vYHSB6s88l5eJgSRgk4MHmM9rp
	JFugSPNoC/5cWeBxp+W8R+oOlMrILhQUf2hR7X/L/SmTtqlBu0/sKGGz4E6rsMm5F9Mwu+9SB4t
	PUPKLPwiGOjXLaHmU2sdTepdlPBurXEzhAvK0hRq3f4J9N4kViwoF
X-Gm-Gg: ASbGncsV0zjUufAjLoGEtQ3gSMsyY2pfJva4FdJSE3HzAyCiLEFnCT6zb1qXPBwPHzj
	Frg+ej/rAxhjM5+F8Cq+A63FDI7JRDxD9XSAMLplztfwoZTqBn0U448l3fN4gZRJg+Njg/RzoA4
	ekGYYKrq1yd/BIn55+AwchCW61uOBt4OuvYX0p5UTYgXxCQd3AlKxQAZuFsVpJsX9a2jo7x5/WW
	KFR4iJFDO4OS5JRmVbpKCXS0QdPRv04BK0A53PsSzTJULbPwSpytYjrfGHPE0v8hCSeBA1xU4d/
	PQcjIqHIqEkAuzqTXAJrBzRll7dgFBJdQjUpGRnLJhZ2djKBKgcz3uXBlvg=
X-Google-Smtp-Source: AGHT+IHFBuXdBHcUoocU29bhImj7n4wo7JMQqdfOvZ3xQYknkYkVo1GnnTsv5mYjprk2aGCiMz9ql+ezl0L1
X-Received: by 2002:a05:6e02:2293:b0:423:fce3:9255 with SMTP id e9e14a558f8ab-4248197c39fmr12210055ab.23.1758224052653;
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-53d56e41e6bsm198876173.44.2025.09.18.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 35A05340853;
	Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F2C33E40696; Thu, 18 Sep 2025 13:34:11 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 18 Sep 2025 13:34:07 -0600
Subject: [PATCH v2 1/3] selftests: ublk: kublk: simplify feat_map
 definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ublk_features-v2-1-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Simplify the definition of feat_map by introducing a helper macro
FEAT_NAME to avoid having to type the feature name twice. As a side
effect, this changes the names in the feature list to be the full macro
name instead of the abbreviated names that were used before, but this is
a good change for clarity.

Using the full feature macro names ruins the alignment of the output, so
change the output format to put each feature's hex value before its
name, as this is easier to align nicely. The output now looks as
follows:

root# ./kublk features
ublk_drv features: 0x7fff
0x1               : UBLK_F_SUPPORT_ZERO_COPY
0x2               : UBLK_F_URING_CMD_COMP_IN_TASK
0x4               : UBLK_F_NEED_GET_DATA
0x8               : UBLK_F_USER_RECOVERY
0x10              : UBLK_F_USER_RECOVERY_REISSUE
0x20              : UBLK_F_UNPRIVILEGED_DEV
0x40              : UBLK_F_CMD_IOCTL_ENCODE
0x80              : UBLK_F_USER_COPY
0x100             : UBLK_F_ZONED
0x200             : UBLK_F_USER_RECOVERY_FAIL_IO
0x400             : UBLK_F_UPDATE_SIZE
0x800             : UBLK_F_AUTO_BUF_REG
0x1000            : UBLK_F_QUIESCE
0x2000            : UBLK_F_PER_IO_DAEMON
0x4000            : unknown

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 6512dfbdbce3a82f1202de17319ea593337427e6..4e5d82f2a14a01d9e56d31126eae2e26ec718b6c 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1363,21 +1363,22 @@ static int cmd_dev_list(struct dev_ctx *ctx)
 static int cmd_dev_get_features(void)
 {
 #define const_ilog2(x) (63 - __builtin_clzll(x))
+#define FEAT_NAME(f) [const_ilog2(f)] = #f
 	static const char *feat_map[] = {
-		[const_ilog2(UBLK_F_SUPPORT_ZERO_COPY)] = "ZERO_COPY",
-		[const_ilog2(UBLK_F_URING_CMD_COMP_IN_TASK)] = "COMP_IN_TASK",
-		[const_ilog2(UBLK_F_NEED_GET_DATA)] = "GET_DATA",
-		[const_ilog2(UBLK_F_USER_RECOVERY)] = "USER_RECOVERY",
-		[const_ilog2(UBLK_F_USER_RECOVERY_REISSUE)] = "RECOVERY_REISSUE",
-		[const_ilog2(UBLK_F_UNPRIVILEGED_DEV)] = "UNPRIVILEGED_DEV",
-		[const_ilog2(UBLK_F_CMD_IOCTL_ENCODE)] = "CMD_IOCTL_ENCODE",
-		[const_ilog2(UBLK_F_USER_COPY)] = "USER_COPY",
-		[const_ilog2(UBLK_F_ZONED)] = "ZONED",
-		[const_ilog2(UBLK_F_USER_RECOVERY_FAIL_IO)] = "RECOVERY_FAIL_IO",
-		[const_ilog2(UBLK_F_UPDATE_SIZE)] = "UPDATE_SIZE",
-		[const_ilog2(UBLK_F_AUTO_BUF_REG)] = "AUTO_BUF_REG",
-		[const_ilog2(UBLK_F_QUIESCE)] = "QUIESCE",
-		[const_ilog2(UBLK_F_PER_IO_DAEMON)] = "PER_IO_DAEMON",
+		FEAT_NAME(UBLK_F_SUPPORT_ZERO_COPY),
+		FEAT_NAME(UBLK_F_URING_CMD_COMP_IN_TASK),
+		FEAT_NAME(UBLK_F_NEED_GET_DATA),
+		FEAT_NAME(UBLK_F_USER_RECOVERY),
+		FEAT_NAME(UBLK_F_USER_RECOVERY_REISSUE),
+		FEAT_NAME(UBLK_F_UNPRIVILEGED_DEV),
+		FEAT_NAME(UBLK_F_CMD_IOCTL_ENCODE),
+		FEAT_NAME(UBLK_F_USER_COPY),
+		FEAT_NAME(UBLK_F_ZONED),
+		FEAT_NAME(UBLK_F_USER_RECOVERY_FAIL_IO),
+		FEAT_NAME(UBLK_F_UPDATE_SIZE),
+		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
+		FEAT_NAME(UBLK_F_QUIESCE),
+		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1404,7 +1405,7 @@ static int cmd_dev_get_features(void)
 				feat = feat_map[i];
 			else
 				feat = "unknown";
-			printf("\t%-20s: 0x%llx\n", feat, 1ULL << i);
+			printf("0x%-16llx: %s\n", 1ULL << i, feat);
 		}
 	}
 

-- 
2.34.1


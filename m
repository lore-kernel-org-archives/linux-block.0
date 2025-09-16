Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81820285418
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060373; cv=none; b=hFeDRuzTaO9WwGLZkh29P50mZnmnKxyK6re3Rdf+JIAUp0kP3A2XngwAi8g+8rVyq5dRbPiDJN1tZ18dQcEFDqfgHgYKHfkCI05ZKbpgDyjxJVzfH7idzGF2ubxBDLKiE9nqj+iQ1ra4KyNE/4dDv5Pyh66ptechAAvMIUPruxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060373; c=relaxed/simple;
	bh=SIKkpUuN+UMf7521jvtEXvNWyyT5bVbD3qrrehDOkvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOPKVA5uwGylDhmmI0ygmwCWtS7Wcso5KHaIfF38yvp9FdZSXaJgPrplpn0u/nCXNEn+2N3eQyWEZlFVtA7vmgang5pDl0V4xmcyafatT8dZPpkBeKXjlj4HRLPn08ttsgvw99dUEVh8v7tN1S3tQ59JG2J1XrbIR/sYAD6o6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Qa/OtKv4; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Qa/OtKv4"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-8988b982245so2935999241.1
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4wsBOfcY7SP6UfIj6tlKK4cAsDmDK/TmLfUs8mNZfw=;
        b=Qa/OtKv4I0T6S6fGPCaPaJZFvWytzOoXDnT7Q3nH11SuoW9lBlrccns3LRDVfTsrGE
         yCzfJ+pmIyh1dItShechWM4zUJ2UT5yJQcIsbDg289Gvj5+hDNQ3MGmr4RVcnMrPkKoJ
         +SN8oHTstQMYL5xHsKPkPr9bqAKrTEBygsxzzUXzy+5hF827qwQtL6Ul8fDFNUg+eax6
         FS5e5c+RJO6QQDMmJkTpJpXd7rJzPBVj+bfblBq1QiB9sTkk9rhkp5h7RoeR8mGIQLRw
         8ThhbyLjDA4By8EfwTn78mFf4qSL5ndrG5GoWzJBcxlhmhs/h+9+sZy3mLRuPLP77Dip
         D5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4wsBOfcY7SP6UfIj6tlKK4cAsDmDK/TmLfUs8mNZfw=;
        b=q2GmNDfmP23Ya3hZYllKo8S9kLU313+NX133HL6NFGlgHzT4lA0ZQcT4g7BVGXEv78
         40nN2rLbOJw7yYPPeVI8ulKKJ6/I5rzBeEzBqwygAtnkWV/f3NgtiH/lGjHWeicWMrb8
         npZ3fIv2hx1/zEaGyXviUVoR2XUp9vZwagHQR11DrmK924yB139dbMOXRgEkAIvcjfu6
         8hOYeqxr/fwltYtmsdadFYvFMFjYGA6AOo2WpzaDroDKH/ypWs1qDBa9tygaWmDKTzLq
         Bo8ULVqPh9hS57/hUf3R9rL4nph32JyKlxx53/jpurL9whYq64Xz00FReT6z671hBm4Z
         LDIA==
X-Gm-Message-State: AOJu0YzwgkI03MmIz7FyDY2XPX72/+bFNM+t1tSIJxRTjjtCB1ofVFQt
	iSLN5XrqnYZg3ceqoHtfQdBVXWztzxrT81NXFLYLVPDCrtu6k3y+a8BuwXZ1rfPIlAyd/VZg+zd
	dK9ugJqyS9u+jdo+kbID1XXLnddavd3ad8Mj4eX8d7mKNCeomoBG0
X-Gm-Gg: ASbGncsnHW4rD1ZEyuNY3GesbmQQOl07G2X9Yzdmowb68KHHGDHUWkT2OsoLqoVvj49
	iXxj71sJg7omXQoXOa+OH7e0+ylGJnaIEE4qVM2zHNTwWt5kySrwvLnFhWN4AkXJaCxdTMhkNd0
	QpTm+c3Q7D+dUK4X4q6Itprf6ZvTvsMqVXeA5mQAo+MpNZKdfXjZ9mp6+uHBfPi4XCnwym0ikL8
	qySZG2z8RgptqUG/Pmoduk//WQd0yB+ezV3jHbZsYAlJdNDvR3PoOGcO3b41edEoOlmT0lpUwYQ
	0piUvawXUfBenjhzv53BQTXg06kfqPsJ+qdgSAeYpUVbnRHXBPkHo4ko1+k=
X-Google-Smtp-Source: AGHT+IFugGzusLHKIrSZCStJj5Llvm4aQRrc73nKgf/iXkByRK+6zltAVsAANgINDHQF55kouKN5b5uW5P5c
X-Received: by 2002:a05:6102:5a92:b0:526:1e74:9548 with SMTP id ada2fe7eead31-55608ea0285mr7126569137.1.1758060370249;
        Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-557f9d4b892sm975973137.5.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C7E57340A4D;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C2794E40837; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 16:05:55 -0600
Subject: [PATCH 1/3] selftests: ublk: kublk: simplify feat_map definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_features-v1-1-52014be9cde5@purestorage.com>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
In-Reply-To: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
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

# ./kublk features
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


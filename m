Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877512D7DEB
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224056; cv=none; b=RQ1DJeh+z1nM3pPll7O+UBQrOrGlxwh09RjCjKKdsm4NrzYDC6StT+vLMZycENdwfQZiq4K7RVGBNgaYNQWL1OTE3CadkqEIPGtMU/qwTpQKh6+ag9pClRo0A8zwNZKqcvdLJWbx7O78FTg9Gq9oxq7eTcv4GpP6x215P92Y2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224056; c=relaxed/simple;
	bh=sbBFmEbCI91GGT3v21kazP+Hml2+1L3pYFT4t/iXCGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YnLjm2GesaeGPqSO/mSCiD1i3NANaFL+mrVUA0eZLlq8ffubA4zkntjpXU/NklYsurZGgXwySin//g97wc+UqOe4eHgAFqlcZmN69mcclzKCyiesu5Y1dbVh/bZQPQzSBX8Ng0twxoFLZsWMgpnwXBKLZQA7cxyO4vwPpnuEFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TDHRu4t6; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TDHRu4t6"
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-893661db432so48333039f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758224053; x=1758828853; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOBwRz3GaH1eMWrUN/iKniZd7P9/BH19U7AxNISMrY8=;
        b=TDHRu4t6ZRs7QcsPy5HsBPNAtVxOSVWCZCQAMlihYSpl3DJXpw1Ax2XNV+gbD/G6BA
         RGfjRJTjRfkZQqZSIX4CXXSmSysv0yIFa6BJX2+J6wfw5+SiF3oAmpswVh/e5vODKDq/
         jlVqe6r0A3MSUk21IKOGRRlV78ELeXlhvb2wbmlqEF3J7Rbjy/kqF9K7aJfQWBls8Udz
         CyjVAY3AHFCVckHAhswWF2hvFiVoF2mw00UY/6U+wY3zd8dux2qGUit4HCJ236Fxp9qM
         EkvqI1yHa+L58SArfuOQ9HZOjZjjkZGfLhLo1agsLZjMJxtPgQ1kBxljmx7QZ0sP2zRO
         9yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224053; x=1758828853;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOBwRz3GaH1eMWrUN/iKniZd7P9/BH19U7AxNISMrY8=;
        b=kBH126cM6L5fQCx+3eT5nEAcP0aj08Npqtgj1Q06taAMoNb3fIE7teASepsX3tM9B8
         KObWxFZEP/rdT/ecsqw6AN9GYQTOojp75xZ/tSWg1YVzvNWsNUHVDMk9SqVtQ81alQA9
         2+TOYzcpT+xsE2xxDab8sbLgvIJyAIHtJMMpeA5LPOQIKBrLh7E3RRicMyLt6oQNlAoS
         zZdLWpBYC1Wn9F+n6v3+bOlkwrANrYimudo7vS/abn6sGhJo1d/g9srA6nxZRXzgC5hL
         kU89B3OGLlJJxZVlTJ8mboi2bAPFv8fLD/iZce3kM7oaLbG1CyOVQ9BFu/uV+QtS9BuI
         /hAQ==
X-Gm-Message-State: AOJu0YwcrpnNI7YVymlpuFUufDEwHd9zApPac2jTGJViapsQ2HX+lIFx
	qExilzgYixMnk7YiyZ+asCNX807CFh8aPW/vctx6gR7iTkWxcwhkw9x/JNwi0mRq0iTJrzTMpYs
	bT0Pxa1tvKXWofdp35zVBOuWlGJMxC9335BYjfUY4J/w6SeVPM6X3
X-Gm-Gg: ASbGncun6x/zc6i9qhzU54lPo+7VoFxO9syjSF1pYhYOXtnFHBXXyHGrdhXiEbIQQTu
	SLLV+ZrKDQFiuFluksuA9Vt1jj/H5Q/H9Xd5ysMO3EC0mmHCoeadYKSiwMa8WCNnn0NHvjlFhOB
	Agcswm53Dn0f6qCsQK/XtnuDSr1D+byKtA64Oc5YAb3hdNCplO7eR2eIs/jwRc+dzLv0QFmnqJL
	hYqU+XXWAuNa6SgjxLeh567D32BqOM/6bexDyFjGssiTA6c7kKy+s1s5s/VgPJqrw90KynWTzfZ
	ao1rOMSV9VpNPA4UGjCgFdO5alDeeMhOM+TedMVPs/pL1XavlAlikboJ6r4=
X-Google-Smtp-Source: AGHT+IGX1LUa+89FnJFZOHh/KHneHBukRt9x+vWGpsegi63eqsXXAjtX/M3kZSJSv56LCLKXci5rMTAPLk5V
X-Received: by 2002:a05:6e02:1c09:b0:424:6c8e:6185 with SMTP id e9e14a558f8ab-42481903866mr10677075ab.7.1758224052618;
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-53d39a17a51sm221217173.10.2025.09.18.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3278E340325;
	Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id EE141E53938; Thu, 18 Sep 2025 13:34:11 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v2 0/3] selftests: ublk: kublk: fix feature list
Date: Thu, 18 Sep 2025 13:34:06 -0600
Message-Id: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK5ezGgC/3WM0Q6CIBhGX8X919GApGZXvUdzDfFDWSUO1NUc7
 x563+U52zkrRQSHSNdipYDFReeHDPJQkOn10IG5NjNJLhWvxJnNzev5sNDTHBAZv2hb4iQFlKb
 cjAHWffbfvc7cuzj58N33i9jsv9MiGGdKclE2qEwLdRs3n2vd4Wj8m+qU0g9C9LaEsAAAAA==
X-Change-ID: 20250916-ublk_features-07af4e321e5a
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch simplifies kublk's implementation of the feature list
command, fixes a bug where a feature was missing, and adds a test to
ensure that similar bugs do not happen in the future.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v2:
- Add log lines to new test in failure case, to tell the user how to fix
  the test, and to indicate that the failure is expected when running
  an old test suite against a new kernel (Ming Lei)
- Link to v1: https://lore.kernel.org/r/20250916-ublk_features-v1-0-52014be9cde5@purestorage.com

---
Uday Shankar (3):
      selftests: ublk: kublk: simplify feat_map definition
      selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON to feat_map
      selftests: ublk: add test to verify that feat_map is complete

 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            | 32 +++++++++++++------------
 tools/testing/selftests/ublk/test_generic_13.sh | 20 ++++++++++++++++
 3 files changed, 38 insertions(+), 15 deletions(-)
---
base-commit: da7b97ba0d219a14a83e9cc93f98b53939f12944
change-id: 20250916-ublk_features-07af4e321e5a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA4211C
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881844; cv=none; b=NUJGLqdCu1pNm7BYT4AjtbYG2MDdgHb6ScoEIvEOn4aiuAwX/Z3ZHXZ3yrNnSXdtNIFFCzBHmSq3Ok1aqo3vaENWk0zq6tFbpJ0OM5vJ25ISVFStEFjjvWM/9trX6zVG26EWQGbaA57uxt6nli05IFN7Gdm8SfhA5qiR8BHABZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881844; c=relaxed/simple;
	bh=5R1ihXWNblpTcigqrOrVvxreW0nOHeJ3fH4HtMTNR2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKWw1NQC0OUWpUhooPysOq+9gL9z0QNF3JTh8Ibw113jAsM6eVqXUDJeg1Lyyajfn47WunlSzqdbgeMglmilnLHXcaHoXTgaKIeSk/Tm6KBKTmJx0lMhlPqV4sisdQRwTGm1RvWcA7BrjVO6ZpMM4+Y2KA1i+PGNMBsUfPcOweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AD1oepuu; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AD1oepuu"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-224019ad9edso81116395ad.1
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745881842; x=1746486642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yN6X8qy6iIXBeRkDCjdD0w88qJ6dcCiPtrqiszUMgAY=;
        b=AD1oepuu0paRzg6wueEwG+FWx0b0H/PPA7MRK5MOvWF+apvUqAxkD0pj40F5oWvqIk
         FgPL4hxJI5cOMfO4a4wcEga+8JC7uWbCksIknxRel7aTj39VA4A+xk5pQGFMHjp52aD2
         4DoMArpUz1+OtD7HEwvHqShjvo5B4T2u/q5FBthbQsrwDVALlzWiHLQ3VFGxe5DbHSFQ
         Bo01dyN/fQViqn34hPG2T/wLsO2BgRJIynTwO84LAIzFyvrLKVjXSimdKgypGsJvCQKN
         gtK8sA1QB2Sw7n2HmIJtO/FphR3xVNrbdT2TuuJFUQbgabzPr6LkCpXVaCnsH5uz+Nsy
         8DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881842; x=1746486642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN6X8qy6iIXBeRkDCjdD0w88qJ6dcCiPtrqiszUMgAY=;
        b=WDGZdmqCU9Z6r/qceTc4EKtCbX06tNtPNQwo+Dqn8l15QsHh0AmMT8DMFGOGuRQL+w
         s9uIVxq9shKDgrlLXog2qPMEw/CR9PoWorZV3f1TdODDS3vRusO2OmEOAvpCGZLPpbOR
         sdgQYAxMfC6QlOs0pIE3GQG0DUzifu98+Oru5kcvMVi5/7JeSUcWZfnQCSsb4kpU2tub
         YAog7Vo1uX1ZmANkWF1zrK3uoglC8V0hckG0OafdxUDyqR35BphIll0ou0wP+171spH8
         TgxvkKOVUHc57QIyuIte65QGQwNaq6VopTT3ikUmshwYvHKMCXrf+gedwkROywHCr1VP
         9XMg==
X-Gm-Message-State: AOJu0Yxkx6DRUoEw1O1BCrKUw5ZveSTi+6tKdLBWzN0UwB2EeCKxk24u
	Q3RuVElYR7rrQgY9r8EHBHBrhYP2yWnut8wnkkq8xp4NVJWbB10gdsnHGP/GDO0E6nd8SI/LwCH
	/pj7edYxXn0s7Dtn7FGiAfby+sf7i/NGCQ/qma4WOxA/x2crt
X-Gm-Gg: ASbGncsT/F5LBqnMXa6ChxL8I885LjpQct2P2BfO4Z23Wydsad8jAS3A+C5TkDkb9BW
	aEXG1FG2qfWPl4wPUEh9CHmNsW5eeOkuGGoYvxFlo4vzvbPDl3FWY64XS1DZeiSOgjPPQ4TRyJX
	QHf0O51QyFTyXJfnjLql5VDMO7bivKEMqmO8PS9qdUsu+kga87EY9H86hMlJqJbdIJyW6ctJyZb
	5pusoWQTDpdEnSDyxj43eob0ugR47MlTvqRPi6NpARICQE3LAfm9TNThrHc9gKHaolNx3HuIi0v
	1Xy4VD0f0KNotDuW30rDups0QRvhDnc=
X-Google-Smtp-Source: AGHT+IGLl7TOqKFNXF5fmwjy9nOE7m0hNA10OLnBEeDkYFZQHcoN4UwcAMLHuXqjIk6lJT7AmRIwF17PnTRk
X-Received: by 2002:a17:903:2284:b0:216:3d72:1712 with SMTP id d9443c01a7336-22de7024ab6mr13691355ad.48.1745881842017;
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22db4de9303sm12508135ad.45.2025.04.28.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4008734065D;
	Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 35C66E40B9B; Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 28 Apr 2025 17:10:20 -0600
Subject: [PATCH 1/3] selftests: ublk: kublk: build with -Werror iff
 CONFIG_WERROR=y
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-ublk_selftests-v1-1-5795f7b00cda@purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
In-Reply-To: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Compiler warnings can catch bugs at compile time. They can also produce
annoying false positives. Due to this duality, the kernel provides
CONFIG_WERROR so that the developer can choose whether or not they want
compiler warnings to fail the build. Use this same config options to
control whether or not warnings in building kublk fail its build.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec4624a283bce2ebeed80509be6573c1b7a3623d..86474cfe8d03b2df3f8c9bc1a5902701a0f72f58 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
+CONFIG = $(top_srcdir)/include/config/auto.conf
+WERROR = $(if $(shell grep CONFIG_WERROR=y ${CONFIG}),-Werror,)
+CFLAGS += -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh

-- 
2.34.1


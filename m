Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87934404F
	for <linux-block@vger.kernel.org>; Sun, 28 Jun 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782651567; cv=none; b=UwNeOic3gtMrJVsnghGjHdZpQlFj5EosvB8mfczyYLUvcn6jx8CX3jby0RCJhtTbPeMUqqBmq+xdo2Pylfi9VonfRIIfHPzA4HBmYZGeP0oEK3rJx2wSRUOQFanwBHCOK2ii6rd3j7d0QcQ7+6JtVZN/CY6wFaOpRFSLW5TtL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782651567; c=relaxed/simple;
	bh=Y4BnfNiT1we4bt1zWbjoZAkgncDWAqCsT4UhVeCZyjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhxw7QWQ5gNtLWOyZgV/CxrwCVBqxse34PNllH75gSjGt2oiHasH+dnYcGhkp+z1g17sbCfo2kHkOBpKLE4eoodLpuL9GOrdPMmulMMwEI+hZwVQtdfMRJ3fg4x0lnA1mQziI0tDByTIlX/9ecxWnqn32A7Qg1X8naZ7PVmtTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEixEAoC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEixEAoC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46ee68c3b7aso2024084f8f.3
        for <linux-block@vger.kernel.org>; Sun, 28 Jun 2026 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782651565; x=1783256365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3xuQGI0YA2MOv6aDh1dGyM6NDCzSIEOXdNl1rcjYmQ=;
        b=JEixEAoC/rub/eNMeszkA4Y2LWBhUKfnvM6OoBYn0WCDz2vBPjnNEOXivsTn8qbrMM
         jVdWwANM3x/ll6IX5+xu1BRVcwkvx0go3+KoKj2zmftPievzuK3eU5ijeKtpCuwLPXIy
         9318Dl+/mcu4J21PDvLYJU2faRvmvzuzR7is1HFlFnRpvMeDHpHE1hECE0LExsNdN63U
         NpOcxlGVAnwNLrpx3izIxrqui8NghCDug5i1Qpr8kiGo6l9F11T+shzhMn0PQdibwn09
         J6XwSAdPzbtNWYvaMQ8FjBdoVryimfNPAfMcV/KCmwCsekFvX6XwxjZiOa3enDfgfDoc
         UWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782651565; x=1783256365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3xuQGI0YA2MOv6aDh1dGyM6NDCzSIEOXdNl1rcjYmQ=;
        b=G4Rv7YQlydvGJPOidbD5ESoGmSlKooFpC1wCUycYFFzwA4/GX3SyvcEsLk6PXKZ9GD
         ZeZFSyAQeAscQ2gyUhoyux/DYWjj6UWNKoZ4owkJxvT3k5q+qEopIcPCNGsn7jP4vPvR
         M7vwP2+KAmd9/2OgCQ+08OCRP6kSETdWaP1xPzFOfNiD9ZzKRqnmvQeMnB7nZA7JpHoT
         ZKNw1uyPAUCOij2TaSwN+fRyfFZ+9niAg211i5C1VdokABljUyOlNolwdWQJ5wxapptR
         9A3W74eIOOA5vj6cAlk/BLqkPCTVN8oXOYVSme2nUO+vTYkJ6hFMzVSNSaP2fYFeBz4d
         bzMQ==
X-Gm-Message-State: AOJu0Yy0RcTP85cD28ejpsMnOLjPpFqZqDkfGCuoT/juU5mXm4YcZlEj
	MEoeiMC6R8FBOBCE5lMhImv6vzinxm91fRPG36q8nk8NkkNzxMdzyitkU7/2kw==
X-Gm-Gg: AfdE7cnO5u2vMRwg7OPAPnDtqSQU/THN6TN3mpd8ptQkLuLq09EXpL7oCe9pPeJDUyO
	fKtyIpSYMukBmuXDfjH5POAoio4wb8WmdFGu9QIYAMldd5aWKGi1uSHc+Ge8n3KubPFYjOOT6HI
	Avksa+MZheWVllyJVszMXs6xkcMq9B7D0vZhXXXRlP+O28rSRPiu/sNMo6Hi7GXCTlIxeYcXD3r
	Noc3VeKv6CiuQvJKmOlT+PSV1U8EeFahnAyhH34+c0B8s2rZjsDX87myOwXyIQHqMjMWrFX06PU
	5iX2x3bZL8OiB98bHYqgW+PvtiGWR3RBsBIhKBDdlVMuLQMaFraPd8fPQZ7YMjr/lwJBHGODwKf
	EAoGmlBvT9cS8YEzzAKD9zlxidHoErbmiAAZs/15VaETFC6578LEq91KpkAe+FahA/D2Ric0xzK
	4TDFsUo+X5IFIek+oSIIxQMTGSonkifaIlEzPdCQE/CsbZvyIZfAUqsuMdpyX27L9zalqm
X-Received: by 2002:a05:600c:e556:20b0:493:bb0:3b43 with SMTP id 5b1f17b1804b1-4930bb03c0amr48898535e9.2.1782651564866;
        Sun, 28 Jun 2026 05:59:24 -0700 (PDT)
Received: from localhost.suse.org ([37.109.163.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071c9esm229273735e9.9.2026.06.28.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:59:24 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests] src/Makefile: escape '#' in HAVE_C_DEF
Date: Sun, 28 Jun 2026 14:59:08 +0200
Message-ID: <20260628125908.31524-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older make versions treat '#' as a comment, leaving the shell call
unterminated. Use $(H) instead.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---

Reproduces on GNU Make 4.2.1 as:
`Makefile:11: *** unterminated call to function 'shell': missing ')'.  Stop`


 src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index adfe3ef..d75daf1 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -8,7 +8,7 @@ HAVE_C_MACRO = $(shell if echo "$(H)include <$(1)>" |	\
 		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
 
-HAVE_C_DEF = $(shell if echo -e "$(H)include <$(1)>\n#ifdef $(2)\nHAVE_$(2)\n#endif" | \
+HAVE_C_DEF = $(shell if echo -e "$(H)include <$(1)>\n$(H)ifdef $(2)\nHAVE_$(2)\n$(H)endif" | \
 		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep HAVE_$(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
 
-- 
2.51.0


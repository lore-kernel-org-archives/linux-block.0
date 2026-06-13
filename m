Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6842749C1
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391276; cv=none; b=K3BiOU5BiYDP2Rx/JS1rthd8iyTmjemEDvvEY7cjqTcFe2yPAmbsO24atcgaOCMEbYgWM/478rqnApf4Vr2INZTwFXT6UHUUcfXUNtImElT2rYkqYcDtzh7pp4JXDQQzmcd6vJ09D7lF+5ZY0bHtnKvqI//RkPlxdYale990Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391276; c=relaxed/simple;
	bh=iZbJHDSwm/+M/O7W6upSMl4Wv69MZ6HERedebOMSJkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcIdsUyQZ02dQq87SMJBmgCI4zepi0q2JoBegnjKbMmgmJnp3D1ny++WrIBMW31CoJgG6ffptBs5M0iY/VG9vWOIqT7jHPiJXbIDKUmKFsESf1RnWwCKLWH2URwp3igl7lRr08x7R14NBtsgE0wR8vmA+cmQcLmMxyAH1rkhZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPtYAaVb; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPtYAaVb"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1384eb94d20so3092080c88.1
        for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781391273; x=1781996073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGN41lJJpUoPArkrSVIPW84Lj0UWsceBpbacK1PPJMQ=;
        b=EPtYAaVbdb7OMtts5QCZZjsrTny0h4X5jVsH+EtnJ13sSdXRfy3owCyVshZ5rVuCbf
         eg/O+6o2vWS2giZowymf6/LrUwEIXSdHpO39wQ0e9kaLZFWTvyGjqYOieJLc65HUDMoT
         ndRyVxX/hpXD+Ky9sEBNnsOKJxJOndx82F63GebSz+xqdEAcc6wb7ZTqAYsFAWSUbsfv
         iRuomQ0vkvwa7mRD0M7Bsky1riywd90nskZFDO0t3cDhdNQlQMu9u6oiyc+UjvvsyMKy
         vXFce/eQm1rdHk7sGgw5bnLv/fGGty8H3XT21zvIGrF26aQUtQ6fH6uC8g0XyN3EqYng
         aJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781391273; x=1781996073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGN41lJJpUoPArkrSVIPW84Lj0UWsceBpbacK1PPJMQ=;
        b=pq1/INmrYzJSDVEvW5haZhGWV7oE0s2IaSh48oDamnWWgPmzBcwwX65O8pJ6ZSHG+s
         YSohjXtTQPFQCXDK5ppd8XNldJ9MfCo+jbtGlh5mUR8Nvz7zgNFfJ9QGubLnBBz2CVoF
         xIjWvVuUP4cPUkJGdcuyUvi13Qdw9Ejwh759JywwQYS4J03rY1v1AEEkGQpDPTHjezqW
         ppGJ7Fifwc9zpBXYao0Kz+GAscKPahAhtwssFgNvNqTWIWxwHrKeTP1Unz4inAHAPkRl
         2sWq5mDk6Z2nLJqKnNf/HS4UYjJv8UGhCgEnHTPaip0znh185C/A+y8f5Ve0txne2B8z
         xpAg==
X-Forwarded-Encrypted: i=1; AFNElJ9JWswotX4h0Y70bk9aEIggL4wVFyy72yD+iryDzuP8g5LEBOGrHsAPC/MMBfm7oC2X3B8r3LeXbQIRIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrRfYFp5z2FCpzVyLdMIl13Pp3VzxyLyfugNY9whcjt1p83WL
	kB4K5YB2BIBXpk25LFWj10TD4BdIfV4kWXaYgflB4MJ7DMCcniTxDFLc
X-Gm-Gg: Acq92OFYkHBd/vCUg+cBwDSeBJOWve8QCeOetQxI3zFEfhJhPBFC+nvqydUCVnK3SrP
	08Fpz0SGYhjEUthbYxG1R1zjUwjIDqVyQoOEpcqZg/+JXnwWXtRaHUi/0fCHL7u0EEb9oMYTNxD
	VXNwd/sBM2bPQR09nyYxAwiMvZy23Nmh8IcO7ljh8xXjVGHRbZp/K+L1p5BEG78OLERTzDKkr6X
	J3ujxgx4wMYk/6FFdtK0sms/yqDxjnMdZIuVlDVcgdALETvysEQa9xJL/aOJ32E1kSAsHiLs5O6
	M2mZnEOWhHROp7hwqWFxUQ0CYAvHGYEcIEZwfV83Fl3Q+nOOfu7AId3VM95QlqfjAU9CFeiq8cK
	zWBX2uSJ/0nkMmlsqFzrWLQ9xSINCC2z/3G9IzdjLCGB65TxysVjdiay3JyZym7LF9L8gQ27rU4
	EqiaFJ6L5VsnrH+3krDuiT+cLd4B8jb7j0wXYKt7oV1qivrgWeMsut/A2RIjW6MkB+fvPNToZEN
	j17ABgzY933icVXNKY1rSSlarr7kPYua8sYuFLoqYa4UZ5NoZyk7XHWAYpvgk44zAfdVcuXnyvv
	5qBKbvkH7Q92ZxkVVA==
X-Received: by 2002:a05:7300:4347:b0:304:2af3:5ffa with SMTP id 5a478bee46e88-3093ec3e363mr2952961eec.19.1781391273082;
        Sat, 13 Jun 2026 15:54:33 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43f69sm8413333eec.20.2026.06.13.15.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:54:32 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-iocost: correct CONFIG_TRACEPOINTS macro name in comments
Date: Sat, 13 Jun 2026 15:54:26 -0700
Message-ID: <20260613225427.139129-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Comments in block/blk-iocost.c incorrectly refer to
CONFIG_TRACE_POINTS instead of CONFIG_TRACEPOINTS. Correct them.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0cca88a366dc..04630c36b737 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -205,9 +205,9 @@ static char trace_iocg_path[TRACE_IOCG_PATH_LEN];
 		}								\
 	} while (0)
 
-#else	/* CONFIG_TRACE_POINTS */
+#else	/* CONFIG_TRACEPOINTS */
 #define TRACE_IOCG_PATH(type, iocg, ...)	do { } while (0)
-#endif	/* CONFIG_TRACE_POINTS */
+#endif	/* CONFIG_TRACEPOINTS */
 
 enum {
 	MILLION			= 1000000,
-- 
2.43.0


Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79A19D884
	for <linux-block@vger.kernel.org>; Sat, 21 Jun 2025 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750523336; cv=none; b=YfUdm7f2Sv0RU8qXFh2aRb+1UzDTtdRdqbPJ+EOFdplp/tmnSYDP8yEReYyhgfjPbyfVXimJmyB3zuZEfkrO62cgsAmBhYxXoElksvSZV9wBDbQJDUhjfbmJz9UeLQYsoigHhbG7levre5j3Z5POF+Um4/T27DBDNQH/y+DQT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750523336; c=relaxed/simple;
	bh=Br/AjUiqPK7kWS3d/p1T4f7jWJcitMJB/k21O5avM0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ei95QNgaA7uV8bj4TpYH/Do53h0PWeOEegqLFiEMQYdN7XkH5vPIWf84ToYxDEBkae9AQ0DDQjc8yzBYOJmH0HWxQYGJ/12yiupGWnco549+q1p6A8fjQJLfgRk57KPlaOGbFqH5YBeFS4asSRZtwxARtUDm6nfiUUTCzw6SR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NW5GhdnB; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NW5GhdnB"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b26ed911f4cso386548a12.3
        for <linux-block@vger.kernel.org>; Sat, 21 Jun 2025 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750523332; x=1751128132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqc1pNioaqt03KwmwQ7jb1MxVBLMpBdNgYbtBd1e3XU=;
        b=NW5GhdnBwU0xlJ5NsLYEEsg4VZeJbHAfcGzBOEmuGPMTCwIAD46mTXiAZzPy/z7W7r
         vrROsgrJZ5x6FDzX0H0SsBT8ImbiNToj8BSQYfA50WGBGm0uw2BeJI+cMp73CPYSdXMx
         2emtcemFp+Gqpfa2e3MxGkMW5Xjfc8GT+5OywsUHkD4KBriO/N33oZwxLlFZHnqbAEbx
         UXgDKrg23LuJOISYYoLH/w4EQEc7+W+D06A4c8L3uH5afFP0osb/miGzC+MRUx7oD0fW
         1e3kgvqhmD/zVKxdXgTZmF2QONZwCEjKXVQkgbjp9DVoGcHRdMwk4GOYyFjg0xyXrxw8
         R2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750523332; x=1751128132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqc1pNioaqt03KwmwQ7jb1MxVBLMpBdNgYbtBd1e3XU=;
        b=iWLBxpDiSWvUWEhxjodoiyFF4EsY8tNo4u8b+kWznf8cNVu5R2nazxQks3doSnTDHn
         FY+9w69Jvyh18usJpHT7ohjf2/H1e1Qu1DHokdTOh02yqYpfYBhiofSjyjcesj3k7ecU
         CkDY33lFii2Yu+FeEWmE8y4vuEv0NZXLGhcPQuv5mGHydDRvkVRmvcpjzYJw6O7F40jP
         7lBMSdVTPR/ahQMUGKEO+KkD3g6jJugpErRRa3a9j03tKym6bfmLYFvqagJ5osX15Mbb
         OQAOEK9h7lrhu1BXbM+kR3xv9Nczu0MV+ifaAFa0OpmXEtQ6zyzmN7O4/BquP9XSxLTb
         S2ag==
X-Forwarded-Encrypted: i=1; AJvYcCULy99cSQzhBYyQIWHzG2T9B/cofDvGyOLATdwfsoNRD2WFUwPjF7DVM6A2X6ehwaA4zV6TbmQs0gPN9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzF3ane/wvutRp5TbRANyxuhICjsZOQlIEKFQEOF77s5u4DMHq
	lUwI1zVaCbD+lakLe5XxwogHae3sy5V1zSR0RJfvL1Gi1hgkNgyWAkOBEXzqXFFQdOfURxtSxkn
	ZDnYQVUox7DeHl449j01Phm4yaMRLwqApF/03
X-Gm-Gg: ASbGncspeoIIZUZtR75zXnuyIIKBGP69fa8dhxkeSmMTG0MUMy9d/596UUfVxa1QYrp
	tM4RFCGCjCNAII0eFv3lkThjKYg/JjCTdKDEFu7qFQBph1fuWoRjcyvTIfNrYO70AKTsAGKHrq1
	/FNQ92R1+UbIYo/EwHVQG851jA9+tb5sjd24sppd9TnXS0Dic8Au1OiZtuM2qS0D+aTJqihB1SA
	clYULgmdbDKyYFbO50ZDMCJcg+2C+avWbg3bEtPF7i2AAgwPqqaEilvne1d+GD6obxTIyyJJP6I
	h88GtbDgcnA9LSo4u4uKdaMXlyUeh7RyPQ8dj5mej+ezCAAs4FTideg=
X-Google-Smtp-Source: AGHT+IEBFdypyH71FaCNERa1yO+D1fgnOThDQ8WvWeH0QQB+6Sdy5Xr31fsXZ/ez38hI2Xk/wp4CgKkZkJ4t
X-Received: by 2002:a05:6a00:a1f:b0:736:559f:eca9 with SMTP id d2e1a72fcca58-7490d6117damr4263850b3a.3.1750523332468;
        Sat, 21 Jun 2025 09:28:52 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b31f1259cfcsm222403a12.26.2025.06.21.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 09:28:52 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D48AF3400D0;
	Sat, 21 Jun 2025 10:28:51 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B7A81E42425; Sat, 21 Jun 2025 10:28:51 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: fix narrowing warnings in UAPI header
Date: Sat, 21 Jun 2025 10:28:41 -0600
Message-ID: <20250621162842.337452-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a C++ file compiled with -Wc++11-narrowing includes the UAPI header
linux/ublk_cmd.h, ublk_sqe_addr_to_auto_buf_reg()'s assignments of u64
values to u8, u16, and u32 fields result in compiler warnings. Add
explicit casts to the intended types to avoid these warnings. Drop the
unnecessary bitmasks.

Reported-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG")
---
 include/uapi/linux/ublk_cmd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 77d9d6af46da..c062109cb686 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -448,14 +448,14 @@ struct ublk_auto_buf_reg {
  */
 static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
 		__u64 sqe_addr)
 {
 	struct ublk_auto_buf_reg reg = {
-		.index = sqe_addr & 0xffff,
-		.flags = (sqe_addr >> 16) & 0xff,
-		.reserved0 = (sqe_addr >> 24) & 0xff,
-		.reserved1 = sqe_addr >> 32,
+		.index = (__u16)sqe_addr,
+		.flags = (__u8)(sqe_addr >> 16),
+		.reserved0 = (__u8)(sqe_addr >> 24),
+		.reserved1 = (__u32)(sqe_addr >> 32),
 	};
 
 	return reg;
 }
 
-- 
2.45.2


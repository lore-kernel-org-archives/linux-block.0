Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9771A8F60;
	Sun,  3 Aug 2025 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754202344; cv=none; b=FAyqN3Mt2Iqk0lcmMgio8e/a8WgoaFg+DgVeSsdxcjR5VIB9zeW9DML6t6u0OhI9Kzjrs/Vqe5bjFZCN1GBob/reImDsfchEyugiGg8/ZVsLvvNMjtBnV9mZxpBLR3DDs1rE4jG8SL/IwMjBHPuaXrk3mSDkR6BOJhd9rWzMfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754202344; c=relaxed/simple;
	bh=z2Rlz37BzFsAO3RN3PIojtGI77f+StT+TcBS/qpMkXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/S1ZwaOSHx3BSvSEiKDDjy9wito6/aoLSdfwuPNfkF82V2mGXQqWddlCN8gbne/Fk2EgfKln/eUdAgWQbeFLH9SEcG36/W5Rk1kPhADJi4/+sdM7CDeRIW+XD+PrVSBkUIIH53aOXLDF+8mCeoZ59xvv8SkBlzV1JHOG/LKN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcyv2aY/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcyv2aY/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e7f9bba93fso26876885a.3;
        Sat, 02 Aug 2025 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754202341; x=1754807141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18FUEBSoMNXtCmemBKC2uYLgcBGhaKjELbQUea43rEA=;
        b=fcyv2aY/+AzPqsgn+FpC2jc4bT26mF2uoq7Iwqdld7u1Ezs+MX8NH/g4GQKRfM2w6k
         dRpWlsykJS/7/Sm3eWnd+vi8m6NemZCDa/RU3U4Th1MGublQ0V7YUPqL6HE47vT5BQFP
         MI4M/jS4Osgrvo6ma+n4WpBPrK+vmiZzApe0H/AA0K8ec7qgJgR824so08ZvUJPJKmnw
         toUyc10uHsT190NnM+Z91/JBdnnG32LBZ+zkEPLRs8hvSVEoqqDe2ihKyF0RMv+zLM4X
         QQ+HGpRm6YTe+KfBpeej2vhfbahuW45rAer6ZeoLvZZCr20Lays75Qz7FBZtaI6NZ98q
         zp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754202341; x=1754807141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18FUEBSoMNXtCmemBKC2uYLgcBGhaKjELbQUea43rEA=;
        b=pr50EemtsZgq4rZWtkATeb6Pj1EyriHdEb5h68fMDrOZGzxhzCnFaonuPmJSOm/fhQ
         yM75ZzVIB6pV7srfjh8pCOZqb7TscBG8kgzVsKblXgz8/5aFV5qo4RjzYBXvDyk/9ycq
         mMsC5JLvijZohLZb4lP29iGtVJkjfuXBBl5lG5pM/vLfENRRpQ4pKgIoxY2OFREGQ17p
         2wrCuPoCZkEm8vq5PemwEwyGL6EJw47hqRfomn57O4vAue1mZnpvuRjv2j3wc3i/Bunw
         xZRSuQ24l1UbGDqs0K/bhf6zdmWIimV4G/2+h641O4F43dkEY7wAavULgYSKYdXs9OHG
         6xjw==
X-Forwarded-Encrypted: i=1; AJvYcCV8lSozPVvcA+CQlezrVYZEI4UVCFoti8qNw/JI6zhaUDyP1ck0gytxM8bhMeOXICjyGddXduxp1Wugag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6D9CK2ZVLmhZum/QmTyapaGZiLMYYTH1u0Ok/iyhXPldORbdQ
	fgv4+H9ilDiZYegspOnS6M9hqk2M24te+JP3A4skatRACieZ/AV2uarH
X-Gm-Gg: ASbGncuokj5lGTWX0H4+voe/0tF8X/kUyr9vc+6E6mx8j49oC9az2A8+Pww0KeH36+9
	agooInYAg5lF7yY284tkz0ZV8osk9BhJ0chdQcrEFsqRoEPeoWpfkUDVBLRAXQkE0iARjZh0d3C
	auVGmct+Mis5If4cQPOjnPBhCBRO3hNbiyZbDvOwFQqOPbz6F4oVfH2nOckpdU3aQ04m8pjNjmZ
	vYlG3GsyMLhRHhp+A9cUgcHpAG+POkSGoi4JbRShyuygr5U294/Q+cp55lmukbPe2GVSGUKxT8p
	bIlaDYZcjv5trTcjwv9Ph1k6OCs55leNgYs+HgQ0J6gHa7aKq65EwEKQmOarFbrn8nZtReZXUc8
	cGz1dXlC9G8vjg3MNT8UtMw==
X-Google-Smtp-Source: AGHT+IFh4n13JjdrnLeDOzRP8+CtmXsyh19v5MBjZtLm2eTvH+1k0UaoCo5l2RifkPvYCJhLFbSMsA==
X-Received: by 2002:a05:620a:2652:b0:7e6:857e:6939 with SMTP id af79cd13be357-7e69635d36emr673433985a.40.1754202341330;
        Sat, 02 Aug 2025 23:25:41 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5cd7f4sm412585285a.38.2025.08.02.23.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 23:25:40 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Seyediman Seyedarab <ImanDevel@gmail.com>,
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: [PATCH] zram: fix NULL pointer dereference in zcomp_available_show()
Date: Sun,  3 Aug 2025 02:25:19 -0400
Message-ID: <20250803062519.35712-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During zram_reset_device(), comp_algs[prio] is set to NULL by
zram_destroy_comps() before being reinitialized to the default algorithm.
A concurrent sysfs read can occur between these operations, passing NULL
to strcmp() and causing a crash.

Additionally, there's a use-after-free race where zram_remove() frees the
zram structure while concurrent sysfs operations may still be accessing
it. This is because del_gendisk() doesn't wait for active sysfs operations
to complete - it only removes the files from the filesystem but doesn't
drain active references.

Temporarily add a NULL check in zcomp_available_show() to prevent the
crash. The use-after-free issue requires a more comprehensive fix using
proper reference counting to ensure the zram structure isn't freed while
still in use.

Fixes: e46b8a030d76 ("zram: make compression algorithm selection possible")
Reported-by: syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a281a451fd8c0945d07
Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
 drivers/block/zram/zcomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index b1bd1daa0060..98a2a3199ba2 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -95,7 +95,7 @@ ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(backends) - 1; i++) {
-		if (!strcmp(comp, backends[i]->name)) {
+		if (comp && !strcmp(comp, backends[i]->name)) {
 			at += sysfs_emit_at(buf, at, "[%s] ",
 					    backends[i]->name);
 		} else {
-- 
2.50.1


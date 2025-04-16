Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714391D5AB9
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764083; cv=none; b=ZSllr4boZdtSYVSLbl/NnPs3u/1mu9tvaoq28j9hem3rTrr1rfWV27kbHkxxSycnOpZC4Tmu8naAIKs2GBhxauvLD+yyX/sFBXQStHlN6uVFOqK8l3Hb/72IPRgPyK4oQs+dkaKohkNDcUtGkrCrVtRmT7S74NWK5V+mYWymttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764083; c=relaxed/simple;
	bh=IHoy1oBggMFnLfKoeLbTx2d3XJ5sGNyUv4H3NdcBGsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7ObID51GSteX6vs8A26mWB9BUtDXYbvqgzj0V+qI7Mm5N/6OVDeRJDm76HAEjAhzoc1reFjMG28+P/aEKm4RYw284hKr0oJdB6ZFHbWvWRXudkeIY9UpJxISAKBmXBuzc4M+ZDwVvVghBmoANk5fOB1NC2JeFO2IB2ZzQapUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ry/0lPeh; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ry/0lPeh"
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e6df4c443f8so725549276.1
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744764078; x=1745368878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=We9hYP2a4j/pz4Al55wunw35Rf7VsQ4yD4bT1cDaqGc=;
        b=Ry/0lPehAqJoa4zDERgGq3r+2jWclQfqaVZg5M6qClsDZLKapwgItnaWi2Ki9fvzLU
         BTYdXccnvivy/1RIqwT3QEy52D7lv80F1pDDKLs/AYzdnjTERalSHRrFe/mfGSu44/Lg
         jFH6E7hqxoi4qP3D4XX4GY7qZYT4u1TOQNgV1zK+uuR749VEzYCGw62Jexowdcc37DeJ
         MNPTawdTbDhKbY4+PVPZnqMG/ik7nDXJdyG7hI8pL76Y2CZ6JKY1TjlhL/8VL+QkijIp
         TF5XXAR3NCPzXpP6/af42LM7vqLuYNq3zJmI1cREwEiPJIB8mba6WiGNSuUdl+u//FId
         zlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744764078; x=1745368878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=We9hYP2a4j/pz4Al55wunw35Rf7VsQ4yD4bT1cDaqGc=;
        b=cIptS7JfgUGcYX5FoQVe+ceWdFV+67D4uCTW01DwzUu2Y3qU1gdLc+oatQxZWtXiQ4
         rdG9BnrYjYi8saQKEhtp3EL+c7g7LRsCe3+zwZdH5jtAQ3gkqW25i17On991fGrqqHUz
         zOrMuEsJfvM/hWE6sBlRFissSx3BR3/HD4y5QKp7pds/gpMzNvNGZAEg9PHHXb1JRQVo
         bmGt24pOK1NXRUw2ua4UYH+q632YGSM7ez+ZnPzAzn/jFSVvLxEdsHKwl34robo5fgAD
         1bPKcQPIyalQ2ZCQnOZ9hujASNUTcV17p3SKiLSGXnatqRr4i1IedTIhPjVbouGdhzAc
         ejkw==
X-Forwarded-Encrypted: i=1; AJvYcCWqTSJXiI79fp8NRh0S3tT2oc2IHtXVjA3dvZvX+mZI96GwlQ49yLF747jql0hG9ZUJJRQKpnsFuyzcBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7NDe5unHbFpZyicDjdODtK7P7d+nGR7owAKqgdRQQDD7TnD7
	uKFiRjxyo5uwTuXFNfPRM2Eij9xdexzNswhhaFSc/X6kOT7SkkqI3PsxxIBEjA/pVUOBHYLnvF/
	1vkCFKYLmt0BDGi2mInRfF6g/ah9IVjqcWLxKEV9wXgO49rKs
X-Gm-Gg: ASbGncvVqgZBnsZ1Q5LTlPA7IuZFLN6qkzkMcyrsqyLRz1dyOZxh+2qVhpCJx+bnlNr
	uG7tQY0aws0JcR/+TVTWnlU2VAN/Chse1kqIQv/d7oI189vmSC3HVh2X+TDjyXr44AXlABUPUMj
	2/Y0v09E9oeOBASJ7FotQZ0JlXRi1/14hbO3Wf9W7AzMHWnniRODYfbJB7jVrax3txgxobalsxN
	vgfVz4RyJIhyjNFsSTrkAM+auO61Q9eOp1Y/JZ4PDv8S4QBkI7j7C6XtzBIfN4N3dIvgOVksMFG
	UFVCrRqWtaVMDrcATSSpytDeJv7kbA==
X-Google-Smtp-Source: AGHT+IH4eWSJkQrrpBMlanNtR2s7qbUIU9WRo2WRGrWkrS8v/Qlmkd9wF65x5vFf0yGNqHGBVulqkmf+MiBv
X-Received: by 2002:a05:690c:6610:b0:703:b7c9:ec05 with SMTP id 00721157ae682-706acecaa79mr9212117b3.3.1744764078276;
        Tue, 15 Apr 2025 17:41:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7053e0f432fsm6373617b3.12.2025.04.15.17.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:41:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 538C8340237;
	Tue, 15 Apr 2025 18:41:17 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4CE62E41852; Tue, 15 Apr 2025 18:41:17 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y
Date: Tue, 15 Apr 2025 18:41:10 -0600
Message-ID: <20250416004111.3242817-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CONFIG_BLK_DEV_UBLK help text suggests setting the config option to
Y so task_work_add() can be used to dispatch I/O, improving performance.
However, this mechanism was removed in commit 29dc5d06613f2 ("ublk: kill
queuing request by task_work_add"). So remove this paragraph from the
config help text.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 2551ebf88dda..e48b24be45ee 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -386,16 +386,10 @@ config BLK_DEV_UBLK
 	  io_uring based userspace block driver. Together with ublk server, ublk
 	  has been working well, but interface with userspace or command data
 	  definition isn't finalized yet, and might change according to future
 	  requirement, so mark is as experimental now.
 
-	  Say Y if you want to get better performance because task_work_add()
-	  can be used in IO path for replacing io_uring cmd, which will become
-	  shared between IO tasks and ubq daemon, meantime task_work_add() can
-	  can handle batch more effectively, but task_work_add() isn't exported
-	  for module, so ublk has to be built to kernel.
-
 config BLKDEV_UBLK_LEGACY_OPCODES
 	bool "Support legacy command opcode"
 	depends on BLK_DEV_UBLK
 	default y
 	help
-- 
2.45.2


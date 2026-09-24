Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDF41A79C
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243376; cv=none; b=t2dYZ35mwLdkhK8s/MI5fK8zOGbosbstQ3Mg2cgAAi33w0lep7r2q8dWw3VTaQglM2T68OGF8jBltWu6LmXwbzfSKOkxIPilfJZQrm8Gh6LpJVuoC1EdfoRUCRcjVCle59cRcsZIkOdVIdU1njgb6HmSFTwGGV2L5VKqYpsQfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243376; c=relaxed/simple;
	bh=6AxHVVl+gZTn8j7aNuoJz+d9M/a0mR4Yz8N6BMkLiwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVRa7oE3zARBOETwuDnZqvTRwSJdmwCuZqxO+UUv4rnsPmAu3QG+ll4hGidrQoPQsA8bHv6ngXL1qBOEP2gx2Tfjg2CnxUiIsrCJLklpEdcsZniB/VnNfxsQ/Np3R0vS31rDZ+0xoXlZkkCAGCcR+OYQNNBj4VfeyHGdpIF1cDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350faaso1194488f8f.0
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 02:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243358; x=1790848158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wBClDNoiMcfukXqTKxUO0O44/6vZOeXszispr41Gs0A=;
        b=tdPdSvb5CfVb18s74uaQ2NOANGxVixzgdF+Ins87clUMAP31qOBI5XO2uEyZbt1IFu
         mVEhOb8zOf5DzRHceTXFLHGMK+wb8UMilud2mHguNSn3nUz96+SS9s4ELaqTSrpchg9X
         NWkoRQbHjCrXAc3CXS6fiiL/I5l7xAV9BZXTkN+63Dlsarpx7CzIsxmvLCDpr6ndK+Qk
         FOXOuUp6xsNVaGcpWE+aUydHQ6ccuryCA60vPpzQL7lqIaq5Ui5eLnV38O7OCesiKvDx
         vjRTp7a7yDQriejgFlRGoC0iNtxL2BJzH2Bt3p/FjtbQPTnKw9v5wremOLJ1aWhUQFGe
         WA4Q==
X-Gm-Message-State: AFuF++ls5LdDckf/Y2wWKu0K4vPP1ShxBMuiFw7RjduA3v+lHRwA4VCZ
	v5+nDD4clTyqK1ZSHApA5iMRe8+ww+cq4F9DHJWicYPQamoWiy/BbJChYl05aQ==
X-Gm-Gg: AYBFou2nbsuoyFK6isPUrGSpqZs/BH0MCK6mlmiyEuhuqVNS096AKk2WOoZUhoaAOH/
	5pCxMImeR638HYUvElGHHUU1gQ6MhMm5bdzyx9CO55A+RBtXp9BydQ9c2N/J2RwKyBzwZqqWDwB
	ZpEpNmuxV1yUn/cmpCjJzuPe5/SHt+PKXcS7VQLhGkRdzcZmdsg/QalVLjtT753/JVjSN6WYpN2
	p2lPphvQO4fQvGqaKFgrJrWgmn3nMbpO4yNjhUCwd7lOkINBDSnZDMHfQb237mCOxHVdNrwb9oc
	HQtZIqK9rJaIDCmrO8v7BIcVPtnYtxqFHtrblToVxayhRgZf6Xr58QG3HA2ydMuR4YTX9SKTnYY
	AS0zj+HTUamz88p7DTP45crAbF9gHgJMIE9+8rcohqlNtRI6v6CUhxy82wNV5rgliNfVJNusQ77
	kEq8vrSHOgnCaHJ2LtgrmeLdm/BNcWyN2vplSKOJaEHeBM/j95hI8hYq3aTLU=
X-Received: by 2002:a05:6000:2584:b0:487:8ec:1fc with SMTP id ffacd0b85a97d-4887170d3f8mr3448462f8f.12.1790243358351;
        Thu, 24 Sep 2026 02:49:18 -0700 (PDT)
Received: from white ([5.194.185.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4886876c027sm14791908f8f.17.2026.09.24.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:49:17 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>,
	stable@vger.kernel.org,
	syzbot+874c2707f97fac24b090@syzkaller.appspotmail.com
Subject: [PATCH] floppy: don't store a stack buffer in timeout_message
Date: Thu, 24 Sep 2026 13:48:39 +0400
Message-ID: <20260924094839.3239569-1-efremov@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_done() formats "request done %d" into a buffer on its stack and
passes it to reschedule_timeout(), which keeps the pointer in
timeout_message. show_floppy() prints timeout_message long after
request_done() has returned, e.g. from result() in the interrupt
handler, and reads a dead stack frame:

  BUG: KASAN: stack-out-of-bounds in string+0x39c/0x3d0 lib/vsprintf.c:720
  Read of size 1 at addr ffffc900003cfc70 by task swapper/3/0
  Call Trace:
   <IRQ>
   ...
   show_floppy+0xb1/0x45f drivers/block/floppy.c:1838
   result.cold+0x2b/0x30 drivers/block/floppy.c:1183
   floppy_interrupt+0x191/0x340 drivers/block/floppy.c:1755
   floppy_hardint+0x1a7/0x200 arch/x86/include/asm/floppy.h:66

uptodate is either 0 or 1, so pass one of two string literals instead.

Cc: stable@vger.kernel.org
Fixes: 73507e6cd8dc ("drivers/block/floppy.c: remove unnecessary argument from [__]reschedule_timeout")
Reported-by: syzbot+874c2707f97fac24b090@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=874c2707f97fac24b090
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..02a34de69102 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2276,11 +2276,10 @@ static void request_done(int uptodate)
 {
 	struct request *req = current_req;
 	int block;
-	char msg[sizeof("request done ") + sizeof(int) * 3];
 
 	probing = 0;
-	snprintf(msg, sizeof(msg), "request done %d", uptodate);
-	reschedule_timeout(MAXTIMEOUT, msg);
+	reschedule_timeout(MAXTIMEOUT,
+			   uptodate ? "request done 1" : "request done 0");
 
 	if (!req) {
 		pr_info("floppy.c: no request in request_done\n");

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0


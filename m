Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C436A36B
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272712; cv=none; b=kT7EKN0vVynuC6UR8iJN7dweJCHJiV07K5pSTGy5y0S6r/OvAlySKq2EIZypVRgznBMi4s9ivL5g9djC8ko9yao9rLAAjQ2cBY8sMBW6i9HdpoAWW9nyUTWpcQAjY51kFPSM3OhUpDD/R9vqKRr+QYcEXf7Ev4nK3uCBTIMhx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272712; c=relaxed/simple;
	bh=qoRZ05JJwklOZtnBZMCx4wBgFBttxH93P3usMiYSZpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7hBZ6/k+SwYKalXJGs/RLLlx+O+oFUKe7gdDSo35yaWNGy8Qa4wU6gulcgrUmz654F6hB2NV2BkQglfF7lHHKTef9LrwCgTt514bIdp24+QwouzhpNEoKmOk5aG+A33d4YUyUtxNuIb1cWhZwfzUz42lPHgz5gKWTOk3KI6/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W73kZnnw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W73kZnnw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d5335cf904so46334485ad.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272710; x=1788877510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JjrwEkCbmc0MKU+e4rFJ/zhohW3Jl49TSFk12a1syWE=;
        b=W73kZnnwRe7gBh3KEwV9LJ4urVEEQefhex032LDO+2d6oDsr3bmz9dNVvj2+731JzB
         pl5DgLb7fhdzvBu6I5D+9jz74esjW8ZD7W02OSSvnuiTA/91O7lipvrUONY8+K4A2EUu
         UPgbfo1xovnJod3Tnb0x9gm/ioaC+yWVAAKt6QhLOFsLsZ/gEqXOI5rVZ9e9DzlJtma1
         gGhpoT5zwljx3YBXaiY+0Mji3cNOH9senoepvRczMo50vT+8enh/SfQiJ5DVDEJCp6/x
         wRxQhLD0Vm5F8jVzdQe/KQTUb6Wae/7hP14y6pJadFrWKUi6kTdurF+fLm2rRa+dCHXa
         Y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272710; x=1788877510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjrwEkCbmc0MKU+e4rFJ/zhohW3Jl49TSFk12a1syWE=;
        b=PoX1lw4Yz5F4YpTdztcfbqLtfO85doIgshH5aKuG1yT2sIHZ7DHwa0jiFm7N31AH7I
         ZAuTOyD/fmsPIDiGMgMc56/ANuCPsgesGwQLy44w0WQZoygESU4sI6O4i12kwDvxEKGh
         Ae42QekzUj6yNwrQe33b75bmm692LghwDEodaSwu4jM/xvzZxnfsQ1MX4jhHUwWN+Ec0
         eWoQl7oJO9nnCIg3VrKfZ7xY1MkWH2i0/O/tlv+TuSl04GHp2mi15XeXOrUG5MwGV0Ce
         NhabbgcUgGjVrvk/EoVWqBTi1BwO1IJshBOyiW4oajRHziOmpAaxz1KwnnEx4NDh2lg6
         IbcA==
X-Gm-Message-State: AFuF++mbMMy5FNM4JQd/PTUQRySQ2I4ZrOIXg7WhRWq4Yk8zumncCuCp
	h4rPfvCuvxlUdn2Tmq8gBIJSqtj/X4SBY/WLcpIex7dN4H/VhIkp1EAT
X-Gm-Gg: AYBFou074p8gOMVYAlWUgZ9hysf3Gq+EvJKg4PTedaIPOG9GTKarxncDOY8ghUc2R+H
	3kTjjSTQDmfLj95ibLwiTr84aJrbaqKs6pvIVdN9yKx5X5fv9tn97r/urgMrKh6b9fB5aWEvyom
	qFgKF9P6flaMizfuvnitqBYkvk3tGR2mUtYSOprnVJCG45/D2b4NwBTGJj779ANllA+pN7M+wMJ
	yG5Pa59zNF3YT8a1V3qDvT0weqIWj4snq/LE4/8IKZkxuPMJ/hqLc92PIFVBNVnDrwBs9lkEGkP
	PKZ/xPykBlxlKz9MmmLjkLR6s+CT//KyjBeK8rkTkEj848h6sjDgBwnvShPjndVwd8R2K27Lv3X
	EDJY6vZMbllGzYf7zYew3bAhH2tmBT91Qxs9IPzzbeFWE5zFg1A9gUV/e4eq1l32doEEGSbvyGv
	/65m/tF5kI2DrCPtDc9DFsE8ozR0TbOeOnT3yQNnDe0NO0hkYFHTqJyZNLzw1xO3Kos0e4AqcV3
	nIw7seXVFRnAEST
X-Received: by 2002:a17:903:2f0f:b0:2d8:d4cc:be65 with SMTP id d9443c01a7336-2d94a905007mr121238475ad.18.1788272708865;
        Tue, 01 Sep 2026 07:25:08 -0700 (PDT)
Received: from wokron-navi.tail1fe8a3.ts.net ([219.143.23.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598bfa51sm52655845ad.78.2026.09.01.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:25:08 -0700 (PDT)
From: Yitang Yang <yi1tang.yang@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Yitang Yang <yi1tang.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ublk: add missing DEL_DEV_ASYNC to unprivileged permission check
Date: Tue,  1 Sep 2026 22:24:38 +0800
Message-ID: <20260901142438.237586-1-yi1tang.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ctrl_uring_cmd_permission() is missing the UBLK_CMD_DEL_DEV_ASYNC
case, causing the command to always return -EINVAL for unprivileged
ublk devices. Fix it by adding the missing case.

Fixes: 13fe8e6825e4 ("ublk: add UBLK_CMD_DEL_DEV_ASYNC")
Cc: stable@vger.kernel.org
Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>
---
 drivers/block/ublk_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6c5bec7da97c..ade5d7fddd9d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5716,6 +5716,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_STOP_DEV:
 	case UBLK_CMD_ADD_DEV:
 	case UBLK_CMD_DEL_DEV:
+	case UBLK_CMD_DEL_DEV_ASYNC:
 	case UBLK_CMD_SET_PARAMS:
 	case UBLK_CMD_START_USER_RECOVERY:
 	case UBLK_CMD_END_USER_RECOVERY:
-- 
2.43.0


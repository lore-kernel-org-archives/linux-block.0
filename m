Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3D480951
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791630963; cv=none; b=Ri2eVOoNE+IGO3vfvabVE29CD1Adc+NzEvw31pD1WHHJ8/jAeY4pIZKbp4jeA1iL+u6dGyxdUjFWkx4bFYL3xN05da9AAh89aZpdPG8OYtXK+rja0VeX5VVLwsvk7NGflillQo/GLFllP6ZGbq/vsc26TRaX/bmvJOdt5Ic+7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791630963; c=relaxed/simple;
	bh=5CzusKcxVyXaR3QsGDMDR2qgmjRv/fJBLlwlaaARS3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPXbr2XI30ViNXAb/+lpO3wkaI5TFFFsiHs9VushatQ4Qc0gdHQCb6W1fT0OuugF/uibBJmS9G8JNJWnXz1aJgALyewOVAnQTYSDFm+n/iFfpYsuENKwJR3zS6ZfqgzuJof76VsMtm+iBKZPrn716h5pzjaz/k6QCA9MhPLRlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c9995ca60so2584228d50.1
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 04:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791630958; x=1792235758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FLKHNVxY/mArmCUsnuC+Ob3WlxaCdcNFSgH2tcREQM=;
        b=e54hvTxf5yO1XCLy6N+fjECFDZzsf0MNUZDW9sM7U4C25BRlPToHd0mEK8eztvUj1N
         hW7EovQ5rBANwLxZXRMFWq65m/NptSvYR1HYgyXjSAd43lWgnWrjq4mIaD6I4eXlgF75
         RzLoKNvihwLzLsPwKmvjIUlVO5k3eRHCt5YJbFN/kdwDPyYVV0cndmuef/6Jzvr2oMPj
         BUKP+b3401PbwLR7/beO6ylxw3bMWUY8d2mG8xJT5OLl+dgEXKxbW/mLJIlR7WWX/+Kv
         /fzMnRDKdR3c7HF5MZKsgTyJqR7pmYUKnv6ygrFjkeQshhpxAopovdMgWzaan35Z7Sw2
         P6OA==
X-Gm-Message-State: AFq9FYKzVp/87z+q2BpzQCo4h9N45Jdiv6LLfUfILQap5TGMPlVRh6yD
	VGrWXxwLS34onVbhbkRQV2R9S4nLRTKTB9ZqNNiElCD5Ch6lJrutAFYmtHNTGgtqibQ=
X-Gm-Gg: AYBFou0f/mFetaqIlwdOWLFjL/LqkxfyOs1H7gTmFuG03WLEL22usVce6V8xDXd5oGp
	5E2MSATyzpquR1Os0weX5dzna3kp5KL9VJPoi2vAUC4nSA3RUsRb0AvoCEekxnjOpaP1bnMp2wv
	7RpPENKi6Fo+IKyHeKUKH4iLUXpNGfLmHvlF8SW7D94dpyC3Eiwuj7+LqUSCbwXV0DqPGrE4siH
	UCGdhShL2GjAh82kR8HYYUV4fOdgr8n/fLqiql70rw9Tk1TCh7Vn3neH5plKMe3k9pZQKUTGOB0
	oxyh3lUhczjRuVYDwxTI0ioiZRwQarG1573t/F95eBrvSWhB8tuLeo1aSR/3XohYDkwf6f0BA32
	llrjNe0uIjcwyx44KBh7TqnyZIutrwhSTZOXu/4hS7eJZXpLy2L43uP7ugtrlcp4xGPoBFrecNC
	JC+kNUso/ABZ7vz3N7W/R8qlrzSVoRFPhDsw2jRR5VTO0ZrkzTBDhDwj/50goBEhHbF4s54M1oI
	yBaeAbzWjZJzN5xMSsAjvAVPns=
X-Received: by 2002:a05:690c:4990:b0:8b0:88c7:f184 with SMTP id 00721157ae682-8b088c7f2cemr9045237b3.4.1791630958518;
        Sat, 10 Oct 2026 04:15:58 -0700 (PDT)
Received: from white (bba-217-165-185-173.alshamil.net.ae. [217.165.185.173])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b07f25ae62sm17263837b3.43.2026.10.10.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 04:15:56 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>
Subject: [PATCH] floppy: fix the message printed by floppy_set_flags()
Date: Sat, 10 Oct 2026 15:15:25 +0400
Message-ID: <20261010111525.1337458-1-efremov@linux.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

floppy_set_flags() sets the flag in param2 when param is non-zero and
clears it otherwise, but its message picks "Setting" or "Clearing" from
param2 and prints param as the flag. So floppy=thinkpad prints "Setting
flag 0x1", and floppy=0,thinkpad prints "Setting flag 0x0" while it
clears FD_INVERTED_DCL.

Swap the two arguments, so that these print "Setting flag 0x80" and
"Clearing flag 0x80".

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..b6f73a11bff4 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4321,7 +4321,7 @@ static void __init floppy_set_flags(int *ints, int param, int param2)
 		else
 			default_drive_params[i].params.flags &= ~param2;
 	}
-	DPRINT("%s flag 0x%x\n", param2 ? "Setting" : "Clearing", param);
+	DPRINT("%s flag 0x%x\n", param ? "Setting" : "Clearing", param2);
 }
 
 static void __init daring(int *ints, int param, int param2)

base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
-- 
2.56.0


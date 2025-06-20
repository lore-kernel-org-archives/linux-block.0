Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343D634EC
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432219; cv=none; b=EjusFPjdcHkGuQ27OVXKIMroYYZhrWPyDZECe+n/6nGeM/t7Y4E6RaD6/dCyJ84ruxW2puWz8oB1OhMKD6TeVfM/4MpHLfmvpEuGaOGr3X/ymke26n5QO55Tlc/Yt390FvIuvrrZjcBT7BU6FSepEXP8gh9PZs2+5trGyo8swWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432219; c=relaxed/simple;
	bh=1lpUnXsGfB3WAGdZ/la/vV49k/o7hmxGXP07HMo5pCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYOuAM0SvJu3qWZBy0SezpXrnvGp7XcMIAirgGjQ5F7ntyljFTL7sa2//K28RHz4pP0tgR8VHgusX+jFaQ2Af1tuDfOmjXyBWcZ0RzyQ+825+36eiwFsqHU1nBRZ2pZKKNQVTnn/ZDbU3IQoj3X6+TBdf4lh3X7di+i999LWUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fvmV0ALJ; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fvmV0ALJ"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4a76de215b6so1907551cf.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432216; x=1751037016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBliFS3mF/y0wcyfKQli/rZwXniCX+HgieNcqZNB1+k=;
        b=fvmV0ALJ/KhwgzN75TOWrCcEv9TgBb9gFmN4DnoxmGxIWK0iindqH0ux1GzNZDGTTq
         DsEqaRSWsk4aSGBy4nA0IZodvB3kYr78IT7mxuhd5Rxjy8MNw7CKknoKTtc8X3GbnUr4
         Xgfbw0sq4FXviUlplmy1BpHtKQ+eptP+2I9n8dXhhGDNTz9LDe+oNL6MQfjlKWNHHtjc
         IvcNLppLJSpQnOgd0FzYkZzqJixbEYv2EM9AirkNxGEZDVMS+jWzIjKLzfE+/Vf7nYxi
         rIjEbrE5BMI9y3hWfB3t8CpdG21h9mnRx1uHG8IuXtcM5vY4c0it0fyS3DyyLvhiBCzq
         bnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432216; x=1751037016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBliFS3mF/y0wcyfKQli/rZwXniCX+HgieNcqZNB1+k=;
        b=aafslnXxm5vjO8bsVrXhC9+oA50C/FGywQLW+/RgKHBbSgcF0n0n088WmgmIoY89Zc
         aVyn3pcqjfycf6FYq7+Zlpbrrr40nVye6uOuI6Q5hNTbEsmG69xDTz1xqHPPRrcGnbP+
         n1DSc36RSAhUZ1doIjX8ugg6l1A5LuoMhfkAp3e+2CgEDxrBYb3J4gSCPJY92ugYE2a2
         l/Tdof7Os0Lbow/fPrcSZ5YdkIGScZtSYWwSJn6FIaBedKEl+404O612nXjPQNOhXX/1
         57DmWsppWA+B1FoOeocWreBevQz77BNBZ00SUn1ovPs0KYSPRpF3g9aRodG9Rn9wjSZ4
         Epmg==
X-Gm-Message-State: AOJu0YyafCvadqGFQebHYu4/evyfhWW+5i3kORAWIMGWUcmJH4Zuurav
	KtNXOHQMDhL8i7dI0ZYr5X1Pnlz7Gq5vU2n6kYP1vtxEohXWzWImLHb0iuSQTNPwfWkYAD3K176
	Zl/w86yc4UAV1fQJaMqT8V3aUw/P+6/uQBjWVEPilmm49iByL3b++
X-Gm-Gg: ASbGnctg6vehFK7MmSPjBsg3jGzSosjQC/mJQnyw/yd+E7+B2trFei7b8+AqfnfFGQ3
	ryAQG0jeKBew1kmtdfuS+Xt791UBIcQE/wPee4ud0a/6O2mZFplnLjj6Jjzi5P49zOT0JZA049E
	Oa+bsRdJjs4rVf7XWismBPUiiNAAP5UrLuNrzfON36GPVO/tBE7RrupCvvcXckIJdmV8mA76lXE
	PeIUP0VNApMeBKfUcjLIjWt+JvMtt/Mu7efM9lueaPePw+fdNjVt+YU2v3FmhUmT7SDtJeu8YHR
	IMw8RKSwRtEXVkaVY+qfpnt/kVp10T6TB3saaDSu
X-Google-Smtp-Source: AGHT+IH7Lr3N0UoZflwqk0HG35nSts1DBMaCOeg9OTAG8ftFWZHPzQIT3dAKEglbQKYz1j7KoZw2Cc3ni4Q9
X-Received: by 2002:ac8:580e:0:b0:47a:ecd7:6714 with SMTP id d75a77b69052e-4a77a22ff40mr17808711cf.9.1750432216182;
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4a779e6e4aasm720201cf.9.2025.06.20.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 381D63403AF;
	Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 372F0E4548E; Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 05/14] ublk: remove task variable from __ublk_ch_uring_cmd()
Date: Fri, 20 Jun 2025 09:09:59 -0600
Message-ID: <20250620151008.3976463-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable is computed from a simple expression and used once, so just
replace it with the expression.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8df70a5fb129..7635105c1596 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2172,11 +2172,10 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
-	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret;
@@ -2207,12 +2206,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		return -EIOCBQUEUED;
 	}
 
-	task = READ_ONCE(io->task);
-	if (task != current)
+	if (READ_ONCE(io->task) != current)
 		goto out;
 
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
 		ret = -EBUSY;
-- 
2.45.2


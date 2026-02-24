Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9F3A641B
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948664; cv=none; b=DYDXvspLom8skXzr6G9+Bo6W0OzEFmfGg/FgKa1SOjpsf4egN1gyiwdsLmxOtEbnmpkpt+76xpogpAq/unPKOsoJpeoUWuCvLx3dIRNHjF8ZKN9NAbkQikoLROXds0RMOpoLvE+sFOATPuQJvTpbWUX4nzHMRY84lEbL3+PTn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948664; c=relaxed/simple;
	bh=kua0dMOa1KKrMDsLYutpadgHlL+5mZ2m7xXOjwrYqEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4NPEYeMy071+zC7k7rKzhZbimqnerahxF4L9qQAI7KmGyA3wWYT1pGcR05Rx20IrJwpnvV20xQ4S03eHTwNBiKbQnsDBI6fSsVobS90Ry+muc/+h27Ez+L5ePx/TYz9w7dy09DO0YTMOg1w1MvvXbSSwOzaCXzdQTc1c/bD5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dnH5ddUF; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dnH5ddUF"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2aae38670daso4884445ad.3
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771948661; x=1772553461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy1fELu4btboyO+hpI1XroaaE7BCW4a9Mq60yzvaGxc=;
        b=dnH5ddUFrEby7A9rfSQYjW4NqHOThaU/vhJze/CeKieujyV/zwl90krgv1Mg3CTNHu
         bQqwEkv0svZ0xILkZFXinDXs+WKR3fZ8TsHbHuOhhasOKWQ2e4h+zfA/SIQoAK8OodBZ
         z1AllLtWd6BVCzjUpv1xP98yiKG19Xior25D864McHJmlfiCpdPXjMIzyFTbRvAFRV4Z
         Zn6g640VJtzYGvXt9fWv7TOObZfyZzXhZ9cm8FN8iO0CUnDd7widhcofYqL4K8EHSKWu
         wSyJwkZSQBptLaJ41qXkT7Lh5io1zd6Phhzd9f0zEKssilA4sLzwXQfyJZccE80Q5RTi
         mEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771948661; x=1772553461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy1fELu4btboyO+hpI1XroaaE7BCW4a9Mq60yzvaGxc=;
        b=kDC9ylhn8InvOqSPigMOTC6wlxTmfgquZ+SK/2ggr9oUrhdpBT0RReBWQqXJd6YMnT
         maSFyG+sqhT95TncE340loX6oVIRCwGIpjNBFEZ/mc67HPn2K4+9lObwso/1S3Y3Uivt
         X5Knu9I+JdItcmzAQjNEtMyhqL87+brNbsITZjaKs3QgllYyFtKhIaGbkhI3+acMgguy
         PQTeNbd8Y6bfry56SSm7PygL2GmJaRcEneUQO0SmaOGxbXRSA/2a/PKWmfcTQkJTczrd
         2JYFMxmuthzbuakYMIbMiYocru8qpfG8UCEHfdEt7+l8OcoKiKesK0ClgsPZllUNX0A5
         XEQg==
X-Forwarded-Encrypted: i=1; AJvYcCVX/xHzFqocOJvxP8KVMRwiswWuNiw27AmexDJ8JsbZI24/1vv/IagMpULKoHhP9TD5K7MIIgkQw/xk3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOF7kyz5YnqCV1VH7iqzysK6f/f7pfXfDImEqQHjdv4NluUPWv
	ghor9Uhmc5jr/ml4p/TTkK3NR+122FXMmcJxouZKEGHYoTLsrYxAsiDBcRY/Vg7fmB06xPDpwCm
	Se1go1nePZzSf8lmThCBfzhUX4JY4iBqVdxYA
X-Gm-Gg: ATEYQzzFyV3ZJKw/KHpJJ2ZwAODNXlp49Vc04QoJCEl5P3WN33PgSIw9/RNiIH8EZdH
	Mg3Z71FFgj8Mp5CrV458zzbod/+HETQKHTGwD+XhlAdQiJdsKnqZp5zHarob/l+dZ1I89L9tGH+
	IOWguvTdUaGrxL/thhbLQQ440RmyiAohXex7r4yzcgxAuo/4gv55GzLwxlImc2NcPTmsFWSnumn
	/UDyZJFLRTVQY8Y2arO/eskuE81UYPAX8xxWF6HLTipPpAfQSDsQzSjDrnBTUk3I7ODBulQ0bXf
	m3496RZ6t2AMyTOJYszW3BYMfxc/mo1F5Ta/dPrOzsLmw274TM2EVR4YqIoD61HvoMcTLCY4grI
	c96mSoEL/WACI1wfkm721ZFhZD+AZpyW1EYW+LcxMlrj7Fv02b70Xtg==
X-Received: by 2002:a17:903:2f87:b0:2a0:992c:1ddd with SMTP id d9443c01a7336-2ad745498femr82078195ad.8.1771948660899;
        Tue, 24 Feb 2026 07:57:40 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad74e18969sm11883255ad.19.2026.02.24.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:57:40 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B658934051A;
	Tue, 24 Feb 2026 08:57:39 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A5FECE401BD; Tue, 24 Feb 2026 08:57:39 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7.1] ublk: report BLK_SPLIT_INTERVAL_CAPABLE
Date: Tue, 24 Feb 2026 08:57:22 -0700
Message-ID: <20260224155724.3142007-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ublk driver doesn't access request integrity buffers directly, it
only copies them to/from the ublk server in ublk_copy_user_integrity().
ublk_copy_user_integrity() uses bio_for_each_integrity_vec() to walk all
the integrity segments. ublk devices are therefore capable of handling
requests with integrity intervals split across segments. Set
BLK_SPLIT_INTERVAL_CAPABLE in the struct blk_integrity flags for ublk
devices to opt out of the integrity-interval dma_alignment limit.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 004f367243b6..34ed4f6a02ef 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -806,11 +806,11 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 	set_capacity(ub->ub_disk, p->dev_sectors);
 }
 
 static int ublk_integrity_flags(u32 flags)
 {
-	int ret_flags = 0;
+	int ret_flags = BLK_SPLIT_INTERVAL_CAPABLE;
 
 	if (flags & LBMD_PI_CAP_INTEGRITY) {
 		flags &= ~LBMD_PI_CAP_INTEGRITY;
 		ret_flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
 	}
-- 
2.45.2


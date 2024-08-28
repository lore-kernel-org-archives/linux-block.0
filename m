Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518E15B99D
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833790; cv=none; b=sw5nhE7saYIBR5OjxzD3VsBfGPngFLOCCqMf2FrNY37/uz1OmEEz/Dtw9SSfsw0GBh4GO6ALic5sPvDe8r+cFcui+g3H5kD9frywZQ3LS5/XqCzncCcT4tenuq5Nh88f16xRlnkrHqeSURNv4kAOEABnbTa0+rMvam6PmkxreCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833790; c=relaxed/simple;
	bh=lH0JUoaogPNZeArNaajzdEVnjxOdXb0pQ9xe5QMFhqc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jmuDKs2mnO/68GCqm3tbd35pMcrHu9Tf1GOwC1K7ID0DRlkpGXzRkgNbJ85B0dTG3yL/cjRloVdmmpCz+Pm+clyc+irzY2w2678f5ktLfk9UyTDg5Xwcc6UCAXKafyaHeVVlwze74eNk0RfSbzKu2xr9Y2/+KjUGXWuNsnG4Qqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SW9r9xMU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SW9r9xMU"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71446fefddfso3672832b3a.0
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724833788; x=1725438588; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxhRZ1h+j0dbjbcPThYnjdsx7lav8ugYYLKcysaTxyQ=;
        b=SW9r9xMUO/P0E1uw+8yEwwZYwk3801QbhD0XCt+jiq7Sy80NL1u5rJYOU//lWO7dK2
         qfwzk5otlc3C4/8jV+F0Ql8KNmTpb3bTcdlUMjwZ3VMrDAOnjng0lDqhSqjBce3Ny9QG
         2YBaP1g7z2IxhTjLgtSW5NwwLfQMyKLpuc7Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833788; x=1725438588;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxhRZ1h+j0dbjbcPThYnjdsx7lav8ugYYLKcysaTxyQ=;
        b=bTLx0KbTuSUiLLxfZLIGnifEogYUG2TLWZe47oo4se1k5vNagHPbzlp7Lk2OTCITLh
         mRnzQ3G7jWPCaZ7TnUYLGQ4LkY+SHF9/vpqltxHGJ2xx3tllAzz/dPH58FLjb7PVTRCb
         KUtEtZXT+8ySpmpBMTT9ZcagiN8awljMWacCIguWobAvzBlhuqQYLS8OvQ4e2LcHUKL9
         hccxbCj2boLkdfX70+Z5BGgNcQdzaSFTn//Qv5jVhmscqHgyfdlZjOeqvAuu3lZyyIdJ
         uwUdvpvpvXEYI1twtDDeB6caCwiLbJ6kzEQcj9bJM+X7D6Lb+77MP58mOArtnmsyZkX8
         At3A==
X-Gm-Message-State: AOJu0Yx+061C1eA2JV5M0xS9EqCWjCQlcXVpZpLivh8RaRZnVVr1ue3q
	IDFI0EVh1PZ8T2mcuu93YrpQfEWQ5v+5ZRb3s4RaG1yCk02YBrOYLxQE6Gya0w==
X-Google-Smtp-Source: AGHT+IFjEjdpgIEVnUhx2ej6u1HsyozqDRSPIdIIFfYpkP3l/Nxh+aH6L9FcUI8iawXwDrUfbfJctQ==
X-Received: by 2002:a05:6a00:91cf:b0:714:3831:ec91 with SMTP id d2e1a72fcca58-714458b2fe1mr16370822b3a.25.1724833787768;
        Wed, 28 Aug 2024 01:29:47 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714351aee05sm9856257b3a.91.2024.08.28.01.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 01:29:47 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: axboe@kernel.dk,
	niklas.cassel@wdc.com,
	dlemoal@kernel.org,
	hare@suse.de,
	martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com
Subject: [PATCH] block: Fix validation of ioprio level
Date: Wed, 28 Aug 2024 13:58:15 +0530
Message-Id: <1724833695-22194-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The commit eca2040972b4 introduced a backward compatibility issue in
the function ioprio_check_cap.

Before the change, if ioprio contains a level greater than 0x7, it was
treated as -EINVAL:

    data = ioprio & 0x1FFF
    if data >= 0x7, return -EINVAL 

Since the change, if ioprio contains a level greater than 0x7 say 0x8
it is calculated as 0x0:

    level = ioprio & 0x7

To maintain backward compatibility the kernel should return -EINVAL in
the above case as well.

Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 block/ioprio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 73301a2..f08e76b 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -30,6 +30,15 @@
 #include <linux/security.h>
 #include <linux/pid_namespace.h>
 
+static inline int ioprio_check_level(int ioprio, int max_level)
+{
+	int data = IOPRIO_PRIO_DATA(ioprio);
+
+	if (IOPRIO_BAD_VALUE(data, max_level))
+		return -EINVAL;
+	return 0;
+}
+
 int ioprio_check_cap(int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
@@ -49,7 +58,7 @@ int ioprio_check_cap(int ioprio)
 			fallthrough;
 			/* rt has prio field too */
 		case IOPRIO_CLASS_BE:
-			if (level >= IOPRIO_NR_LEVELS)
+			if (ioprio_check_level(ioprio, IOPRIO_NR_LEVELS))
 				return -EINVAL;
 			break;
 		case IOPRIO_CLASS_IDLE:
-- 
2.45.1

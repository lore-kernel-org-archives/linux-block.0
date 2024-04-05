Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB879E3
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336083; cv=none; b=NdX6Sr4CbdPqi/5VFldpPfmOnQWDgc9/vJfEuUTB5/OxG1ax0JGvtlHAclnJIrCN1lECRo46v1z+ddfl9jzwH/dW3SSqZIr7zDIKnQzn8XIDt624WvZLaPNkW990XoqhtFbwGJO73aO0f0Ar7pzVAo08nC2qLcPgp/sEfMUr/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336083; c=relaxed/simple;
	bh=QmMGc4lZNnal1xrlpffavXZQOLh5Y2mZyE/7fa+sy5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdWj4uZRj2GTk2/W4jOstuEjMSvkcPj7qhkSPYfb3MUzjlSNC2rmxp6zbYsG78qxe1oCYynb+kMnEUSM2A+BZUyHxyoA/WE4lXDa6iwPadseYztztEqve480LdJFrEebvUgniK7khT2T2hGIS8gkC2WWshax8n/4ijjifApZDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOMoaGOX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOMoaGOX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecff9df447so965820b3a.1
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712336081; x=1712940881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CzOFu2vYoKJKFl0BkpF69L1Nr9SowKahxiD3QPgAQs=;
        b=DOMoaGOXMC/np76bMWbk0asixnfmqZrFC22ug24gJrjujpCXKZOfBhVpt57hxALwyf
         tHsakIKbG0tMIk4wKGP3zQff6xarPRw3+pyq1/pze3iRRBayKOvTP58IRq/eDM+aVrUd
         UcEvnB/sM9/Byvv5Hu5GRftY0qJnfTCqR5o7mVaDeYZ9GeIRas4/aA66hLUNo4NNvEPp
         OJpPouukjcSA9Zic4OIlzcqhD2P7wcXOfT/o3nXWh9QyQOzb0OS8AYBxIbCgXGlJxD6Y
         p/WWxrYJvkymBxSbrrONhxS5AJxW9tc/+lEIzm3hd0HkEFI6co2qRADeWWGo7R2rPDxb
         et7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712336081; x=1712940881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CzOFu2vYoKJKFl0BkpF69L1Nr9SowKahxiD3QPgAQs=;
        b=b53z/6B8xPFGFff2j5+5lIxtzyggBekpvy1zs27MQ/uzy+h570kQgQO5yOwWDosyrv
         XyYBLe9aOmTu6YXMBH1+GTpJpBhGZheEqMF0OImUJJ69W6f4df+9MXKyM4GaNFbIdFRA
         OmMTjpDuyJUxt8UF3wnY/t1V5YrDxk3m5ka9KtiB7s3r+LnNZH8k+d84shSt4ImnFTGg
         Guu6LhztISdHgGFrfO/iCfm2BC+yPCTwLPdsRbmuyzkXlvPBsngzuwKucyafHnv/W/Oc
         2+o/iFE+Ftzqf3LmM15pQhfSUodd1Cd6YFZTgUe5kKq8KFO+4bbfhwd5jwTuiMRrs+Rb
         haKA==
X-Gm-Message-State: AOJu0Yypqu3OvlWClWR4uLDCzzlYReQ0LiKIK2UMiy9ZxYgyRJLC9fLI
	QSaFzNl/mMQP6bQJ/s1LxGyq3Dtmpb/tWQhXrwI9b8fpjEa/P3A6fCdDa0smwmg=
X-Google-Smtp-Source: AGHT+IHf7lPnrYPRlgBJQwQAepP395s/Vk3i8T4l0VjMhG9A5+DVaM2Zgr8ciNDmiHej3MG2V4WR/g==
X-Received: by 2002:a05:6a21:7894:b0:1a3:8984:b334 with SMTP id bf20-20020a056a21789400b001a38984b334mr2485816pzc.22.1712336081076;
        Fri, 05 Apr 2024 09:54:41 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:6bf8:8d28:8374:5b7d])
        by smtp.gmail.com with ESMTPSA id hq8-20020a056a00680800b006eaf186e078sm1717692pfb.132.2024.04.05.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:54:40 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-block@vger.kernel.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] docs: sysfs-block: document size sysfs entry
Date: Sat,  6 Apr 2024 01:54:34 +0900
Message-Id: <20240405165434.12673-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document it since /sys/block/<disk>/size is undocumented.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 Documentation/ABI/stable/sysfs-block | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 7718ed34777e..881049419054 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -707,6 +707,13 @@ Description:
 		zoned will report "none".
 
 
+What:		/sys/block/<disk>/size
+Date:		April 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This is the 512 bytes size sector number.
+
+
 What:		/sys/block/<disk>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
-- 
2.40.1


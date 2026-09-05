Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0F36BCD7;
	Sat,  5 Sep 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615413; cv=none; b=q5ceSPiT3SDsGT8CDZ18olaiTV1agfr1tdidx/SWZYA7xLJ69F0rOXgoUmOJ9/7WpSdvkL5DXbXXjphw1JMXprEpNFLLyu1ud63jh2/eoD/ax1ekpha8JzLq6X8sWnhIlCUooRDseyfsCpYn6zzLaJWTb08mVqRBztAnsBYWjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615413; c=relaxed/simple;
	bh=yhKO9bOb/N3AvqrLnoGZ7S9kF4H+sBzGwCSuypc/F0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcAIePJ17lacNsRwuj2z0njVrpD/4k3tTZakoF2RF/vDzmQ4RFAAv6i8ydq9l3HeSqStHeGABTdlKscXZI98jgSZZcyuRWVqOeTuOlZdd0N/Mcl7lRAouEMQBmBxRh0BM7pxKMZZcoeYN3Ix9U1JEzS/ZE5frICMsKthpZRne/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EKILi+qK; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EKILi+qK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=M8
	xrQuRZrrg8dBIydNuAY1LQa79Az3g0ro2yQ6/wPEo=; b=EKILi+qKAAk1kzq/Rs
	DDoenIYm1qWpo8GT0+BtMHcfnyPvj4M49g7Wl19PJ1WydA9dD555yuQ6pStHL8jh
	CagHHzYlmAgdLXsMhjXWNRfJd6CvwspUwpNIECngvTEKc2mQ4NQcUKdxForjDvT3
	nz1MkeH6cqrfNzFy7pog9Sjk8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnrQK5GpxqzTUWOw--.16845S2;
	Sat, 05 Sep 2026 21:35:54 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "hpp.iscas" <hppiscas@163.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] block: swim3: Publish the MacIO OF module aliases
Date: Sat,  5 Sep 2026 21:35:51 +0800
Message-ID: <20260905133551.65061-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:PSgvCgDnrQK5GpxqzTUWOw--.16845S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy7tryfXr1DJr4rKryDKFg_yoW3trX_C3
	4UXF9rWr4xCrnxAF1xKFnavryjy3W0vFs3Xr1Syr9aqryfuFn3Xa4qv342yr1DGa47J3Z0
	kryDXw18Cry8XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU3fH5UUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7Rp2P2qcGrpa0QAA3j

The SWIM3 driver registers swim3_match with the MacIO bus. MacIO emits=0D
OF modalias events, but this module only has a block-major alias. The=0D
block-major alias does not describe the OF devices in the match table.=0D
=0D
Publish the existing OF IDs while retaining block-major loading.=0D
=0D
Fixes: 3e9a69275f23 ("[POWERPC] Update the SWIM3 (powermac) floppy driver")=
=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/block/swim3.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c=0D
index d4f0d43..fe6f3b9 100644=0D
--- a/drivers/block/swim3.c=0D
+++ b/drivers/block/swim3.c=0D
@@ -1262,6 +1262,7 @@ static const struct of_device_id swim3_match[] =3D=0D
 	},=0D
 	{ /* end of list */ }=0D
 };=0D
+MODULE_DEVICE_TABLE(of, swim3_match);=0D
 =0D
 static struct macio_driver swim3_driver =3D=0D
 {=0D


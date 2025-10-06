Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870419067C;
	Mon,  6 Oct 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744989; cv=none; b=gtJ4WrYPU6mm1j9scCB7E3doarIJa+LdVnmMtbfaBujPppzF4RNw9rh6GuU2QT4gAN9WBcEc0nFQ8rZ++GxSVt1kBcrSMShmE7a7N00Ukv3W/dn+tPNn2eHb2Zd/4oZuvrU9JkGDdjyt0rGjVXzCYxfgk1wQQ2v2X35OIDlzghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744989; c=relaxed/simple;
	bh=0xkFkIFtnjQEGwwUdi3WgGkOeaYx/drZLQoCWnU5p+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNag0vnyoGoBF33qL6R1Bvx38LXZcHHWLqvn8ru3fhuNpkS4RHXZYN8CwYr7MeOYzUb4LUAd9a0xeE0h++LM+24por0qTtH0rAgBGCzJ/is5gaqqrz5BwEupFmfk2k7Bkc/PjRd2MSZSyRSgewbg58z6wUnILtg/0W9SkdR+OYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UQQs/TXr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UQQs/TXr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NlQ6RCgH5WimmF64AW0550GztKYD0qltZSKMbkkqcek=; t=1759744987; x=1760349787; 
	b=UQQs/TXrXwsyAc0bvmzr3fVFsKcdoluFpaoTvzA55MtGLovoWArXuw5TQDFK2kneJdjm4lwHy9K
	RQfWapwXXMtaoXDHCbNrlug3mw4HqaEdJwko5RA4CKLaNKLSwV2BHS3QE6XEl+DV4Ae8D45cUvggr
	sMyUMCxPPa+ERrWHG3tj9CT2pCTU0pnK0o0xEoFteDr7btCIdYVk1DJhKTpT0XDCrEaVBxAqQNHzk
	pBnSMtzHZu7S/W8V9NxVcu/nd5C8cBSl7kWo8DjmPyJcvR51UN+ALYa/X+SOqGtH4PJTKquyJvsHT
	jEOoVYkQ+oMrASTaC8rvtd3Ekq9H0DrU9rlA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5hzC-00000002lzh-2gAs; Mon, 06 Oct 2025 11:58:30 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5hzC-00000002aJ1-1c9N; Mon, 06 Oct 2025 11:58:30 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.98.2)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1v5hzC-000000000xV-035o;
	Mon, 06 Oct 2025 11:58:30 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Sam James <sam@gentoo.org>,
	"David S . Miller" <davem@davemloft.net>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	sparclinux@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] Revert "sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN"
Date: Mon,  6 Oct 2025 11:58:27 +0200
Message-ID: <20251006095827.3666-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

In a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop when vio_ldc_send()
returns EAGAIN"), a maximum retry count was added to __vdc_tx_trigger().

After this change, several users reported disk I/O errors when running Linux
inside a logical domain on Solaris 11.4:

[19095.192532] sunvdc: vdc_tx_trigger() failure, err=-11
[19095.192605] I/O error, dev vdiskc, sector 368208928 op 0x1:(WRITE) flags 0x1000 phys_seg 2 prio class 2
[19095.205681] XFS (vdiskc1): metadata I/O error in "xfs_buf_ioend+0x28c/0x600 [xfs]" at daddr 0x15f26420 len 32 error 5
[19432.043471] sunvdc: vdc_tx_trigger() failure, err=-11
[19432.043529] I/O error, dev vdiskc, sector 3732568 op 0x1:(WRITE) flags 0x1000 phys_seg 1 prio class 2
[19432.058821] sunvdc: vdc_tx_trigger() failure, err=-11
[19432.058843] I/O error, dev vdiskc, sector 3736256 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio class 2
[19432.074109] sunvdc: vdc_tx_trigger() failure, err=-11
[19432.074128] I/O error, dev vdiskc, sector 3736512 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio class 2
[19432.089425] sunvdc: vdc_tx_trigger() failure, err=-11
[19432.089443] I/O error, dev vdiskc, sector 3737024 op 0x1:(WRITE) flags 0x1000 phys_seg 1 prio class 2
[19432.100964] XFS (vdiskc1): metadata I/O error in "xfs_buf_ioend+0x28c/0x600 [xfs]" at daddr 0x38ec58 len 8 error 5

Since this change seems to have only been justified by reading the code which
becomes evident by the reference to adddc32d6fde ("sunvnet: Do not spin in an
infinite loop when vio_ldc_send() returns EAGAIN") in the commit message, it
can be safely assumed the change was neither properly tested nor motivated by
actual bug reports.

Thus, let's revert this change to address the disk I/O errors above.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 drivers/block/sunvdc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index db1fe9772a4d..a2aaa4cca676 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -45,8 +45,6 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define WAITING_FOR_GEN_CMD	0x04
 #define WAITING_FOR_ANY		-1
 
-#define	VDC_MAX_RETRIES	10
-
 static struct workqueue_struct *sunvdc_wq;
 
 struct vdc_req_entry {
@@ -436,7 +434,6 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		.end_idx		= dr->prod,
 	};
 	int err, delay;
-	int retries = 0;
 
 	hdr.seq = dr->snd_nxt;
 	delay = 1;
@@ -449,8 +446,6 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		udelay(delay);
 		if ((delay <<= 1) > 128)
 			delay = 128;
-		if (retries++ > VDC_MAX_RETRIES)
-			break;
 	} while (err == -EAGAIN);
 
 	if (err == -ENOTCONN)
-- 
2.47.3


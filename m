Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9B1F4CB3;
	Mon,  6 Oct 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745214; cv=none; b=cLm4xF5Sl5LjRhXsIOJI6tf4xao6HeOklmbbcEJB+eyCmFHhdD8DhPCnHBI4peFSKr5nlQh7naaVyOyavPIgVZQZFUKX0HyU4+MfXY5pOufgtlJJe8urAVpGSKOZ3hkunLAMBdwPyd8COnQ8HDgw0eYXqwRl/Xp7ixCziC0uPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745214; c=relaxed/simple;
	bh=RqgAW9lbqtckIbXNmjORUUqpdakAcL+TaSmrw3Jzu/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2De6LJs6cyIMBW1PB0QrPuIssiy/ZB/zz5xwsDSaJXSDnp8eK4KLCRCekDwIbgjIMZ7/iqS94KqZmBdjkFzTQ6maLR+EKJk++K6NYnhWKtSlJSr647FPXWwX1hIyWeOe8aSBika00lxn4KrXcUw2hCnbpBrnZZO9scSkO9Un4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=YRe9Turp; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="YRe9Turp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=HORcpKNl5P77OslotDTpzvdXhKvc79Dm6vcBc2f2Cfw=; t=1759745211; x=1760350011; 
	b=YRe9TurpPZqO+QFE4ADnowcxhQD6cXtOHYtMzOGEemPpQ2T9KMoAqIt+9wKPIRMFdpFjQPxxW/D
	rlI5N5B2O9Huv4PLCXhJI3YPZ6rAraBNQUKa6lHpKz0uJwYAy5guDC3QH2gbHotMxCFWFQup0ynZN
	X+WCLtW3tPDuAteMqIrumkgOzE8YfkAS3CnjM0nTamOpPhCM6GcS61m6gvwLZehe/HaKELiZhZDNC
	4u3a1Nbas9LkDtQ50CXsjSjSoCP3KYfLzZ+lhZuEBl/AqAHIUQvsJiyKkbt82kVFYfg2Aan15d4dA
	+jTh0L1bbdUHHb8qj+d5VZwy8Mn+2bRGV3aA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5i7E-00000002s6d-3DKw; Mon, 06 Oct 2025 12:06:48 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5i7E-00000002bP1-29Iz; Mon, 06 Oct 2025 12:06:48 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.98.2)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1v5i7E-0000000019q-0cDx;
	Mon, 06 Oct 2025 12:06:48 +0200
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
Subject: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN"
Date: Mon,  6 Oct 2025 12:02:26 +0200
Message-ID: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
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
can be safely assumed that the change was neither properly tested nor motivated
by any actual bug reports.

Thus, let's revert this change to address the disk I/O errors above.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
Changes since v1:
- Rephrase commit message
---
 drivers/block/sunvdc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 282f81616a78..f56023c2b033 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -45,8 +45,6 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define WAITING_FOR_GEN_CMD	0x04
 #define WAITING_FOR_ANY		-1
 
-#define	VDC_MAX_RETRIES	10
-
 static struct workqueue_struct *sunvdc_wq;
 
 struct vdc_req_entry {
@@ -437,7 +435,6 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		.end_idx		= dr->prod,
 	};
 	int err, delay;
-	int retries = 0;
 
 	hdr.seq = dr->snd_nxt;
 	delay = 1;
@@ -450,8 +447,6 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		udelay(delay);
 		if ((delay <<= 1) > 128)
 			delay = 128;
-		if (retries++ > VDC_MAX_RETRIES)
-			break;
 	} while (err == -EAGAIN);
 
 	if (err == -ENOTCONN)
-- 
2.47.3


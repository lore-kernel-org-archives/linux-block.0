Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8736AB57;
	Sat, 26 Sep 2026 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408952; cv=none; b=V/siNhkr+pWIwnwzH+cxaBLa7rdmUANIKCXsDMzz0gxu9f1SyLipXDiG1TyqPWd20YuBXf5f6ZE6c0PwD7i6hA22HDCnPl1Ft8PxsYvYQ+WzUwUsQzZ5x0feXof3eOU0D+HMreZLPSqLGnmze2CLCyXRCHJ27yqQi59C4YqKYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408952; c=relaxed/simple;
	bh=9jqprNjQ+rZUgGynglRYeBSnrELRrWgBvxGJeLvby08=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=QUBZQlvhXG+rlNk8nmLQ+QgtqQQh6fPECGo9ugrg9HUSSFZgt05PqEEmUR3gcmLBTgjrGEsB9dlpxe3TvQOCDDIrozWTqvv4pvFXeiDUp/Bfv365yJ7/YGaHpuGzLU0GPlxHwyIXFSoSHtNLEj5Q80/9SXzvbqKwNvzNbtxu0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2AVLwRt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2AVLwRt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E9AF5EC00F3;
	Sat, 26 Sep 2026 03:49:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 26 Sep 2026 03:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790408949; x=
	1790495349; bh=hQU8G7hRI1PTcYkQFKyfpf0KmkM7AnjmW4BT7O257n8=; b=S
	2AVLwRtH12XtuEdjAl/fv+uJSgs+8GFzn7IpkL1WrM/yPk/+mBMKNIHWh9Gt8/JR
	cKLWV7mnLZS8JWElkZ1zYs6VY/phIrDlnb6aBEnSlqIuozvzAfZbSts+C3qLQa4r
	OwjV9zJnu5E3zj9OiUMAu6xA2/ECdG7FywmcNk2RraJh7v0kWpo6+XaYqiGSqmR9
	bZFfnantjkY5IVUavW1hUVb6+A23y9waT/xFZaraVOtX0c0sLyRZ5jd0NobcJ4Dv
	2nJX+5emdVgW6rWrwTNlUIo03PQJuOZDf3bG2PUIUhKLL0WnLDiQI7TldxglWpYi
	tmCvlsgWh7dopdaxO3afQ==
X-ME-Sender: <xms:9Xi3ajE43GAlgnECV0SAvxhDCJoxcKnKX_9T0wwAY64s0082Zb0mTw>
    <xme:9Xi3asXwI0Skm6LA2eHhgDkDM8bDgO1Lf_GyTHKo1D4zTb6spmFvjlrLuhbaOQPRu
    NbV0Sfdm5j-H8qR51aGe49RWNjZOAWNA0l6Im_Q_KLIjEQ4yQ7prMH7>
X-ME-Received: <xmr:9Xi3anXS_ZvDUv2xhTksO7PGvCT9vXiSxv4WICxjFPs3LL76SiuFuYhDy6-MpvBMnvChX8RwCgykVgfnB3qmQdE7l3JkLe92FMs>
X-ME-Proxy-Cause: dmFkZTFhgbhGL2sj4pJrw+Bgdida+aoInjEU9BhPhvnEODw606EnVRu1dtUBIWrHIHekHs
    iPFmOMYom+uzd2hm7ODvC6qvS+UrltZ0XbuNmj1TOpI+GdMrWxrTg3t+GZ6GD785M8BoqG
    ivRuNhwFUuwPia8CRYlTHrpJrtmEN+VpLVaEepzBBL0JSMs3+k/3ZbVn5SPHFypbmXHlCF
    /W3XnSpXVQOE4/0N+kMzFoXtLehqeVQNxh1mLFOUBeoDti+xLVk+77y+w0Y1sGJmCD8cH6
    ZVDanVVOCaa/YJ0Xmo8pYEptujYeBEVtsXgGW6oXN39UlMk1lro9/ZLIuE6YaRrTiRFVVQ
    dyT7Pm9GWq3n+lIo/dwZkFsT098Bsl8VccpmgN/eUF1nEJGmp+m32hUDcqrr6iez/y9FCf
    aF/N42OzyVIs2/aCraSAibtO9rGYo/HlVTiE54bOEtLkgDAR/sjkkgtRhR2QeWpDwpbygf
    qqfcnNtaejMyd0awa4UqK+a48+7w6NiDW32VAHtWpkQ9uswlw827MMHaIBf4+aacCvoesw
    l7vxW/rHelARrAuIoCmhJW+RvVO693PSPk4LOp6WilQTlKDXIL343JNhqORMA9Gnj8GhQ3
    j1yz1cHT4Rc0ubxKodDn6cDJE1cX1sQd6xxHxM1xAlE6PUJTs+nabvUBmvkg
X-ME-Proxy: <xmx:9Xi3aiKatyIXTkcjQ7ZRmHZJw5c5ilGJlD08pw-dHL6fKRgnMmqVlg>
    <xmx:9Xi3anABHddFmrpu9ye8FIqZ2y9f1_0XRt0SoLvySCsdUKLxJNPCew>
    <xmx:9Xi3aifycCfceUTQLR_8zOfjFxPwF3TScxMsAx_cuCd5CrXVixSACw>
    <xmx:9Xi3am1UGtTf0GMJMZFJCBmIi_CMxDiWW47Q4pF1wxsYDW-KxLVe4w>
    <xmx:9Xi3ajFSdJkBmTFXLh_9_DIQKx-O9fhoBmkUdxaF51YlyZIkXZmDiOyc>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 03:49:07 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Stan Johnson <userm57@yahoo.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <ef4368d696b4b68ea3f288327432f4027afcca81.1790408363.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1790408363.git.fthain@linux-m68k.org>
References: <cover.1790408363.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 1/2] swim: Return -EROFS when opened with BLK_OPEN_WRITE flag
Date: Sat, 26 Sep 2026 17:39:23 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Write requests are not supported by the driver and produce IO errors as
shown below. Avoid this by returning -EROFS when opened for writing.

[ 4111.690000] I/O error, dev fd0, sector 2 op 0x1:(WRITE) flags 0x800800 phys_seg 1 prio class 2
[ 4111.700000] Buffer I/O error on dev fd0, logical block 2, lost async page write

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0ccc12a72388..601b1ab1d32c 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -640,7 +640,8 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 	if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
 		if (disk_check_media_change(disk) && fs->disk_in)
 			fs->ejected = 0;
-		if ((mode & BLK_OPEN_WRITE) && fs->write_protected) {
+		if (mode & BLK_OPEN_WRITE) {
+			/* Write support isn't implemented. */
 			err = -EROFS;
 			goto out;
 		}
-- 
2.52.0


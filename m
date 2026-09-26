Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DF322C73;
	Sat, 26 Sep 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408963; cv=none; b=o2jVV9dIKdJDlQ0CEMY3A5PRdpMxgJAwZ92pmcZwQyX3Vx3nT7K/HwAt4APKCYTkLnDshpOFdxyGMQJxqMjHTazFj9xuNcVO+29wyLcO2P+tJI10mS4NOLihg9+80nMK+Cm54bep6FKSbBwb6i/1YiXvRscUaqAY/U7p5l158Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408963; c=relaxed/simple;
	bh=dn02Q7ecKJWz5B04rCwHbNrQH8D02KhFAwFllXMLtEk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=eMPDKaELIjaXXDIk7+3NVCwnzqOGQ/LfkZqhSOqXKsJmFBXr7UGnYoaq0lmSw95/NvCbD/Ein26ooJKFAn7w8nuZsWC6i+3FXh5K0jkYOk7Rhc4TC2aLo47PXLOt+GhV/ZrdttL0+Io2Jec1/1qtLJ1jjCkSXtTOFp2jB4Bt2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ezr+W6gY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ezr+W6gY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F1B9EC0118;
	Sat, 26 Sep 2026 03:49:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 26 Sep 2026 03:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790408960; x=
	1790495360; bh=s/bTxCYVDE7uT2dDkanJ5+/0oTAO+Kb1T6rIVmbsr/s=; b=E
	zr+W6gYHEkEDPx/6ko3x6RhySfTKNAh3BfYkqtjit0+JA82V/m9UjjghXyxPp8jE
	kQ8wTQyMTPxcXx8WQm75S3jc8bZubYhoCIzv+bBKViBMWRtaGPevU8tz0QIYWRt6
	o3afzndYbmvBCi/vZ4JNI84uT3BpfEYPvrPje0EMZZ6s2anj9HZwtd1ETiJgyJQN
	x2iXnUIG9A7+wiC78dfSFhgUIG+oe6SZNjUJsufmENMiw4N5R/rLPw3BJvJLJkLm
	NiL2ue/5R4dRZh6uVckt4qjSNC3ZRei9TgeW8mCurMI9fMqtiNBpR0kmbdSiqYmm
	El9OE64WtscleAF8GR0Yg==
X-ME-Sender: <xms:AHm3akI-UTiNvKx083NJFi30Q6cXfH05229hf9QJWUnEu-2Tl1BV9A>
    <xme:AHm3agLMFnoJsiZ7UkAz1FWnqzofuEBq1bb4hG2O4Q-xQ5CYsOX7nOabSgABDe-77
    gev_zGsGRCtjNIMoV_anJRCtLySqBwFA3hLLAPKQ7WCGYmiwcwvUZA>
X-ME-Received: <xmr:AHm3am75mcdo8saOo5qkrQmknuHD2f0FOhEs9TaH6vzI6hBv8Hrc9ildlxVxZMCCKaORgFf4i6trcb2aYqKPvJT9fzS5-POyTLY>
X-ME-Proxy-Cause: dmFkZTFhgbhGL2sj4pJrw+Bgdida+aoInjEU9BhPhvnEODw606EnVRu1dtUBIWrHIHekHs
    iPFmOMYom+uzd2hm7ODvC6qvS+UrltZ0XbuNmj1TOpI+GdMrWxrTg3t+GZ6GD785M8BoqG
    ivRuNhwFUuwPia8CRYlTHrpJrtmEN+VpLVaEepzBBL0JSMs3+k/3ZbVn5SPHFypbmXHlCF
    /W3XnSpXVQOE4/0N+kMzFoXtLehqeVQNxh1mLFOUBeoDti+xLVk+77y+w0Y1sGJmCD8cH6
    ZVDanVVOCaa/YJ0Xmo8pYEptujYeBEVtsXgGW6oXN39UlMk1lro9/ZLIuE6YaRrTiRFVop
    Ex0LzygTHBndrS88jiVsLgBCV9M+XL0XDbnsFZmzimnoPptSY3Zok/u/oY3yDYD4uF8qin
    ZUyi+cDeghiz1Z8+LdBL8peuPyK4EYkUANGhZ1eRijgE+8Ngb5V6S2MvGVx/FrPENNZp8m
    2Vh0s/GTqe3xvZQiX7WtYZf32BxWX4f9TtS93guT/Gmlkbt6ZmSLsOAQYliGJ14307sp0I
    Hv10TCkTnpNV1VKZWIABGigjnkbHVpLxF1YuGJXReWXemHEPGqB6oy/Ht5pjf2tlDXOhXx
    WHOuhFv5rubLdhAmrYu/WtC9osSSxhpYgJ6/wcpOMlaaiBEFLNQ5y3J8gPkQ
X-ME-Proxy: <xmx:AHm3aifow9qPK2ExwXLjDIdctuEgJVDPuEqN5-574SfYTnBXRWZiqQ>
    <xmx:AHm3apG3DoWu6bbQat1k1Xyk3A8cpCnry5oyCCcVDgxGTZZgnRD7Fg>
    <xmx:AHm3ajQkaeXVs_LiCo-DaznGvKXJ5CgfcaJcjLrldNX3-MjxMKyk6g>
    <xmx:AHm3avZRux35nWNfz-9u_9RBEYJNv7Ss4HJhyXkA79eg2Xv5O9ONLg>
    <xmx:AHm3am43WEmzrK91LfAH5QAHcNTN8DB3RSAXZiSe_ih2H6T0Db__cpHz>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 03:49:17 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Stan Johnson <userm57@yahoo.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <418801832b878b9a3383aac4f7b9b9469ae494b0.1790408363.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1790408363.git.fthain@linux-m68k.org>
References: <cover.1790408363.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 2/2] swim, swim3: Fix FDEJECT ioctl for exclusive open
Date: Sat, 26 Sep 2026 17:39:23 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The eject command from the util-linux package does not work with swim3 or
swim drivers: the drive doesn't eject anything and the command fails.
Apparently, ioctl(fd, FDEJECT) returns -EBUSY when fd is opened O_EXCL.
Fix this by checking ref_count for either 1 or -1. Either value means that
the caller is the sole user of the disk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c  | 2 +-
 drivers/block/swim3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 601b1ab1d32c..1552fee28eaa 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -696,7 +696,7 @@ static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch (cmd) {
 	case FDEJECT:
-		if (fs->ref_count != 1)
+		if (fs->ref_count != -1 && fs->ref_count != 1)
 			return -EBUSY;
 		mutex_lock(&swim_mutex);
 		err = floppy_eject(fs);
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index d4f0d43e0a72..aa27dfd2820e 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -898,7 +898,7 @@ static int floppy_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch (cmd) {
 	case FDEJECT:
-		if (fs->ref_count != 1)
+		if (fs->ref_count != -1 && fs->ref_count != 1)
 			return -EBUSY;
 		err = fd_eject(fs);
 		return err;
-- 
2.52.0


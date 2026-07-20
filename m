Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E1449B14
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576666; cv=none; b=YMZ+Rp286m+zz6j9CHdRI/Y9wn3Vbh8kgrhitjiM3Iw2/zw84pvGJXWOekWNzO93HaL3ZGmCqyfmVCIyYxpCDCi2wfL4at8xhFxLz3GU6W7FHZGlCGfWI2442FolQnEKhQHqBkLXYdx/+v8vU+fE/oyPMYV0PkQpTcXIqfCbZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576666; c=relaxed/simple;
	bh=UMFAJLlkdhiAiXJxPECb8KGPHLmWVaQbYtJj/8NRAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a11qm6cSLEObklm+7Rg3lEn7q9KZInFW1trR2b+jrRBf63yNaGaReo4HbWx04iIoPGHbke9uAjGeFOx1LKR5cCDLGFIBVsXYKrwBGIdWB9UpF7mqJRLIFnzO6qz6Nn2qGA1oNnDWEOUO+laSJk/ajJnmVjF+csfPNUnUxcik8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=IjbvN0tD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="IjbvN0tD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f73d9c177so1416386f8f.3
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1784576662; x=1785181462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHbadXg6CUSoqHxAKPZRLjtEG7IiQoNH5no6JLfzRAU=;
        b=IjbvN0tDQtoqqL6mwcpjjdAbcfZpwUlPYBqOQD59Z8ZPbDyklfhJi4keSyutt7kPfO
         y0/mZ+EvJCpbyYOa66hGuxvxbLxf+sMHU69AbdFD+uJWJ8E6EEHdy85JyASvYFZVyggN
         K11WNFaJ0wBFoLFcVnyWUdiMxcF9f6CgYliaFG2F3Ly7zA1dO34533suoDsem82R8vHD
         CZ1vW8airO9EXOHs/d3ZLF4gphhX4qNZKAg6Tl+H8Yxh+dyi1P3vj5p1FQ7Jie4C9KPw
         A63vkVJYVObOiPhSbZrho3/zcU3DuujRDsMhzRJ70HAhMGKEu/Cm+u/SxlChbwjTbfah
         EcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576662; x=1785181462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHbadXg6CUSoqHxAKPZRLjtEG7IiQoNH5no6JLfzRAU=;
        b=Y11i+OTyc3eCsnN061XatLykGIHY2ToCJj8G0cBf65og1MRuUoOsMOiho5B6ic/Y/I
         x6u+WCiJS9FHQ75OIBAG9B4l6pAgAGvw/jL8FsInelO7DakN9uFO9pKo7VuvlD+BWqlg
         omddGfSYCeOcutCRi8l9xYyk/yLeA3d//0cf7E4ZEA0H1+0MpccxH9LxZDuDiAqFE8ar
         iqFpJZqn3iAG/7nZRBwkQlSe4rzDoPXYBCNlCOksnuxGZY5ijdg3H71hOEXF/SkVM6HL
         T5ogp7MLGSFkdbKVQwVT3J2C4wwr2/ChLByrvuSRL+haNGGv6VuqTdcSMIniMN0GvmyN
         R9KA==
X-Gm-Message-State: AOJu0YwRWVFdcpnrxKmbP3Y9OVgVOBLZswsUlqcsHCYF5cYpS1RgSs8k
	/KpX6SwccyeueE5jhxsHUFXXkdQ6AnJftRXsbX7rsNPe7x5Z0xB/ANEIjLyEQd5qTDw=
X-Gm-Gg: AR+sD12nhnafPHnEvJHk5r+rRe8wAKRaXSPqPowAzbz3tXTDr60g+HxMXtZS3HTOWPx
	LD/A3ByEZL4pHkNv0CRIg7LhcOo9Ao7D6p0cvr7AQAgkQLWka3hgpwVJmtz1CjUz/Ljh2bGx+UR
	gDFkhG8cb9Zlsu4EidA7/FVs4w+3uRB++OgAs9XdGHL/boEzhBb4Daaoi6lU+fon4mpz31TGBMB
	//FHNb7Sk/ZLs1DiRTrzrixFJFCCjrCaN+SzZiFnQTFSeNi1rJ8zkoF1+cV2d9jiABSRLq/Fy1+
	JfXX5yzOXCbTqz2E98ruhxl/xwTdMIoQ6BxODptxKwmHMYbKz/HvkWR4ajNq0BZWBEN3gEeho/R
	k6ErHSSTIEAkIb7C/Rs024R6z8tZf737rj2N2B7TuYYxdhKiFSukiIjHiWZR9PF1LmkRchBl8BX
	bbS/cl5UrJxeQKW8DcmklaXJ6SLWTEQHvf5ZgYuByeLW7cU+cEIBzgyBgvpvukOQ==
X-Received: by 2002:a05:6000:2f86:b0:47f:7c54:4d09 with SMTP id ffacd0b85a97d-47f7c544d3cmr4066245f8f.43.1784576662544;
        Mon, 20 Jul 2026 12:44:22 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51986sm37031348f8f.11.2026.07.20.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:44:22 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH 1/1] cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
Date: Mon, 20 Jul 2026 20:44:21 +0100
Message-ID: <20260720194421.1497-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720194421.1497-1-phil@philpotter.co.uk>
References: <20260720194421.1497-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

mmc_ioctl_cdrom_volume() first reads the audio control mode page into a
32-byte stack buffer with cgc->buflen set to 24.  If the device reports a
block descriptor, the function increases cgc->buflen to include that
descriptor and reads the page again.

For CDROMVOLCTRL, the function then builds a MODE SELECT parameter list
by moving cgc->buffer forward by offset - 8 bytes.  This drops the block
descriptor from the outgoing payload and leaves a new 8-byte mode
parameter header in front of the audio control page.  However, cgc->buflen
is left unchanged.

With a standard 8-byte block descriptor, cgc->buffer points at buffer + 8
but cgc->buflen remains 32.  cdrom_mode_select() therefore asks the low
level packet path to write 32 bytes from that adjusted pointer, reading 8
bytes past the end of the 32-byte stack buffer.

This is not hit by CDROMVOLREAD, and CDROMVOLCTRL only triggers it on
drives that return a non-zero block descriptor length, which helps explain
why it has gone unnoticed.  The overread is also sent to the device as
extra MODE SELECT payload, so it may not produce an obvious local failure.

Reduce cgc->buflen by the same amount as the buffer pointer adjustment so
the MODE SELECT transfer covers only the intended parameter list.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 62934cf4b10d..4f1fd389260f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3187,6 +3187,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 
 	/* set volume */
 	cgc->buffer = buffer + offset - 8;
+	cgc->buflen -= offset - 8;
 	memset(cgc->buffer, 0, 8);
 	return cdrom_mode_select(cdi, cgc);
 }
-- 
2.55.0


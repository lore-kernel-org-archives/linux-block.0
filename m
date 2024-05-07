Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75977F2C
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120725; cv=none; b=ix88915/F7yNT+Zo4WnKS2/BIQsTjtLrbU2Dsfs+OIm37h4Ghwh20/Py0SM3TfrrUj61mBtFWe+she6FtrbQXhwMoahLSyaXSuQy6NESq2w0UNZtVxabRNxFWqFY+ZnJStPrPB4yNpYL6q28w4QLdLZKjegaBZG2p8/ATNdMCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120725; c=relaxed/simple;
	bh=CUY/GJmWdeqg1ntm0+UX1mI4BYPOGY/fNRdw17kvVYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlKsjM3kSlaOTjmUfpQkW7BaeERXgZNSkRSQYTsQGLLSKdhMS96ukEWUtvgIeUQXSWRq2tzDHT1NkH2pMmG2mS27tRkB2miaJUzHglMBFR2Z4G+4ShBuI6eJIzztGzUYyhsJk1QrU/tIbE+W05ztJaI1gg+/35FWI9ErtB8jBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=ksBF8ML3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="ksBF8ML3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso28079765e9.2
        for <linux-block@vger.kernel.org>; Tue, 07 May 2024 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1715120721; x=1715725521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0ke0Z0Js1JxqztPOY6fpD7JyerLnzWwnqdNPDKo4Tc=;
        b=ksBF8ML3Wb5WAScZ3q5ud9nGYd20nEYI9ubqWGh3iMxAzWQV3eQKo/Ummx+A+Lht81
         MKC44IGWjO20/e2iIDYZ/ZS8waIVvc9IXHCQ/viZuP/D+MWGbVB5ckQlWmozThNZB6Jp
         nCuyb4h9Gp7KeyfagXTiddgO7TWxy3rUGOiyIiS1FEl3nEDjqa+22ADSVYkHAH+CGqUi
         dvXkq0swtXpFDYTMGnCWSx0+e2x/jUJDHb1mQ/gFD5zbvOmFOgniNyLrqKvDcISPqey1
         dL38WrRa/0MKs9KFC57yOYWdKRFVuilDCXsV/T02gjL+XuQ6gMx8+ecU/cgB7gGU5bqn
         fVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715120721; x=1715725521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0ke0Z0Js1JxqztPOY6fpD7JyerLnzWwnqdNPDKo4Tc=;
        b=wlynvRowNTdWguTcz+64FF3+gXpO18mYXH1kr9FL7KWojYwtKCimfge5OCARbKvius
         lAXTN7j8ZlskpLxhYFJosepwE9h3gGz9/XchW6dkqSiSXcFb1GIBlHiOUuZ2DTcq4GFo
         egJPqr+Gx8dmGuI/S4Na/MbiD+Mrt6W8YrKpJveqM+f1W09FMc5vpGepcA48WLOyXdCV
         PReBAALjq47bUlLKZ37XH6WiUHd4kcx/I8omroc6vrHa8PNkOmNGl2ansOzSbuvYy+5D
         3uCBpM2p+93K/HgRj6NqSwgQ334SynXJco1HQNkIfnufDdZONr2r4RdOgXMJxRofJld9
         deEA==
X-Gm-Message-State: AOJu0Yw3GWVNhQvs9Tc8ImZfScMaPS080Fh/8IbMThxeXwZArd8Jn7WY
	NTNsVGUQBTiA153w8Bwnd/xs2/FDS8K+pktFJLROdch6xkwUqvSRg2O0+olNrf1yDwrdO/Q49vb
	/
X-Google-Smtp-Source: AGHT+IEttH/Yf5bbCtCyHkPPGyFJ/whpjUMjisHODQzKdFN8B3V2s6yJu8TmQ5CAY6DW7qrLJMfIuA==
X-Received: by 2002:a05:600c:444e:b0:41b:935:24a9 with SMTP id 5b1f17b1804b1-41f714fbe0amr8032905e9.24.1715120721724;
        Tue, 07 May 2024 15:25:21 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b0041be4065adasm54878wmq.22.2024.05.07.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 15:25:21 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: rearrange last_media_change check to avoid unintentional overflow
Date: Tue,  7 May 2024 23:25:20 +0100
Message-ID: <20240507222520.1445-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507222520.1445-1-phil@philpotter.co.uk>
References: <20240507222520.1445-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Stitt <justinstitt@google.com>

When running syzkaller with the newly reintroduced signed integer wrap
sanitizer we encounter this splat:

[  366.015950] UBSAN: signed-integer-overflow in ../drivers/cdrom/cdrom.c:2361:33
[  366.021089] -9223372036854775808 - 346321 cannot be represented in type '__s64' (aka 'long long')
[  366.025894] program syz-executor.4 is using a deprecated SCSI ioctl, please convert it to SG_IO
[  366.027502] CPU: 5 PID: 28472 Comm: syz-executor.7 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[  366.027512] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  366.027518] Call Trace:
[  366.027523]  <TASK>
[  366.027533]  dump_stack_lvl+0x93/0xd0
[  366.027899]  handle_overflow+0x171/0x1b0
[  366.038787] ata1.00: invalid multi_count 32 ignored
[  366.043924]  cdrom_ioctl+0x2c3f/0x2d10
[  366.063932]  ? __pm_runtime_resume+0xe6/0x130
[  366.071923]  sr_block_ioctl+0x15d/0x1d0
[  366.074624]  ? __pfx_sr_block_ioctl+0x10/0x10
[  366.077642]  blkdev_ioctl+0x419/0x500
[  366.080231]  ? __pfx_blkdev_ioctl+0x10/0x10
...

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's rearrange the check to not perform any arithmetic, thus not
tripping the sanitizer.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/354
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/lkml/20240507-b4-sio-ata1-v1-1-810ffac6080a@google.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/lkml/ZjqU0fbzHrlnad8D@equinox
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index a5e07270e0d4..20c90ebb3a3f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2358,7 +2358,7 @@ static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
 		return -EFAULT;
 
 	tmp_info.media_flags = 0;
-	if (tmp_info.last_media_change - cdi->last_media_change_ms < 0)
+	if (cdi->last_media_change_ms > tmp_info.last_media_change)
 		tmp_info.media_flags |= MEDIA_CHANGED_FLAG;
 
 	tmp_info.last_media_change = cdi->last_media_change_ms;
-- 
2.44.0


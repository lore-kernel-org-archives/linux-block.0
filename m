Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B54822339
	for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587276; cv=none; b=Q/ZC9tSWL/0WWliFo70pm6mq+kvUhqc67+EasJ6QGGbf5y+CaOBosx8qYZB+e+JLOZ3S/cDNBX6nKakv7AqonARwoZJ3WrnezoLQ+1DQJPn2yyaPC013zB+IxbehXeV4Mq3xXUHI4i1ZkS79Ja4/iL9UCY0eZhLDAipRRCGedOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587276; c=relaxed/simple;
	bh=oZtlk0nVL4o/ZQQqjGWMAYcCPbd5AjG10okIgbtXlr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvcdM8PxgO7QvDH2DiyjCB6CRKRETl6nvvigVGIntEg16CxxtebVTGwaKSYKFp0xivZt7nzU1AkMP4y3TGUDjWHDR1M14xsWlhTjI/5gSDE9Va1guL8FM2KqUl5s1a0fCytxl7UwXmsgTxjMinvys9+0xP+RdrgTrm9iYXGnBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=xbfy+xfp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="xbfy+xfp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43634b570c1so68340475e9.0
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1735587273; x=1736192073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MpEvwZ+po6qqVfPLko9RifmMx3SKCJ8t5apEb89jIY=;
        b=xbfy+xfpBcsC6zniCzBXMASOqmkxC4s1GyJwFGmKPJdOVKmLqVDNJ1D3ca/kTqgr2k
         5DNpVE40Gc0lx90qJMa6+/J78OkcG4lHD2Mec4JYXVjnb7vTJ9en4L9bU5XWzFPg8EJ0
         AVfggwJ2stKZRiIgjdzf1+gDAL+FwB75ABTlX2DQZfAwMBkzp4qUKDxTESmAxtA7ughg
         qutMRJara3QvYPXgVIz0qnIK2PyzLqeYZVdPadTVN0Xki1YI3FUukYbp5mHN+7bisQNc
         UUBHIziL2GpeKlxAnpn3kXiONqELxbxfCuluIz5K0MEwwVYmgldcGjvpg42gkYIkONiy
         C3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735587273; x=1736192073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MpEvwZ+po6qqVfPLko9RifmMx3SKCJ8t5apEb89jIY=;
        b=kwkJ9VjR7DrRN8s+E6MtkDUyJg8PpiZukgP5I2o+9xDyG1N+VzNofotx8itoBu5Pma
         GzOp1vbZGzEy/pg+61NQHbXh2xy0Cl4Z3Hszzg7nysd/4FnXF+FHOCifpdBy0a7JGlU4
         M6rOcomB/HMM4kz3+fC95slQ6wRq3nvN6pgVEGPjyKCaW2sIj3DqG5B8ehBmpSLhuJ0s
         2zMLLqkxLnGzIyaa8L2SP3Zw/Lw1qrDEzLo7eejwbAaZCxYfUuQNaPNKH/MORYcNN9u2
         EiqIigSemnsczF6T6RdBTaCvfeMsss3XLeHGEuN8aRnEwY3iRX4CdWavQGL/rlbYMU77
         ip+A==
X-Forwarded-Encrypted: i=1; AJvYcCWqVDeL3PfrtKmmYa/SdYKgTlLb+k0YuO69d/YChT0WqpvJubZz2/Vgk2yrsytouYu62aVlqnI6I/sbQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC98LrBm169wCxo4b68rDs+3060yQYaSB6GckbkXFQjNxqWifu
	cA7uRP1uY0Uwm8C8jEYQWGg1LFCegf20ZEyO6lnADv5EDxlFRLRHSH13XjiYJIyyI3BithcH1aI
	D
X-Gm-Gg: ASbGncvIhr1ZkLRRsY3EZStBcQ0UFPHI8xRXYytvFzHwO9rdN9AOwGlLy11VIa+MwZF
	9fTZaZu8zV4lrK3uFON+xCNfLxW+W4lIKHXEBbXopzDEB51LeoaOw/f+UudEu9QlJivdNFgb2S+
	OvaH5eV6oi+0FHdwS8VP7raxyuOXgjhmZgaK/KIAowyRs+dm+7XRaTTlFiCtDKNiMHUpCBK9lR0
	t9CQPQL8GAXOfInL6MrQmQp7Z9My2FQ+4SUCxrjge2Eu2JGxyTcY6jo6Cml8XCBp/zM3JT87bU8
	9ButOsL0fgHVV4BCFdTwCC5kLpokRy33Tgi1VB5uiKVBMOiUMCvJSaD7mQ==
X-Google-Smtp-Source: AGHT+IHRMtHD18T4dfw7aiPpwTCbpMsH6D+wH2du7lGhySZYDYqhGiquZGq7CBxrVe6JJ5hWnAefSw==
X-Received: by 2002:a05:6000:70a:b0:374:c4e2:3ca7 with SMTP id ffacd0b85a97d-38a221e2ea8mr31369083f8f.5.1735587272650;
        Mon, 30 Dec 2024 11:34:32 -0800 (PST)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm362767025e9.24.2024.12.30.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 11:34:32 -0800 (PST)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: phil@philpotter.co.uk,
	linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: typo-fixing patch for inclusion
Date: Mon, 30 Dec 2024 19:34:30 +0000
Message-ID: <20241230193431.441120-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

I hope you're well and have had a decent break over the holiday seasion.
Please apply the following patch from Steven Davis that fixes a typo in
a cd_dbg call.

Many thanks in advance.

Regards,
Phil

Steven Davis (1):
  cdrom: Fix typo, 'devicen' to 'device'

 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.1


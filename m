Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150ED1D55D
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280300; cv=none; b=qndma27kzmZl2J8ryCxfG7JX+XKvQMGjWfy2onvBdKXMk/ckXRyq4mKLm8n3wjJe5evEpHxi7eQZLq56giRwmmbSrSVlW8vwtYBm67fVd5ZQiVabJhJJefKj0xs/gVFd8ZJ0DR0p9pmTB2FsqT/lSmK2dQlMqIYK5gm12s8GMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280300; c=relaxed/simple;
	bh=JzXfpNVjw50s5rAgQuhSRe661hjXQsdfRVTn6CPH4G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0JFcAgWGoMHehjrcOnzlZoU+L+4qzFYWiYo9XBDJruQF0C3PQd7RaBfb3kjmfSB1yBzzWQR7/NwcKO4PrAp7Y/pZKR+YcC2dLdc1OkNIyi9oZh12l1OC6Kfozs7q2OWOQav+0aSU5Ofl8+uCaQShrLbr6G4NJe/tyHoradmuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=POaSU8G1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="POaSU8G1"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dbfe31905so3265659f8f.2
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1717280297; x=1717885097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mtfPtb8vjzM7x3qDKr35z4QK2kl5BxhMzJBiNyrtEI=;
        b=POaSU8G1+Y2ipMTgeB0WSHedsW/mjhq7JYQ2wP/2eqcK0x+umFVA292nxqn/a4QVYM
         0tuITruspysB03L/yuZjbZ9o1jWVzNA8FMOaf0+w1VXbHi63PZIXIyZSslGwvoUxPCAo
         02JUZuBJ2cNxabSO6XDWF3paYOun7H6WUKA9faqzaCtlyBhKdo8rVjMJ42WNZZGcXRNJ
         X3T0QyQ+li68XQvQRwmByBmydIJNGmHE/aFQ7dW6e51Bhi19u/M8QEYfhl95WKMJ/nwg
         03k1qYmAeGmmjjEUxyjlNX5xrFxQgyeoBZ4XSVIcYEoMjsXIV/eIh08Sq1mBsNuDeaYb
         EJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717280297; x=1717885097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mtfPtb8vjzM7x3qDKr35z4QK2kl5BxhMzJBiNyrtEI=;
        b=UnC3hxrME4MgnSCzfLMiWTDJeA+IdG7VmD0j7RPcd0SQ7fS1kjKnzyFQMAcIcvWocH
         xxVGSRSJoBqj5Bb0A1SiOz8mu6kZPAc+HI0TCFRFCuuSrW2OW2ayglnU3uldVa6wEPgZ
         rYzejqlDW13fuWnrk/CXaZj9x+q+RQFieH0ZDzyuziZPSc841tI6ZRpegcOJOgSgdBLd
         yFkLoZHBQnSQBszVklYxh7xzflLwvHWIDCPPESEqd+HT77r7ZGu3v2+Bl3u3rWdlLoag
         41rwFO+VrWnsxr6kevqJKi1pGiBDe/GzYE07ilDl5GFoZf8xsyUmqJbbMn7YxNl5EEZG
         dVgQ==
X-Gm-Message-State: AOJu0Ywqjrp7+HHH+3AHagA62WMwwdUt1qmPKyUzcBXSItJMit0iu2JR
	40SpddUzr7MGbhJ4aFlB2gmhE1hxyhr+GZOtkNr4ew1qA8isfqvKy2x8lc888lA=
X-Google-Smtp-Source: AGHT+IGshaCoR13sPGr0Jw8xVOfILR+pgDTQjh/Ho8D1jH0ZbWXVFMgc6vBglRCSbIHBYBj35IX7TA==
X-Received: by 2002:a5d:5643:0:b0:355:2ee:9f09 with SMTP id ffacd0b85a97d-35e0f2a3f93mr3671400f8f.41.1717280297219;
        Sat, 01 Jun 2024 15:18:17 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421381c650csm19592865e9.27.2024.06.01.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 15:18:16 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: patch for inclusion
Date: Sat,  1 Jun 2024 23:18:15 +0100
Message-ID: <20240601221816.136977-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please apply the following patch from Jeff Johnson, that adds a missing
MODULE_DESCRIPTION() invocation to drivers/cdrom/cdrom.c, to prevent a
build warning regarding its absence.

Many thanks in advance.

Regards,
Phil

Jeff Johnson (1):
  cdrom: Add missing MODULE_DESCRIPTION()

 drivers/cdrom/cdrom.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.45.1


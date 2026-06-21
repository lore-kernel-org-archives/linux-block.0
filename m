Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF236254B18
	for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021733; cv=none; b=tn6yIrD466+0wkwMwttFVz5VHCgyxcE6WIucughBu3qP+hORi2Bd/0TxpjdY2T6N8krMXU9kutc/dxVQ8R8yp7w9chTG+gY+Ip6tFkE85z0V4Hwp3epCKZOEXzK3/1nyxULKg7ukOiImC/6Xh/YReus8QBWpKP2pie6+3cOvC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021733; c=relaxed/simple;
	bh=oAZ4LLK4qeQvWdxhfK5qeoyXDIjZ5SUq26am3mzeO94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnb6ep8j9/X1yWYr5DecLkie32OUAl4lj2fDW4LQRTHYlEQ/uZrdaWyE/2KldvZoj0AHGEXs8ZfpQnD89+95QB2u+hE9Kg0IPf1lfEhHhNxY5NHMGtA3qzjnCd/NQFgDFz4t0j7v9R3q3965SR//J9sX1QiM9JvhFM9ZwbbWPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpwLNjLX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpwLNjLX"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fd464d51fso1941961f8f.3
        for <linux-block@vger.kernel.org>; Sat, 20 Jun 2026 23:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021728; x=1782626528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XW22mR6l3lTGNPr8AcOBrvc/VU7Xe5luK3BLVH/LaIo=;
        b=TpwLNjLX0juNC+e4jLk4Od/OIW8uiJGZYjJjpjW5l2UAL+A+DYKgdXD1THzTZkhi8Z
         SSDo9TFCEACH6ocQMsXdfhlvM7a7bAYsmy5Y5UxKsj7dpSAKApo6WH/Rae8vf1nLS35g
         IsYyn2dZ064GZzstI+96ETxh7NXQQLlfjEccglA4dN+McHSQhvy3SCvA1bD80I0XWbJO
         1nxFOAk/6fbJkGaPFWoviZ8gle2SrmrqOwxB59LqNnvvIM/5mhQATFpBkF6cKT+JunY2
         PG7Pne9/lWbpFr3dQ0U6/WtCgHbktc5wXLXokdmOiQPArvhjKIWZq/A5f283ZygG+pf3
         YdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021728; x=1782626528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW22mR6l3lTGNPr8AcOBrvc/VU7Xe5luK3BLVH/LaIo=;
        b=cSdcVeqpK+8d0GwWsjJUDcG+cotvTkQfrvtY0b8YJovMNPX9TS87smH4ORePb/jfm/
         lApxgxj3za1LX0gNY3a13uKPK/4EvWGwUdd+CoWUUZhSJeBjh3gZrYhGoAppBPag8S9D
         uUbw3cyR7yIbg00UJ6py0o5vQrSsDhR38Fr7YUH6wrRjS/v7/PlakWMfX3FWK/rQQFFf
         PrUSzDfciQyDbLEbNlf9eFpUsdPKmem9Rg/31AOtRCCxzZqVzqb0djRxyFUYktxOZrOA
         6CteZ90Fba6Bvk3WQgITdvxebqhEz6Fton36MR78a0EItXi084RJ/MURLLiCszx7mnwU
         l6HQ==
X-Gm-Message-State: AOJu0Yw1K6ftnFD1dSARl+Y4iFS+bLwgnWJtw65kFdYk6ooSSeRiVm4w
	YPr95kMeEoDbzKveiU0mWwdNbHGCxomnbgih8+DFCVd1ZaG4C/MVFGgd
X-Gm-Gg: AfdE7cnW2ZR8DUzLAQrV6csBsgAD5wi8KyiIkHf5KVqNyRpbmd0YlUXUlu3Cvf0g9P0
	Yo43TPZmw/o4SolbedH4YXC549IRq71nMZ/GhuCE618bXUKka36Rc18BRkEwKnDE/NV9vc/Zhc9
	L2eOdrrvIceNB3/Mth17Y256vjH5f5BZYu0RSHMWNtjUMndatMxWNpjNbekt57zOWOApPWQADIS
	ZpDRfShtWEbpqpzsV8gdlvWXqqjr+SoBqeOLALG94I3Zaw789+sExNRBnm33TSe60jzn91wNWUP
	hJOnhjfHSl6SQQcNJ9B6pccUpJxSMBWMrih9mZsmgh2eB21FOWpZpibSlLpJQiSaFC9ssUXoCya
	VXr1YwO9SQou2H6s36tAjRjcz37hceEvMmc/VobFLmHYUz6XOh7xO9aqHZL4AmHJxKFqSi7hySf
	HSpdRrRqmUyiQCksQUdPM60iBTI4rFjFPZwMN4viDh5uTIq+f915MYotxqFIntZgs=
X-Received: by 2002:a05:6000:46ce:b0:462:1aaa:2490 with SMTP id ffacd0b85a97d-46500a02b2bmr11882002f8f.6.1782021727882;
        Sat, 20 Jun 2026 23:02:07 -0700 (PDT)
Received: from practice.local (bzq-79-177-129-37.red.bezeqint.net. [79.177.129.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4ee6sm13525771f8f.5.2026.06.20.23.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 23:02:07 -0700 (PDT)
From: Jay Winston <jaybenjaminwinston@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	Jay Winston <jaybenjaminwinston@gmail.com>
Subject: [PATCH] Documentation: ABI: fix "unexpected indentation" error in sysfs-block
Date: Sun, 21 Jun 2026 09:02:02 +0300
Message-ID: <20260621060235.12994-1-jaybenjaminwinston@gmail.com>
X-Mailer: git-send-email 2.46.4
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`make htmldocs` reports:
Documentation/ABI/stable/sysfs-block:612: ERROR: Unexpected indentation

Leading dashes at lines 623, 636, and 641 were considered line
continuation with errant indent and not bullet points due to
missing blank lines.  Add the blank lines.

Signed-off-by: Jay Winston <jaybenjaminwinston@gmail.com>
---
 Documentation/ABI/stable/sysfs-block | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index aa1e94169666..f4bce370a540 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -620,6 +620,7 @@ Description:
 		- async_depth is always equal to nr_requests.
 
 		For bfq scheduler:
+
 		- By default, async_depth is set to 75% of nr_requests.
 		  Internal limits are then derived from this value:
 		  * Sync writes: limited to async_depth (≈75% of nr_requests).
@@ -633,11 +634,13 @@ Description:
 		  these limits proportionally based on the new value.
 
 		For Kyber:
+
 		- By default async_depth is set to 75% of nr_requests.
 		- If the user writes a custom value to async_depth, then it override the
 		  default and directly control the limit for writes and async I/O.
 
 		For mq-deadline:
+
 		- By default async_depth is set to nr_requests.
 		- If the user writes a custom value to async_depth, then it override the
 		  default and directly control the limit for writes and async I/O.
-- 
2.46.4


Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECF1D5CD4;
	Wed, 13 Aug 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069535; cv=none; b=aF1WLNV/F4q4tTs/7cMPlcyPSuqJA+QiJxbFe5AvInoSVKahFy2sIw47K711SqQ2cCD6I4dxqmabRfIT2Rgc0F+5cEppDAoFd3i6UbCKNR+YEZBtKxHQGDZ5ss0UvPCsHxtAtMj3/ZxcketYgLQVbhFzPMlVcTgQu9Jsx3bbsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069535; c=relaxed/simple;
	bh=8j2oxT6mk0yZmoWePt15+N5CrKZUEqAw4bGln0C329U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RN4W8klDS50CITMyCZrPvD680HIVzkx8a162nTjp69feM5+UNFuRLCqOXVIT7uBjfqejDihOw1PGkeKkAI/FNUrJvgDBpRNg0lPpSsRqLcH3l6kULlX0lb6Vhjp+HWzjTuCaemOb+bDC6K9L4MO5yM5FlViaPKH7mltBlfGgDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0yz68jM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0yz68jM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so52552525e9.0;
        Wed, 13 Aug 2025 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755069531; x=1755674331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hT7zNC81MFnipI/Ag5QHfvvjbScQaZ5LLk5g2Y05B+0=;
        b=l0yz68jM8PRtbrThPSRRutroH7oQ1sny5ofGnxJX+LDTbFRxW1XBSb+QXum/COi+aF
         y6iZIRF6Sdoemxx4GM2//l+My30UCRefEg9vFAdVEl7qfV6XtIZHXqhaqw13uYyCJaqS
         hMr3stBOsxqq5olCyR5s1Cbt5v+YT36+p/Duc7V0sdEBnA1FPsnTirSeU3oTN+kZK3jy
         KBhwNqVgiS0Kjp/AsY7CS2Qx0l3iQ5Z1UWDVG52ffyTpn8JjoRMSz1qNMt67l1K5a+vC
         vkD8ykZKE31vGgJbKd57LawBQJt8nJZjkqIDGS3Vyrh6mBiSCsxbrpk0beK9a4gWoBIm
         S7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069531; x=1755674331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hT7zNC81MFnipI/Ag5QHfvvjbScQaZ5LLk5g2Y05B+0=;
        b=QYe9NUevc7ZIc7mWQrrr7wgYH1h/D6fbJqFpi44nnNJGwT+vZC/4HL4Pr0m+FWY4Vk
         y9CLiTHiO3n5rlsQWN6zrF2Ja+XoLrCfK8OSWV8YLgGXkP3xtg50W/WYtuaIhXcV6lYs
         UzvRU7wHSJgf/dO1wM7htrW3a8Vw2aZDNVrlSI3uX3/shVqn/qQ6zSVnLBlrK6A22kiZ
         tOx5LlbpMfHHYT6Mx7Poq9Y40XYjBJ1tsBiwFVvCpzAJXl/5J9YoAGPgD5wes+SZ/3dt
         6/NlR7/GbQns8CSbUQzmukWiotpOxRtu9lM1npxb5cMx0wJywbjWN+DEuJ96oZVXbwyf
         rA4A==
X-Forwarded-Encrypted: i=1; AJvYcCVfkUyPc3s1BUfTaFJU4uqzjMW8AGbHiUF3/S4e0AHEP12E9gjsyGjlmxthHSWwChkMt6kS50sPaRgC@vger.kernel.org, AJvYcCWlNTuWlQe6QiR2z9/SdhucFHvOxEWNkIwf9CcrokezSst4D1+SX2YdeRtiXkTj1WPeHUlWUnkZtrpWRPbb@vger.kernel.org, AJvYcCXjGEtOfGcft4nWYWlKPk4cm5y2So9+480TzoHZtUOlFRv+AAB4ep+CT/yh4h7TRx34gJHdMeLxNZAFoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTLVigLTAp78a6aht6dg3RFddRnk5AvYDWMP0lbMkyhItG/pSV
	P+XrQ6Ff2V9+adq4/N2Ad1CulEIk/QlHmTCVE9LGv5tGZYS4jS/zM8oU
X-Gm-Gg: ASbGncvfcYFrPzjXXgCJWC+6omTpHjbmTcq69QV0Vi/8peu7rkY9quYosaGbnJDuX8Q
	DJMGTbks8/8TNmMhwrrGCuumjX6mNroNzbyUtV2zti0vjmuVAh1ZOqx8UuEfuV7Gaf5eaRWEZQS
	WKPKCcIa0KCbg9ZzbJqre+4AbCS595Al7Gjj+vgOc8UitH2LVPaEmtIbyumYtpoewX7ISOqH8YL
	uG128/kHtQGUCFWblJoVhCdacjjWQCKHHJ9CUnI5fkVh07pkZqSO8RzRWFCv1FbHheZOp1BfsKQ
	RjUCLZhF3JNgK1tLrJydt5Tl6Np2EibTsoyJdCnGanqC8C80XlZ9uPuQsF8hvlW4QiQheZl9eO8
	v8ZsGats1lZAMDoPeYn0=
X-Google-Smtp-Source: AGHT+IEglHcl0W/BNit8lnQzWA48TYtNNYEYIowfu0Jp/7j5jJeKFCchpl/EObW5f9/xZRNrLK5j6g==
X-Received: by 2002:a05:600c:1d20:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45a165fbf95mr14268835e9.7.1755069530601;
        Wed, 13 Aug 2025 00:18:50 -0700 (PDT)
Received: from pc.. ([102.208.164.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16df1cf8sm16944565e9.24.2025.08.13.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:18:49 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	linux-block@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] Docs: admin-guide: Correct spelling mistake
Date: Wed, 13 Aug 2025 10:18:36 +0300
Message-ID: <20250813071837.668613-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake directoy to directory

Reported-by: codespell

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 Documentation/admin-guide/blockdev/zoned_loop.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index 9c7aa3b482f3..64dcfde7450a 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -79,7 +79,7 @@ zone_capacity_mb   Device zone capacity (must always be equal to or lower than
                    the zone size. Default: zone size.
 conv_zones         Total number of conventioanl zones starting from sector 0.
                    Default: 8.
-base_dir           Path to the base directoy where to create the directory
+base_dir           Path to the base directory where to create the directory
                    containing the zone files of the device.
                    Default=/var/local/zloop.
                    The device directory containing the zone files is always
-- 
2.43.0


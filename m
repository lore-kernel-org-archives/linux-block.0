Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81D644
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="awEMNyUf"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F59C8
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 18:42:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso5720927b3a.1
        for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 18:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700016158; x=1700620958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VD/qfUA8hK9LrNVNGdNy45/FGzdZaL0XDcCmNsYDKk=;
        b=awEMNyUf3PS99csUDZtoHr1Oe6PHeW0+VoZEwZg1S6s39G8IyL/1GlP5lQCpYGpw/E
         TU7OFCcKOEbzuMEWECcKuXEYES9LdGQ1lwZJemSxXc1kQ5W895kWZFB0g8XpuDlF+MNN
         Ahv849U+JT6/OI+9sTK6TFFh//4NxKnK6oAxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700016158; x=1700620958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VD/qfUA8hK9LrNVNGdNy45/FGzdZaL0XDcCmNsYDKk=;
        b=UHWGK5/DzF+4XCTB4loqul93t3E559j05k1RQ9yxLLT5INQriKFPVnmLcfL5A9ziEv
         TvLq0koYZkErDTV/ENpRcR97aNa3/3hoeCmUNSCDNWOI6cHo9OzMsIf9HZd+9tJIQrfw
         zjV3VmqoL9PVTQLie1CYyrPu9E0tKxhf3sBJ2TDJeGQRm3awMPZ/6BKn8S+/BhrjHrec
         bxc9GYLD3TOcIGTqdIlznn3+v1soOmtu43Y4bUyDPyEcr+J53ohqHHR31lzDWcdQUm05
         ZDAzma+a+nAGNS/kEL8+XxXFxvKkcm6JJY/zl+CzqRnJJsEuMRjxMZpQKjLdvSsF6yK+
         4zqA==
X-Gm-Message-State: AOJu0YyOe3X0yKa8cVsLcFLbwUVD6E1seL4t/rg2cU1RRgXIE6b/HEGc
	HZOZsn6UVrKNep9bOXob0MCLqfh8krtzDBvd4fE=
X-Google-Smtp-Source: AGHT+IHSV0HQALZRrZs3q5DkDvLmgw0G/p1SXNykrNJdK5dx0Fyf6gr985MkByLq7NofCYDhQdbmCw==
X-Received: by 2002:a05:6a00:8c05:b0:6c3:402a:d53d with SMTP id ih5-20020a056a008c0500b006c3402ad53dmr10257300pfb.2.1700016158230;
        Tue, 14 Nov 2023 18:42:38 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dfe3:bfcd:e155:c392])
        by smtp.gmail.com with ESMTPSA id c15-20020a62e80f000000b0068ffd56f705sm1862016pfi.118.2023.11.14.18.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 18:42:37 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] zram: tweak writeback config help
Date: Wed, 15 Nov 2023 11:42:13 +0900
Message-ID: <20231115024223.4133148-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231115024223.4133148-1-senozhatsky@chromium.org>
References: <20231115024223.4133148-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback is for incompressible and idle zram pages.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index af201392ed52..7b29cce60ab2 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -59,8 +59,8 @@ config ZRAM_WRITEBACK
        bool "Write back incompressible or idle page to backing device"
        depends on ZRAM
        help
-	 With incompressible page, there is no memory saving to keep it
-	 in memory. Instead, write it out to backing device.
+	 This lets zram entries (incompressible or idle pages) be written
+	 back to a backing device, helping save memory.
 	 For this feature, admin should set up backing device via
 	 /sys/block/zramX/backing_dev.
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

